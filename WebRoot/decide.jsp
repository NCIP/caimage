<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<%@ page language="java" import="java.util.*,gov.nih.nci.caIMAGE.util.*,gov.nih.nci.caIMAGE.*,gov.nih.nci.caimage.db.*"%>
<%@ page info="this page is the login page, first name & last name and verified on tbis page "%>
<form name="main" method="POST" ENCTYPE="multipart/form-data">
	<font face="Arial,'MS Sans Serif',Geneva,sans-serif,monospace"></font> <sub><sup>
			<h3>
				<h2>
					<h1>
						<pre style="border-left: thin Aqua; color: Aqua; margin-bottom: auto; text-align: left; white-space: nowrap; width: 50px; border-color: Black;" dir="ltr">
abc
</pre>
					</h1>
				</h2>
			</h3>
		</sup></sub>

	<%String mode = request.getParameter("mode");

			String id = request.getParameter("id");

			if (mode.equals("edit")) {%>
	<jsp:include page="caimageEditData.jsp?id=549&mode=edit" flush="true" />
	<BR>
	<%} else {%>
	<jsp:include page="caimageEditSubmitResults.jsp?id=549" flush="true" />
	<BR>
	<%}%>
</form>
