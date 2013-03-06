<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<!--
  	Himanso Sahni
	MMHCC
	SAIC NCI
	login_a.jsp
-->


<%@ page language="java" import="java.util.*,gov.nih.nci.caIMAGE.util.*,gov.nih.nci.caIMAGE.*,gov.nih.nci.caimage.db.*"%>
<%@ page info="this page is the login page, first name & last name and verified on tbis page "%>
<%//SessionManager sessionManager = new SessionManager(session,-1);
			//SessionManager.setSessionProperties(session,-1);
			//DatabaseSetup.setPageExpiration(response); %>
<% //add request type to session 	

			String mode = (String) request.getParameter("mode");
			if (mode == null) {
				mode = (String) request.getAttribute("nci.mmhcc.newuser");
			}

			if ((mode != null) && mode.equals("Submit")) {

				session.setAttribute("nci.mmhcc.requestType", mode);
				response.sendRedirect("redirect.jsp?mode=Submit");
			}
			//Object sca = session.getAttribute("sca");
			//if(mode.equals("sca")){

			//session.setAttribute("nci.mmhcc.submitter.userName","demo"); 	
			//response.sendRedirect("redirect.jsp?mode=sca");
			//}

			%>
<%response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");%>
<%-- Populate Submitter object with last and first name --%>
<%-- Verify name --%>
<%@ include file="submit_images.htm"%>
<!--- <%//@ include file="login_a.html"%>  --->
<!---  <h2>Coming Soon...........<h2>  --->


