/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;


import java.lang.*;
import java.util.*;
import java.sql.*;
import java.io.*;
import gov.nih.nci.caimage.db.*;
import gov.nih.nci.caIMAGE.*;


public class LizardtechConverter
{
    public static void converttransfer(String caimage_script,
                                       long filesize) throws InterruptedException
    {
        long time1 = System.currentTimeMillis();
        long time2 = 0;

        try
        {
            Runtime r = Runtime.getRuntime();
            //this is for lpgprot
            //for cbiodev104
            String timing = "bash " + caimage_script + "timing.sh";
            String imagecopy = "bash " + caimage_script + "imagecopy.sh";

            //Process p = r.exec("bash /usr/local/tomcat4/webapps/caIMAGE/timing1.sh" +"\n" );
            Process p = r.exec(timing + "\n");

            //Converter time is set here depending upon size
            //half the time on 01/16/2003
            if (filesize >= 0 && filesize <= 100000)
            {

                Thread.sleep(filesize);
                Process p1 = r.exec(imagecopy + "\n");

            }
            else if (filesize >= 100000 && filesize <= 2000000)
            {

                Thread.sleep(filesize / 6);
                Process p2 = r.exec(imagecopy + "\n");

            }
            else if (filesize >= 2000000 && filesize <= 5242880)
            {

                Thread.sleep(filesize / 10);
                Process p3 = r.exec(imagecopy + "\n");

            }
            else
            {

                //Thread.sleep(filesize/50);
            }


            time2 = System.currentTimeMillis();
            System.out.println("i am at the end");
        }//try
        catch (IOException ex)
        {
            ex.printStackTrace();
            System.err.println("Error: " + ex.toString() + "\n");
        }

        System.err.println("The time converter used is : " + (time2 - time1) + "\n");
    }//convert

}
