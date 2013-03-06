<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!--
  	Himanso Sahni
	MMHCC
	SAIC NCI
	createuser.jsp
-->
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page language="java" import="gov.nih.nci.caIMAGE.*,gov.nih.nci.caIMAGE.util.*"%>

<%@ page info="this page is the create user page, if a new user then the submitter info is captured here"%>

<%gov.nih.nci.caIMAGE.DatabaseSetup.setPageExpiration(response);
			response.setHeader("Cache-Control", "no-cache");
			response.setHeader("Pragma", "no-cache");
			response.setDateHeader("Expires", System.currentTimeMillis());
			//SessionManager.verifySession(request,response,"Error.jsp");%>

<%@ include file="headernotab.html"%>


<jsp:useBean id="user" scope="page" class="gov.nih.nci.caimage.db.Login" />
<%System.out.println("******* Create User ************");
			Long submitterUid = null;
			String modeType = null;
			String type = (String) request.getParameter("type");
			String mode = (String) session
					.getAttribute("nci.mmhcc.requestType");
		
			if (type != null) {
				session.setAttribute("nci.mmhcc.type", type);
			}
			String id = (String) request.getParameter("submitterUID");
		
			if (id != null) {
				submitterUid = Long.decode(id);
				user.retrieveByKey(submitterUid);
			}

			
%>

<!--start of wrap table-->
<%if (submitterUid != null) {%>
<FORM METHOD="POST" ACTION="createuser.jsp?submitterUID=<%=id%>">
	<%}%>
	<%if (submitterUid == null) {%>
	<FORM METHOD="POST" ACTION="createuser.jsp">
		<%}%>
		<INPUT TYPE="HIDDEN" NAME="submitterUid" VALUE="<%=id%>">
		<%System.out.println("hidden submitteruid:" + submitterUid);%>


		<br>
		<div align="center">
			<font class="bluhderslrg">Create User Account</font>
		</div>
		<br>
		<br>
		<TABLE border="0" align="center" cellspacing="5" cellpadding="5">
			<!--insert mainpart here-->





			<TR ALIGN="LEFT" VALIGN="TOP">
				<td colspan="3" height="50" valign="top" class="bodytxrequ" align="right">
					* Required Fields
				</td>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">

				<TD class="bodytxrequ">
					Submitter's First Name:
				</TD>

				<TD>
					<INPUT NAME="required_First Name" TYPE=TEXT SIZE=40 MAXLENGTH=50 value="<%=DatabaseSetup.removeNull(user.getFirstname())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxrequ">
					Submitter's Last Name:
				</TD>

				<TD>
					<INPUT NAME="required_Last Name" TYPE=TEXT SIZE=40 MAXLENGTH=50 value="<%=DatabaseSetup.removeNull(user.getLastname())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxrequ">
					Submitter's Email:
				</TD>

				<TD>
					<INPUT NAME="required_Submitter Email" TYPE=TEXT SIZE=40 MAXLENGTH=75 value="<%=DatabaseSetup.removeNull(user.getEmail())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxrequ">
					Principal Investigator's Name:
					<br>
					(Lastname, Firstname )
				</TD>

				<TD>
					<INPUT NAME="required_PI Name" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getPi_name())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxrequ">
					Principal Investigator's Email:
				</TD>

				<TD>
					<!--new field, add script, required field, need to add PI Email field to Login table-->
					<INPUT NAME="required_PI Email" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getPi_email())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxrequ">
					Institute:
				</TD>

				<TD>
					<INPUT NAME="required_PI Institute" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getInstitute())%>">
				</TD>
			</TR>

			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					Laboratory Name:
				</TD>

				<TD>
					<INPUT NAME="Laboratory" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getLaboratory())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					Address 1:
				</TD>

				<TD>
					<INPUT NAME="Address1" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getAddress1())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					Address 2:
				</TD>

				<TD>
					<INPUT NAME="Address2" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getAddress2())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					City:
				</TD>

				<TD>
					<INPUT NAME="City" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getCity())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					State / Province:
				</TD>

				<TD>
					<INPUT NAME="State" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getState())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					Zip:
				</TD>

				<TD>
					<INPUT NAME="Zip" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getZip())%>">
				</TD>
			</TR>


			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					Country:
				</TD>

				<TD>
					<INPUT NAME="Country" TYPE=TEXT SIZE=40 MAXLENGTH=255 value="<%=DatabaseSetup.removeNull(user.getCountry())%>">
				</TD>
			</TR>



			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					Phone:
				</TD>

				<TD>
					<INPUT NAME="Phone" TYPE=TEXT SIZE=15 MAXLENGTH=15 value="<%=DatabaseSetup.removeNull(user.getPhone())%>">
				</TD>
			</TR>
			<TR ALIGN="LEFT" VALIGN="TOP">
				<TD class="bodytxbold">
					Fax:
				</TD>

				<TD>
					<INPUT NAME="Fax" TYPE=TEXT SIZE=15 MAXLENGTH=15 value="<%=DatabaseSetup.removeNull(user.getFax())%>">
				</TD>
			</TR>


			<TR align="LEFT" valign="TOP">
				<TD>
					&nbsp;
				</TD>
				<TD align="left">
					<INPUT TYPE=SUBMIT NAME="insert_submitter" VALUE="   NEXT   &gt;&gt;&gt;">
					&nbsp;
					<INPUT TYPE=RESET VALUE="  Reset  ">
				</td>
			</tr>
		</TABLE>



		<p align="right">
			<a href="#top">Top of the page</a>
		</p>
		<!--end of main table-->



		<jsp:setProperty name="user" property="lastname" param="required_Last Name" />
		<jsp:setProperty name="user" property="firstname" param="required_First Name" />
		<jsp:setProperty name="user" property="institute" param="required_PI Institute" />
		<jsp:setProperty name="user" property="pi_name" param="required_PI Name" />
		<jsp:setProperty name="user" property="pi_email" param="required_PI Email" />
		<jsp:setProperty name="user" property="laboratory" param="Laboratory" />
		<jsp:setProperty name="user" property="address1" param="Address1" />
		<jsp:setProperty name="user" property="address2" param="Address2" />
		<jsp:setProperty name="user" property="city" param="City" />
		<jsp:setProperty name="user" property="state" param="State" />
		<jsp:setProperty name="user" property="zip" param="Zip" />
		<jsp:setProperty name="user" property="country" param="Country" />
		<jsp:setProperty name="user" property="phone" param="Phone" />
		<jsp:setProperty name="user" property="fax" param="Fax" />
		<jsp:setProperty name="user" property="email" param="required_Submitter Email" />
		<%boolean Status = false;
			System.out.println("Submitteruid :" + id);
			if (request.getParameter("insert_submitter") != null) {
				session.removeAttribute("nci.mmhcc.user");
				session.removeAttribute("nci.mmhcc.mmhccSession");
				boolean flag = DatabaseSetup.checkRequiredFeilds(request,
						"login");
				System.err.println(flag);
				if (flag) {

				%>
		<jsp:forward page="missing_required_feilds.jsp" />
		<%}
				if (submitterUid != null) {
					session.setAttribute("nci.mmhcc.user", user);%>
		<jsp:forward page="verify_password.jsp" />
		<%} else {
					//make sure the user does not already exsist in the db
					String where = " UPPER(LASTNAME) like UPPER('"
							+ user.getLastname()
							+ "') and UPPER(FIRSTNAME) like UPPER('"
							+ user.getFirstname() + "') and "
							+ "UPPER(LABORATORY) like UPPER('"
							+ user.getLaboratory()
							+ "') and UPPER(EMAIL) like UPPER('"
							+ user.getEmail() + "') ";
					Vector records = new Vector();
					records = user.retrieveAllWhere(where);

					//if(records.size() == 0 ){  //okay does not exsist	
					session.setAttribute("nci.mmhcc.user", user);%>
		<jsp:forward page="verify_password.jsp" />
		//response.sendRedirect("verify_password.jsp"); //} //else {%>
		
		<%//}
				}

			}

		%>
		<%--
function isEmail(str) {
  // are regular expressions supported?
  var supported = 0;
  if (window.RegExp) {
    var tempStr = "a";
    var tempReg = new RegExp(tempStr);
    if (tempReg.test(tempStr)) supported = 1;
  }
  if (!supported) 
    return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);
  var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
  var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");
  return (!r1.test(str) && r2.test(str));
}
--%>




		</TD>
		</TR>
		</TABLE>
		<!--end of wrap table-->





		</BODY>
		</HTML>