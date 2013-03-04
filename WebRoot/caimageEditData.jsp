<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See https://github.com/NCIP/caimage/LICENSE.txt for details.
L--%>

<%@ page language="java"%>
<%@ page import="gov.nih.nci.caimage.db.*"%>
<%@ page import="gov.nih.nci.caIMAGE.*"%>
<%@ page import="gov.nih.nci.caIMAGE.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.io.*"%>
<%@ page import="com.oroinc.io.Util"%>
<%@ page import="com.oroinc.io.CopyStreamException"%>
<%@ page import="com.bigfoot.bugar.servlet.http.*"%>
<%@ page buffer="32kb"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page errorPage="Error.jsp "%>

<%@ include file="html/Submit_results_short.html"%>
<FORM method="POST" ENCTYPE="multipart/form-data" NAME="form1" action="caimageUsers.jsp">
	<%System.err.println("=======Submission Page===============");

			// constructor class
			Species sp = new Species();
			Annotations annot = new Annotations();
			Publication pub = new Publication();
			Strain str = new Strain();
			Stain st = new Stain();
			try {
				// Instantiate a MultipartFormData object for this request 
				//MultipartFormData multipart = new MultipartFormData(request, 5242880L ); //5 MB limit on files
				MultipartFormData multipart = new MultipartFormData(request,
						1024L * 1024L * 1024L);

			
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

				String mode = request.getParameter("mode");
				//imagetitle = imagetitle.substring(0, imagetitle.lastIndexOf(".") );
				annotation_id = Long.valueOf(imagetitle);

				imagedesc = multipart.getParameter("imagedesc").trim();
				speciesreq = multipart.getParameter("species").trim();
				organTissueCode = multipart.getParameter("organTissueCode").trim();
				modality = multipart.getParameter("modality").trim();

				if ((imagetitle.length() != 0)
						&& (organTissueCode.length() != 0)
						&& (speciesreq.length() != 0)
						&& (modality.length() != 0)) {
					Enumeration input = multipart.getParameterNames();
				
					String donator = null;
					String organ = null;
					String donator_email = null;
					String diagnosis = null;
					String speciesval = null;
					KeyRetriever tk = new KeyRetriever();
					while (input.hasMoreElements()) {
						String name = (String) input.nextElement();
						String value = multipart.getParameter(name);
					
						StringBuffer whereBuf = new StringBuffer();
						String species = null;
						Long speciesl = null;
						
						annot.setAnnotation_id(annotation_id);

						//image title
						if ((name != null) && (name.equals("imagedesc"))) {
						
							annot.setImage_description(value);
							imagetitle = value;
						}//if
						
						//image description
						if ((name != null) && (name.equals("imageannot"))) {
							
							annot.setImage_annotations(value);
						}//if
			
						//Species Submission
						if ((name != null) && (name.equals("species"))) {
						
							speciesval = value;
							if (speciesval != null) {
								if (speciesval.length() != 0
										&& !speciesval.equals("null")) {
									//name to id conversion
									String searchstring = "SPECIES_NAME = "
											+ "'" + speciesval + "'";
									Vector spec = sp
											.retrieveAllWhere(searchstring);
									for (int k = 0; k < spec.size(); k++) {
										Species spvec = (Species) spec
												.elementAt(k);
										speciesl = spvec.getSpecies_id();
						
										annot.setSpecies_id(speciesl);
									}//for
								}//if
							}//if species val
						}//if

						// OrganTissue  Submission
						Image_organ organses = new Image_organ();
						if ((name != null) && (name.equals("organTissueCode"))) {
					
							organ = value;

							if (organ != null) {
								if (organ.indexOf(",") != -1) {// this is for generic diagnosis search
									organ = organ.substring(
											organ.indexOf("C") + 1, organ
													.indexOf(","));
			
									if (value.length() != 0) {
										organses.setOrgan(organ);
									}
								}//if
								else {
									organ = organ.substring(organ.indexOf("C") + 1);
								
									if (value.length() != 0) {
										organses.setOrgan(organ);
									}
								}//else
							}//if organ
						}//if name
						//update only organ
						boolean status_organ = ImageOrganDiagnosis.imageOrganUpdate(annotation_id, organses);
					
						//Diagnosis Submission
						Image_diagnosis diagnosises = new Image_diagnosis();
						if ((name != null) && (name.equals("DiagnosisCode"))) {
						
							diagnosis = value;
							if (diagnosis != null) { //multivalue comma seperated
								if (diagnosis.indexOf(",") != -1) {// this is for generic diagnosis search
									diagnosis = diagnosis.substring(diagnosis
											.indexOf("C") + 1, diagnosis
											.indexOf(","));
									
									if (value.length() != 0) {
										diagnosises.setDiagnosis(diagnosis);
									}//value
								} else {//single value comma seperated
									diagnosis = diagnosis.substring(diagnosis
											.indexOf("C") + 1);
								
									if (value.length() != 0) {
										if (diagnosis.equals("000000")) {
								
											/*
											 if ( name.equals("DiagnosisName") ) {
											  annot.setTumor_classification(value);
											 Mail mail = new Mail("localhost", "guptaa@mail.nih.gov", "guptaa@mail.nih.gov","subject","content");
											 }*/
											diagnosises.setDiagnosis(diagnosis);
										} else {
											diagnosises.setDiagnosis(diagnosis);
										}
									}//value
								}//else

							}//if diagnosis
						}
						// DignosisName Submission
						if ((name != null)
								&& (name.equals("TumorClassification"))
								&& diagnosis.equals("000000")) {
							//if ( (name != null) && (name.equals("DiagnosisName") ) && diagnosis.equals("000000")  ){
								if (value != null) {
								if (value.length() != 0) {
									diagnosises.setTumor_classification(value);
									String[] dig = { value };
									DiagnosisSubmission diagnosisSubmission = new DiagnosisSubmission(
											dig, imagetitle, new Long(
													imagetitle),
											organTissueName, speciesreq);
									diagnosisSubmission.sendStrainSubmission();
									//Mail mail = new Mail("mailfwd.nih.gov", "guptaa@mail.nih.gov", "guptaa@mail.nih.gov","subject","New Evs ID"+value);

								}
							}
						}//if
						//update only dignosis
						boolean status_diagnosis = ImageOrganDiagnosis
								.imageDiagnosisUpdate(annotation_id,
										diagnosises);
				
						// Gender Submission
						if ((name != null) && (name.equals("gene"))) {
							if (value != null) {
								if (value.length() != 0) {
									annot.setGene(value);
								}
							}
						}//if
						if ((name != null) && (name.equals("promoter"))) {
							if (value != null) {
								if (value.length() != 0) {
									annot.setPromoter(value);
								}
							}
						}//if

						// Gender Submission
						if ((name != null) && (name.equals("gender"))) {
							if (value != null) {
								if (value.length() != 0) {
									annot.setGender_id(new Long(value));
								}
							}
						}//if

						//Publication Submission
						if (name != null && name.equals("PMID")) {
							if (value != null) {
								if (value.length() != 0) {
									String publicationquery = "PUBLICATION_NAME = "
											+ "'" + value + "'";
									Vector pubv = pub
											.retrieveAllWhere(publicationquery);
									if (pubv.size() != 0) {
										Long publicationid = null;
										for (int k = 0; k < pubv.size(); k++) {
											Publication pubvec = (Publication) pubv
													.elementAt(k);
											publicationid = pubvec.getPublication_id();
										}//for
										pub.setPublication_id(publicationid);
										pub.setPublication_name(value);
										pub.updateByIndex();
										annot.setPublication_id(publicationid);
									} else {
										if (value.length() != 0) {
											Long pubcount = tk
													.getNextKey("PUBLICATION");
												pub.setPublication_id(pubcount);
											pub.setPublication_name(value);
											pub.insert();
											annot.setPublication_id(pubcount);
										}//if
									}//else
								}
							}
						}

						//Donator Submission
						Long donatorid = (Long) session
								.getAttribute("nci.mmhcc.submitter.submitterKey");
						if (donatorid != null) {
							annot.setDonator_id(donatorid);
						}
						//Stain Submission
						if ((name != null) && (name.equals("stain"))) {
							if (value != null) {
								if (value.length() != 0) {
									if (!value.equals("0")) {
										annot.setStain_id(new Long(value));
									}
								}

							}
						}//if
						if ((name != null) && (name.equals("Other"))) {
							if (value != null) {
								Long stain_count = null;
								if (value.length() != 0) {
									stain_count = tk.getNextKey("STAIN");
									st.setStain_id(stain_count);
									st.setStain_name("Other");
									st.setStain_description(value);
									st.insert();
								}
								annot.setStain_id(stain_count);
							}
						}//if

						//Strain Submission
						if ((name != null) && (name.equals("strain"))) {
							if (value != null) {
								if (value.length() != 0) {
									if (!value.equals("0")) {
										annot.setStrain_id(new Long(value));
									}
								}
							}
						}//if
						if ((name != null) && (name.equals("Otherstrain"))) {
							if (value != null) {
								Long strain_count = null;
								if (value.length() != 0) {
									strain_count = tk.getNextKey("STRAIN");
									str.setStrain_id(strain_count);
									str.setStrain_name(value);
									str.setStrain_source("Other");
									str.insert();
								}
								annot.setStrain_id(strain_count);
							}
						}//if
	
					}//while
					//annot.setCurated_id(new Long(2) );
					Locale locale = Locale.getDefault();
					TimeZone tz = TimeZone.getDefault();
					DateFormat myFormat = DateFormat.getDateTimeInstance(
							DateFormat.FULL, DateFormat.FULL, locale);
					myFormat.setTimeZone(tz);
					DateFormat df = DateFormat.getDateInstance(DateFormat.LONG,
							Locale.US);
					Date d = new Date();
					annot.setDatetime(myFormat.format(d));
				
					annot.getAnnotation_id();
				
					//annot.insert();
					annot.setCurated_id(new Long(1));
					annot.setAnnotation_id(annotation_id);
					Annotations annotunmod = new Annotations();
					annotunmod.retrieveByIndex(annotation_id);
					annot.setImage_name(annotunmod.getImage_name());
					annot.setCatalog_id(annotunmod.getCatalog_id());
					boolean status = annot.updateByKey();
						%>
	<center>
		<H4>
			The annotations including changes for image
			<%=annotation_id%>
			have been saved to the database.
			<br>
			To prevent misuse of the application each image will be screened before it appears online.
		</H4>
		<input TYPE="submit" NAME="goback" VALUE=" Submit/Edit Another Image">
		&nbsp;&nbsp;
	</center>
	<%} else {

					%>
	<h4>
		<font color="red">Error: Missing Required Fields</font>
		<br>
		<br>
	</H4>
	<h4>
		The record could not be added because the following required fields were left empty:
	</H4>
	<br>
	<%if (imagetitle.length() <= 0) {

					%>
	<h4>
		<font color="red">Image Name</font>
		<br>
	</h4>
	<%}
					if (organTissueCode.length() <= 0) {

					%>
	<h4>
		<font color="red">Organ Tissue Name</font>
		<br>
	</h4>
	<%}
					if (speciesreq.length() <= 0) {

					%>
	<h4>
		<font color="red">Species Name</font>
		<br>
	</h4>
	<%}
					if (modality.length() <= 0) {%>
	<font color="red">Modality</font>
	<br>
	<br>
	</H4>
	<%}%>

	<h4>
		Please go back using your browser's back button, and enter a values for these fields.
	</h4>
	<%}

			} catch (EOFException eof) {
				eof.printStackTrace();
			}

		%>

</FORM>
<%@ include file="html/submit_results_bot.htm"%>


</body>
</html>




