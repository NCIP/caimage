<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import ="gov.nih.nci.caIMAGE.*" %>
	<title>Untitled</title>
</head>

<body>

<%
String stain_name = request.getParameter("stainname");
System.out.println(stain_name);
String stain_desc = request.getParameter("staindesc");
System.out.println(stain_desc);
KeyRetriever tk = new KeyRetriever();
Long stain_count = tk.getNextKey ("STAIN");
System.out.println("annotation count"+stain_count);
Stain st = new Stain();
st.setStain_id(stain_count);
st.setStain_name(stain_name);
st.setStain_description(stain_desc);
boolean  success = st.insert ();
System.out.println("the flag is"+success);
	if (success) { %>
	The entry has been added in the stain table
	<%}
%>
</body>
</html>
