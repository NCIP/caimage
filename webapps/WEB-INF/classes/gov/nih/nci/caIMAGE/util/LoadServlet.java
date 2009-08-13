package gov.nih.nci.caIMAGE.util;

import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import gov.nih.nci.caIMAGE.*;
import java.io.*;

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
       ServletContext context = config.getServletContext();
		// Find out the server type unix or windows
		 String userDir = System.getProperty("user.dir");
		 System.out.println(userDir);
		 String dbImagePropDir = null;
 		 String imageDir = null;
		 if(userDir.indexOf(":")!= -1){ //if a windows system
		 	dbImagePropDir = context.getInitParameter ("dbProp_IMAGE_WIN32");
		 	//imageDir = context.getInitParameter ("image_WIN32");
		 }
		 else{
		 	dbImagePropDir = context.getInitParameter ("dbProp_caIMAGE_UNIX");
		 	//imageDir = context.getInitParameter ("image_UNIX");

		 }

	   //System.out.println (" Load caIMAGEimageDir  " +
       //  (imageDir != null ? "succeeded" : "failed"));
	   //if(imageDir != null){
	   //	System.setProperty("imageDir",imageDir);
		//}


  	   System.out.println(dbImagePropDir);
       System.out.println (" Load dbImageProp  " +
         (dbImagePropDir != null ? "succeeded" : "failed"));
		Properties props = new Properties();

   FileInputStream fis = new FileInputStream(dbImagePropDir);
  		props.load(fis);
  		database.setImageDBProperties(props);
		fis.close();


		}
		catch(Exception e){
		System.out.println(" Error in Init for Loadservlet");
		e.printStackTrace();
		}
	}
}

