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
<%//@ page import="gov.nih.nci.evs.query.*"%>
<%//@ page import="gov.nih.nci.evs.domain.*"%>
<%//@ page import="gov.nih.nci.system.applicationservice.*"%>
<%@ page import="javax.swing.tree.*"%>
<%//@ page import="gov.nih.nci.evs.domain.DescLogicConcept"%>
<%//@ page import="gov.nih.nci.common.net.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="gov.nih.nci.system.client.ApplicationServiceProvider"%>
<%@ page import="org.LexGrid.LexBIG.LexBIGService.*"%>
<%@ page import="org.LexGrid.LexBIG.caCore.interfaces.LexEVSApplicationService"%>
<%@ page import="org.LexGrid.LexBIG.caCore.interfaces.LexEVSDistributed"%>
<%@ page import="org.LexGrid.LexBIG.caCore.interfaces.LexEVSService"%>
<%@ page import="gov.nih.nci.evs.security.SecurityToken"%>
<%@ page import="gov.nih.nci.system.applicationservice.ApplicationService"%>


<%			Logger logger = Logger.getLogger(simpleandfile.class);
			logger.debug("****Simple results.jsp*********");	%>

<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<script language="JavaScript">
function showWindow(imgscr){
		myWind = window.open(imgscr,"subWindow","HEIGHT=1000,WIDTH=1024,resizable");
		myWind.focus();
	}
</script>

<%@ include file="html/search_results_top.htm"%>
<FORM method="POST">

	<%
			//ApplicationService appService = null;
			LexBIGService appService = null;

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

				//appService = ApplicationService.getRemoteInstance(qa);
				appService = (LexBIGService)ApplicationServiceProvider.getApplicationServiceFromUrl(qa, "EvsServiceInfo");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		
			//request.isValid();
			int cnt = 0;
			String organ = "";
			String dignosis = "";
			//String tissue = null;
			String dignosisName = "";
			String tname = "";
			int a = 0;
			String species = "";
			String imagename = null;
			boolean navflag = false;

			
			species = request.getParameter("species").trim();
			if (species != null && !species.equals("")) {
				species = SafeHTMLUtil.clean(species);
				List speciesList = new ArrayList();
				speciesList = (List) request.getSession().getAttribute(Constants.Dropdowns.SPECIESQUERYDROP);
				request.getSession().setAttribute(Constants.Dropdowns.SEARCHSPECIESDROP, speciesList);
				if (!SafeHTMLUtil.isValidStringValue(species, Constants.Dropdowns.SEARCHSPECIESDROP, request))
				{ 
					System.err.println("SPECIES.error.validValue:" + species);
					throw new IOException("invalid species:" + species);
				} 
			}
			
			
			tname = request.getParameter("organTissueName").trim();

			tname = URLDecoder.decode(tname).trim();
			if (tname != null && !tname.equals("")) {
				tname = SafeHTMLUtil.clean(tname);
			}
			

			organ = request.getParameter("organTissueCode").trim();
			if (organ != null && !organ.equals("")) {
				organ = SafeHTMLUtil.clean(organ);
			}
			dignosis = request.getParameter("diagnosisCode").trim();
			if (dignosis != null && !dignosis.equals("")) {
				dignosis = SafeHTMLUtil.clean(dignosis);
			}
			
			dignosisName = request.getParameter("diagnosisName").trim();
			dignosisName = URLDecoder.decode(dignosisName).trim();
			if (dignosisName != null && !dignosisName.equals("")) {
				dignosisName = SafeHTMLUtil.clean(dignosisName);
			}
			
			//constructors classes
			Species sp = new Species();
			Stain st = new Stain();
			Image_characteristic ic = new Image_characteristic();
			Strain str = new Strain();
			Gender gen = new Gender();
			Publication_journal pj = new Publication_journal();
			Publication pub = new Publication();
			Login log = new Login();

			

			if (species != null && !species.equals("")
					&& !species.equals("null")) {
				cnt = cnt + 1;
			}
			if (organ != null && !organ.equals("") && !organ.equals("null")) {
				cnt = cnt + 1;
			}
			if (dignosis != null && !dignosis.equals("")
					&& !dignosis.equals("null")) {
				cnt = cnt + 1;
			}
			if (session.getAttribute("sca") != null) {
				cnt = cnt + 1;
			}

			int q = 0;
			q = Integer.parseInt(request.getParameter("q"));

			int j = 0;
			int l = q + 5;
		
			String sw = null;
			Annotations annot = new Annotations();
			Vector annotv = null;

			if (cnt <= 0) {
	
				annotv = annot.retrieveAll();		%>

	<H3 style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF;">
		Search Criteria: all &nbsp;
	</H3>
	<%} else {
				%>
	<H3 style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF;">
		Search Criteria: &nbsp;
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
					convert = CommaConcat.convert(dignosisName, cnt1);	%>
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}
				if (session.getAttribute("sca") != null) {
					String loginuid = (String) session.getAttribute("sca");
					convert = CommaConcat.convert(loginuid, cnt1);	%>
		Login =
		<%=convert%>
		<%cnt1 = cnt1 - 1;
				}

			%>
		&nbsp;
	</H3>
	<%} //if(cnt)
			String where = null;
			String nextwhere = null;
			for (int m = 0; m < cnt; cnt--) {
				if (((species.length() != 0) && species != null)
						|| ((organ.length() != 0) && organ != null)
						|| ((dignosis.length() != 0) && dignosis != null)) {

					if (species != null && !species.equals("")) {
				
						Long speciesl = null;
						//name to id conversion
						String searchstring = "SPECIES_NAME = " + "'" + species
								+ "'";
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
					} //species

					if (organ != null && !organ.equals("")
							&& !organ.equals("null")) {
						StringBuffer whereBuf = new StringBuffer();
						String organsep = null;
						if (organ.indexOf(",") != -1) {// this is for generic diagnosis search
							StringTokenizer tokens = new StringTokenizer(organ,
									",");
							while (tokens.hasMoreTokens()) {
								organsep = tokens.nextToken();
								whereBuf
										.append("'"
												+ organsep.substring(organ
														.indexOf("C") + 1)
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

					} //organ

					if (dignosis != null && !dignosis.equals("")
							&& !dignosis.equals("null")) {

						String concept_id = null;
						StringBuffer whereBuf = new StringBuffer();
						String diagnosissep = null;
						if (dignosis.indexOf(",") != -1) {// this is for generic diagnosis search
							StringTokenizer tokens = new StringTokenizer(
									dignosis, ",");
							while (tokens.hasMoreTokens()) {
								diagnosissep = tokens.nextToken();
								whereBuf.append("'"
										+ diagnosissep.substring(dignosis
												.indexOf("C") + 1) + "'" + ",");
							}//while
							whereBuf.deleteCharAt(whereBuf.length() - 1);
	
							nextwhere = "annotation_id in (select annotation_id from image_diagnosis where diagnosis in "
									+ "(" + whereBuf + ") )";
						}//if
						else {
							nextwhere = "annotation_id in (select annotation_id from image_diagnosis where diagnosis in "
									+ "'"
									+ dignosis
											.substring(dignosis.indexOf("C") + 1)
									+ "' )";
						}
						if (where != null) {
							where += WhereConverter.convert(nextwhere, cnt);
						} else {
							where = WhereConverter.convert(nextwhere, cnt);
						}
						cnt = cnt - 1;
					} //if dignosis

					if (session.getAttribute("sca") != null) {

						String loginid = (String) session.getAttribute("sca");

						String searchstring = "DONATOR_ID = " + "'" + loginid
								+ "'";

						nextwhere = searchstring;
						if (where != null) {
							where += WhereConverter.convert(nextwhere, cnt);
						} else {
							where = WhereConverter.convert(nextwhere, cnt);
						}
						cnt = cnt - 1;
					} //LOGIN

					annotv = annot.retrieveAllWhere(where
							+ " and CURATED_ID = 1");



					if (annotv.size() > 5) {
						l = q + 5;
					} else {
						l = annotv.size();
						q = 0;
					}
				}//if 
			}//for

			Long catalog = null;
			Long annotationid = null;

			if (q == 0 && annotv.size() == 0) {
			
			%>
	<font style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF; font-size:15px"> No image found; &nbsp;</font>
	<br>
	<%} else {
				String catdir = null;		%>
	<table align="Center" width="95%" WRAP>
		<%if (l > annotv.size()) {
					a = l - annotv.size();
				}				%>
		<%if ((q + 5) < annotv.size()) {%>
		<%@ include file="numberSimple.html"%>
		<%} else if (q > 5) {
					q = q - 5;
					navflag = true;%>
		<%@ include file="numberSimpleLast.html"%>
		<%} else {%>
		<%@ include file="numberSimple.html"%>
		<%}%>
		<%//this will adjust the length of the last records
				for (j = q; j < l - a; j++) {
					if (q >= 0 && q <= annotv.size()) {
						Annotations Annot = null;
						if (j >= 0 && j <= annotv.size()) {
							try {
								Annot = (Annotations) annotv.elementAt(j);
							} catch (Exception ex) {
								System.err.println("the exception is" + ex);
							}
						}
						String image_trim = Annot.getImage_name().trim();
						String image_type = null;
						int annotationimagename = Annot.getImage_name()
								.length() - 4;
						image_type = image_trim.substring(annotationimagename,
								Annot.getImage_name().length() - 1);
		if (image_trim.indexOf(".pff") < 0) {
						%>
		<%-- <%@ include file="imageCharacterstic.jsp"%> --%>
		<%@ include file="djatokaThumb.jsp"%>
		<%} else  {%>
						
			<%@ include file="imageZoomify.jsp"%>
		<%}	%>
		<%}//if
				}//for 	%>
	
		<%if ((q + a + 5) < annotv.size() && (navflag == false)) {%>
		<%@ include file="numberSimple.html"%>
		<%}
				if ((navflag) && (q != 0)) {
			
					q = q;%>
		<%@ include file="numberSimpleLast.html"%>
		<%}

			%>
	</table>
	<%}//else
			System.err.println("I reached the end");

		%>
</FORM>
<%@ include file="html/search_results_bot.htm"%>
</body>
</html>
