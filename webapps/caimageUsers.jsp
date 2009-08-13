<HTML>
<head>
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


<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/edit_images_top.htm"%>
<head>
<body>
<form method="post"  action="intro.jsp" >
<table width="90%" align="center">
<tr><td>	
<%
System.out.println("*************I am in caimageUsers.jsp****************");
Annotations annot = new Annotations();
Long donator_id =  null;
donator_id = (Long)session.getAttribute("nci.mmhcc.submitter.submitterKey");
System.out.println("the donator id is"+donator_id);
if (donator_id != null ){
//annot.setDonator_id(donator_id);

Vector annotv  = null;
String catdir = null;
annotv = annot.retrieveAllWhere(" donator_ID =" + "'"+donator_id +"'" + "order by annotation_id desc");	
Login log = new Login();
log.retrieveByKey( donator_id );	%>

<h2 class="bodytxrequ">Welcome back <%=log.getFirstname()%> <%=log.getLastname()%> !</h2>
</td></tr><tr><td class="bodytext">To edit one of your <b>existing images</b> click on the name of the image. <br>To add a <b>new image</b> select &quot;Add new Image&quot;.<br><br>
If you are unfamiliar with the submission process please refer to <a href="help_submit.html" target="_blank" class="bodytxrequ">HELP</a>.
</td></tr>
<tr><td class="bodytext"> <img src= "#" alt="imagename.sid" width="105" height="30" /> indicates that image is available on the server but not ready for display.</td></tr>
<tr><td class="bodytext"><br>You previously submitted <b><%=annotv.size()%></b> images.</td></tr>

</table>
<p>
<TABLE border="1" align="center" cellspacing="5" cellpadding="5" width="85%">
<tr>
		<td>&nbsp;</td><td align="center" colspan="3"><a href="caimageSubmit.jsp" class="bodytxrequ" >Add new Image</a></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
</tr>
<tr><td colspan="4"></td></tr>	
	<tr><td align="center" class="bodytxrequ" >Duplicate Annotations</td>
	<td class="bodytxrequ" align="center">Image Name</td>
	<td align="center"  class="bodytxrequ" >Image Number</td>
	<td align="center"  class="bodytxrequ" >Date Time</td>
	<td align="center" class="bodytxrequ" >Thumbnail image</td>
	<td align="center" class="bodytxrequ" >Remove</td>
</tr>
	
<%System.out.println("The size is"+annotv.size());
for(int j = 0 ; j < annotv.size(); j++){ 
Annotations Annot = (Annotations) annotv.elementAt(j);
System.out.println("The image name is"+Annot.getImage_name() );
String lizard = getServletConfig().getServletContext().getInitParameter("lizard");
String imagepath = lizard+"/iserv/getthumb?cat=";
System.out.println("lizard image path:"+imagepath);
System.out.println(Annot.getCatalog_id());
			Catalog ce = new Catalog();
			Vector catv = ce.retrieveAllWhere("CATALOG_ID = '"+Annot.getCatalog_id()+"'");
				for(int k =0; k < catv.size(); k++){
				Catalog Ceta = null;
					if(k >=0  && k <= annotv.size()) {
					System.out.println("The value of k "+ k );
					Ceta = (Catalog) catv.elementAt(k);
					catdir = Ceta.getCatalog_directory().trim();
					System.out.println("the get value is"+catdir);
					}
				}	
	Long id = Annot.getAnnotation_id();%>
	
		<tr>
		<td align="center">
		
		<a href ="intro.jsp?id=<%=id%>&copyStatus=true" onClick="return confirm('Do you want to duplicate the annotations of image #<%=id%>')"><img src="images/history_copy.gif" width="30" height="35" border="0"></a></td>
		<%
		System.out.println("image name"+Annot.getImage_name() );
		if(Annot.getImage_name().equals("No Image") ) { %>
		<td align="center" class="bodytext"><a href="caimageEdit.jsp?id=<%=id%>&mode=clone" ><%=Annot.getImage_description()%></a></td>
		<td align="center" class="bodytext"><%=id%>
		</td> 
		<%} else{%>
		<td align="center" class="bodytext"><a href="caimageEdit.jsp?id=<%=id%>&mode=edit" ><%=Annot.getImage_description()%></a></td>
		<td align="center" class="bodytext"><%=id%>
		</td>
		<%}
		if(Annot.getDatetime()!=null){%>
		<td align="center" class="bodytext"><%=Annot.getDatetime()%></td>
		<%} else { %>
		<td align="center" class="bodytext"></td>
		<%}%>
			<td align="center" class="bodytext">
			<%
			if(Annot.getImage_name()!=null) {
				System.out.println("The image is"+Annot.getImage_name()) ;
				if ( Annot.getImage_name().equals("No Image")  ) {
				System.out.println("I am in no image clone record");%>
				No Image Found <br>
				<%} else {
						 String strid = null;
						 if(id.longValue()>=10000) {
				 			strid = "stage/"+Annot.getImage_name();
				 			System.out.println("i am in if");%>
				 			<img src= "<%=imagepath%><%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(strid)%>&thumbspec="main"  alt="<%=DatabaseSetup.checkForNull(Annot.getImage_name().trim())%>" border="0" target="_blank"> <br>
				 		<%}else {
				 			System.out.println("i am in else");%>
				  			<img src= "<%=imagepath%><%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(Annot.getImage_name().trim())%>&thumbspec="main"  alt="<%=DatabaseSetup.checkForNull(Annot.getImage_name().trim())%>" border="0" target="_blank"> <br>
				 		<%}%>
					<%}
			}%>
				</td>
		<td align="center">
		<a href ="intro.jsp?id=<%=id%>&deleteStatus=true" onClick="return confirm('Are you sure you want to delete the record #<%=id%>')"><img src="images/trashcan.gif" border="0" ></a></td>
	</tr>
	<!--- <td ALIGN=middle WIDTH=15 bgcolor=#339933><a href='vListing.asp?Page=1&Search=0'><font color=#FFFFFF face=Arial><b>1</b></font></a></td>
 ---><%}
}//if donator
%>
</TABLE><p align="right" class="bodytextrt"><a href="#top">Top of the page</a></p>
	
	
	
</form>	
<P>&nbsp;</P><!-- #EndEditable -->
<%@ include file="html/simple_search2.htm"%>
</BODY>
<!-- #EndTemplate -->
</HTML>


