<%--L
  Copyright SAIC

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<%@ page import="gov.nih.nci.caimage.db.*"%>
		<%@ page import="gov.nih.nci.caIMAGE.*"%>
		<title>
			Untitled
		</title>
	</head>

	<body>

		<%String stain_name = request.getParameter("stainname");

			String stain_desc = request.getParameter("staindesc");

			KeyRetriever tk = new KeyRetriever();
			Long stain_count = tk.getNextKey("STAIN");
			Stain st = new Stain();
			st.setStain_id(stain_count);
			st.setStain_name(stain_name);
			st.setStain_description(stain_desc);
			boolean success = st.insert();

			if (success) {

			%>
		The entry has been added in the stain table
		<%}

		%>
	</body>
</html>
