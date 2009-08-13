
<!--
  	Himanso Sahni
	MMHCC
	SAIC NCI
	verify_password.jsp
-->


 <%@ page language="java" import="java.util.*,gov.nih.nci.caimage.db.*" %>
  <%@ page info="this page is the password login page, password is validated on tbis page "%>
 <%gov.nih.nci.caIMAGE.DatabaseSetup.setPageExpiration(response);%>
 <%-- If the user has no session, reply with message --%>
 

<%@ include file="headernotab.html"%> 
<!--- <%//@ include file="submission_header.html"%>  --->

<!--start of wrap table-->
<TABLE align="left" width="80%" cellspacing="10" cellpadding="10" border="0">
	<TR>
	<!--start of naviagation table-->
		<TD align="left" valign="top" width="10%">

		</TD>
		<!--end of naviagation table-->
		<TD valign="top">
			<!--start of main table-->

<FORM METHOD=POST ACTION="verify_password.jsp">
<TABLE BORDER="0" align=center cellspacing="5" cellpadding="5" width="85%">


<TR ALIGN=left VALIGN=TOP>
<TD class="bodytxrequ">User Name:</TD>
<TD>
<INPUT TYPE=TEXT MAXLENGTH=100 SIZE=20  NAME="required_New User Name"  VALUE="" >
</TD></tr>
<TR ALIGN=left VALIGN=TOP>
<TD class="bodytxrequ">Password:</TD>
<TD>
<INPUT TYPE=password MAXLENGTH=15 SIZE=20  NAME="required_New Password"  VALUE="" >
</TD></tr>
<TR ALIGN=left VALIGN=TOP>
<TD class="bodytxrequ">Reenter Password:</TD>
<TD>
<INPUT TYPE=password MAXLENGTH=15 SIZE=20  NAME="required_Reenter Password"  VALUE="" >
</TD></tr>
<tr><td>&nbsp;</td>
<TD><INPUT TYPE=SUBMIT NAME="submit_password" VALUE="   NEXT   &gt;&gt;&gt;" >&nbsp;<INPUT TYPE=RESET VALUE="  Reset  " > 
</TD>
</TR>


</TABLE>
</FORM>



 <%@ page import="java.lang.Long"%>		
 <%@ page import="gov.nih.nci.caimage.*"%>
 <jsp:useBean id="user" scope="page" class="gov.nih.nci.caimage.db.Login"/>
 <%-- Verify password and reenter are the same--%>
 <%! 
     boolean Status = false;
	 Vector submitters = new Vector();
	 String where = null;
	String name =null;
	boolean status = false;
	boolean status2 = false;
	String password, reenter, userName;%>
 <%  System.out.println("I am in verify passowrd***************");
 	userName = (String) request.getParameter("required_New User Name");
	System.out.println("The user name is"+userName);
 	 password = (String) request.getParameter("required_New Password");
	 System.out.println("The password is"+password);
 	 reenter =  (String) request.getParameter("required_Reenter Password"); 
	 where  = " USERNAME ='" + userName + "'";
	  System.out.println("Wher is"+where);
	 submitters = user.retrieveAllWhere(where);
	 
	 System.out.println("submitters.size():"+submitters.size());
		 if (submitters!=null && submitters.size()>0){
		 for(int i=0;i<submitters.size();i++){
		 user=(Login)submitters.elementAt(i);
		 name =user.getUsername();
			 }
		 }
	 String mode = (String)session.getAttribute("nci.mmhcc.requestType");
	 System.out.println("mode:"+mode);
	 String type=(String)session.getAttribute("nci.mmhcc.type");
	 System.out.println("type:"+type);
	 if(request.getParameter("submit_password")!= null && mode!=null && type !=null) { 		
	   System.out.println("1");
	  if (submitters!=null && submitters.size()>0){
		 if((type.equals("new_user")&& mode.equals("Submit")&& name.equals(userName))||(type.equals("new_user")&&mode.equalsIgnoreCase("User"+" " +"Profile")&& name.equals(userName))){
		 	System.out.println("2");
		 %>
			 <TABLE BORDER=0 align=center cellspacing="5" cellpadding="5">
			 <hr noshade>
				<TR ALIGN=left VALIGN=TOP>
				<TD><h3><font color="black">Someone else has already chosen <font color="maroon"> <%=userName%></font>. Please try another username.</font></h3></TD></TR>		
				</TABLE><hr noshade>
			 <%}
			 }
		 System.out.println("3");
		 System.out.println("mode:"+mode+"type:"+type+"name:"+name+"submitters.size():"+submitters.size());
		 if((mode.equalsIgnoreCase("User"+" " +"Profile") && type.equals("update")&& name != null && name.equals(userName)) ||(submitters.size()==0) ){
		    System.out.println("4");
		   	if(userName != null && password != null && reenter != null){
		 		if(password.length() > 0 && password.equals(reenter)){
				System.err.println( " user name & password" +userName+ password);
	 	  		user = (Login) session.getAttribute("nci.mmhcc.user");
				Long submitterUID = user.getLoginuid();
				System.out.println("submitterUID:" + submitterUID);
			
			  		if(user != null){
			  			user.setUsername(userName);
						user.setPassword(password);
							if(submitterUID != null){//so just update record
					//so just update record
									Status = user.updateByKey();
									System.err.println("update data");
									session.removeAttribute("nci.mmhcc.user");
									request.setAttribute("nci.mmhcc.newuser","Submit");%>
									<jsp:forward page="login_a.jsp"/>
									<%//response.sendRedirect("login_a.jsp?mode=Submit");
								}
							else{
								
								if (submitterUID == null){
								Long l = new Long(1);
								Vector v = user.retrieveAll();
								System.out.println("The reached here"+v.size() );
								int submitterUID3 = v.size() +1 ;
								 	System.out.println("The reached here"+submitterUID3);
								 Long  submitterUID4 = new Long (submitterUID3 );
								user.setLoginuid(submitterUID4 );
								user.setUsername(userName);
								user.setPassword(password);
								  status2 = user.insert();
								  System.out.println("The status1 is"+status2); %>
								  <jsp:forward page="login_a.jsp"/>
								
								<% } else {
							 System.out.println("I am in 2");
							  int submitterUID1 = submitterUID.intValue() +1 ;
								 Long  submitterUID2 = new Long (submitterUID1 );
								 user.setLoginuid(submitterUID2);
								user.setUsername(userName);
								user.setPassword(password);
								  status2 = user.insert();
								  System.out.println("The status2 is"+status2);
								 }
								  System.out.println("The status is"+status2);
									if(submitterUID != null){
											user.setLoginuid(submitterUID);
									         status2 = user.insert();
											 System.err.println("insert status" + Status);
											 session.removeAttribute("nci.mmhcc.user");
											 session.removeAttribute("nci.mmhcc.newuser");
											 request.setAttribute("nci.mmhcc.newuser","Submit");%>
											<jsp:forward page="login_a.jsp"/>
											<%//response.sendRedirect("login_a.jsp?mode=Submit");	
										}//end if
									}
								}//end if
						}
			else{%>
				<TABLE BORDER=0 align=center cellspacing="5" cellpadding="5">
				 <hr noshade>
				<TR ALIGN=left VALIGN=TOP>
				<TD><h3><font color = "maroon">Please make sure that both passwords are identical</font></h3></TD>
				</tr>
				</TABLE> <hr noshade width="70%">
		
							<%}//end else
						 }//end if
					}
				}
			//end if%>
	
		<!-- End of the main part table -->
		</TD>
	</TR>
</TABLE><!-- End of the wrap table -->
</BODY>
</HTML>
