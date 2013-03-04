<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See https://github.com/NCIP/caimage/LICENSE.txt for details.
L--%>

<%@ page language="java" import="java.util.*,gov.nih.nci.caIMAGE.util.*,gov.nih.nci.caIMAGE.*,gov.nih.nci.caimage.db.*"%>
<%@ page info="this page is the login page, first name & last name and verified on tbis page "%>
<jsp:useBean id="user" scope="page" class="gov.nih.nci.caimage.db.Login" />
<jsp:setProperty name="user" property="username" param="UserName" />
<jsp:setProperty name="user" property="password" param="password" />
<%String mode = (String) request.getParameter("mode");
			if (mode == null) {
				mode = (String) session.getAttribute("nci.mmhcc.newuser");
			}

			if (mode != null) {
				session.setAttribute("nci.mmhcc.requestType", mode);
			}

			%>
<%String where;

			%>
<%where = "USERNAME  ='" + user.getUsername() + "'"
					+ " and PASSWORD = '" + user.getPassword() + "'";

			%>
<%System.err.println("login_where: " + where);%>

<%!Vector records = new Vector();

	%>


<%Long SubmitterId;
			Long userTypekey = null;
			String url = null;

			if (request.getParameter("submit_name") != null
					&& (user.getUsername() != null & user.getPassword() != null)) {
				// set session id
				session.setAttribute("nci.mmhcc.sessionId", session.getId());
				session.setAttribute("nci.mmhcc.submitter.userName", user
						.getUsername());
				System.err.println("login_a requesttype:"
						+ ((String) session
								.getAttribute("nci.mmhcc.requestType")));
				records = user.retrieveAllWhere(where);

				if (records.size() == 1) { //yes found a match, now check the password 
					user = (Login) records.firstElement();
					session.removeAttribute("nci.mmhcc.submitter");
					session.setAttribute("nci.mmhcc.submitter", user);
					SubmitterId = user.getLoginuid();
					System.err.println("set submitterid" + SubmitterId);
					System.err
							.println("login_a userName:" + user.getUsername());
					System.err.println("login_a getpassword:"
							+ user.getPassword());
					// Enumeration mySession = (Enumeration)session.getAttribute("nci.mmhcc.mmhccSession");

					session.setAttribute("nci.mmhcc.submitter.submitterKey",
							SubmitterId);
					String requestType = (String) session
							.getAttribute("nci.mmhcc.requestType");
					String requestType2 = (String) session
							.getAttribute("nci.mmhcc.requestType2");
					Long pageNum = (Long) session
							.getAttribute("nci.mmhcc.pagenumber");
					System.err.println("requestType:" + requestType);
					System.err
							.println("requestType2----------:" + requestType2);
					response.sendRedirect("caimageUsers.jsp?userid="
							+ SubmitterId);

				} else { //no match so show login error page 

					response.sendRedirect("login_c.jsp");

				}

			} else { //no change so show logic page again 

				//for sca
				if (mode.equals("sca")) {

					String scawhere;
					request.getSession(true);
					String username = (String) session
							.getAttribute("nci.caimage.userName");

					String pass = (String) session
							.getAttribute("nci.caimage.password");

					scawhere = "USERNAME  ='" + username + "'"
							+ " and PASSWORD = '" + pass + "'";
					System.err.println("login_where: " + scawhere);
					records = user.retrieveAllWhere(scawhere);
					session.removeAttribute("nci.caimage.userName");
					session.removeAttribute("nci.caimage.password");

					if (records.size() == 1) { //yes found a match, now check the password 
						response.sendRedirect("caimageSubmit.jsp");
					}
				} else {

					response.sendRedirect("login_a.jsp");
				}

			}

		%>



