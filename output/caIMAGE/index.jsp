
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



