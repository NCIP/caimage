<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<!--
  	Himanso Sahni
	MMHCC
	SAIC NCI
	login_name.jsp
-->




<%@ page language="java" import="gov.nih.nci.caimage.db.* ,gov.nih.nci.caIMAGE.util.*" %>

<%   
 	 SessionManager.verifySession(request,response,"Error.jsp");
   // nci.mmhcc.DatabaseSetup.setPageExpiration(response);
	 
    //SessionManager.verifySession(request,response,"error_entry.html",(String) session.getAttribute("loginId"));
%>


<%@ include file="headernotab.html"%>

	

			



			<!--start of main table-->		
			<TABLE border="0" align="center" cellspacing="5" cellpadding="5">
		<tr><td>

	
		<FORM METHOD=POST ACTION="login_a.jsp">
		<tr>
		</tr>
		<p>&nbsp;</p>
<tr class="bodytxbold">
<%! String  userName, password ; %> 
<% userName = (String) session.getAttribute("nci.mmhcc.submitter.userName");
   %>
 You have entered 
&quot;<font color=red><%= userName %></font>&quot; as your user name.<br>
Either the user name or password  is incorrect. <br>
</tr>
<p>
<br>
<tr class="bodytxbold">Helpful Hints:</tr>
<ul><tr class="bodytxbold"><li>Make sure you did not mistype.</tr> 
<tr class="bodytxbold"><li>Did you enter your nick name?</tr>
<tr class="bodytxbold"><li>Make sure to enter your password correctly.
<tr class="bodytxbold"><li>User name and password are case-sensitive.
<tr><td class="bodytext" colspan="2">You don't have a user account yet?<a href="createuser.jsp?type=new_user" > Sign up now</a> to submit images.</td></tr>
<tr><td class="bodytext" colspan="2">User with existing user account?<a href="login_a.jsp" > Sign in</a> to submit images.</td></tr>
</ul>
</FORM>



		</td></tr>
		
		</table>

		<!-- End of the main part table -->
	

 


</BODY>
</HTML>
