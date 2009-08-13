<%//reset all sessions
//session.invalidate();
%>
<% 
//This is for DANA sca project
	
	System.out.println("I am before sca"+request.getParameter("sca"));
			session = request.getSession();
     		//session = request.getSession(true);
	/*
	if(session.isNew()){
		if(request.getParameter("sca")!= null){
		 session.setAttribute("sca",request.getParameter("sca"));
		 System.out.println("sca a:" +session.getAttribute("sca"));  
		 session = request.getSession(false);
	 	System.out.println("I am in sca if "+request.getParameter("sca"));
		} else {
		System.out.println("I am in sca else "+request.getParameter("sca"));
		 session.setAttribute("sca",request.getParameter("sca"));
		session = request.getSession(true);
		}
	}*/
	if(!session.isNew()){
		request.getSession(false);
		System.out.println("I reached here");
		System.out.println("Session id :"+(String)session.getId());%>		
		<%@ include file="home.html"%>
		<%//@ include file="maintenance.html"%>
		<%}  
	else { 
	    request.getSession(true);
		System.out.println("Session id :"+(String)session.getId());%>
		<%System.out.println("MMHCC"+ request.getParameter("mmhcc"));%> 
	 	<%	if(request.getParameter("mmhcc")!= null){%>
	 		<%@ include file="html/caIMAGEMembersDisclaimer.html"%>
			<%}
		else{%>
	 		<%@ include file="GeneralDisclaimer.html"%>
		<%} 
	}      
	System.out.println("mmhcc:" + request.getParameter("mmhcc"));  
	if(request.getParameter("mmhcc")!= null){
 		 session.setAttribute("emiceMember","1");
		 System.out.println("emice:" +session.getAttribute("emiceMember"));  
	}
 %> 

 
       
