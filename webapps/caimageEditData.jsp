
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
<%@ page errorPage = "Error.jsp " %>

<%@ include file="html/Submit_results_short.html"%>
<FORM method="POST" ENCTYPE ="multipart/form-data" NAME="form1"  action="caimageUsers.jsp">
<%System.out.println("=======Submission Page===============");

// constructor class
Species sp = new Species();
Annotations annot = new Annotations();
Publication pub = new Publication();
Strain str = new Strain();
Stain st = new Stain();
try{
	// Instantiate a MultipartFormData object for this request 
	//MultipartFormData multipart = new MultipartFormData(request, 5242880L ); //5 MB limit on files
	 MultipartFormData multipart = new MultipartFormData(request, 1024L * 1024L * 1024L );
	
	System.out.println("The multipart "+multipart);
	String imagetitle = null;
	String imagedesc = null;
	String image = null;
	String speciesreq = null;
	String organTissueCode = null;
	String organTissueName = null;
	String modality = null;
	Long annotation_id = null;
	
	//This is the image actual name which shall be used throuout
	imagetitle = request.getParameter("id").trim();
	System.out.println(" The value is"+imagetitle);
	String mode = request.getParameter("mode");
	//imagetitle = imagetitle.substring(0, imagetitle.lastIndexOf(".") );
	annotation_id = Long.valueOf(imagetitle) ;
	System.out.println(" The value is"+annotation_id);
	
	
	imagedesc = multipart.getParameter("imagedesc").trim();
	speciesreq = multipart.getParameter("species").trim();
	organTissueCode= multipart.getParameter("organTissueCode").trim();
	modality= multipart.getParameter("modality").trim(); 
	
	
	
	//System.out.println("i reached  here 2");	
	//image =  multipart.getFileName("myUploadObject");
	//System.out.println("i reached  here 3");	
	System.out.println("The values are "+imagetitle+imagedesc+image+modality+speciesreq);
	System.out.println("The lengths are image title "+imagetitle.length()+"organtissue code"+organTissueCode.length()+"modlaity"+modality.length()+"species"+speciesreq);
	//long filesize = multipart.getFileSize("myUploadObject");
	//System.out.println("The file size is *******"+filesize);
	
			if(  (imagetitle.length()!= 0) && (organTissueCode.length() != 0 ) && (speciesreq.length() != 0) && (modality.length() != 0)  ){
					System.out.println("I am in else loop");
					Enumeration input = multipart.getParameterNames();
					System.out.println("The input value is " +input);
					String donator = null;
					String organ  = null;
					String donator_email = null;
					String diagnosis  = null; 
					String speciesval  = null;
					KeyRetriever tk = new KeyRetriever();
				while(input.hasMoreElements()) {
			   		String name = (String) input.nextElement();
					String value = multipart.getParameter(name);
					System.out.println("The name is "+ name );
					System.out.println("The value is "+ value);
					StringBuffer whereBuf = new StringBuffer();
					String species = null;
					Long speciesl = null;
					System.out.println("here annotation id is ****"+annotation_id );
					annot.setAnnotation_id(annotation_id  );
					
					//image title
					if ( (name != null) && (name.equals("imagedesc") ) ){
					System.out.println("The value for  " + name +" is "+  value);
					annot.setImage_description(value);
					imagetitle = value;
					}//if
					//System.out.println("i reached  here 4");	
					//image description
					if ( (name != null) && (name.equals("imageannot") ) ){
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
									DiagnosisSubmission  diagnosisSubmission = new DiagnosisSubmission(dig, imagetitle,new Long(imagetitle),organTissueName, speciesreq  );
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
								if(value!=null){
									if (value.length() !=0){
										System.out.println("I am updating the new record");
										String publicationquery = "PUBLICATION_NAME = " +"'"+value+"'" ;
										System.out.println("publication query"+publicationquery );
										Vector pubv = pub.retrieveAllWhere( publicationquery);
										System.out.println("the length"+pubv.size());
										if (pubv.size() != 0){
											Long publicationid=null;
											for(int k =0; k < pubv.size(); k++){
												Publication  pubvec = (Publication) pubv.elementAt(k);
												publicationid = pubvec.getPublication_id();
												System.out.println(" value of publication "+publicationid);
											}//for
										pub.setPublication_id( publicationid );
										pub.setPublication_name(value);
										pub.updateByIndex();
										annot.setPublication_id(publicationid);
									} else {
										System.out.println("I am inserting the new record");
										if (value.length() !=0){
										Long pubcount = tk.getNextKey ("PUBLICATION");
										System.out.println("The pub int ***"+pubcount);
										pub.setPublication_id(pubcount);
										pub.setPublication_name(value);
										pub.insert();
										annot.setPublication_id(pubcount);
										}//if
									}//else
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
									System.out.println("I am in zero");
										if (!value.equals("0")){
										System.out.println("I am in not zero");
									annot.setStain_id(new Long(value));
										}
									}
						
								}
						}//if
						if ( (name != null) && (name.equals("Other") ) ){
									System.out.println("The value for " + name +" is "+  value);
										if(value!=null){
											Long stain_count = null;
											if (value.length() !=0){
											stain_count = tk.getNextKey ("STAIN");
											System.out.println("stain count"+stain_count);
											st.setStain_id(stain_count);
											st.setStain_name("Other");
											st.setStain_description(value);
											st.insert();
											}
										annot.setStain_id(stain_count);
									}
						}//if
							
							//Strain Submission
							if ( (name != null) && (name.equals("strain") ) ){
							System.out.println("The value for " + name +" is "+  value);
								if(value!=null){
									if (value.length() !=0){
										System.out.println("I am in zero");
										if (!value.equals("0")){
										System.out.println("I am in not zero");
										annot.setStrain_id(new Long(value));
										}
									}
								}
							}//if
							if ( (name != null) && (name.equals("Otherstrain") ) ){
										System.out.println("The value for " + name +" is "+  value);
											if(value!=null){
												Long strain_count = null;
												if (value.length() !=0){
													strain_count = tk.getNextKey ("STRAIN");
													System.out.println("strain count"+strain_count);
													str.setStrain_id(strain_count);
													str.setStrain_name(value);
													str.setStrain_source("Other");
													str.insert();
												}
											annot.setStrain_id(strain_count);
										}
							}//if
							//System.out.println("i reached  here 9");	
						}//while
		//annot.setCurated_id(new Long(2) );
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
		//annot.insert();
		annot.setCurated_id(new Long(1) );
		System.out.println("I reached here 1");
		annot.setAnnotation_id(annotation_id);
		System.out.println("I reached here 2");
		Annotations annotunmod = new Annotations();
		System.out.println("I reached here 3");
		annotunmod.retrieveByIndex(annotation_id );
		System.out.println("I reached here 4"+annotunmod.getImage_name());
		annot.setImage_name(annotunmod.getImage_name());
		System.out.println("I reached here 5");
		annot.setCatalog_id(annotunmod.getCatalog_id());
		System.out.println("I reached here 6");
		boolean status = annot.updateByKey();		
		System.out.println("the status is"+status);
		%>
		<center><H4>The annotations including changes for image  
		<%=annotation_id%> have been saved to the database. <br>
		To prevent misuse of the application each image will be screened before it appears online. 
		</H4>
		<input TYPE="submit" NAME="goback" VALUE=" Submit/Edit Another Image" >&nbsp;&nbsp;
		</center> 
		<%	}	else { %>
						<h4><font color="red" >Error: Missing Required Fields</font><br><br></H4> 
						<h4>The record could not be added because the following required fields were left empty:</H4><br>
						<%if (imagetitle.length() <= 0 ) { %>
						<h4><font color="red" >Image Name</font><br></h4>
				 		<%} 
						if (organTissueCode.length() <= 0 ) { %> 
						<h4><font color="red" >Organ Tissue Name</font><br></h4>
						<%} 
						if (speciesreq.length() <= 0 ) { %> 
						<h4><font color="red" >Species Name</font><br></h4> 
						<%} 
						if(modality.length() <= 0 ) {%>
						<font color="red" >Modality</font><br><br></H4> 
						<%}%>
		
					<h4>Please go back using your browser's back button, and enter a values for these fields.</h4>
			<%	}

} catch (EOFException eof) {
	eof.printStackTrace(); 
} %>

</FORM>
<%@ include file="html/submit_results_bot.htm"%> 


</body>
</html>	




