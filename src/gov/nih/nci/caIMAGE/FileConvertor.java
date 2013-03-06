/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE;

import java.awt.image.*;
import gov.nih.nci.caimage.db.*;
import gov.nih.nci.caIMAGE.util.*;
import java.lang.*;
import java.io.*;
import gov.nih.nci.caIMAGE.*;
import java.util.*;
import javax.swing.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.bigfoot.bugar.servlet.http.*;




public class FileConvertor {  



public  static void  Convertor(File[] file,Long imageId) {  
	String ftpfile = null;
	String folder = null;
	String directoryName = null;
	ServletConfig config  = null;
	String dbProp = null;
	String pathftp = null;
	
		try{
		pathftp = "/saic/projects/Test_Images/Model";
	 	System.out.println(" the path before window and unix is"+ pathftp);
		String urlName = "lpgdev101.nci.nih.gov";
		System.out.println("the url is"+urlName);	
		//this is Ftp
		FTPUtil.transfer(file, null, imageId,urlName, pathftp,"guptaa","lpgaja");	
		Thread.sleep(15000);	
		//String imagepartName = imageId+".sid";
		//System.out.println("The image partname"+imagepartName);
		//Object lookupfile = pathftp+"/output/"+imagepartName;
		//System.out.println("The file path is"+lookupfile);
		//File f = new File(lookupfile.toString());
		//System.out.println("The file is"+f.isFile() + f.canRead());
		//if(!f.isFile()  && !f.canRead()){
		//File  file2 = new File(lookupfile.toString());
		//File[] filearray = {file2};
		//String newpath = null;
		//newpath = "/usr/local/newLizardTech/TestImages/Model";
		//FTPUtil.transfer(filearray, null,imageId, urlName, newpath,"guptaa","lpgaja");	
		//}		
		} catch(InterruptedException e){
		e.printStackTrace();
		}
	} //file convertor sub
public  static void  Convertor(File[] file,Long imageId, String pathftp) {  
			
		try{
		String urlName = "lpgdev101.nci.nih.gov";
	  	System.out.println("the url is"+urlName);
		//this is Ftp
		FTPUtil.transfer(file, null, imageId,urlName, pathftp,"guptaa","lpgaja");	
		Thread.sleep(15000);	
		} catch(InterruptedException e){
		e.printStackTrace();
		}				
	}//ploymorhism Convertor
 
 
}//file convertor main


  

