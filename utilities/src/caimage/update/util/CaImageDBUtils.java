/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package caimage.update.util;
import gov.nih.nci.caimage.db.Annotation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 
 */

/**
 * Contains utilities for reading/writing the caImage database.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Dec 2, 2009 vaughng: Initial version
 * -->
 */
public class CaImageDBUtils
{

    
    private static Connection getConnection() throws SQLException, ClassNotFoundException
    {
        Class.forName(PropertyUtils.getProperty("db.driver"));
        String url = PropertyUtils.getProperty("db.url");
        String usr = PropertyUtils.getProperty("db.usr");
        String pwd = PropertyUtils.getProperty("db.pwd");
        
        Connection loccon = DriverManager.getConnection(url, usr, pwd);
        return loccon;
    }
    
    public static void insertAnnotationData(Annotation annotation) throws SQLException, ClassNotFoundException
    {
        Connection con = getConnection();
        
        try
        {
        String insert = "insert into annotations (annotation_id, image_name, image_description, species_id, catalog_id) values(" + annotation.getAnnotation_id() + 
        ",'" + annotation.getImage_name() +"','" + annotation.getImage_description() + "'," + annotation.getSpecies_id() + "," + annotation.getCatalog_id() + ")";
        Statement st = con.createStatement();
        st.executeUpdate(insert);
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            throw e;
        }
        finally
        {
            try
            {
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
        
    }
    
    public static int getAnnotationId(String imageName) throws SQLException, ClassNotFoundException
    {
        int id = -1;
        
        Connection con = getConnection();
        try
        {
        String select = "select annotation_id from annotations where image_name = '" + imageName + "'";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(select);
        if (rs.next())
        {
            id = rs.getInt("annotation_id");
        }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            throw e;
        }
        finally
        {
            try
            {
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
        return id;
    }
    
    public static int[] getDimensions(int annotationId) throws SQLException, ClassNotFoundException
    {
        int[] dim = null;
        Connection con = getConnection();
        try
        {
        String select = "select image_characteristic_width, image_characteristic_height from image_characteristic " +
        "where image_characteristic_id = " + annotationId;
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(select);
        if (rs.next())
        {
            int wid = rs.getInt("image_characteristic_width");
            int ht = rs.getInt("image_characteristic_height");
            if (wid != 0 || ht != 0)
            {
                dim = new int[2];
                dim[0] = wid;
                dim[1] = ht;
            }
        }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            throw e;
        }
        finally
        {
            try
            {
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
        return dim;
    }
    
    public static void setDimensions(int annotationId, int width, int height) throws SQLException, ClassNotFoundException
    {
        Connection con = getConnection();
        try
        {
        String update = "update image_characteristic set image_characteristic_width = " + width + ", image_characteristic_height = " +
            height + " where image_characteristic_id = " + annotationId;
        Statement st = con.createStatement();
        st.executeUpdate(update);
        }
        catch (SQLException e)
        {
            e.printStackTrace();
            throw e;
        }
        finally
        {
            try
            {
                con.close();
            }
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
    }
    
}