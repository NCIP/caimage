/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;


import java.lang.*;
import java.util.*;
import java.sql.*;
import java.io.*;

public class DatabaseSelection
{
    public static String setSelected()
    {
        Properties db_props = new Properties();
        String userDir = System.getProperty("user.dir");
        InputStream in = null;
        try
        {
            in = Thread.currentThread().getContextClassLoader().getResourceAsStream("db.properties");
            //				if(userDir.indexOf(":")!= -1){ 
            //				in = Thread.currentThread().getContextClassLoader().getResourceAsStream("db_caimage.properties");
            //				} else {
            //				in = Thread.currentThread().getContextClassLoader().getResourceAsStream("db.properties");
            //				}

            if (in == null)
            {
                throw new RuntimeException("Couldn't locate property file");
            }
        }//try
        catch (Exception e)
        {
            System.err.println("problem to load input stream.");
            e.printStackTrace();
            // System.exit(1);
        }
        try
        {
            db_props.load(in);
        }
        catch (Exception e)
        {
            System.err.println("problem to load properties.");
            e.printStackTrace();
            //System.exit(1);
        }


        return db_props.getProperty("username");
    }

}
