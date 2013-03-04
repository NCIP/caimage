/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See https://github.com/NCIP/caimage/LICENSE.txt for details.
 */

package caimage.update.util;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 
 */

/**
 * Bean that reads a csv file holding the results of image conversion performed
 * by SidImageConverter.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Nov 16, 2009 vaughng: Initial version
 * -->
 */
public class ImageConversionResults
{

    private static final String FILE_PATH = "Original File", NEW_FILE_PATH = "New File", 
        ORIG_NAME = "Original Name", NEW_EXT = "New Ext", ID_COL = "catalog_id";
    private Map<String,Integer> columnHeaderMap = new HashMap<String, Integer>();
    private List<ConversionMapping> conversionMappings = new ArrayList<ConversionMapping>();
    
    public ImageConversionResults(String conversionFile) throws FileNotFoundException, IOException
    {
        File configFile = new File(conversionFile);
        BufferedReader reader = new BufferedReader(new FileReader(configFile));
    
        String row;
        
        row = reader.readLine();
        String[] columnHeaders = row.split(",");
        for (int i = 0; i < columnHeaders.length; i++)
        {
            columnHeaderMap.put(columnHeaders[i], i);
        }
        while ((row = reader.readLine()) != null)
        {
            ConversionMapping mapping = new ConversionMapping();
            String[] splitRow = split(row, ",");
            if (splitRow.length > columnHeaderMap.get(FILE_PATH) && !splitRow[columnHeaderMap.get(FILE_PATH)].equals(""))
            {
                mapping.originalFilePath = splitRow[columnHeaderMap.get(FILE_PATH)];
            }
            if (splitRow.length > columnHeaderMap.get(NEW_FILE_PATH) && !splitRow[columnHeaderMap.get(NEW_FILE_PATH)].equals(""))
            {
                mapping.newFilePath = splitRow[columnHeaderMap.get(NEW_FILE_PATH)];
            }
            if (splitRow.length > columnHeaderMap.get(ORIG_NAME) && !splitRow[columnHeaderMap.get(ORIG_NAME)].equals(""))
            {
                mapping.originalFileName = splitRow[columnHeaderMap.get(ORIG_NAME)];
            }
            if (splitRow.length > columnHeaderMap.get(NEW_EXT) && !splitRow[columnHeaderMap.get(NEW_EXT)].equals(""))
            {
                mapping.newExt = splitRow[columnHeaderMap.get(NEW_EXT)];
            }
            if (splitRow.length > columnHeaderMap.get(ID_COL) && !splitRow[columnHeaderMap.get(ID_COL)].equals(""))
            {
                mapping.catalogId = Integer.parseInt(splitRow[columnHeaderMap.get(ID_COL)]);
            }
            
            conversionMappings.add(mapping);
        }
    }
    
    /**
     * Returns the result of replacing any null values in the given array with
     * the empty string.
     * 
     * @param arg Array in which nulls will be removed.
     * @return An array containing empty strings in place of null values.
     */
    private static String[] removeNulls(String[] arg)
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
    
    public class ConversionMapping
    {
        private String originalFilePath, newFilePath, originalFileName, newExt;
        private int catalogId = 0;
        /**
         * @return the originalFilePath
         */
        public String getOriginalFilePath()
        {
            return originalFilePath;
        }
        /**
         * @param originalFilePath the originalFilePath to set
         */
        public void setOriginalFilePath(String originalFilePath)
        {
            this.originalFilePath = originalFilePath;
        }
        /**
         * @return the newFilePath
         */
        public String getNewFilePath()
        {
            return newFilePath;
        }
        /**
         * @param newFilePath the newFilePath to set
         */
        public void setNewFilePath(String newFilePath)
        {
            this.newFilePath = newFilePath;
        }
        /**
         * @return the originalFileName
         */
        public String getOriginalFileName()
        {
            return originalFileName;
        }
        /**
         * @param originalFileName the originalFileName to set
         */
        public void setOriginalFileName(String originalFileName)
        {
            this.originalFileName = originalFileName;
        }
        /**
         * @return the newExt
         */
        public String getNewExt()
        {
            return newExt;
        }
        /**
         * @param newExt the newExt to set
         */
        public void setNewExt(String newExt)
        {
            this.newExt = newExt;
        }
        /**
         * @return the catalogId
         */
        public int getCatalogId()
        {
            return catalogId;
        }
        /**
         * @param catalogId the catalogId to set
         */
        public void setCatalogId(int catalogId)
        {
            this.catalogId = catalogId;
        }
        
        
    }
    /**
     * @return the conversionMappings
     */
    public List<ConversionMapping> getConversionMappings()
    {
        return conversionMappings;
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
}
