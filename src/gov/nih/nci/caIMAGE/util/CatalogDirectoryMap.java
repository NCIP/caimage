/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See https://github.com/NCIP/caimage/LICENSE.txt for details.
 */

/**
 * 
 */
package gov.nih.nci.caIMAGE.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

/**
 * Utility for mapping catalog ids and catalog names to an image path.
 * Image path mappings are loaded from the CatalogMap.csv file.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Nov 16, 2009 vaughng: Initial version
 * -->
 */
public class CatalogDirectoryMap
{
    //TODO: load from props file
    private static final String CONFIG_FILE = "CatalogMap.csv";
    private static final String ID_COL = "catalog_id", NAME_COL = "catalog", DIR_COL = "directory";
    
    private static CatalogDirectoryMap instance = null;
    private static Boolean mutex = new Boolean(false);
    
    private Map<String,Integer> columnHeaderMap = new HashMap<String, Integer>();
    private Map<Long, CatalogMapping> idMap = new HashMap<Long, CatalogMapping>();
    private Map<String, CatalogMapping> nameMap = new HashMap<String, CatalogMapping>();
    private Map<String,CatalogMapping> dirMap = new HashMap<String, CatalogMapping>();
    
    public static CatalogDirectoryMap getInstance() throws FileNotFoundException, IOException
    {
        synchronized (mutex)
        {
            if (instance == null)
                instance = new CatalogDirectoryMap();
        }
        return instance;
    }
    
    private CatalogDirectoryMap() throws FileNotFoundException, IOException
    {
        //File configFile = new File(CONFIG_FILE);
        BufferedReader reader = new BufferedReader(new InputStreamReader(this.getClass().getResourceAsStream(CONFIG_FILE)));
    
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
    
    public long getCatalogId(File dir, File baseDir)
    {
        long id = -1;
        for (String dirName : dirMap.keySet())
        {
            String absDir = baseDir + File.separator + dirName;
            File compDir = new File(absDir);
            if (compDir.equals(dir))
            {
                id = dirMap.get(dirName).catalogId;
            }
        }
        return id;
    }
    
    public String getImagePath(long catalogId)
    {
        String path = "";
        if (idMap.containsKey(catalogId))
        {
            path = idMap.get(catalogId).directory;
        }
        return path;
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
        protected long catalogId;
    }
}
