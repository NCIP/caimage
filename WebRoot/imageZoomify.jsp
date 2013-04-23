<%--L
  Copyright SAIC

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<%// this part is needed to get the  get the url formed for get the parameter in case
			// there is not in database and or forming the xml
			System.out.println("******** I am in Zoomify now**************");
			catalog = Annot.getCatalog_id();
			annotationid = Annot.getAnnotation_id();
			Long curationid = Annot.getCurated_id();
			if (curationid.equals(new Long(1))) {

				logger.debug("catalog id " + Annot.getCatalog_id());
				logger.debug("image name" + Annot.getImage_name());
				String image = Annot.getImage_name().trim();
				Catalog ce = new Catalog();
				Vector catv = ce.retrieveAllWhere("CATALOG_ID = '" + catalog
						+ "'");
				for (int k = 0; k < catv.size(); k++) {
					Catalog Ceta = null;
					if (k >= 0 && k <= annotv.size()) {

						Ceta = (Catalog) catv.elementAt(k);
						catdir = Ceta.getCatalog_directory().trim();
						logger.debug("the get value is" + catdir);
					}//if

				}//for

				String userDir = System.getProperty("user.dir");
				String zoomifyDir = null;
				String imageDir = null;
				String zoomifyHost = null;
				zoomifyDir = sysProps.getProperty("zoomify_dir");
				zoomifyHost = sysProps.getProperty("zoomify_host");
				String imagepath = zoomifyDir;
				try {

					String bName = request.getHeader("User-Agent");
					if (bName != null) {

						%>
<tr valign="top" bgcolor="#FFFFFF">
	<td align="left" valign="top" width="85">
		<%String strid = null;

						%>
		<a href="javascript:showWindow('<%=imagepath%>ZoomPages/zoomifyDynamic.jsp?catalog=<%=catdir%>&img=<%=image%>&x=0.0&y=0.0&zoom=-1&host=<%=zoomifyHost %>')"> <font FACE="sans-serif" size="-4">Simple Viewer</font> </a> <a
			href="javascript:showWindow('<%=imagepath%>ZoomPages/zoomifyDynamic.jsp?catalog=<%=catdir%>&img=<%=image%>&x=0.0&y=0.0&zoom=-1&host=<%=zoomifyHost %>')"> <img src="<%=imagepath%>servlet/zoomifyservlet.ZoomifyServlet?file=/ZoomImages/zoomify/<%=catdir%>/<%=image%>" width="60">
		</a> <a href="javascript:showWindow('<%=imagepath%>ZoomPages/ZAS.jsp?catalog=<%=catdir%>&img=<%=image%>&x=0.0&y=0.0&zoom=-1&host=<%=zoomifyHost %>')"> <font FACE="sans-serif" size="-4">Advanced Viewer</font> </a> <a
			href="javascript:showWindow('<%=imagepath%>ZoomPages/ZAS.jsp?catalog=<%=catdir%>&img=<%=image%>&x=0.0&y=0.0&zoom=-1&host=<%=zoomifyHost %>')"> <img src="<%=imagepath%>servlet/zoomifyservlet.ZoomifyServlet?file=/ZoomImages/zoomify/<%=catdir%>/<%=image%>" width="60"> </a> <font
			FACE="sans-serif" size="-1" color="Red"><%=image%></font>
	</td>
	<%}
					System.err.println("Results starts here");%>
	<%@ include file="results.jsp"%>
	<%System.err.println("Results end here");

					//input.close();
				} catch (IOException e) {%>
<tr valign="top" bgcolor="#FFFFFF">
	<td align="left" valign="top" width="11%">
		<font FACE="trebuchet" size="-1" color="Red"><%=catdir%>-<%=image%> not found<br> </font>
	</td>
	<%@ include file="results.jsp"%>
</tr>
<%e.printStackTrace();
				}//try ends %>
</tr>
<%} //if for cuaration
			else {

				%>
<tr>
	<td colspan=3>
		<font style="font-family: Verdana, Arial, Helvetica, sans-serif; color:#FFFFFF; font-size:12px"> The image number <%=Annot.getAnnotation_id()%> was successfully entered in the database and awaits approval for display. &nbsp;</font>
		<br>
	</td>
</tr>
<%}//else curation

		%>
