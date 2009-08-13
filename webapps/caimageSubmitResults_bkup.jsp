<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN""http://www.w3.org/TR/REC-html40/frameset.dtd">
<html>

<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %> 
<%@ page import = "java.text.*" %> 
<%@ page import = "java.lang.*"  %>
<%@ page import = "java.net.URL"  %>
<%@ page import = "java.io.*"  %>
<%@ page import="com.oroinc.io.Util"%>
<%@ page import="com.oroinc.io.CopyStreamException"%>
<%@ page import="com.bigfoot.bugar.servlet.http.*"%>
<%@ page buffer="32kb"%>
<%@ page import = "java.net.URLDecoder"  %>
<%@ page import = "java.net.URLEncoder"  %>
<%//@ page errorPage = "Error.jsp " %>


<head>
<!-- This is for making the images to UTF format -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cancer Models Database - Submission</title>
<LINK rel="stylesheet" type="text/css" href="images/submission.css">
</head>

<body>
<%@ include file="html/Submit_results_short.html"%>
<FORM method="POST" ENCTYPE ="multipart/form-data" NAME="form1"  action="caimageSubmit.jsp">


<!--- <FORM method="POST"  name = "form1" >  --->
<!--- <%//@ include file="tabsimage.htm"%> --->
<%System.out.println("=======Submission Page===============");

// constructor class
Species sp = new Species();
Annotations annot = new Annotations();
Publication pub = new Publication();
try{
// Instantiate a MultipartFormData object for this request 
//MultipartFormData multipart = new MultipartFormData(request, 5242880L ); //5 MB limit on files
 MultipartFormData multipart = new MultipartFormData(request, 1024L * 1024L * 1024L );

System.out.println("The multipart "+multipart);

String imagetitle = null;
String imagedesc = null;
String image = null;
String speciesreq = null;
String organTissueName = null;
String modality = null;
Long annotation_id = null;

imagetitle = multipart.getParameter("imagetitle").trim();
imagedesc = multipart.getParameter("imagedesc").trim();
speciesreq = multipart.getParameter("species").trim();
organTissueName= multipart.getParameter("organTissueName").trim();
organTissueName= multipart.getParameter("modality").trim(); 

//System.out.println("i reached  here 2");	
image =  multipart.getFileName("myUploadObject");
//System.out.println("i reached  here 3");	
System.out.println("The values are "+imagetitle+imagedesc+image);
System.out.println("The lengths are "+imagetitle.length()+imagedesc.length()+image.length());
long filesize = multipart.getFileSize("myUploadObject");
System.out.println("The file size is *******"+filesize);

if(filesize <= 25000 ) { 
System.out.println("I reached here"); %>
<center><h4>File size  has to be greater than 25 kb.</h4>
<input TYPE="submit" NAME="goback" VALUE=" Go back to previous Page" >&nbsp;&nbsp;</center>
<%} else if(filesize >= 25000  &&  filesize <= 1024L * 1024L * 1024L  ) {
if(  (imagetitle.length()<= 0) && (imagedesc.length() <= 0 ) && (image.length() <= 0) || (speciesreq.length() <= 0) ){%> 
<H4> Please enter the required field. <br>
	<%if (imagetitle.length() <= 0 ) { %>
	<font color="red" >Image Title </font><br><br>
 	<%} else if (imagedesc.length() <= 0 ) { %> 
	<font color="red" >Image Description</font><br><br>
	<% } else if (speciesreq.length() <= 0 ) { %> 
	<font color="red" >Species</font><br><br>
	<% } else if(image.length() <= 0  && filesize >= 27647 ) {%>
	<font color="red" >Upload Image </font><br><br></H4>
	<%  }
} else {
	System.out.println("I am in else loop");
	Enumeration input = multipart.getParameterNames();
	System.out.println("The input value is " +input);
	String donator = null;
	String organ  = null;
	String donator_email = null;
	String diagnosis  = null; 
	String imagename = null;
	String speciesval  = null;
	while(input.hasMoreElements()) {
   		Long l = new Long(30);
		annot.setCatalog_id(l);
		String name = (String) input.nextElement();
		String value = multipart.getParameter(name);
		System.out.println("The name is "+ name );
		System.out.println("The value is "+ value);
		StringBuffer whereBuf = new StringBuffer();
		String species = null;
		Long speciesl = null;
		System.out.println("here is the count****"+annot.count() );
		Integer annotcount = new Integer(annot.count() +1);
		annotation_id = new Long(annotcount.toString() );
		annot.setAnnotation_id(annotation_id  );
		
		//image title
		if ( (name != null) && (name.equals("imagetitle") ) ){
		System.out.println("The value for  " + name +" is "+  value);
		annot.setImage_description(value);
		imagename = value;
		}//if
		//System.out.println("i reached  here 4");	
		//image description
		if ( (name != null) && (name.equals("imagedesc") ) ){
		System.out.println("The value for  " + name +" is "+  value);
		annot.setImage_annotations(value);
		}//if
		//System.out.println("i reached  here 5");	
		//Species Submission
		if ( (name != null) && (name.equals("species") ) ){
		System.out.println("The value for " + name +" is "+ value);
		speciesval = value;
		 	if(speciesval != null){
				if(speciesval.length() != 0 && !speciesval.equals("null") ) {
				//name to id conversion
					String searchstring = "SPECIES_NAME = " + "'"+speciesval+"'" ;
					Vector spec = sp.retrieveAllWhere(searchstring);
					for(int k =0; k < spec.size(); k++){
							Species  spvec = (Species) spec.elementAt(k);
							speciesl = spvec.getSpecies_id();
					System.out.println(" value of long species "+speciesl);
					annot.setSpecies_id(speciesl);
					}//for
				}//if
			}//if species val
		}//if
		
		// OrganTissue  Submission
		if ( (name != null) && (name.equals("organTissueCode") ) ){
		//System.out.println("The value for organTissueCode is "+ value);
			organ = value;
			if(organ!=null){
				if(organ.indexOf(",")!=-1){// this is for generic diagnosis search
				organ = organ.substring(organ.indexOf("C")+1 ,organ.indexOf(",") ) ;
				System.out.println("the organTissue ids "+organ);
					if (value.length() !=0){
						annot.setOrgan(organ);
						}
				}//if
			else{
				 organ = organ.substring(organ.indexOf("C")+1  ) ;
				System.out.println("the else organTissue ids "+organ);
					if (value.length() !=0){
						annot.setOrgan(organ);
					}
			}//else
		}//if organ
	}//if name
			//System.out.println("i reached  here 6");	
		//Diagnosis Submission
		if ( (name != null) && (name.equals("DiagnosisCode") ) ){
		System.out.println("The value for DignosisCode is "+ value);
			diagnosis = value;
			if(diagnosis!=null){ //multivalue comma seperated
				if(diagnosis.indexOf(",")!=-1){// this is for generic diagnosis search
			    diagnosis = diagnosis.substring(diagnosis.indexOf("C")+1 ,diagnosis.indexOf(",") ) ;
				System.out.println("the Dignosis ids "+diagnosis);
					if (value.length() !=0){
					annot.setConcept_id(diagnosis);
					}//value
				}
				else {//single value comma seperated
				 diagnosis = diagnosis.substring(diagnosis.indexOf("C")+1 ) ;
				System.out.println("the  else Dignosis ids "+diagnosis);
					if (value.length() !=0){
						if(diagnosis.equals("000000")){
						System.out.println("I made it here"+name+value);
							/*
							if ( name.equals("DiagnosisName") ) {
								System.out.println("I made it here too");
								System.out.println("the diagnosis entered name is"+value);
								annot.setTumor_classification(value);
								Mail mail = new Mail("localhost", "guptaa@mail.nih.gov", "guptaa@mail.nih.gov","subject","content");
								}*/
						annot.setConcept_id(diagnosis);
						}else
						{
						annot.setConcept_id(diagnosis);
						}
					}//value
				}//else
					
				 }//if diagnosis
		} 
		// DignosisName Submission
		if ( (name != null) && (name.equals("DiagnosisName") ) && diagnosis.equals("000000")  ){
		System.out.println("The value for  " + name +" is "+  value +diagnosis);
			if (value != null){
				if (value.length() !=0){
				annot.setTumor_classification(value);
				String[] dig = {value};
				DiagnosisSubmission  diagnosisSubmission = new DiagnosisSubmission(dig, annotcount.toString()+".sid",new Long(annotcount.toString()),organTissueName, speciesreq  );
	 			diagnosisSubmission.sendStrainSubmission();
				//Mail mail = new Mail("mailfwd.nih.gov", "guptaa@mail.nih.gov", "guptaa@mail.nih.gov","subject","New Evs ID"+value);
				
				}
			}
		}//if
		
		// Gender Submission
		if ( (name != null) && (name.equals("gene") ) ){
		System.out.println("The value for  " + name +" is "+  value);
			if (value != null){
				if (value.length() !=0){
				annot.setGene(value);
				}
			}
		}//if
		if ( (name != null) && (name.equals("promoter") ) ){
		System.out.println("The value for  " + name +" is "+  value);
			if (value != null){
				if (value.length() !=0){
				annot.setPromoter(value);
				}
			}
		}//if
		
		//System.out.println("i reached  here 7");	
		// Gender Submission
		if ( (name != null) && (name.equals("gender") ) ){
		System.out.println("The value for  " + name +" is "+  value);
			if (value != null){
				if (value.length() !=0){
				annot.setGender_id(new Long(value));
				}
			}
		}//if
		
		//Publication Submission
		if ( name != null &&  name.equals("PMID")  ){
			System.out.println("I am in publication id");
			System.out.println("The value for  " + name +" is "+ value);
			int pubint = pub.count()+1;
			System.out.println("The pub int ***"+pubint);
			if(value!=null){
				if (value.length() !=0){
				pub.setPublication_id( new Long(new Integer(pubint).longValue()) );
				pub.setPublication_name(value);
				pub.insert();
				annot.setPublication_id(new Long(new Integer(pubint).longValue()) );
				}
			}
		}
		
		//System.out.println("i reached  here 8");	
		//Donator Submission
		Long donatorid = (Long)session.getAttribute("nci.mmhcc.submitter.submitterKey");
		System.out.println("the donator id is"+donatorid);
		if (donatorid != null ){
		annot.setDonator_id(donatorid);
		}
		//Stain Submission
		if ( (name != null) && (name.equals("stain") ) ){
		System.out.println("The value for  " + name +" is "+  value);
			if(value!=null){
				if (value.length() !=0){
				annot.setStain_id(new Long(value));
				}
			}
		}//if
		
		//Strain Submission
		if ( (name != null) && (name.equals("strain") ) ){
		System.out.println("The value for " + name +" is "+  value);
			if(value!=null){
				if (value.length() !=0){
				annot.setStrain_id(new Long(value));
				}
			}
		}//if
		//System.out.println("i reached  here 9");	
	}//while
}//if
System.out.println("I am in images");
	String  uploadObject = multipart.getFileName("myUploadObject") ;
	System.out.println("I am in upload object"+uploadObject);
	String imageDir = multipart.getLocalPath("myUploadObject");
	System.out.println("image directory is"+imageDir);
 	imageDir = imageDir.substring(0,imageDir.lastIndexOf(File.separator));
 	System.out.println("imageDir:"+imageDir);
	
 	if ( uploadObject !=null && !uploadObject.equals("") ){
	System.out.println("I am in images");
	//System.out.println("The value for  " + name +" is "+  value);
		String imagename = null;
		//this is correct
		
		if(uploadObject.indexOf("\\") != -1) { //uploaded file from windows
		imagename = uploadObject.substring(uploadObject.lastIndexOf("\\")+1, uploadObject.length() );
		} else if (uploadObject.indexOf("/") != -1) { //uploaded file from unix or linux
			  imagename = uploadObject.substring(uploadObject.lastIndexOf("/")+1, uploadObject.length() );
			  }
			  else { //if(uploadObject.indexOf(":") != -1) { //uploaded file from macs
			     imagename = uploadObject.substring(uploadObject.lastIndexOf("null")+1, uploadObject.length() );
			  }

					  
		System.out.println("The image name is *********"+imagename);
		String lizard = getServletConfig().getServletContext().getInitParameter("lizard");
		String lizardwindow = getServletConfig().getServletContext().getInitParameter("lizard_Window");
		System.out.println("lizardwindow :"+lizardwindow); 
		String path = getServletConfig().getServletContext().getInitParameter("ftppath");
		System.out.println("path :"+path); 
		String ftpusername = getServletConfig().getServletContext().getInitParameter("ftpusername");
		System.out.println("ftp username :"+ftpusername); 
		String ftppwd = getServletConfig().getServletContext().getInitParameter("ftppwd");
		System.out.println("ftp pwd :"+ftppwd); 
		System.out.println("the windows parameters are"+ lizard);
	
		File filen = new File( imageDir,imagename);	
 		System.out.println("imageName:"+imagename);
  		new File( multipart.getLocalPath( "myUploadObject" ) ).renameTo( filen );
  		File[] filearray = {filen}; 				 
		System.out.println("image directory is"+imageDir);		
		String ftpurl = getServletConfig().getServletContext().getInitParameter("ftpurl");
		System.out.println("ftp url :********"+ftpurl.trim()); 
			
		//File file = new File("abc");
		//File[] filearray = {file};
		String newPath = path+"/External/Donator/Tissue/Diagnosis";
		System.out.println("the new path is "+ newPath);
			 //This is for sid images
			 if(imagename.substring(imagename.lastIndexOf(".")+1).trim().equalsIgnoreCase("sid") ){
			 System.out.println("I am in unix ftp command");
			 FTPUtil.transfer(filearray, null,  annotation_id , ftpurl.trim(), newPath.trim(), ftpusername.trim(), ftppwd.trim());
			//temporary closed
			annot.setImage_name(new Long(annot.count()+1)+".sid");
			} 
			//this is for non sid format
			else
			 { //Convertor module start from here
			  	long time1 = System.currentTimeMillis();
				long time2  = 0;
				System.out.println("I am in converter"+filearray+"\n");
				String savePath = getServletConfig().getServletContext().getInitParameter("ftppath");
				System.out.println("ftp path :"+savePath); 
				String convurl = getServletConfig().getServletContext().getInitParameter("convurl");
				System.out.println("conv url :********"+convurl.trim()); 
				String convPath = getServletConfig().getServletContext().getInitParameter("convpath");
				System.out.println("conv path :"+convPath); 
				String convusername = getServletConfig().getServletContext().getInitParameter("convusername");
				System.out.println("conv username :"+convusername); 
				String convpwd = getServletConfig().getServletContext().getInitParameter("convpwd");
				System.out.println("conv pwd :"+convpwd); 
				String convpathout = convPath +"/Output";
				System.out.println("the output path"+convpathout);
				String converrorpath = getServletConfig().getServletContext().getInitParameter("converrorpath");
				System.out.println("the error path"+converrorpath);
				
				//FTPUtil.transfer(filearray, null,  new Long(annot.count()+1), convurl.trim(), "/encode/enc6", "tomcat", "lpgtom");
			  	
  				//First time transfer the file to the convertor
			  	FTPUtil.transfer(filearray, null,  annotation_id , convurl.trim(),convPath.trim(), convusername.trim(), convpwd.trim());
			  	System.out.println(" Transfer complete"+"\n"+"\n");
				//waiting for converter to convert
				//wait();
				Thread.sleep(1500);
			  	//Look for the following file name which is determined 
				File ftpfile = new File(annotation_id +".sid");
			  	//Ftp from ftp server to destination server
				String orgimage = annotation_id +imagename.substring(imagename.lastIndexOf("."), imagename.length() );
				File orgfile = new File(orgimage);
					annot.setImage_name(new Long(annot.count()+1)+".sid");
				try {
				Runtime r = Runtime.getRuntime();
				String bName = request.getHeader("User-Agent");
				System.out.println("the value of opertaing system is"+bName);
					//this is for lpgprot
					Process p = r.exec("bash /encode/timing1.sh" +"\n" );
					//this is for cbiodev102
					//Process p = r.exec("bash /encode/timing.sh" +"\n" );
					System.out.println("The timing1 worked"+p);
					System.out.println("I have copied files to lizardtech directory second time"+" \n"+p);
					//Converter time is set here depending upon size
					//half the time on 01/16/2003
					if (filesize >= 0 && filesize <= 100000) {
					System.out.println(" I am in 1st"+filesize);
					Thread.sleep(filesize);
					Process p1 = r.exec("bash /encode/imagecopy.sh" +"\n" );
					System.out.println("The image copy worked"+p1);
					} else if (filesize >= 100000 && filesize <= 2000000) {
					System.out.println(" I am in 2nd"+filesize);
					Thread.sleep(filesize/5);
					Process p2 = r.exec("bash /encode/imagecopy.sh" +"\n" );
					System.out.println("The image copy worked"+p2);
					} else if (filesize >= 2000000 && filesize <= 5242880) {
					System.out.println(" I am in 3rd"+filesize);
					Thread.sleep(filesize/9);
					Process p3 = r.exec("bash /encode/imagecopy.sh" +"\n" );
					System.out.println("The image copy worked"+p3);
					}else {
					System.out.println(" I am in 4th"+filesize);
					//Thread.sleep(filesize/50);
					}
					
					//Not for the big images
					//Process p1 = r.exec("bash /encode/imagecopy.sh" +"\n" );
					//System.out.println("The image copy worked"+p1);
					//Converter to destination transfer.
					//FTPUtil_3.transfer("555.sid","555.sid","555", "lpgdev101.nci.nih.gov","encode/enc/Output","/user/local/.../external",  "lizard", "ncicb..." );
					//FTPUtil_3.transfer(orgimage,ftpfile, new Long(annot.count()+1), ftpurl.trim(),convpathout, newPath,  ftpusername.trim(), ftppwd.trim() );
					
					time2 = System.currentTimeMillis();
					//boolean success = FTPUtil_3.failedoperation();
					//System.out.println("i am at the end"+success);
					//if ( !success ) {
					//FTPUtil_3.transfer(orgimage,null, new Long(annot.count()+1), ftpurl.trim(),converrorpath , newPath,  ftpusername.trim(), ftppwd.trim() );
					//This works
					//FTPUtil_3.transfer(orgimage,ftpfile, new Long(annot.count()+1), convurl.trim(), ftpurl.trim(),"/encode/enc6/Input", newPath,  convusername.trim(), convpwd.trim(),  ftpusername.trim(), ftppwd.trim() );
					//}
					System.out.println("i am at the end");
				}//try
				 catch (IOException ex) {
				  ex.printStackTrace();
				  System.out.println("Error: " + ex.toString() + "\n");
				}
				
				System.out.println("The time converter used is : " + (time2- time1)+ "\n");
			}//else convertor
			filen.delete();
			multipart.cleanUp();
annot.setCurated_id(new Long(2) );
Locale locale = Locale.getDefault();
TimeZone tz = TimeZone.getDefault();
DateFormat  myFormat = DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL, locale);
myFormat.setTimeZone(tz);
DateFormat df = DateFormat.getDateInstance(DateFormat.LONG, Locale.US);
Date d = new Date() ;
          
System.out.println("The local time is"+ myFormat.format(d) );
annot.setDatetime(myFormat.format(d) );
//annot.setDatetime(Long.toString(System.currentTimeMillis()));
annot.getAnnotation_id();
System.out.println("the annotation id"+annot.getAnnotation_id() );
annot.insert(); %>
<center><H4>The image and associated information you submitted were entered as record 
<%=new Long(annot.count())%>  in the database. <br>
To prevent misuse of the application each image will be screened before it appears online. 
</H4>
<input TYPE="submit" NAME="goback" VALUE=" Submit Another Image" >&nbsp;&nbsp;
</center> 
<%}//if upload object
}//if file size

 }catch(com.bigfoot.bugar.servlet.http.ByteLimitExceededException ble) {  
 					//Vector byte_errors = new Vector();
					//byte_errors.add("upload file larger than 5 MB");
					pageContext.handlePageException(ble);
					//request.setAttribute("nci.mmhcc.MissingFeilds", byte_errors);
					 ble.printStackTrace(); 
					  //System.out.println("Error: " + ble.toString() + "\n");%>
					 I reached here
					<jsp:forward page="missing_required_feilds.jsp"/>
					<%System.out.println("The size is larger than 5 MB");
					return;
				
	} catch (EOFException eof) {
	eof.printStackTrace(); 
	}
%>

</FORM>
<%@ include file="html/search_results_bot.htm"%>

</body>
</html>	
