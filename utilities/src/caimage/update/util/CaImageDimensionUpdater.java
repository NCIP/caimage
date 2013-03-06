/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package caimage.update.util;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 */

/**
 * Compares the dimensions of a converted image file to the dimesnsions of
 * the original file as recorded in the caImage database and updates the
 * database if necessary.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Dec 2, 2009 vaughng: Initial version
 * -->
 */
public class CaImageDimensionUpdater
{
    
    private static List<ImageComparisonResults> results = new ArrayList<ImageComparisonResults>();
    private static final String CONVERSION_FILE = "Conversion_Success_Results.csv";
    private static final String URL_BASE = "http://ncias-d330-v.nci.nih.gov:19080/adore-djatoka/images/caimage";
    /**
     * @param args
     */
    public static void main(String[] args)
    {
        try {
        File file = new File(PropertyUtils.getProperty("image.basedir"));
        //getResults(file);
        getRemoteResults();
        System.out.println("Number of comparison results: " + results.size());
        for (ImageComparisonResults result : results)
        {
            if (!result.matches())
            {
                System.out.println("Incompatible dimensions: " + result.name);
                System.out.println("*** DB width: " + result.dbWidth + "  TIF width: " + result.tifWidth);
                System.out.println("*** DB height: " + result.dbHeight + "  TIF height: " + result.tifHeight);
                CaImageDBUtils.setDimensions(result.annotationId, result.tifWidth, result.tifHeight);
            }
            else
            {
                System.out.println("Results match for file: " + result.name);
            }
        }
        System.exit(0);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }
    
    private static void getResults(File file) throws Exception
    {
        if (file.isDirectory())
        {
            File[] children = file.listFiles();
            for (File child : children)
            {
                getResults(child);
            }
        }
        else if (file.getName().endsWith("tif"))
        {
            int annoId = CaImageDBUtils.getAnnotationId(file.getName());
            if (annoId > -1)
            {
                int[] dim = CaImageDBUtils.getDimensions(annoId);
                if (dim != null)
                {
                    int tifWidth = ImageUtils.getTifWidth(file);
                    int tifHeight = ImageUtils.getTifLength(file);
                    ImageComparisonResults result = new ImageComparisonResults();
                    result.dbWidth = dim[0];
                    result.dbHeight = dim[1];
                    result.tifWidth = tifWidth;
                    result.tifHeight = tifHeight;
                    result.name = file.getName();
                    result.annotationId = annoId;
                    results.add(result);
                }
                else
                {
                    System.out.println("No db dimensions for file: " + file.getName());
                }
            }
            else
            {
                System.out.println("No db entry for: " + file.getName());
            }
        }
    }
    
    private static void getRemoteResults() throws FileNotFoundException, IOException, URISyntaxException, SQLException, ClassNotFoundException
    {
        ImageConversionResults conversionResults = new ImageConversionResults(CONVERSION_FILE);
        
        for (ImageConversionResults.ConversionMapping mapping : conversionResults.getConversionMappings())
        {
            if (mapping.getCatalogId() != 0 && mapping.getNewExt().equals(".tif"))
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
                CatalogMap catalogMap = new CatalogMap();
                String dir = catalogMap.getCatalog(mapping.getCatalogId());
                if (dir == null)
                    return;
                
                String remoteName = URL_BASE + "/" + dir + "/" + newName;
                //URI remote = new URI(remoteName);
                //File file = new File(remote);
             // Create an URL instance
                URL url = new URL(remoteName);

                // Get an input stream for reading
                InputStream in = url.openStream();

                // Create a buffered input stream for efficency
                BufferedInputStream bufIn = new BufferedInputStream(in);

                int annoId = CaImageDBUtils.getAnnotationId(newName);
                    if (annoId > -1)
                    {
                        int[] dim = CaImageDBUtils.getDimensions(annoId);
                        if (dim != null)
                        {
                            int tifWidth = ImageUtils.getTifWidth(bufIn);
                            int tifHeight = ImageUtils.getTifLength(bufIn);
                            ImageComparisonResults result = new ImageComparisonResults();
                            result.dbWidth = dim[0];
                            result.dbHeight = dim[1];
                            result.tifWidth = tifWidth;
                            result.tifHeight = tifHeight;
                            result.name = newName;
                            result.annotationId = annoId;
                            results.add(result);
                        }
                        else
                        {
                            System.out.println("No db dimensions for file: " + newName);
                        }
                    }
            
            }
        }
    }
    
    static class ImageComparisonResults
    {
        int tifWidth, tifHeight, dbWidth, dbHeight, annotationId;
        String name;
        
        public boolean matches()
        {
            return tifWidth == dbWidth && tifHeight == dbHeight;
        }
    }

}
