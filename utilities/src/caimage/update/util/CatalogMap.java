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
import java.util.HashMap;
import java.util.Map;

/**
 * 
 */

/**
 * Bean that holds mappings from caImage categories to file directories.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Nov 13, 2009 vaughng: Initial version
 * -->
 */
public class CatalogMap
{
    private static final String CONFIG_FILE = "CatalogMap.csv";
    private static final String ID_COL = "catalog_id", NAME_COL = "catalog", DIR_COL = "directory";
    private Map<String,Integer> columnHeaderMap = new HashMap<String, Integer>();
    private Map<Integer, CatalogMapping> idMap = new HashMap<Integer, CatalogMapping>();
    private Map<String, CatalogMapping> nameMap = new HashMap<String, CatalogMapping>();
    private Map<String,CatalogMapping> dirMap = new HashMap<String, CatalogMapping>();
    
    public CatalogMap() throws FileNotFoundException, IOException
    {
        File configFile = new File(CONFIG_FILE);
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
            CatalogMapping mapping = new CatalogMapping();
            String[] splitRow = removeNulls(row.split(","));
            if (splitRow.length > columnHeaderMap.get(ID_COL) && !splitRow[columnHeaderMap.get(ID_COL)].equals(""))
            {
                mapping.catalogId = Integer.parseInt(splitRow[columnHeaderMap.get(ID_COL)]);
                idMap.put(mapping.catalogId, mapping);
            }
            if (splitRow.length > columnHeaderMap.get(NAME_COL) && !splitRow[columnHeaderMap.get(NAME_COL)].equals(""))
            {
                mapping.catalog = splitRow[columnHeaderMap.get(NAME_COL)];
                nameMap.put(mapping.catalog, mapping);
            }
            if (splitRow.length > columnHeaderMap.get(DIR_COL) && !splitRow[columnHeaderMap.get(DIR_COL)].equals(""))
            {
                mapping.directory = splitRow[columnHeaderMap.get(DIR_COL)];
                dirMap.put(mapping.directory, mapping);
            }           
        }
    }
    
    public int getCatalogId(File dir)
    {
        System.out.println("Checking catalog id for dir: " + dir);
        File baseDir = new File(PropertyUtils.getProperty("image.basedir"));
        
        int id = -1;
        for (String dirName : dirMap.keySet())
        {
            String absDir = baseDir + File.separator + dirName;
            File compDir = new File(absDir);
            //System.out.println("Comparing to dir: " + compDir.getAbsolutePath());
            if (compDir.equals(dir))
            {
                id = dirMap.get(dirName).catalogId;
            }
        }
        return id;
    }
    
    public String getCatalog(int id)
    {
        System.out.println("Checking catalog name for id: " + id);
        if (idMap.containsKey(id))
        {
            return idMap.get(id).directory;
        }
        return null;
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
    
    class CatalogMapping
    {
        protected String catalog, directory;
        protected int catalogId;
    }
}
