<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

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
<%@ page import="gov.nih.nci.evs.query.*"%>
<%@ page import="gov.nih.nci.evs.domain.*"%>
<%@ page import="gov.nih.nci.system.applicationservice.*"%>
<%@ page import="javax.swing.tree.*"%>
<%@ page import="gov.nih.nci.evs.domain.DescLogicConcept"%>
<%@ page import="gov.nih.nci.common.net.*"%>
<%@ page import="org.apache.log4j.Logger"%>

<link rel="stylesheet" href="caIMAGE.css" type="text/css">

<script language="JavaScript">

function showWindow(imgscr){
		myWind = window.open(imgscr,"subWindow","HEIGHT=1000,WIDTH=1024,resizable");
		myWind.focus();
	}
</script>


<FORM method="POST">
	<%@ include file="html/search_results_adv_top.htm"%>
	<%Logger logger = Logger.getLogger(simpleandfile.class);
			ApplicationService appService = null;
			Calendar rightNow = Calendar.getInstance();

			InputStream in = null;
			Properties sysProps = new Properties();
			try {
				in = Thread.currentThread().getContextClassLoader()
						.getResourceAsStream("system.properties");
				sysProps.load(in);
			} catch (Exception e) {
				System.err.println("Error loading system.properties file");
				e.printStackTrace();
			}
			try {

				String qa = sysProps.getProperty("qaserver");

				appService = ApplicationService.getRemoteInstance(qa);
			} catch (Exception e) {
				e.printStackTrace();
			}
			//logger.debug("=======AdvanceSearch================");

			int cnt = 0;
			String species = null;
			String organ = null;
			String dignosis = null;
			String dignosisName = null;
			String donator = null;
			String donator_Institution = null;
			String journal_id = null;
			String observation = null;
			String stain = null;
			String strain = null;
			String gender = null;
			String tname = null;
			String imagename = null;
			boolean navflag = false;
			int a = 0;

			species = request.getParameter("species").trim();

			tname = request.getParameter("organTissueName").trim();
			tname = URLDecoder.decode(tname).trim();
			organ = request.getParameter("organTissueCode").trim();
			dignosis = request.getParameter("diagnosisCode").trim();
			dignosisName = request.getParameter("diagnosisName").trim();
			dignosisName = URLDecoder.decode(dignosisName).trim();
			imagename = request.getParameter("imagename").trim();
			donator = request.getParameter("donator").trim();
			donator = URLDecoder.decode(donator).trim();
			donator_Institution = request.getParameter("donator_Institution")
					.trim();
			donator_Institution = URLDecoder.decode(donator_Institution).trim();
			stain = request.getParameter("stain").trim();
			stain = URLDecoder.decode(stain).trim();
			strain = request.getParameter("strain").trim();
			strain = URLDecoder.decode(strain).trim();
			gender = request.getParameter("gender").trim();
			gender = URLDecoder.decode(gender).trim();
		
			// constructor class
			Species sp = new Species();
			Stain st = new Stain();
			Image_characteristic ic = new Image_characteristic();
			Strain str = new Strain();
			Gender gen = new Gender();
			Publication_journal pj = new Publication_journal();
			Publication pub = new Publication();
			Observation obj = new Observation();
			Journal jour = new Journal();
			Login log = new Login();


			if (species != null && !species.equals("")
					&& !species.equals("null")) {
				cnt = cnt + 1;
				logger.debug("I reached here 1" + cnt);
			}
		
			if (organ != null && !organ.equals("") && !organ.equals("null")) {
				cnt = cnt + 1;
			}
			if (dignosis != null && !dignosis.equals("")
					&& !dignosis.equals("null")) {
				cnt = cnt + 1;
				
			}
			if (!imagename.equals("") && imagename != null
					&& !imagename.equals("null")) {
				cnt = cnt + 1;
				
			}
			if (!donator.equals("") && donator != null
					&& !donator.equals("null")) {
				cnt = cnt + 1;
			
			}
			if (!donator_Institution.equals("") && donator_Institution != null
					&& !donator_Institution.equals("null")) {
				cnt = cnt + 1;
				
			}
			if (!stain.equals("") && stain != null && !stain.equals("null")) {
				cnt = cnt + 1;
			}
			if (!strain.equals("") && strain != null && !strain.equals("null")) {
				cnt = cnt + 1;
			}
			if (!gender.equals("") && gender != null && !gender.equals("null")) {
				cnt = cnt + 1;
			}
			logger.debug("so far" + species + organ + dignosis + donator
					+ donator_Institution + journal_id + observation + stain
					+ strain + gender);
			int q = 0;
			q = Integer.parseInt(request.getParameter("q"));
			int j = 0;
			int l = q + 5;
			//logger.debug(" q value is" + q);
			//logger.debug(" l value is" + l);
			String sw = null;
			Annotations annot = new Annotations();
			logger.debug("the get value is species Name=" + species
					+ " organ name=" + organ + " dignosis name=" + dignosis
					+ " donator=" + donator + " donator_Institution="
					+ donator_Institution + " journal_id= " + journal_id
					+ "Observation=" + observation + " stain= " + stain
					+ " strain= " + strain + " gender=" + gender);
			Vector annotv = null;

			if (cnt <= 0) {
				logger.debug("The where cluse for all query");
				annotv = annot.retrieveAll();

			%>

	<H3 style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF;">
		Search Criteria: all &nbsp;
	</H3>
	<%} else {
				logger.debug("The count is" + cnt);%>
	<H3 style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF;">
		Search Criteria:
		<%int cnt1 = cnt;
				String convert = null;
				if (species.length() != 0 && species != null
						&& !species.equals("null")) {
						convert = CommaConcat.convert(species, cnt1);%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (organ != null && !organ.equals("") && !organ.equals("null")) {
					convert = CommaConcat.convert(tname, cnt1);	%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (dignosis != null && !dignosis.equals("")
						&& !dignosis.equals("null")) {
					convert = CommaConcat.convert(dignosisName, cnt1);%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (imagename.length() != 0 && imagename != null
						&& !imagename.equals("") && !imagename.equals("null")) {
					convert = CommaConcat.convert(imagename, cnt1);%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (donator.length() != 0 && donator != null
						&& !donator.equals("") && !donator.equals("null")) {
					log.retrieveByIndex(Long.decode(donator));
					convert = CommaConcat.convert(log.getPi_name(), cnt1);	%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (donator_Institution.length() != 0
						&& donator_Institution != null
						&& !donator_Institution.equals("null")) {
					log.retrieveAllWhere("INSTITUTE =" + "'"
							+ donator_Institution + "'");
					convert = CommaConcat.convert(log.getInstitute(), cnt1);
					logger.debug("The decode donating inst is"
							+ donator_Institution + cnt1);%>
		<%=donator_Institution%>
		<%cnt1 = cnt1 - 1;
				}
				if (stain.length() != 0 && stain != null
						&& !stain.equals("null")) {
					st.retrieveByIndex(Long.decode(stain));
					convert = CommaConcat.convert(st.getStain_description(),
							cnt1);
					//st.retrieveByIndex(Long.decode(stain)  );%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (strain.length() != 0 && strain != null
						&& !strain.equals("null")) {
					str.retrieveByIndex(Long.decode(strain));
					convert = CommaConcat.convert(str.getStrain_name(), cnt1);	%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (gender.length() != 0 && gender != null
						&& !gender.equals("null")) {
					gen.retrieveByIndex(Long.decode(gender));
					convert = CommaConcat.convert(gen.getGender_name(), cnt1);%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}

				%>
		&nbsp;
	</H3>
	<%logger.debug("I reached the end of search criteria" + cnt1);
			} //if(cnt)

			String where = null;
			String nextwhere = null;
			
			for (int m = 0; m < cnt; cnt--) {
				if (species.length() != 0 && !species.equals("null")) {
					Long speciesl = null;
					//name to id conversion
					String searchstring = "SPECIES_NAME = " + "'" + species
							+ "'";
					logger.debug(searchstring);
					Vector spec = sp.retrieveAllWhere(searchstring);
					for (int k = 0; k < spec.size(); k++) {
						Species spvec = (Species) spec.elementAt(k);
						speciesl = spvec.getSpecies_id();
					}//for
					nextwhere = "SPECIES_ID = " + speciesl;
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
					logger.debug("The where after conversion" + where + "Count"
							+ cnt + "\n");
				} //species
				if (organ != null && !organ.equals("") && !organ.equals("null")) {
					logger.debug(" I  am organ loop in ");
					StringBuffer whereBuf = new StringBuffer();
					String organsep = null;
					if (organ.indexOf(",") != -1) {// this is for generic diagnosis search
						StringTokenizer tokens = new StringTokenizer(organ, ",");
						while (tokens.hasMoreTokens()) {
							organsep = tokens.nextToken();
							whereBuf.append("'"
									+ organsep
											.substring(organ.indexOf("C") + 1)
									+ "'" + ",");
						}//while
						whereBuf.deleteCharAt(whereBuf.length() - 1);
								nextwhere = " annotation_id in (select annotation_id from image_organ where ORGAN in "
								+ "(" + whereBuf + ") )";
					}//if
					else {
						nextwhere = "annotation_id in (select annotation_id from image_organ where ORGAN in"
								+ "'"
								+ organ.substring(organ.indexOf("C") + 1)
								+ "' )";
					}
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
					logger.debug("The organ after conversion " + where + "\n");
				
				} //organ


				if (dignosis != null && !dignosis.equals("")
						&& !dignosis.equals("null")) {
			
					Long concept_id = null;
					StringBuffer whereBuf = new StringBuffer();
					String diagnosissep = null;
					if (dignosis.indexOf(",") != -1) {// this is for generic diagnosis search
						StringTokenizer tokens = new StringTokenizer(dignosis,
								",");
						while (tokens.hasMoreTokens()) {
							diagnosissep = tokens.nextToken();
							whereBuf.append("'"
									+ diagnosissep.substring(dignosis
											.indexOf("C") + 1) + "'" + ",");
						}//while
						whereBuf.deleteCharAt(whereBuf.length() - 1);
						logger.debug("the value is" + whereBuf);
						nextwhere = "annotation_id in (select annotation_id from image_diagnosis where diagnosis in "
								+ "(" + whereBuf + ") )";
					}//if
					else {
						nextwhere = "annotation_id in (select annotation_id from image_diagnosis where diagnosis in "
								+ "'"
								+ dignosis.substring(dignosis.indexOf("C") + 1)
								+ "' )";
					}
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
				
				} //if dignosis

			
				if (imagename != null && !imagename.equals("")
						&& !imagename.equals("null")) {
					logger.debug(" I  am imagename loop");
					nextwhere = " ( IMAGE_NAME like" + "'%" + imagename + "%'"
							+ " or IMAGE_NAME like" + "'%"
							+ imagename.toLowerCase() + "%'"
							+ " or IMAGE_NAME like" + "'%"
							+ imagename.toUpperCase() + "%' )";
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
				
				}

				if (donator != null && !donator.equals("")
						&& !donator.equals("null")) {
				
					nextwhere = " DONATOR_ID =" + "'" + donator + "'";
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
				
				}
				if (donator_Institution.length() != 0) {
				
					nextwhere = " DONATOR_ID in"
							+ "(select  LOGINUID from LOGIN where INSTITUTE like"
							+ "'" + donator_Institution + "'" + ")";
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
				
				}

				if (stain.length() != 0) {
				
					nextwhere = "STAIN_ID =" + "'" + stain + "'";
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
					
					//logger.debug(" L value is" + l + "q " + q);
				}
				if (strain.length() != 0) {
				
					nextwhere = " STRAIN_ID =" + "'" + strain + "'";
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
				
					//logger.debug(" L value is" + l + "q " + q);
				}
				if (gender.length() != 0) {
			
					if (gender.equals("0")) {
						nextwhere = " GENDER_ID is null";
					} else {
						nextwhere = " GENDER_ID =" + "'" + gender + "'";
					}
					if (where != null) {
						where += WhereConverter.convert(nextwhere, cnt);
					} else {
						where = WhereConverter.convert(nextwhere, cnt);
					}
					cnt = cnt - 1;
				
					//logger.debug(" L value is" + l + "q " + q);
				}
				// to search by image name.
				where = where + " order by image_name";
				logger.debug("The where cluse" + where);
				annotv = annot.retrieveAllWhere(where);
				logger.debug("The size is" + annotv.size());
				if (annotv.size() > 5) {
					l = q + 5;
				} else {
					l = annotv.size();
					q = 0;
				}
				//}//if 
			}//for

			Long catalog = null;
			Long annotationid = null;
			logger.debug("The *****" + q + annotv.size());
			if (q == 0 && annotv.size() == 0) {
				logger.debug("I did not find" + annotv.size() + q);

			%>
	<font style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF; font-size:x-small"> No image found; &nbsp;</font>
	<br>
	<%} else {
				logger.debug("I am in else");
				String catdir = null;

				%>
	<table align="center" width="95%" WRAP>
		<%if (l > annotv.size()) {
					a = l - annotv.size();
				}

				%>

		<%if ((q + 5) < annotv.size()) {%>
		<%@ include file="numberAdv.html"%>
		<%} else if ((q % 5) != 0) {
				q = q - 5;
					navflag = true;%>
		<%@ include file="numberAdvLast.html"%>
		<%} else if ((q % 5) == 0 && q != annotv.size()) { 
					//q=q-5;%>
			
		<%@ include file="numberAdv.html"%>
		<%} else {
					q = q - 5;
					logger.debug("**************" + q);%>
		<%@ include file="numberAdvLast.html"%>
		<%}%>

		<%//this will adjust the length of the last records
		
				for (j = q; j < l - a; j++) {
					if (q >= 0 && q <= annotv.size()) {
						logger.debug("The value of j and q and L " + j + " "
								+ q + " " + l + "annot " + annotv.size());
						Annotations Annot = null;
						if (j >= 0 && j <= annotv.size()) {
							logger.debug("The value of j " + j);
							try {
								Annot = (Annotations) annotv.elementAt(j);
							} catch (Exception ex) {
								logger.debug("the exception is" + ex);
							}
						}
						
						String image_trim = Annot.getImage_name().trim();
						
						String image_type = null;
						int annotationimagename = Annot.getImage_name()
								.length() - 4;
					
						image_type = image_trim.substring(annotationimagename,
								Annot.getImage_name().length() - 1);
					
						if (image_type.equals(".ti")
								|| image_type.equals("tif")) {
							logger.debug("I am in sid loop");%>
		<%-- <%@ include file="imageCharacterstic.jsp"%> --%>
		<%@ include file="djatokaThumb.jsp"%>
		<%} else if (image_type.equals(".pf")
								|| image_type.equals(".pff")) {//This is not sid 
							logger.debug("I am in not in sid loop");

							%>
		<%@ include file="imageZoomify.jsp"%>
		<%} else if (image_type.equals(".mp")
								|| image_type.equals(".mpg")) {//This is mpeg 
							logger.debug("I am in not in sid loop");

							%>
		<%@ include file="imageMpeg.jsp"%>
		<%}%>
		<%}//if
				}//for 

				%>
		<%logger.debug("At the end of for q is" + q + "annotv.size()"
						+ annotv.size() + navflag);

				%>
		<%if ((q + a + 5) < annotv.size() && (navflag == false)) {
					logger.debug("i am here1 q " + q + "a " + a
							+ "annotv.size()" + annotv.size());%>
		<%@ include file="numberAdv.html"%>
		<%} else if ((q % 5) != 0) {
			
					q = q - 5;
					navflag = true;%>
		<%@ include file="numberAdvLast.html"%>
		<%} else if ((q % 5) == 0 && q != annotv.size() - 5) {
					//q=q-5;
			%>
		<%@ include file="numberAdv.html"%>
		<%} else if ((q + 5 == annotv.size()) && (navflag = true)) {
					%>
		<%@ include file="numberAdvLast.html"%>
		<%} else {
					%>
		<%@ include file="numberAdv.html"%>
		<%}%>

	</table>
	<%logger.debug("I reached the end");
			}

		%>
</FORM>
<%@ include file="html/search_results_bot.htm"%>
</body>
</html>
