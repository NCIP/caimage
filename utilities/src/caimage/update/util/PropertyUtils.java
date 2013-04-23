/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package caimage.update.util;
import java.io.FileInputStream;
import java.util.Properties;

/**
 * 
 */

/**
 * [Replace this line with description]
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Dec 16, 2009 vaughng: Initial version
 * -->
 */
public class PropertyUtils
{
    private static final String PROPS_FILE = "caimage_update.properties";
    private static Properties props = null;
    
    
    public static String getProperty(String key)
    {
        return getProps().getProperty(key);
    }
    
    private static synchronized Properties getProps()
    {
        if (props == null)
        {
            try
            {
                props = new Properties();
                FileInputStream inStream = new FileInputStream(PROPS_FILE);
                props.load(inStream);
            }
            catch (Exception e)
            {
                System.err.println("ERROR: Could not initialize properties file.");
                e.printStackTrace();
                throw new RuntimeException("ERROR: Could not initialize properties file.");
            }
        }
        return props;
    }
}
