<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">



<html>

<head> -->
<!--- <%//@ include file="submission_header.html"%> --->

<%@ include file="headernotab.html"%> 

</head>



<body>














<!--start of wrap table-->
<TABLE align="left" width="80%" cellspacing="10" cellpadding="10" border="0">
	<TR>
	<!--start of naviagation table-->
		<TD align="left" valign="top" width="10%">
		<%@ page import="java.util.*"%>
		<%-- check which navBar to include --%>
		<%--<%! String navBar; %>
			<% 
			navBar = (String) request.getAttribute("nci.mmhcc.navBar");
			if(navBar.equalsIgnoreCase("geninfo")){%>
				<%@ include file="navtable_geninfo.html"%>
				
		<% }else if(navBar.equalsIgnoreCase("genmodel")){%>
		<%@ include file="navtable_genmodel.html"%>
		<% }else if(navBar.equalsIgnoreCase("login")){%>
		<%@ include file="navtable_login.html"%>
		<%} else if (navBar.equalsIgnoreCase("histopath")){%>
		<%@ include file="navtable_histopath.html"%>
		<%} else if (navBar.equalsIgnoreCase("theraAppro")){%>
		<%@ include file="navtable_theraAppro.html"%>	
			<%}  else if (navBar.equalsIgnoreCase("cellLines")){%>
			<%@ include file="navtable_cellLines.html"%>	
			<%}%>		
		</TD>%>--%>
		<!--end of naviagation table-->
		<TD valign="top">
			<!--start of main table-->
			<TABLE border="0" align="center" cellspacing="5" cellpadding="5">
			<!--insert mainpart here-->
		<tr><td>
		
		<font style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#ff0000; font-size:20px">Error: Missing Required Fields</font>
<p class="bodytxbold">The record could not be added because the following required fields were left empty:
</p>

<ul>
	<%-- find out which feilds were missing --%>
	<%! Vector missing_feilds = new Vector();
		Enumeration feilds = null; %>
	<%  missing_feilds = (Vector) request.getAttribute("nci.mmhcc.MissingFeilds");
	if(missing_feilds != null){
	feilds = missing_feilds.elements();
	while(feilds.hasMoreElements()){%>
		<!--- <li class="bodytext"><color="red"><%//=(String)feilds.nextElement()%></font> --->
	<p class="bodytext"><%=(String)feilds.nextElement()%></p>
	<%}//end while
	}//end if%>
</ul>
<P class="bodytxbold">
Please go back using your browser's back button and enter a values for these fields.

		</td></tr>
		</table>
		<!--end of main table-->
		</TD>
	</TR>
</TABLE>
<!--end of wrap table-->




</BODY>

</HTML>
