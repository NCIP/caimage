<!--commented out by Ulli
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN""http://www.w3.org/TR/REC-html40/frameset.dtd">
<html> -->
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

<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<!-- commented out by Ulli<head> -->
<!-- This is for making the images to UTF format -->
<!--commented out by Ulli
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<LINK rel="stylesheet" type="text/css" href="images/submission.css"> -->
<script language="JavaScript">

function showWindow(imgscr){
		myWind = window.open(imgscr,"subWindow","HEIGHT=520,WIDTH=520,resizable");
		myWind.focus();
	}

</script>
<!-- commented out by Ulli
 </head>

<body> -->
<%@ include file="html/search_results_top.htm"%>


<FORM method="POST"   >

<%System.out.println("=======simple================");
System.out.println("sca at the simple results:" +session.getAttribute("sca")); 
//System.out.println("session is"+request.getSession(false) );
//System.out.println("session is"+request.getSession(true) );
//request.isValid();
int cnt = 0;
 String organ = "";
 String dignosis = "";
 //String tissue = null;
 String dignosisName = "";
 String tname = "";
 int a = 0 ;
 String species = "";
 
Species sp = new Species();
 
species = request.getParameter("species").trim();
System.out.println("species"+species);
tname= request.getParameter("organTissueName").trim();
System.out.println("The param organ name"+tname);
tname = URLDecoder.decode(tname).trim();
organ = request.getParameter("organTissueCode").trim();
System.out.println("The param organ code"+organ);
dignosis = request.getParameter("DiagnosisCode").trim();
System.out.println("dignosis code"+dignosis);
dignosisName = request.getParameter("DiagnosisName").trim();
System.out.println(dignosisName); 
dignosisName = URLDecoder.decode(dignosisName).trim();

//constructors classes
//Species sp = new Species();
Stain st = new Stain();
Concept_mapping cm  = new Concept_mapping();
Image_characteristic ic = new Image_characteristic() ;
Model mod = new Model();
Strain str = new Strain();
Gender gen = new Gender();
Publication_journal pj = new Publication_journal();
Publication pub = new Publication();
Login log = new Login();
EvsUtil myEvs = new EvsUtil("evs.properties");

	if (species !=null && !species.equals("") && !species.equals("null") ){
	cnt = cnt + 1;
	System.out.println("I reached here 1");
	}	
	if (organ != null && !organ.equals("") && !organ.equals("null") ){
	cnt = cnt + 1;
	}
	if (dignosis != null && !dignosis.equals("") && !dignosis.equals("null")  ){
	cnt = cnt + 1;
	}
	if (session.getAttribute("sca") != null){
	cnt = cnt + 1;
	}
	System.out.println("total count is"+cnt);
	System.out.println("so far"+species+organ+dignosis);
	int q = 0;
	q = Integer.parseInt(request.getParameter("q"));
	System.out.println("I reached here 4");
int j = 0;
int l = q+5;
System.out.println(" q value is"+q);
System.out.println(" l value is"+l);
String sw = null;
Annotations annot = new Annotations();
System.out.println("the get value is"+annot);
System.out.println("the get value is "+species+"organ "+organ+"dignosis "+dignosis);
Vector annotv  = null;
	System.out.println("I reached here 5");
if(cnt <= 0){
	System.out.println("The where cluse for all");
	annotv = annot.retrieveAll(); %>
	
<H3 style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF;">Search Criteria:  all 
         &nbsp;</H3>
	<%} else { 
	System.out.println("The count is"+cnt);%>
	<H3 style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF;">Search Criteria:  
	&nbsp;
	<%
	int cnt1= cnt;
	String convert = null;
	if ( species.length()!= 0 &&  species != null && !species.equals("null")){
	//sp.retrieveByIndex(Long.decode(species)  );
	//convert = CommaConcat.convert(sp.getSpecies_name(), cnt1); 
		convert = CommaConcat.convert(species, cnt1); 
		//System.out.println(" sp comma value"+convert+cnt1 +species.length());
		//sp.retrieveByIndex(Long.decode(species)  );%>
	<%=convert%>
	<%cnt1 = cnt1 -1 ;
	}
	if (  organ != null && !organ.equals("") && !organ.equals("null") ){
	convert = CommaConcat.convert(tname, cnt1);
		System.out.println("org comma value"+convert+cnt1);%>
	<%=convert%>
	<%cnt1 = cnt1 -1 ;
	} 
	if ( dignosis != null && !dignosis.equals("") && !dignosis.equals("null")  ){
	convert = CommaConcat.convert(dignosisName, cnt1);
		System.out.println("dig comma value"+convert+cnt1);%>
	<%=convert%>
	<%cnt1 = cnt1 -1 ;
	 } 
	 if (session.getAttribute("sca") != null){
	 	String loginuid = (String)session.getAttribute("sca");
		convert = CommaConcat.convert( loginuid , cnt1); 
		//System.out.println(" sp comma value"+convert+cnt1 +species.length());
		//sp.retrieveByIndex(Long.decode(species)  );%>
		Login = <%=convert%>
		<%cnt1 = cnt1 -1 ;
		}
	  %>&nbsp;</H3> 
<%} //if(cnt)
String where = null;
String nextwhere = null;
for (int m = 0 ; m< cnt; cnt --) {
	if( ( (species.length() != 0) && species != null )|| ( (organ.length() != 0) && organ != null ) || ( (dignosis.length() != 0) && dignosis != null ) ){
		
		if(species != null && !species.equals("") ) {
		System.out.println(" I  am species loop");
		Long speciesl = null;
		//name to id conversion
		String searchstring = "SPECIES_NAME = " + "'"+species+"'" ;
		System.out.println(searchstring);
		Vector spec = sp.retrieveAllWhere(searchstring);
		for(int k =0; k < spec.size(); k++){
				Species  spvec = (Species) spec.elementAt(k);
				speciesl = spvec.getSpecies_id();
		}//for
		nextwhere = "SPECIES_ID = " + speciesl ;
			if (where != null){
			where += WhereConverter.convert(nextwhere, cnt);
			} else{
			where = WhereConverter.convert(nextwhere, cnt);
			}
		cnt = cnt - 1;
		System.out.println("The where after conversion"+where+"\n");
		} //species
		if(organ != null && !organ.equals("") && !organ.equals("null")  ) { 
		System.out.println(" I  am organ loop in ");
		 StringBuffer whereBuf = new StringBuffer();
		 String organsep = null;
			if(organ.indexOf(",")!=-1){// this is for generic diagnosis search
		     StringTokenizer tokens = new StringTokenizer(organ,",");
			 	while(tokens.hasMoreTokens()){
			  	organsep = tokens.nextToken();
			  	whereBuf.append("'"+ organsep.substring(organ.indexOf("C")+1) +"'"+",");
			 	}//while
			  	whereBuf.deleteCharAt (whereBuf.length()-1);
			  System.out.println("the value is"+whereBuf);
			nextwhere = "ORGAN in " + "("+whereBuf+")"  ;
			  }//if
		     else {
			 	nextwhere = "ORGAN in" + "'"+organ.substring(organ.indexOf("C")+1)+"'"  ;
			 }
		if (where != null){
			where += WhereConverter.convert(nextwhere, cnt);
			}else
			{
			where = WhereConverter.convert(nextwhere, cnt);
			}
		cnt = cnt - 1;
		System.out.println("The organ after conversion "+where+"\n");
		System.out.println("the organ at the end is"+organ);
		} //organ
		
		if(dignosis !=  null && !dignosis.equals("") && !dignosis.equals("null") ) {
		System.out.println(" I  am dignosis loop");
		String concept_id = null;
		StringBuffer whereBuf = new StringBuffer();
			if(dignosis.indexOf(",")!=-1){// this is for generic diagnosis search
		     StringTokenizer tokens = new StringTokenizer(dignosis,",");
			 	while(tokens.hasMoreTokens()){
			  	dignosis = tokens.nextToken();
			  	whereBuf.append("'"+ dignosis.substring(dignosis.indexOf("C")+1) +"'"+",");
			 	}//while
			  	whereBuf.deleteCharAt (whereBuf.length()-1);
			  System.out.println("the value is"+whereBuf);
			nextwhere = "CONCEPT_ID in " + "("+whereBuf+")"  ;
			  }//if
		     else {
			 	nextwhere = "CONCEPT_ID in" + "'"+dignosis.substring(dignosis.indexOf("C")+1)+"'"  ;
			 }
		/*
		Vector cmret = cm.retrieveAllWhere(" CONCEPT_MAPPING_NAME =" + "'"+ dignosis +"'");
		for(int k =0; k < cmret.size(); k++){
				Concept_mapping Conmap = null;
					if(k >=0  && k <= cmret.size()) {
					System.out.println("The value of k "+ k );
					Conmap = (Concept_mapping) cmret.elementAt(k);
					concept_id = Conmap.getConcept_mapping_id();
					}//if
					
		}//for
		if (concept_id == null){
		nextwhere  = " CONCEPT_ID  is null" ;
		} else {
		nextwhere  = " CONCEPT_ID =" + "'"+concept_id +"'" ;
		} */
		if (where != null){
			where += WhereConverter.convert(nextwhere, cnt);
			}else
			{
			where = WhereConverter.convert(nextwhere, cnt);
			}
		cnt = cnt - 1;
		System.out.println("The dignosis after conversion"+where+"\n");
		} //if dignosis
		if(session.getAttribute("sca") != null ) {
		System.out.println(" I  am loging loop");
		String loginid = (String)session.getAttribute("sca") ;
		//name to id conversion
		String searchstring = "DONATOR_ID = " + "'"+loginid+"'" ;
		System.out.println(searchstring);
		nextwhere = searchstring;
			if (where != null){
			where += WhereConverter.convert(nextwhere, cnt);
			} else{
			where = WhereConverter.convert(nextwhere, cnt);
			}
		cnt = cnt - 1;
		System.out.println("The where after conversion"+where+"\n");
		} //LOGIN
			
		System.out.println("The where cluse"+ where);
		annotv = annot.retrieveAllWhere(where);
		System.out.println("The size is"+annotv.size());
		if(annotv.size()> 5){
			l=q+5;
		}else {
			l=annotv.size();
			q=0;
		}
	}//if 
}//for

System.out.println("The value of L before the for loop is "+l +"q " +q );
Long catalog = null;
Long annotationid = null;
System.out.println("The *****"+q+annotv.size());
if(q == 0 && annotv.size() ==0) { 
	System.out.println("I did not find"+annotv.size()+q); %>
	<font style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF; font-size:15px"> 
        No image found; &nbsp;</font><br>
	<%} else {
	String catdir = null; %>
	<table  align = "Center" width="95%" WRAP  >
		<% if (l> annotv.size()){
	a = l - annotv.size() ;
	} %>
		 <%@ include file="numberSimple.html"%> 
	<%
	//this will adjust the length of the last records
for(j = q ; j < l-a; j++){
	if(q >= 0 && q <= annotv.size() ){
		System.out.println("The value of j and q and L "+ j +" "+q +" "+l+"annot "+annotv.size());
		Annotations Annot = null;
			if(j >= 0 && j <= annotv.size()){
			System.out.println("The value of j "+ j );
				try{
				Annot = (Annotations) annotv.elementAt(j);
				} catch(Exception ex)
					{ 
					System.out.println("the exception is"+ex);
					}
			}
			// this part is needed to get the  get the url formed for get the parameter in case
			// there is not in database and or forming the xml
			System.out.println("reached 1");
			catalog = Annot.getCatalog_id();
			annotationid = Annot.getAnnotation_id();
			Long curationid = Annot.getCurated_id();
			
			if (curationid.equals(new Long(1)) ) {
			
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
					String calcrgn =  null;
					if(annotationid.longValue()>=10000) {
					 String  imagename = "stage/"+image;
					 System.out.println("i am in if");
					 calcrgn = DatabaseSetup.checkForNull(catdir.trim())+"&"+"img="+DatabaseSetup.checkForNull(imagename.trim())+"&wid=400&hei=400&style=none";
					}else {
					 System.out.println("i am in else");
					  calcrgn = DatabaseSetup.checkForNull(catdir.trim())+"&"+"img="+DatabaseSetup.checkForNull(image.trim())+"&wid=400&hei=400&style=none";
					}
				
				//System.out.println("the calcrgn is:"+calcrgn);
				try{
				url = new URL(imageurl+calcrgn);
				System.out.println("The url is"+url);
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
						System.out.println("I reached to end of while"+annotationid);
						}//while
				else
				break;
			%>
			<%
			String bName = request.getHeader("User-Agent");
			if(bName != null ){  
			System.out.println("I am in header directory"+imagepath+"Catalog Directory"+catdir);%>
			 <tr bgcolor="#FFFFFF"> 
			<td align="left" valign="top"  width="11%"   >
				<%String strid = null;
						 if(annotationid.longValue()>=10000) {
				 			strid = "stage/"+Annot.getImage_name();
				 			System.out.println("i am in if");%>
				 			<a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(strid)%>&centerp=<%=number1/2%>,<%=number2/2%>&reslvl=<%=number3%>&wid=400&hei=400')">
							<img src= "<%=imagepath%><%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(strid.trim())%>&thumbspec="main"  alt="<%=DatabaseSetup.checkForNull(image.trim())%>" border="0" target="_blank"> </a><br>
						<%}else {
				 			System.out.println("i am in else");%>
				  			<a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(image.trim())%>&centerp=<%=number1/2%>,<%=number2/2%>&reslvl=<%=number3%>&wid=400&hei=400')">
							<img src= "<%=imagepath%><%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(image.trim())%>&thumbspec="main"  alt="<%=DatabaseSetup.checkForNull(image.trim())%>" border="0" target="_blank"> </a><br>
				 		<%}%>
				<%Thread.sleep(100);%>
				<font FACE ="trebuchet" size="-2" color="Red">
				<%=image%>
				</font> 
			</td>
			<% } 
			System.out.println("Results starts here");%> 
			 <%@ include file="results.jsp"%> 
			<%
			System.out.println("Results end here");
			input.close();
			} catch (IOException e) {%>
			<tr bgcolor="#FFFFFF">
			<td align="left" valign="top"  width="11%"   >
			<font FACE ="trebuchet" size="-1" color="Red"><%=catdir%>-<%=image%> not found<br></font>
			</td>
			<%@ include file="results.jsp"%>
			</tr>
			<%
			e.printStackTrace();
			}//try ends %>
		</tr>
	<%
	} //if for cuaration
		else { %>
		<tr><td colspan=3>
		<font style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF; font-size:12px"> 
        The image number <%=Annot.getAnnotation_id() %> was successfully entered in the database and awaits approval for display.
		 &nbsp;</font><br>
		 </td></tr>
		<%}//else curation
	}//if
	}//for 
		 %>
	<% System.out.println("At the end of for q is"+q); %>
			 <%@ include file="numberSimple.html"%> 
	</table>


<%
	}//else
System.out.println("I reached the end"); 
 %>
</FORM>
<%@ include file="html/search_results_bot.htm"%>
</body>
</html>	
