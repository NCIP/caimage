<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See https://github.com/NCIP/caimage/LICENSE.txt for details.
L--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN""http://www.w3.org/TR/REC-html40/frameset.dtd">

<html>
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
	<%//@ page errorPage = "Error.jsp " %>
	<%@ page import="com.apelon.dts.client.Concept"%>
	<%@ page import="org.apache.log4j.Logger"%>
	<%//simpleandfile sf = new simpleandfile();
			//sf.log("start");
			Logger logger = Logger.getLogger(simpleandfile.class);
			logger.debug("****Pubilcation results.jsp*********");

			%>

	<head>
		<!-- This is for making the images to UTF format -->
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>
			Cancer Models Database - Submission
		</title>
		<LINK rel="stylesheet" type="text/css" href="images/submission.css">
		<script language="JavaScript">

function showWindow(imgscr){
		myWind = window.open(imgscr,"subWindow","HEIGHT=520,WIDTH=520,resizable");
		myWind.focus();
	}

</script>
	</head>

	<body>

		<FORM method="POST">
			<%@ include file="headernotab.html"%>


			<%//@ include file="html/search_results_top.htm"%>
			<%System.out.println("=======Publication Image================");
			int cnt = 0;

			String publication = request.getParameter("publication").trim();
			PublicationImage pi = new PublicationImage();
			Annotations annot = new Annotations();
			String[] pubid = { publication };
			Vector imagevec = pi.loadSessionObjects(pubid);

			cnt = imagevec.size();

			String organ = "";
			String dignosis = "";
			//String tissue = null;
			String dignosisName = "";
			String tname = "";
			String species = "";

			Species sp = new Species();

			//constructors classes
		
			Stain st = new Stain();
		
			Image_characteristic ic = new Image_characteristic();
		
			Login log = new Login();
			Strain str = new Strain();
			Gender gen = new Gender();
			Publication_journal pj = new Publication_journal();
			Publication pub = new Publication();
			//EvsUtil myEvs = new EvsUtil("evs.properties");

			String sw = null;
			
			Vector annotv = null;
		
			int j = 0;
			int q = 0;
			if (cnt == 0) {

				%>
			<H3>
				Search Criteria: Publication=
				<%=publication%>
				Not Found&nbsp;
			</H3>
			<%} else {

				%>
			<H3>
				Search Criteria: Publication=
				<%=publication%>
				Found&nbsp;
			</H3>
			<table align="Center" width="95%" WRAP>
				<%String where = null;
				String nextwhere = null;
				for (int m = 0; m < cnt; cnt--) {
				
					if (publication != null && !publication.equals("")) {
					
						Long speciesl = null;
						//name to id conversion
						StringBuffer sb = new StringBuffer();
						if (imagevec != null) {
							for (int k = 0; k < imagevec.size(); k++) {
								
								String searchstring = "IMAGE_NAME = " + "'"
										+ imagevec.elementAt(k) + "'";
								sb.append("'" + imagevec.elementAt(k) + "'"
										+ ",");
							}
						}
						String sbmodified = sb.substring(0, sb.length() - 1);
						String searchstring = "IMAGE_NAME  IN " + "( "
								+ sbmodified + " )";
					
						nextwhere = searchstring;
					
					} //species
					annotv = annot.retrieveAllWhere(nextwhere);
			
					j = annotv.size();
				}//for%>
				<%Long catalog = null;
				Long annotationid = null;
				String catdir = null;
				if (annotv.size() >= 0) {
					Annotations Annot = null;
					for (j = 0; j < annotv.size(); j++) {
			
						try {
							Annot = (Annotations) annotv.elementAt(j);
						} catch (Exception ex) {
							System.err.println("the exception is" + ex);
						}//catch

					
						catalog = Annot.getCatalog_id();
						annotationid = Annot.getAnnotation_id();
					
						String image = Annot.getImage_name().trim();
						Catalog ce = new Catalog();
						Vector catv = ce.retrieveAllWhere("CATALOG_ID = '"
								+ catalog + "'");
						for (int k = 0; k < catv.size(); k++) {
							Catalog Ceta = null;
							if (k >= 0 && k <= annotv.size()) {
							
								Ceta = (Catalog) catv.elementAt(k);
								catdir = Ceta.getCatalog_directory().trim();
						
							}
					
						}
						URL url = null;
						BufferedReader input = null;
						boolean flag = false;

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
						String lizard = sysProps.getProperty("lizard");
						String lizardstyle = sysProps
								.getProperty("lizard_Style");
						String imagepath = lizard + "/iserv/getthumb?cat=";
					
						String line = new String();
						String imageurl = lizardstyle + "/calcrgn?cat=";
				
						String calcrgn = DatabaseSetup.checkForNull(catdir)
								+ "&" + "img="
								+ DatabaseSetup.checkForNull(image)
								+ "&wid=400&hei=400&style=none";
					

						try {
							url = new URL(imageurl + calcrgn);
						
							Object abc = url.getContent();
							int number1 = 0;
							int number2 = 0;
							int number3 = 0;
							String region = null;
							if (url.openConnection() != null) {
						
								input = new BufferedReader(
										new InputStreamReader(url.openStream()),
										1000);
								//Helps bringing all the images
								Thread.sleep(100);
								System.err.println("the available byte is:"
										+ url.openStream().available());
								StringBuffer buffer = new StringBuffer();
								while ((line = input.readLine()) != null) {
							
									buffer.append(line.toString());
									buffer
											.append("<!DOCTYPE ImageServer SYSTEM"
													+ "\"calcrgn.dtd\">");
									flag = true;
								}
								String outputmod = buffer.delete(
										url.openStream().available() + 40,
										buffer.capacity()).toString();
								// temporary closed but show xml
							
								//String ret = SAXParseUtil.parseurl(outputmod);
								int width = 0;
								int width1 = 0;
								width = outputmod.lastIndexOf("width");
								width1 = outputmod.indexOf(" ", width + 7);
								int height = 0;
								int height1 = 0;
								height = outputmod.lastIndexOf("height");
					
								height1 = outputmod.indexOf(" ", height + 8);
						
								int numlevels = 0;
								numlevels = outputmod.lastIndexOf("numlevels");
								number1 = Integer.parseInt(outputmod.substring(
										width + 7, width1 - 1));
								number2 = Integer.parseInt(outputmod.substring(
										height + 8, height1 - 1));
								number3 = Integer.parseInt(outputmod.substring(
										numlevels + 11, numlevels + 12));
								int rgn = 0;
								int rgn1 = 0;
								rgn = outputmod.lastIndexOf("rgn");
								rgn1 = outputmod.indexOf(" ", rgn + 4);
								region = (String) (outputmod.substring(rgn + 5,
										rgn1 - 1));
						
								boolean catfromic = ic
										.retrieveByKey(annotationid);
								if (!catfromic) {
									ic.setImage_characteristic_id(annotationid);
									//int hei = (height1-height);
									//int wid = (width1-width);
									ic.setImage_characteristic_height(Integer
											.toString(number2));
									ic.setImage_characteristic_width(Integer
											.toString(number1));
									ic.setImage_characteristic_numlevel(Integer
											.toString(number3));
									ic.setImage_modality_id(Long.valueOf("1"));
									ic.insert();
								}
							}//while
							String bName = request.getHeader("User-Agent");
							if (bName != null) {

								%>
				<tr>
					<td align="left" valign="top">
						<a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir)%>&img=<%=DatabaseSetup.checkForNull(image)%>&centerp=<%=number1/2%>,<%=number2/2%>&reslvl=<%=number3%>&wid=400&hei=400')"> <img
								src="<%=imagepath%><%=DatabaseSetup.checkForNull(catdir)%>&img=<%=DatabaseSetup.checkForNull(image)%>&thumbspec=main" alt="<%=DatabaseSetup.checkForNull(image)%>" border="0" target="_blank"> </a>
						<br>
						<%Thread.sleep(100);%>
						<font FACE="trebuchet" size="-1" color="Red"> <%=image%><br> </font>
					</td>
					<%}
							logger.debug("Results starts here");%>
					<%@ include file="results.jsp"%>
					<%logger.debug("Results end here");
							input.close();
						} catch (IOException e) {
							e.printStackTrace();
						}//try ends %>

					<%}//for
				}//if

			%>

					<%}//else%>
			</table>
		</FORM>
	</body>
</html>

