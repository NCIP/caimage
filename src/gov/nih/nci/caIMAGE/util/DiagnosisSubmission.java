/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;
/*
 * diagnosisSubmission.java
 * Created on August 29, 2002
 * author  Dana Zhang SAIC
 * @version 1.0
 */
 
 import java.io.*;
 import java.sql.*;
 import java.text.*;
 import java.util.*;
 import javax.swing.text.html.*;

 import gov.nih.nci.caIMAGE.util.*;

 //import nci.mmhcc.db.*;
 
 /**
 * This class handles the geeration, and submission via email, of a MMHCC
 * diagnosis(which is not included in the EVS database from Histopathology page.
 */
 
 public class DiagnosisSubmission {
  
        // ---------------------------------------
       //   Mail related variables
       //-------------------------------------------
	   
   private static final String HOST = "mailfwd.nih.gov";
   private static final String TO   = "decorons@mail.nih.gov";
   //private static final String TO   = "guptaa@mail.nih.gov";
   private static final String FROM = "caimage@pop.nci.nih.gov";		
   private static final String CC   = "ulrike@mail.nih.gov";
   //private static final String CC   = "guptaa@mail.nih.gov";  
   private static final String BCC  = "guptaa@mail.nih.gov";
   private static final String SUBJECT = " New Diagnosis Submission";
   
   
   private String[] diagnoses   = null;
   private String imageName = null;
   private Long imageId = null;
   private String organName = null;
   private String species = null; 
   private StringBuffer submissionBuffer = new StringBuffer();
   
   
   //-------------------------------------------
   //    Variables used in the HTML 
   //-------------------------------------------
   
   private static final String NEW_LINE = "\n";
   private static final String DOUBLE_SPACE = "&nbsp;&nbsp;";
   private static final String HEADER   = 
      "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\"> " + NEW_LINE;
	
   
   public DiagnosisSubmission(String[] names, String imageName, Long imageId,String organName, String species){
      diagnoses = names;
	  this.imageName = imageName;
	  this.imageId = imageId;
	  this.organName = organName;
	  this.species = species;
	  }
	  
  public void sendStrainSubmission(){
    submissionBuffer.append(HEADER);
	submissionBuffer.append("<html>" + NEW_LINE);
	submissionBuffer.append("<head>" + NEW_LINE);
	submissionBuffer.append("<title> Diagnosis Submssion</title>" + NEW_LINE);
	submissionBuffer.append("</head>" +  NEW_LINE);
	submissionBuffer.append("<body><br><br>" + NEW_LINE);
	submissionBuffer.append("<FONT style=\"font-family:sans-serif\"><BR>" + NEW_LINE);
	submissionBuffer.append("<H3> caIMAGE "+ species+" Diagnosis Submission:</H3><BR>" + NEW_LINE + NEW_LINE);
	submissionBuffer.append("<P>" + NEW_LINE);
	submissionBuffer.append("<B> Image Name:</B>" + DOUBLE_SPACE + imageName + "<BR>" + NEW_LINE);
	submissionBuffer.append("<B> Image ID:</B>" + DOUBLE_SPACE + imageId + "<BR>" + NEW_LINE);
	submissionBuffer.append("<B> Site of Lesion / Tumor:</B>" + DOUBLE_SPACE + organName + "<BR>" + NEW_LINE);
	if(diagnoses.length >0){
	for(int i = 0; i<diagnoses.length; i++){
	  submissionBuffer.append("<B> Diagnosis " + (+i+1) +":</B>" + DOUBLE_SPACE + diagnoses[i] + "<BR>" + NEW_LINE);
	}
	}
	submissionBuffer.append("<B> To access the model:</B><BR><BR>" + NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + "1.	Enter the caIMAGE Website (http://cancerimages.nci.nih.gov/caIMAGE/index.jsp).<BR>" +NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + "2.	The disclaimer page will appear; click on \"clicking here\".<BR>" +NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + "3.	The Images home page will appear; click on the \"Submit\" bubble (on the right).<BR>" +NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + "4.	All thumbnail images appear on the screen after being logged in, you can view the image by clicking on<BR>" +NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + DOUBLE_SPACE + "    the image name that appears in this email.<BR><BR>" +NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + "If you have any questions, please contact Ulli Wagner.<BR><BR>" +NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + "Thank you for your cooperation.<BR><BR>" +NEW_LINE);
	submissionBuffer.append(DOUBLE_SPACE + "caIMAGE Cancer Images Database <BR><BR>" +NEW_LINE);
	submissionBuffer.append("</P><BR>" + NEW_LINE);	
	submissionBuffer.append("</body>" + NEW_LINE);
	submissionBuffer.append("</html>" + NEW_LINE);
	MailUtil mail = new MailUtil
            (HOST, submissionBuffer.toString(), FROM, TO, CC, BCC,SUBJECT, null);
	mail.sendHtmlMessage();		
	 }
	public static void main(String[] args){
	 String diagnosis = args[0];
	 String diagnosis2 = args[1];
	 String organName = args[2];
	 String[] diagnosisArray = {diagnosis,diagnosis2};	 
	 
	 //DiagnosisSubmission  diagnosisSubmission = new DiagnosisSubmission(diagnosisArray, "123", new Long(1474),organName,new Long(1002));
	 //diagnosisSubmission.sendStrainSubmission();
	}
}
	


	
   
   
    
   
   
  
  
  
 
  
