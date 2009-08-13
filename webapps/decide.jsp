<%@ page language="java" import="java.util.*,gov.nih.nci.caIMAGE.util.*, gov.nih.nci.caIMAGE.*,gov.nih.nci.caimage.db.*" %>
<%@ page info="this page is the login page, first name & last name and verified on tbis page "%>
<form name="main" method="POST" ENCTYPE ="multipart/form-data"  >

<% 
String mode = request.getParameter("mode");
System.out.println(mode);
String id = request.getParameter("id");
System.out.println(id);
System.out.println("=======abc page===============");
if (mode.equals("edit") ) {
System.out.println("I am in if loop Edit data"+mode+id);
//response.sendRedirect("caimageEditData.jsp?id="+id+"&mode="+mode);%>
<jsp:include page="caimageEditData.jsp?id=549&mode=edit" flush= "true"/> <BR>
<%} else { 
System.out.println("I am in else loop submit"+mode+id);
//response.sendRedirect("caimageEditSubmitResults_1.jsp?id="+id+"&mode="+mode);%>
<jsp:include page="caimageEditSubmitResults.jsp?id=549" flush= "true"/> <BR> 
<%}%>
</form>
