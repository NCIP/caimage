<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
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
<%//@ page errorPage = "Error.jsp " %>

<head>
	<title>Untitled</title>
</head>

<body>
<FORM method="POST" NAME="form1"  action="caimageSubmit.jsp">

 <jsp:include page="caimageROI.jsp" flush="true" />
<table>
<%
String species  = null;
String organ = null;
String dignosis = null;
String roidesc = null;
species= request.getParameter("species");
organ= request.getParameter("organTissueCode");
dignosis=request.getParameter("DiagnosisCode");
roidesc= request.getParameter("roidesc");
System.out.println(species+organ+dignosis+roidesc);%>
<tr>
<td><%=species%></td>
<td><%=organ%></td>
<td><%=dignosis%></td>
<td><%=roidesc%></td>
</tr>
</table>

</FORM>
</body>
</html>
