package caimage.update.util;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 */

/**
 * Utility for creating a mapping of caImage categories to file directories.
 * A csv file containing known mappings is read and copied to the new file,
 * and any additional unmapped categories found in the database are mapped
 * to generated directories.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Nov 13, 2009 vaughng: Initial version
 * -->
 */
public class CatalogMapConverter
{

    private static String currentFile = "C:" + File.separator + "caImage" + File.separator + "CatalogMap.csv";
    private static String newFile = "C:" + File.separator + "caImage" + File.separator + "FinalCatalogMap.csv";
    private static String imgBaseStr = "Images/images/";
    private static final String CONN_URL_LOC = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String DB_DRIVER = "oracle.jdbc.driver.OracleDriver";
    private static final String USR_LOC = "system";   
    private static final String PWD_LOC = "caimage4nci";
    
    public static void main(String[] args)
    {
        try
        {
            loadFile();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
    private static void loadFile() throws Exception
    {
        File configFile = new File(currentFile);
        BufferedReader reader = new BufferedReader(new FileReader(configFile));
    
        Class.forName(DB_DRIVER);
        List<String> spreadsheetRows = new ArrayList<String>();
        String row;
        while ((row = reader.readLine()) != null)
        {
            String[] splitRow = row.split(",");
            if (splitRow.length < 3 && splitRow.length > 0)
            {
                System.out.println("Unfinshed line: " + row);
                String cat = getDir(splitRow[1]);
                if (cat != null)
                    row += imgBaseStr + cat;
                System.out.println("New line: " + row);
            }
            spreadsheetRows.add(row);
        }
        
        Writer writer = new OutputStreamWriter(new FileOutputStream(newFile));
        
        
        for (String newRow : spreadsheetRows)
        {
            writer.write(newRow);
            writer.write('\n');
        }
        writer.flush();
        writer.close();
    }
    
    private static String getDir(String catalog) throws Exception
    {
        Connection loccon = DriverManager.getConnection(CONN_URL_LOC, USR_LOC, PWD_LOC);
        String cat = null;
        Statement st = loccon.createStatement();
        String select = "select catalog_name from catalog where catalog_directory = '" + catalog + "'";
        ResultSet rs = st.executeQuery(select);
        if (rs.next())
        {
            cat = rs.getString(1);
        }
        rs.close();
        st.close();
        loccon.close();
        return cat;
    }
}
