/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;

import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import gov.nih.nci.caIMAGE.*;
import java.io.*;
import java.sql.*;
import gov.nih.nci.caimage.db.*;
/*
 * LoadServlet.java
 * Created on April 2, 2001, 5:08 PM
 * @author Himanso Sahni SAIC
 * @version 1.0
 */

public class LoadServlet extends HttpServlet 
{
    private DatabaseSetup database = new DatabaseSetup(); //coming form this gov.nih.nci.caIMAGE.
    public void init(ServletConfig config)
      throws ServletException
    {
       super.init(config);    // required
		try{
			database.setImageDBProperties();
		
		}
		catch(Exception e){
		System.err.println(" Error in Init for Loadservlet");
		e.printStackTrace();
		}
	}
	public void destroy() {
	   try{
	   DatabaseAccess  databaseAcess = new DatabaseAccess ();
	   
	   databaseAcess.destroy();
	   } catch(Exception ex) {
	   System.err.println("I am in destroy method from load servlet"+ex );
	   }
      }
}

