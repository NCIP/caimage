<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %> 
<%@ page import = "java.lang.*"  %>
<%@ page import = "java.net.URL"  %>
<%@ page import = "java.io.*"  %>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page buffer="none" %>
<%
// this is to take care of the catlog directory, image name and region.
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",System.currentTimeMillis());
String bName = request.getHeader("User-Agent");
 
System.out.println("bName:"+bName);
System.out.println("******catalogviewdir*********");
String catdir = null;
String rgn = null;
rgn = (String)request.getParameter("rgn");
System.out.println(rgn);
rgn = "0,0,1,1";
String image =(String) request.getParameter("img");
catdir = (String)request.getParameter("cat");

InputStream in = null;
Properties sysProps = new Properties();
try {
	in = Thread.currentThread().getContextClassLoader().getResourceAsStream("system.properties");
	sysProps.load(in);
} catch (Exception e) {
	System.err.println("Error loading system.properties file");
	e.printStackTrace();
}
String lizard = sysProps.getProperty("lizard");
String lizardstyle = sysProps.getProperty("lizard_Style");
System.out.println("Lizard path is"+lizardstyle);
%>
</head>
<body>
<%
String url = lizardstyle+"/calcrgn?cat="+catdir+"&img="+image+"&rgn="+rgn+"&wid=400&hei=400&props=cat(pon,son),item(en_Name,en_Description)&lang=en&style=view.xsl";
		System.out.println("url is"+url);
		response.sendRedirect(url);
		
%>
