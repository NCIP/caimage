/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package caimage.update.util;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 */

/**
 * Updates image names in the caImage database for converted image files.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Nov 16, 2009 vaughng: Initial version
 * -->
 */
public class CaImageNameUpdater
{
    private static final String RESULTS_FILE = "DB_Image_Update_Results";
    private static final String CONVERSION_FILE = "Conversion_Success_Results.csv";
    //private static final String CONN_URL_LOC = "jdbc:oracle:thin:@localhost:1521:XE";
    //private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
    //private static final String USR = "caimageprod_read";
    //private static final String USR_LOC = "system";
    //private static final String PWD = "readonly";
    //private static final String PWD_LOC = "caimage4nci";
    private List<UpdateResults> updateResults = new ArrayList<UpdateResults>();
    
    /**
     * @param args
     */
    public static void main(String[] args)
    {
        try
        {
            ImageConversionResults conversionResults = new ImageConversionResults(CONVERSION_FILE);
            Class.forName(PropertyUtils.getProperty("db.driver"));
            String url = PropertyUtils.getProperty("db.url");
            String usr = PropertyUtils.getProperty("db.usr");
            String pwd = PropertyUtils.getProperty("db.pwd");
            Connection loccon = DriverManager.getConnection(url, usr, pwd);
            loccon.setAutoCommit(false);
            CaImageNameUpdater updater = new CaImageNameUpdater();
            for (ImageConversionResults.ConversionMapping mapping : conversionResults.getConversionMappings())
            {
                if (mapping.getCatalogId() != 0)
                {
                    String originalName = mapping.getOriginalFileName();
                    String ext = mapping.getNewExt();
                    String newName;
                    if (originalName.indexOf(".") >= 0)
                    {
                        newName = originalName.substring(0,originalName.indexOf(".")) + ext;
                    }
                    else
                    {
                        newName = originalName + ext;
                    }
                    updater.updateImageName(loccon, originalName, newName, mapping.getCatalogId());
                }
            }
            
            updater.writeResultsFile();
            loccon.commit();
            System.exit(0);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }

    private void updateImageName(Connection con, String imageName, String newName, int catalogId) throws SQLException
    {
        String select = "select annotation_id from annotations where image_name like '%" + imageName + "%' and catalog_id = (?)";
        String update = "update annotations set image_name = (?) where annotation_id = (?)";
        
        PreparedStatement find = con.prepareStatement(select);
        //find.setString(1, imageName);
        find.setInt(1, catalogId);
        
        List<UpdateResults> updates = new ArrayList<UpdateResults>();
        
        ResultSet frs = find.executeQuery();
        while (frs.next())
        {
            UpdateResults results = new UpdateResults();
            int annotationId = frs.getInt("annotation_id");
            System.out.println("Found annotation: " + annotationId + " for image: " + imageName);
            results.annotationId = annotationId;
            results.originalName = imageName;
            results.newName = newName;
            results.catalogId = catalogId;
            updates.add(results);
        }
        frs.close();
        find.close();
        
        if (!updates.isEmpty())
        {
            PreparedStatement set = con.prepareStatement(update);
            for (UpdateResults results : updates)
            {
                set.setString(1, results.newName);
                set.setInt(2, results.annotationId);
                System.out.println("Updating annotation: " + results.annotationId + " with image name: " + newName);
                set.executeUpdate();
            }
            set.close();
            updateResults.addAll(updates);
        }
        else
        {
            System.out.println("No updates for image: " + imageName + " select: " + select + " catalog: " + catalogId);
        }
        
    }
    
    private void writeResultsFile() throws IOException
    {
        SimpleDateFormat df = new SimpleDateFormat("MM.dd.yy.mm.ss");
        String successFileName = RESULTS_FILE + df.format(Calendar.getInstance().getTime()) + ".csv";
        File successFile = new File(successFileName);
        if (!successFile.exists())
        {
            successFile.createNewFile();
        }
        String[] columnHeaders = new String[]{"Original File","New File","Catalog Id","Annotation Id"};
        Writer writer = new OutputStreamWriter(new FileOutputStream(successFile));
        
        String columnHeaderString = delimit(columnHeaders, ",");
        writer.write(columnHeaderString);
        writer.write('\n');
        
        for (UpdateResults result : updateResults)
        {
            String[] resultArray = new String[]{result.originalName, result.newName, Integer.toString(result.catalogId),
                    Integer.toString(result.annotationId)};
                String results = delimit(resultArray, ",");
                writer.write(results);
                writer.write('\n');
                         
        }  
        writer.flush();
        writer.close();
        
    }
    
    class UpdateResults
    {
        private String  originalName, newName;
        private int catalogId, annotationId;
    }
    
    /**
     * Splits an input string around a delimiter, ignoring the delimiter
     * if it appears inside quotes.
     * 
     * @param input String to be split into an array.
     * @param delimiter Regular expression, as a String, about which the input will be split.
     * @return An array of Strings split around a delimiter, with delimiters inside quoted text ignored.
     */
    public static String[] split(String input, String delimiter)
    {
        
      if (input == null)
        return null;
      
      String[] delimited;
      
      if (input.indexOf("\"") < 0)
      {
          delimited = input.split(delimiter);
          return removeNulls(delimited);  
      }
        
      
      //Quoted text containing at least one comma
      String quotePattern = "\"[^\"]*" + delimiter + "[^\"]*\"";
      String substitute = "%delim%";
      
      Pattern pattern = Pattern.compile(quotePattern);
      Matcher matcher = pattern.matcher(input);
      StringBuffer replacement = new StringBuffer();
      
      //Replace all commas inside quoted text so they will be ignored in the split operation
      while (matcher.find())
      {
        String group = matcher.group();
        group = group.replaceAll(delimiter,substitute);
        matcher.appendReplacement(replacement,group);
      }
      matcher.appendTail(replacement);
      
      //Remove quotes, and split the substituted input around the delimiter
      input = replacement.toString();
      String boundryQuotePattern = "\"" + delimiter + "\"";
      input = input.replaceAll(boundryQuotePattern,"");
      delimited = input.split(delimiter);
      
      //Replace instances of the delimiter substitution with the delimiter
      for (int i = 0; i < delimited.length; i++)
      {
        delimited[i] = delimited[i].replaceAll(substitute,delimiter);
      }
      
      return removeNulls(delimited);
    }
    
    /**
     * Returns the result of replacing any null values in the given array with
     * the empty string.
     * 
     * @param arg Array in which nulls will be removed.
     * @return An array containing empty strings in place of null values.
     */
    public static String[] removeNulls(String[] arg)
    {
        if (arg == null)
            return null;
        String[] retVal = new String[arg.length];
        System.arraycopy(arg, 0, retVal, 0, arg.length);
        for (int i = 0; i < retVal.length; i++)
        {
            if (retVal[i] == null)
                retVal[i] = "";
        }
        return retVal;
    }
    public static String delimit(String[] tokens, String delimiter)
    {
      String retVal = null;
      
      if (tokens != null)
      {
        retVal = "";
        if (delimiter == null)
          delimiter = "";
        
        for (int i = 0; i < tokens.length; i++)
        {
          if (tokens[i] == null)
            tokens[i] = "";
          
          if (tokens[i].indexOf(",") >= 0 && !tokens[i].startsWith("\""))
            tokens[i] = "\"" + tokens[i] + "\"";
          
          retVal = retVal.concat(tokens[i]);
          if (i < tokens.length - 1)
          {
            retVal = retVal.concat(delimiter);
          }
        }
      }
      
      return retVal;
    }
}
