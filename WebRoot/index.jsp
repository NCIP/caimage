<%--L
  Copyright SAIC

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<%@ page import="gov.nih.nci.caIMAGE.util.*"%>
<%//reset all sessions
			//session.invalidate();

			%>
<%//This is for DANA sca project

			session = request.getSession();
			//session = request.getSession(true);
			/*
			 if(session.isNew()){
			 if(request.getParameter("sca")!= null){
			 session.setAttribute("sca",request.getParameter("sca"));
			 session = request.getSession(false);
			 } else {
			 session.setAttribute("sca",request.getParameter("sca"));
			 session = request.getSession(true);
			 }
			 }*/
			if (!session.isNew()) {
				request.getSession(false);	%>
<%@ include file="home.html"%>
<%//@ include file="maintenance.html"%>
<%} else {
				request.getSession(true);				%>
<% NewDropdownUtil.setup(request); %>				
<%if (request.getParameter("mmhcc") != null) {%>
<%@ include file="html/caIMAGEMembersDisclaimer.html"%>
<%} else {%>
<%@ include file="GeneralDisclaimer.html"%>
<%}
			}
			if (request.getParameter("mmhcc") != null) {
				session.setAttribute("emiceMember", "1");
			
			}

		%>



