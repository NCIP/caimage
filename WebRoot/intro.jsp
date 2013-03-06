<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<html>
	<head>
		<title>
			intro
		</title>

		<%@ page language="java"%>
		<%@ page import="gov.nih.nci.caimage.db.*"%>
		<%@ page import="gov.nih.nci.caIMAGE.*"%>
		<%@ page import="gov.nih.nci.caIMAGE.util.*"%>
		<%@ page import="java.util.*"%>
		<%@ page import="java.lang.*"%>
		<%@ page import="java.net.URL"%>
		<%@ page import="java.io.*"%>
		<%@ page import="javax.xml.parsers.*"%>
		<%@ page import="org.w3c.dom.*"%>
		<%@ page import="org.w3c.dom.Document"%>
		<%@ page import="org.xml.sax.*"%>
		<%@ page import="javax.xml.*"%>
		<%@ page import="java.net.URLDecoder"%>
		<%@ page import="java.net.URLEncoder"%>

		<%@ page buffer="32kb"%>
	</head>

	<body>
		<!--- <form method="post"  action = "intro.jsp"> --->


		<%String mySession = request.getRequestedSessionId();
			//String lastName = null;
			//String firstName = null;
			Long submitterKey = null;
			Long userTypeKey = null;
			Long id = new Long(request.getParameter("id"));
			boolean status_annot = false;
			System.err.println(" id from the script:" + id);
			String copyStatus = (String) request.getParameter("copyStatus");
			String deleteStatus = (String) request.getParameter("deleteStatus");
			System.err.println(" status  from copy:" + copyStatus
					+ "deleteStatus:" + deleteStatus);
			//DeleteRecord delete = new DeleteRecord(); 
		
			//Constructor
			Annotations annot = new Annotations();
			annot.retrieveByIndex(id);
			boolean status_clone = false;
			if ((copyStatus != null) && (copyStatus.equals("true"))) {
			
				Annotations annot1 = new Annotations();
				Vector v = annot1.retrieveAll();
				KeyRetriever tk = new KeyRetriever();
				Long annotation_count = tk.getNextKey("ANNOTATIONS");
			
				annot.setAnnotation_id(annotation_count);
				String copy = null;
				copy = annot.getImage_description();
				int a = copy.lastIndexOf("copy");
				//if description is null it is not a copy first time
				if (copy != null) {
					a = copy.lastIndexOf("copy");
					//if it is a copy already clone(second time clone of clone)
					if (a > 0) {
						copy = annot.getImage_description();
					} //if is not a copy(first time)
					else {
						copy = annot.getImage_description() + "-copy";
						
					}
					annot.setImage_name("No Image");
					annot.setImage_description(copy);
					status_annot = annot.insert();
			
					status_clone = ImageOrganDiagnosis.cloneInsert(id,
							annotation_count, tk, status_annot);
				

				}//if is  
				else {
					annot.setImage_name("No Image");
					annot.setImage_description("No Description");
					status_annot = annot.insert();
					status_clone = ImageOrganDiagnosis.cloneInsert(id,
							annotation_count, tk, status_annot);
				
				}
				//This is for clone of clone
			

				if (!status_clone) {
					status_annot = annot.insert();
						status_clone = ImageOrganDiagnosis.cloneInsert(id,
							annotation_count, tk, status_annot);
				
				}
			}//copy status

			if ((deleteStatus != null) && (deleteStatus.equals("true"))) {
				if ((mySession != null) && (deleteStatus.equals("true"))) {
					boolean status_o_delete = ImageOrganDiagnosis
							.imageOrganDelete(id);
				
					boolean status_dig_delete = ImageOrganDiagnosis
							.imageDiagnosisDelete(id);
					
					boolean status_annotation_delete = annot.deleteByKey(id);
				
					if (!annot.getImage_name().equals("No Image")) {
						//this is for converter
						InputStream in = null;
						Properties sysProps = new Properties();
						try {
							in = Thread.currentThread().getContextClassLoader()
									.getResourceAsStream("system.properties");
							sysProps.load(in);
						} catch (Exception e) {
							System.err
									.println("Error loading system.properties file");
							e.printStackTrace();
						}

						String convurl = sysProps.getProperty("convurl");
						String convPath = sysProps.getProperty("convpath");
						String convOutputPath = convPath + "Output";
						String convusername = sysProps
								.getProperty("convusername");
						String convpwd = sysProps.getProperty("convpwd");
						String imagename = annot.getImage_name();
						String extension = imagename.substring(imagename.lastIndexOf("."), imagename.length());
						String imagenumber = imagename.substring(0, imagename.lastIndexOf("."));
					
						File file = new File(imagename);
					
						File[] filearray = { file };
						FTPUtilDelete ftp = new FTPUtilDelete();
						boolean status = false;
						if (status == false && !extension.equals(".sid")) {
							//This is for converter deletion
							ftp.deleteAllFiles(null, filearray, convurl.trim(),
									convPath.trim(), convPath.trim(),
									convusername.trim(), convpwd.trim());
							status = ftp.getStatus2();
							//remove the converted file from the encode/enc6/Output
							ftp.deleteAllFiles(null, filearray, convurl.trim(),
									convOutputPath.trim(), convOutputPath
											.trim(), convusername.trim(),
									convpwd.trim());
							status = ftp.getStatus2();
						}
					
						if (status == false) {
							//This is for image server deltetion
							
							//Cannot delete the previously submitted images
							if (annot.getCatalog_id().equals(new Long(30))) {
							
								String imageserverpath = sysProps
										.getProperty("image_server_path");
								if (id.longValue() >= 10000) {
									imageserverpath = imageserverpath
											+ "/stage";
								} else {
									imageserverpath = imageserverpath;
								}
								String imageserver = sysProps
										.getProperty("image_server");
								String imageserveruser = sysProps
										.getProperty("image_server_user");
								String imageserverpasswd = sysProps
										.getProperty("image_server_passwd");
								//ftp.deleteAllFiles(null, filearray , imageserverpath.trim(), convOutputPath.trim(), convOutputPath.trim(),convusername.trim(), convpwd.trim());
								ftp.deleteAllFiles(null, filearray, imageserver
										.trim(), imageserverpath.trim(),
										imageserverpath.trim(), imageserveruser
												.trim(), imageserverpasswd
												.trim());
								status = ftp.getStatus2();
								
							} else {%>
		response.sendRedirect("unautomated_images.html");
		<%}
						}
					}//if my session
				}//if delete status
			}//if Noimage
			

			%>

		<script language="JavaScript">
         location.replace("caimageUsers.jsp");
	</script>
		

		<!--- </form>     --->

	</body>
</html>
