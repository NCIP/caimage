<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN""http://www.w3.org/TR/REC-html40/frameset.dtd">

<html>
<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %> 
<%@ page import = "java.lang.*"  %>
<%@ page import = "java.net.URL"  %>
<%@ page import = "java.io.*"  %>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page import = "org.w3c.dom.*" %>
<%@ page import = "org.w3c.dom.Document" %>
<%@ page import = "org.xml.sax.*" %>
<%@ page import = "javax.xml.*" %>
<%@ page import = "java.net.URLDecoder"  %>
<%@ page import = "java.net.URLEncoder"  %>
<%//@ page errorPage = "Error.jsp " %>
<%@ page import = "com.apelon.dts.client.Concept" %>
<%@ page import = "gov.nih.nci.ncicb.evs.*" %>


<head>
<!-- This is for making the images to UTF format -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Cancer Models Database - Submission</title>
<LINK rel="stylesheet" type="text/css" href="images/submission.css">
<script language="JavaScript">

function showWindow(imgscr){
		myWind = window.open(imgscr,"subWindow","HEIGHT=520,WIDTH=520,resizable");
		myWind.focus();
	}

</script>
</head>

<body>

<FORM method="POST"   >
<%@ include file="headernotab.html"%>


<%//@ include file="html/search_results_top.htm"%>
<%System.out.println("=======Publication Image================");
int cnt = 0;

String publication = request.getParameter("publication").trim();
PublicationImage pi = new PublicationImage();
Annotations annot = new Annotations();
String[] pubid = {publication};
Vector imagevec = pi.loadSessionObjects(pubid);

 cnt = imagevec.size();
 System.out.println("The size of the imagevector is ******"+cnt);
 String organ = "";
 String dignosis = "";
 //String tissue = null;
 String dignosisName = "";
 String tname = "";
 String species = "";
 
Species sp = new Species();

//constructors classes
//Species sp = new Species();
Stain st = new Stain();
Concept_mapping cm  = new Concept_mapping();
Image_characteristic ic = new Image_characteristic() ;
Model mod = new Model();
Login log = new Login();
Strain str = new Strain();
Gender gen = new Gender();
Publication_journal pj = new Publication_journal();
Publication pub = new Publication();
EvsUtil myEvs = new EvsUtil("evs.properties");

String sw = null;
//Annotations annot = new Annotations();
System.out.println("the get value is"+annot);
System.out.println("the get value is "+species+"organ "+organ+"dignosis "+dignosis);
Vector annotv  = null;
System.out.println("I reached here 5");
int j = 0;
if(cnt == 0){  %>
<H3>Search Criteria: Publication= <%=publication%> Not Found&nbsp;</H3>
	<%} else {  %>
	<H3>Search Criteria: Publication= <%=publication%> Found&nbsp;</H3>
	<table  align = "Center" width="95%" WRAP  >
	<%  String where = null;
		String nextwhere = null;
		for (int m = 0 ; m< cnt; cnt --) {
		System.out.println("The count is"+cnt);
			if(publication != null && !publication.equals("") ) {
			System.out.println(" I  am publication loop");
			Long speciesl = null;
			//name to id conversion
			StringBuffer sb = new StringBuffer();
				if (imagevec != null){
					for(int k =0; k < imagevec.size(); k++){
					System.out.println("The object value in jsp is"+imagevec.elementAt(k)+"\n" ); 
					String searchstring = "IMAGE_NAME = " + "'"+ imagevec.elementAt(k) + "'" ;
					sb.append("'"+ imagevec.elementAt(k) + "'" +"," );
					}
				}	
			String sbmodified = sb.substring(0, sb.length()-1);
			String searchstring = "IMAGE_NAME  IN " +"( "+ sbmodified +" )" ;
			System.out.println(searchstring);
			nextwhere = searchstring ;
			System.out.println("The where after conversion"+nextwhere+"\n");
			} //species
			annotv = annot.retrieveAllWhere(nextwhere);
			System.out.println("The size is"+annotv.size());
			j=annotv.size();
		}//for%>
	<%
	Long catalog = null;
	Long annotationid = null;
	String catdir = null;
	if(annotv.size()>= 0 ){
			Annotations Annot = null;
			for(j = 0 ; j < annotv.size(); j++ ){
			System.out.println("The value of j "+ j );
				try{
				Annot = (Annotations) annotv.elementAt(j);
				} catch(Exception ex)
					{ 
					System.out.println("the exception is"+ex);
				}//catch
			
			System.out.println("reached 1");
			catalog = Annot.getCatalog_id();
			annotationid = Annot.getAnnotation_id() ;
			System.out.println(Annot.getCatalog_id());
			System.out.println(Annot.getImage_name());
			String image = Annot.getImage_name().trim();
					Catalog ce = new Catalog();
			Vector catv = ce.retrieveAllWhere("CATALOG_ID = '"+catalog+"'");
				for(int k =0; k < catv.size(); k++){
				Catalog Ceta = null;
					if(k >=0  && k <= annotv.size()) {
					System.out.println("The value of k "+ k );
					Ceta = (Catalog) catv.elementAt(k);
					catdir = Ceta.getCatalog_directory().trim();
					System.out.println("the get value is"+catdir);
					}
						System.out.println("reached 5");
				}
				URL url = null;
				BufferedReader input = null;
				boolean flag = false;
				String lizard = getServletConfig().getServletContext().getInitParameter("lizard");
				String imagepath = lizard+"/iserv/getthumb?cat=";
				System.out.println("lizard image path:"+imagepath);
				String  line = new String();
				String imageurl = lizard+"/iserv/calcrgn?cat=";
				//System.out.println("lizard image url:"+imageurl);
				String calcrgn = DatabaseSetup.checkForNull(catdir)+"&"+"img="+DatabaseSetup.checkForNull(image)+"&wid=400&hei=400&style=none";
				//System.out.println("the calcrgn is:"+calcrgn);
		
		try{
				url = new URL(imageurl+calcrgn);
				//System.out.println("The url is"+url);
				Object abc = url.getContent();
				int number1 = 0 ;
				int number2 = 0;
				int number3 = 0;
				String region = null;
				if(url.openConnection() !=null){
					System.out.println("the object returned is:"+abc.toString());
					input = new BufferedReader(new InputStreamReader(url.openStream()), 1000 );
					//Helps bringing all the images
					Thread.sleep(100);
					//System.out.println("The flag  is *****"+flag);
					System.out.println("The input is *****"+input);
					System.out.println("the available byte is:"+url.openStream().available());
					StringBuffer buffer = new StringBuffer();
						while (( line = input.readLine() ) != null ){
							//System.out.println("The line is"+line.toString()+"\n");
							buffer.append( line.toString() );
							buffer.append( "<!DOCTYPE ImageServer SYSTEM" +"\"calcrgn.dtd\">" );
							flag = true;
							}
							String outputmod = buffer.delete(url.openStream().available()+40, buffer.capacity()).toString(); 
							// temporary closed but show xml
							//System.out.println("the output modified is"+outputmod);
							//String ret = SAXParseUtil.parseurl(outputmod);
							int width = 0;
							int width1 = 0;
						 	width= outputmod.lastIndexOf("width"); 
						 	width1=outputmod.indexOf(" ", width+7);
							int height = 0;
							int height1= 0;
							height = outputmod.lastIndexOf("height");
							System.out.println("The start of height is at"+height);
							height1= outputmod.indexOf(" ",height+8);
							System.out.println("The end of height is at"+height1);
							int numlevels = 0;
							numlevels = outputmod.lastIndexOf("numlevels"); 
							number1= Integer.parseInt(outputmod.substring(width+7, width1-1)); 
							number2 = Integer.parseInt(outputmod.substring(height+8, height1-1)); 
							number3 =  Integer.parseInt(outputmod.substring(numlevels+11, numlevels+12)); 
							int rgn = 0;
							int rgn1 = 0;
						 	rgn= outputmod.lastIndexOf("rgn"); 
						 	rgn1=outputmod.indexOf(" ", rgn+4);
							region =  (String)(outputmod.substring(rgn+5, rgn1-1)); 
							System.out.println("The region is"+region);
								System.out.println("I reached to insert"+annotationid);
								boolean catfromic= ic.retrieveByKey(annotationid);
								if(!catfromic){
								ic.setImage_characteristic_id(annotationid);
								//int hei = (height1-height);
								//int wid = (width1-width);
								ic.setImage_characteristic_height(Integer.toString(number2));
								ic.setImage_characteristic_width(Integer.toString(number1));
								ic.setImage_characteristic_numlevel(Integer.toString(number3));
								ic.setImage_modality_id(Long.valueOf("1"));
								ic.insert ();
								}
						}//while
			String bName = request.getHeader("User-Agent");
			if(bName != null ){  %>
			<tr>
			<td align="left" valign="top">
				<a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir)%>&img=<%=DatabaseSetup.checkForNull(image)%>&centerp=<%=number1/2%>,<%=number2/2%>&reslvl=<%=number3%>&wid=400&hei=400')">
				<img src= "<%=imagepath%><%=DatabaseSetup.checkForNull(catdir)%>&img=<%=DatabaseSetup.checkForNull(image)%>&thumbspec=main"  alt="<%=DatabaseSetup.checkForNull(image)%>" border="0" target="_blank"> </a><br>
				<%Thread.sleep(100);%>
				<font FACE ="trebuchet" size="-1" color="Red">
				<%=image%><br>
				</font>
			</td>
			<%} %> 
			<td>&nbsp;</td>
			<td  align="left" valign="top" bgcolor="silver">
				<%if(Annot.getImage_annotations()!=null){%>
				<b>Description:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=DatabaseSetup.checkForNull(Annot.getImage_annotations())%>
				</font><br>
				<%}
				if(Annot.getOrgan()!=null){%>
				<b>Organ:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<% String organname = Annot.getOrgan();
				Concept myConcept = myEvs.getConceptByCode("C"+organname);
				if(myConcept!=null) { %>
					<%=myConcept.getName()%>
					<%} %>
				</font><br>
				<%} 
				sp.retrieveByIndex(Annot.getSpecies_id()  );
				if(Annot.getSpecies_id()!=null){%>
				<b>Species:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=sp.getSpecies_name()%>
				</font><br>
				<%} 
				if(Annot.getConcept_id()!=null){%>
				<b>Diagnosis:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<% String diagnosis = Annot.getConcept_id();
				Concept myConcept = myEvs.getConceptByCode("C"+diagnosis);
				if(myConcept!=null) { %>
					<%=myConcept.getName()%>
					<%} %>
				</font><br>
				<%} 
				str.retrieveByIndex(Annot.getStrain_id()  );
				if (Annot.getStrain_id() != null) {  %>
				<b>Strain:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=str.getStrain_name()%>
				</font><br>
				<%} 
				if (Annot.getGene() != null) {  %>
				<b>Gene:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=Annot.getGene()%>
				</font><br>
				<%} 
				if (Annot.getPromoter() != null) {  %>
				<b>Promoter:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=Annot.getPromoter()%>
				</font><br>
				<%} 
				gen.retrieveByIndex(Annot.getGender_id());
				if (Annot.getGender_id() != null) {%>
				<b>Gender:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=gen.getGender_name()%>
				</font><br>
				<%}	
				pub.retrieveByIndex(Annot.getPublication_id()); 
				if (Annot.getPublication_id() != null) {%>
				<b>Publication Id:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=Pubmed&list_uids=<%=pub.getPublication_name()%>&dopt=Abstract">
				<%=pub.getPublication_name()%></a>
				</font><br>
				<% } 
				mod.retrieveByIndex(Annot.getModel_id()  );
				if (Annot.getModel_id() != null) {%>
				<b>Model:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=mod.getModel_name()%>
				</font><br>
				<% } 
				st.retrieveByIndex(Annot.getStain_id()  );
				if (Annot.getStain_id() != null) {%>
				<b>Stain:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=st.getStain_name()%>
				</font><br>
				<% } 
				log.retrieveByIndex(Annot.getDonator_id()  );
				if(Annot.getDonator_id()!=null)  {%>
				<b>Image Donated by lab of:&nbsp; </b> 
				<!--- <span class="bodytext"> 
				<%//=log.getPi_name()%>
				</span> 
				<span class="bodytxbold">Donator's Email:&nbsp; </span>  --->
					<%if(log.getEmail()!=null)  {%>
					
					<A href="mailto:<%=log.getPi_email()%>"><%=log.getPi_name()%></A>
					
					<br>
				<%	} 
				}
				ic.retrieveByIndex(Annot.getAnnotation_id() );
				if (ic.getImage_characteristic_width()!=null) {%>
				 <b>Image Width:&nbsp;</b>
				 <font FACE ="trebuchet" size="-2" color="Blue">
				 <%=ic.getImage_characteristic_width()%>&nbsp;
				 </font>
				<% }
				if (ic.getImage_characteristic_height()!=null) {%>
				<b>Image Height:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=ic.getImage_characteristic_height()%>&nbsp;
				</font>
				<% } 
				if (ic.getImage_characteristic_width() != null || ic.getImage_characteristic_height() != null  ) {%>
				<b>Unit Type:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%="Pixels"%>&nbsp;
				</font>
				<% } 
				if (ic.getImage_characteristic_numlevel() != null) {%>
				<b>Magnification Level:&nbsp;</b>
				<font FACE ="trebuchet" size="-2" color="Blue">
				<%=ic.getImage_characteristic_numlevel()%>
				</font><br>
				<% }%>
				
			</td>
			</tr>
		
			<%
			input.close();
			} catch (IOException e) {
			e.printStackTrace();
			}//try ends %>
	
	<%
	}//for
	}//if
	%>
	
	<%}//else%>
	</table>
</FORM>
</body>
</html>	

