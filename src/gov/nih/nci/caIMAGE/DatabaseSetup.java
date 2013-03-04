/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See https://github.com/NCIP/caimage/LICENSE.txt for details.
 */

//	Himanso Sahni
//	SAIC NCI
//	MMHCC
//  Jan 16,2000
 
  
package gov.nih.nci.caIMAGE;

import java.lang.*;
import java.util.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
//import nci.mmhcc.db.*;
import gov.nih.nci.caimage.db.*;
import gov.nih.nci.caIMAGE.util.*;
import java.text.*;
import com.bigfoot.bugar.servlet.http.*; //for multipartformdata

public class DatabaseSetup  {
//private static nci.mmhcc.db.DatabaseAccess mmhcc_db;//from mouse model tablegen mmhcc package
private gov.nih.nci.caimage.db.DatabaseAccess image_db;//from caimage tablegen
 // public void  setImageDBProperties(Properties props){
 public void  setImageDBProperties(){
      try{   
			if (image_db == null){
		         image_db = new gov.nih.nci.caimage.db.DatabaseAccess();
				 }
		} catch(IOException io)
		{
		io.printStackTrace();
		}
  }
/*
    public void  setMMHCCDBProperties(Properties props){
         if (mmhcc_db == null){
         mmhcc_db = new nci.mmhcc.db.DatabaseAccess(props);
		 //Lookup lookup = Lookup.getInstance();		 
		 }
  }
*/
  public boolean  getDBStatus(){
        return ((image_db==null )?false:true);
  }  
  public static boolean checkRequiredFeilds(HttpServletRequest req, String navBar ){
   boolean rc = false;
    Enumeration  paramNames = req.getParameterNames();
	Vector missing_feilds = new Vector();
	boolean isRequiredMissing = false;
	while(paramNames.hasMoreElements()){
	    String name = (String)paramNames.nextElement();
		String required = "required_";
		if(name.indexOf(required) != -1){
			if(req.getParameter(name).length()<= 0){
				isRequiredMissing = true;
				missing_feilds.add(name.substring(required.length()));
			}
		}
	}//end while
		if(isRequiredMissing){
		req.setAttribute("nci.mmhcc.MissingFeilds",missing_feilds);
		req.setAttribute("nci.mmhcc.navBar",navBar);
		rc = true;
		}
	return rc;
	}
	
   public static boolean checkMissingRequiredFields(HttpServletRequest req ){
   boolean rc = false;
    Enumeration  paramNames = req.getParameterNames();
	Vector missing_feilds = new Vector();
	boolean isRequiredMissing = false;
	while(paramNames.hasMoreElements()){
	    String name = (String)paramNames.nextElement();
		String required = "required_";
		if(name.indexOf(required) != -1){
			if(req.getParameter(name).length()<= 0){
				isRequiredMissing = true;
				missing_feilds.add(name.substring(required.length()));
			}
		}
	}//end while
		if(isRequiredMissing){
		req.setAttribute("nci.mmhcc.MissingFeilds",missing_feilds);
		
		rc = true;
		}
	return rc;
	}
   public static boolean checkMissingRequiredFields(HttpServletRequest req, MultipartFormData multipart ){
   boolean rc = false;
    Enumeration  paramNames = multipart.getParameterNames();
	Vector missing_feilds = new Vector();
	boolean isRequiredMissing = false;
	while(paramNames.hasMoreElements()){
	    String name = (String)paramNames.nextElement();
		String required = "required_";
		if(name.indexOf(required) != -1){
			if(multipart.getParameter(name).length()<= 0){
				isRequiredMissing = true;
				missing_feilds.add(name.substring(required.length()));
			}
		}
	}//end while
		if(isRequiredMissing){
		req.setAttribute("nci.mmhcc.MissingFeilds",missing_feilds);
		
		rc = true;
		}
	return rc;
	}
	public static void gotoSuccessPage(HttpServletRequest request, HttpServletResponse response,
			String nextPageNavBar, String previousPageName, String previousPageAddress,String nextPageAddress)
			throws ServletException, IOException {
			request.setAttribute("nci.mmhcc.navBar", nextPageNavBar);
			request.setAttribute("nci.mmhcc.prevPageName",previousPageName);
			request.setAttribute("nci.mmhcc.prevPageAddress",previousPageAddress);
			request.setAttribute("nci.mmhcc.nextPageAddress",nextPageAddress);
			gotoPage("successfulAdd.jsp",request,response);									 
	}
	
	public static void setPageExpiration(HttpServletResponse response){
		long currentTime = System.currentTimeMillis();
   		long timeLimit = 30*60*1000; //in milliseconds (30 min)
   		long expires = currentTime + timeLimit; 
   		response.setHeader("Cache-Control","max-age="+ expires);
   		response.setDateHeader("Expires",expires);
	}
	
	private static void gotoPage(String address,
                      HttpServletRequest request,
                      HttpServletResponse response)
    throws ServletException, IOException {
  		RequestDispatcher dispatcher =
   		 	request.getRequestDispatcher(address);
  			dispatcher.forward(request, response);
}
public static String checkForNull(String string){
		if(string == null){
			string = "&nbsp;";
		}
		return string;
}
public static String checkForNull(Long longValue){
	String string = null;
		if(longValue == null){
			string = "&nbsp;";
		}
		else{
			string = longValue.toString();
		}
		return string;
}
public static String removeNull(String string){
		if(string == null){
			string = "";
		}
		return string;
}
public static String removeNull(Long longValue){
	String string = null;
		if(longValue == null){
			string = "";
		}
		else{
			string = longValue.toString();
		}
		return string;
}
public static String removeNull(Long longValue, Long longValue2, String tableName){
	String string = null;
		if((longValue == null)&&(longValue2 == null)&&(tableName==null)){
			string = "";
		}
		else{
			string = longValue.toString()+ longValue2.toString() + tableName;
		}
		return string;
}


}

