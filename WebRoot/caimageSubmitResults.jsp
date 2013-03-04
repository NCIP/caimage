<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See https://github.com/NCIP/caimage/LICENSE.txt for details.
L--%>

<html>
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
	<%//@ page errorPage = "Error.jsp " %>


	<%@ include file="html/Submit_results_short.html"%>
	<FORM method="POST" ENCTYPE="multipart/form-data" NAME="form1" action="caimageUsers.jsp">
		<%System.err.println("=======Submission Page===============");

			// constructor class
			Species sp = new Species();
			Annotations annot = new Annotations();
			Publication pub = new Publication();
			Strain str = new Strain();
			Stain st = new Stain();
			Image_diagnosis diagnosises = new Image_diagnosis();
			Image_organ organs = new Image_organ();
			System.err.println("The multipart ");
			try {
				MultipartFormData multipart = null;
				// Instantiate a MultipartFormData object for this request 
				//MultipartFormData multipart = new MultipartFormData(request, 5242880L ); //5 MB limit on files
				try {
					multipart = new MultipartFormData(request,
							1024L * 1024L * 1024L);
				} catch (Exception e) {
					e.printStackTrace();
				}

				String imagetitle = null;
				String imagedesc = null;
				String image = null;
				String speciesreq = null;
				String organTissueCode = null;
				String organTissueName = null;
				String modality = null;
				Long annotation_id = null;

				imagetitle = multipart.getParameter("imagetitle").trim();
				imagedesc = multipart.getParameter("imagedesc").trim();
				speciesreq = multipart.getParameter("species").trim();
				organTissueCode = multipart.getParameter("organTissueCode")
						.trim();
				modality = multipart.getParameter("modality").trim();

				image = multipart.getFileName("myUploadObject");
				long filesize = multipart.getFileSize("myUploadObject");

				if ((filesize <= 25000) || (filesize == 0)) {

				%>
		<center>
			<h4>
				File size has to be greater than 25 kb, or missing the required image field.
			</h4>
			<br>
			<h4>
				Use the browser back button to fill in the required fields.
			</h4>
			<br>
		</center>
		<%} else {
					if (filesize >= 25000 && filesize <= 1024L * 1024L * 1024L) {

						if ((imagetitle.length() != 0)
								|| (organTissueCode.length() != 0)
								|| (image.length() != 0)
								|| (speciesreq.length() != 0)
								|| (modality.length() != 0)) {

						}//else if 
					}//if
					if ((imagetitle.length() != 0)
							&& (organTissueCode.length() != 0)
							&& (image.length() != 0)
							&& (speciesreq.length() != 0)
							&& (modality.length() != 0)) {

						Enumeration input = multipart.getParameterNames();

						String donator = null;
						String organ = null;
						String donator_email = null;
						String diagnosis = null;
						String speciesval = null;
						boolean flag1 = false;
						boolean flag2 = false;
						KeyRetriever tk = new KeyRetriever();
						Long annotation_count = tk.getNextKey("ANNOTATIONS");

						while (input.hasMoreElements()) {
							Long l = new Long(30);
							annot.setCatalog_id(l);
							String name = (String) input.nextElement();
							String value = multipart.getParameter(name);

							StringBuffer whereBuf = new StringBuffer();
							String species = null;
							Long speciesl = null;
							annotation_id = annotation_count;
							annot.setAnnotation_id(annotation_id);

							//image title
							if ((name != null) && (name.equals("imagetitle"))) {
								System.out.println("The value for  " + name
										+ " is " + value);
								annot.setImage_description(value);
								imagetitle = value;
							}//if

							//image description
							if ((name != null) && (name.equals("imagedesc"))) {

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
											System.out
													.println(" value of long species "
															+ speciesl);
											annot.setSpecies_id(speciesl);
										}//for
									}//if
								}//if species val
							}//if

							// OrganTissue  Submission

							if ((name != null)
									&& (name.equals("organTissueCode"))) {
								//System.out.println("The value for organTissueCode is "+ value);
								organ = value;

								if (organ != null) {
									if (organ.indexOf(",") != -1) {// this is for generic diagnosis search
										organ = organ.substring(organ
												.indexOf("C") + 1, organ
												.indexOf(","));
										if (value.length() != 0) {
											organs.setOrgan(organ);
										}
									}//if
									else {
										organ = organ.substring(organ
												.indexOf("C") + 1);

										if (value.length() != 0) {
											organs.setOrgan(organ);
										}
									}//else
								}//if organ
							}//if name

							if ((!flag1) && (organs.getOrgan() != null)) {

								organs.setImageorgan_id(tk
										.getNextKey("IMAGE_ORGAN"));
								organs.setAnnotation_id(annotation_id);
								flag1 = true;
							}

							//Diagnosis Submission
							if ((name != null)
									&& (name.equals("diagnosisCode"))) {

								diagnosis = value;
								if (diagnosis != null) { //multivalue comma seperated
									if (diagnosis.indexOf(",") != -1) {// this is for generic diagnosis search
										diagnosis = diagnosis.substring(
												diagnosis.indexOf("C") + 1,
												diagnosis.indexOf(","));

										if (value.length() != 0) {
											diagnosises.setDiagnosis(diagnosis);
										}//value
									} else {//single value comma seperated
										diagnosis = diagnosis
												.substring(diagnosis
														.indexOf("C") + 1);

										if (value.length() != 0) {
											if (diagnosis.equals("000000")) {
												System.out
														.println("I made it here"
																+ name + value);
												/*
												 if ( name.equals("diagnosisName") ) {
												 
												 //diagnosises.setTumor_classification(value);
												 Mail mail = new Mail("localhost", "guptaa@mail.nih.gov", "guptaa@mail.nih.gov","subject","content");
												 }*/
												diagnosises
														.setDiagnosis(diagnosis);
											} else {
												diagnosises
														.setDiagnosis(diagnosis);
											}
										}//value
									}//else

								}//if diagnosis
							}
							// DignosisName Submission
							if ((name != null)
									&& (name.equals("diagnosisName"))
									&& diagnosis.equals("000000")) {

								if (value != null) {
									if (value.length() != 0) {
										diagnosises
												.setTumor_classification(value);
										String[] dig = { value };
										DiagnosisSubmission diagnosisSubmission = new DiagnosisSubmission(
												dig, imagetitle, new Long(
														imagetitle),
												organTissueName, speciesreq);
										diagnosisSubmission
												.sendStrainSubmission();
										//Mail mail = new Mail("mailfwd.nih.gov", "guptaa@mail.nih.gov", "guptaa@mail.nih.gov","subject","New Evs ID"+value);

									}
								}
							}//if
							if ((!flag2)
									&& (diagnosises.getDiagnosis() != null)) {

								diagnosises.setImagediagnosis_id(tk
										.getNextKey("IMAGE_DIAGNOSIS"));
								diagnosises.setAnnotation_id(annotation_id);
								flag2 = true;
							}

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
										Long pubcount = tk
												.getNextKey("PUBLICATION");

										pub.setPublication_id(pubcount);
										pub.setPublication_name(value);
										pub.insert();
										annot.setPublication_id(pubcount);
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

						String uploadObject = multipart
								.getFileName("myUploadObject");
						System.out.println("I am in upload object"
								+ uploadObject);
						String imageDir = multipart
								.getLocalPath("myUploadObject");
						System.out.println("image directory is" + imageDir);
						imageDir = imageDir.substring(0, imageDir
								.lastIndexOf(File.separator));

						if (uploadObject != null && !uploadObject.equals("")) {

							String imagename = null;
							//this is correct

							if (uploadObject.indexOf("\\") != -1) { //uploaded file from windows
								imagename = uploadObject.substring(uploadObject
										.lastIndexOf("\\") + 1, uploadObject
										.length());
							} else if (uploadObject.indexOf("/") != -1) { //uploaded file from unix or linux
								imagename = uploadObject.substring(uploadObject
										.lastIndexOf("/") + 1, uploadObject
										.length());
							} else { //if(uploadObject.indexOf(":") != -1) { //uploaded file from macs
								imagename = uploadObject.substring(uploadObject
										.lastIndexOf("null") + 1, uploadObject
										.length());
							}

							InputStream in = null;
							Properties sysProps = new Properties();
							try {
								in = Thread.currentThread()
										.getContextClassLoader()
										.getResourceAsStream(
												"system.properties");
								sysProps.load(in);
							} catch (Exception e) {
								System.err
										.println("Error loading system.properties file");
								e.printStackTrace();
							}

							String lizard = sysProps.getProperty("lizard");
							String lizardwindow = sysProps
									.getProperty("lizard");

							String path = sysProps.getProperty("ftppath");

							String ftpusername = sysProps
									.getProperty("ftpusername");

							String ftppwd = sysProps.getProperty("ftppwd");

							String image_server_path = sysProps
									.getProperty("image_server_path");
							String image_server = sysProps
									.getProperty("image_server");
							String image_server_user = sysProps
									.getProperty("image_server_user");
							String image_server_passwd = sysProps
									.getProperty("image_server_passwd");

							File filen = new File(imageDir, imagename);
							new File(multipart.getLocalPath("myUploadObject"))
									.renameTo(filen);
							File[] filearray = { filen };
							String ftpurl = sysProps.getProperty("ftpurl");

							//File file = new File("abc");
							//File[] filearray = {file};
							//String newPath = path+"/External/Donator/Tissue/Diagnosis";
							String newPath = image_server_path;

							if (annotation_id.longValue() > 10000) {
								newPath = newPath + "/stage";

							}
							//This is for sid images
							if (imagename.substring(
									imagename.lastIndexOf(".") + 1).trim()
									.equalsIgnoreCase("sid")) {

								//ftpurl= image_server;
								//	newPath = "/Images/External/Donator/Tissue/Diagnosis";
								//	ftpusername = "lizupload";
								//	ftppwd = "ncicblts";
								//ftpurl= image_server;
								//ftpusername= image_server_user;
								//ftppwd = image_server_passwd ;
								Thread.sleep(1500);
								FTPUtil.transfer(filearray, null,
										annotation_id, image_server.trim(),
										newPath.trim(), image_server_user
												.trim(), image_server_passwd
												.trim());
								Thread.sleep(1500);
								//FTPUtil.transfer(filearray, null,  annotation_id , ftpurl.trim(), newPath.trim(), ftpusername.trim(), ftppwd.trim());
								annot.setImage_name(annotation_id.toString()
										+ ".sid");
							}
							//this is for non sid format
							else { //Convertor module start from here
								long time1 = System.currentTimeMillis();
								long time2 = 0;

								String savePath = sysProps
										.getProperty("ftppath");

								String convurl = sysProps
										.getProperty("convurl");

								String convPath = sysProps
										.getProperty("convpath");

								String convusername = sysProps
										.getProperty("convusername");

								String convpwd = sysProps
										.getProperty("convpwd");

								String convpathout = convPath + "/Output";

								String converrorpath = sysProps
										.getProperty("converrorpath");

								String caimage_script = sysProps
										.getProperty("caimage_script");

								//FTPUtil.transfer(filearray, null,  new Long(annot.count()+1), convurl.trim(), "/encode/enc6", "tomcat", "lpgtom");

								//First time transfer the file to the convertor
								FTPUtil.transfer(filearray, null,
										annotation_id, convurl.trim(), convPath
												.trim(), convusername.trim(),
										convpwd.trim());
								System.err.println(" Transfer complete" + "\n"
										+ "\n");
								//waiting for converter to convert
								//wait();
								Thread.sleep(1500);
								//Look for the following file name which is determined 
								File ftpfile = new File(annotation_id + ".sid");
								//Ftp from ftp server to destination server
								String orgimage = annotation_id
										+ imagename.substring(imagename
												.lastIndexOf("."), imagename
												.length());
								File orgfile = new File(orgimage);
								annot.setImage_name(annotation_id + ".sid");
								//Runtime r = Runtime.getRuntime();
								String bName = request.getHeader("User-Agent");

								//convert and move the images from converter to image server
								LizardtechConverter.converttransfer(
										caimage_script, filesize);
								//System.out.println("The time converter used is : " + (time2- time1)+ "\n");
							}//else convertor
							filen.delete();
							multipart.cleanUp();
							annot.setCurated_id(new Long(2));
							Locale locale = Locale.getDefault();
							TimeZone tz = TimeZone.getDefault();
							DateFormat myFormat = DateFormat
									.getDateTimeInstance(DateFormat.FULL,
											DateFormat.FULL, locale);
							myFormat.setTimeZone(tz);
							DateFormat df = DateFormat.getDateInstance(
									DateFormat.LONG, Locale.US);
							Date d = new Date();

							System.err.println("The local time is"
									+ myFormat.format(d));
							annot.setDatetime(myFormat.format(d));
							//annot.setDatetime(Long.toString(System.currentTimeMillis()));
							annot.getAnnotation_id();
							System.out.println("the annotation id"
									+ annot.getAnnotation_id());
							//annotation insert
							annot.insert();
							//diagnosis insert
							diagnosises.insert();
							//organ insert
							organs.insert();%>
		<center>
			<H4>
				The image and associated information you submitted were entered as record
				<%=annotation_id%>
				in the database.
				<br>
				To prevent misuse of the application each image will be screened before it appears online.
			</H4>
			<input TYPE="submit" NAME="goback" VALUE="  Submit/Edit Another Image">
			&nbsp;&nbsp;
		</center>
		<%}//if image length

					}//if image file size between 2500 and ...

					else {

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
						if (image.length() <= 0 && filesize >= 27647) {%>
		<h4>
			<font color="red">Upload Image</font>
			<br>
		</H4>
		<%}
						if (modality.length() <= 0) {%>
		<h4>
			<font color="red">Modality</font>
			<br>
			<br>
		</H4>
		<%}%>

		<h4>
			Please go back using your browser's back button, and enter a values for these fields.
		</h4>


		<%}//else

				}//if file size

			} catch (com.bigfoot.bugar.servlet.http.ByteLimitExceededException ble) {
				//Vector byte_errors = new Vector();
				//byte_errors.add("upload file larger than 5 MB");
				pageContext.handlePageException(ble);
				//request.setAttribute("nci.mmhcc.MissingFeilds", byte_errors);
				ble.printStackTrace();
				//System.out.println("Error: " + ble.toString() + "\n");%>
		I reached here
		<jsp:forward page="missing_required_feilds.jsp" />
		<%System.out.println("The size is larger than 5 MB");
				return;

			} catch (EOFException eof) {
				eof.printStackTrace();
			}

		%>
	</FORM>
	<%@ include file="html/submit_results_bot.htm"%>

	</body>
</html>




