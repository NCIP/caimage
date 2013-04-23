<%--L
  Copyright SAIC

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<%
			// this part is needed to get the  get the url formed for get the parameter in case
			// there is not in database and or forming the xml
			logger.debug("reached 1");
			catalog = Annot.getCatalog_id();
			annotationid = Annot.getAnnotation_id();
			Long curationid = Annot.getCurated_id();

			if (curationid.equals(new Long(1))) {

				logger.debug(Annot.getCatalog_id());
				logger.debug(Annot.getImage_name());
				String image = Annot.getImage_name().trim();
				Catalog ce = new Catalog();
				Vector catv = ce.retrieveAllWhere("CATALOG_ID = '" + catalog
						+ "'");
				for (int k = 0; k < catv.size(); k++) {
					Catalog Ceta = null;
					if (k >= 0 && k <= annotv.size()) {
						logger.debug("The value of k " + k);
						Ceta = (Catalog) catv.elementAt(k);
						catdir = Ceta.getCatalog_directory().trim();
						logger.debug("the get value is" + catdir);
					}//if
					logger.debug("reached 5");
				}//for

				URL url = null;
				BufferedReader input = null;
				boolean flag = false;
				String lizard = sysProps.getProperty("lizard");
				String imagepath = lizard + "/iserv/getthumb?cat=";
				//logger.debug("lizard image path:"+imagepath);
				String line = new String();
				String imageurl = lizard + "/iserv/calcrgn?cat=";
				//logger.debug("lizard image url:"+imageurl);
				String calcrgn = null;
				if (annotationid.longValue() >= 10000) {
					imagename = "stage/" + image;
					logger.debug("i am in if");
					calcrgn = DatabaseSetup.checkForNull(catdir.trim()) + "&"
							+ "img="
							+ DatabaseSetup.checkForNull(imagename.trim())
							+ "&wid=400&hei=400&style=none";
				} else {
					//logger.debug("i am in else");
					calcrgn = DatabaseSetup.checkForNull(catdir.trim()) + "&"
							+ "img=" + DatabaseSetup.checkForNull(image.trim())
							+ "&wid=400&hei=400&style=none";
				}

			
				try {
				    /*
					url = new URL(imageurl + calcrgn);
					//logger.debug("The url is"+url);
					Object abc = url.getContent();
					int number1 = 0;
					int number2 = 0;
					int number3 = 0;
					String region = null;
					if (url.openConnection() != null) {
						//logger.debug("the object returned is:"+abc.toString());
						input = new BufferedReader(new InputStreamReader(url
								.openStream()), 1000);
						//Helps bringing all the images
						//Thread.sleep(100);
						StringBuffer buffer = new StringBuffer();
						while ((line = input.readLine()) != null) {
							//logger.debug("The line is"+line.toString()+"\n");
							buffer.append(line.toString());
							buffer.append("<!DOCTYPE ImageServer SYSTEM"
									+ "\"calcrgn.dtd\">");
							flag = true;
						}
						String outputmod = buffer.delete(
								url.openStream().available() + 40,
								buffer.capacity()).toString();
						// temporary closed but show xml
						//logger.debug("the output modified is"+outputmod);
						//String ret = SAXParseUtil.parseurl(outputmod);
						int width = 0;
						int width1 = 0;
						width = outputmod.lastIndexOf("width");
						width1 = outputmod.indexOf(" ", width + 7);
						int height = 0;
						int height1 = 0;
						height = outputmod.lastIndexOf("height");
						logger.debug("The start of height is at" + height);
						height1 = outputmod.indexOf(" ", height + 8);
						logger.debug("The end of height is at" + height1);
						int numlevels = 0;
						numlevels = outputmod.lastIndexOf("numlevels");
						number1 = Integer.parseInt(outputmod.substring(
								width + 7, width1 - 1));
						number2 = Integer.parseInt(outputmod.substring(
								height + 8, height1 - 1));
						number3 = Integer.parseInt(outputmod.substring(
								numlevels + 11, numlevels + 12));
						int rgn = 0;
						int rgn1 = 0;
						rgn = outputmod.lastIndexOf("rgn");
						rgn1 = outputmod.indexOf(" ", rgn + 4);
						region = (String) (outputmod.substring(rgn + 5,
								rgn1 - 1));
						logger.debug("The region is" + region);
						logger.debug("I reached to insert" + annotationid);
						boolean catfromic = ic.retrieveByKey(annotationid);
						if (!catfromic) {
							ic.setImage_characteristic_id(annotationid);
							//int hei = (height1-height);
							//int wid = (width1-width);
							ic.setImage_characteristic_height(Integer
									.toString(number2));
							ic.setImage_characteristic_width(Integer
									.toString(number1));
							ic.setImage_characteristic_numlevel(Integer
									.toString(number3));
							ic.setImage_modality_id(Long.valueOf("1"));
							ic.insert();
						}
						logger.debug("I reached to end of while"
										+ annotationid); */
					//}//while
					/* else
						break;
					String bName = request.getHeader("User-Agent");
					if (bName != null) {
						logger.debug("I am in header directory" + imagepath
								+ "Catalog Directory" + catdir); */
								%>

<%@page import="gov.nih.nci.caIMAGE.util.CatalogDirectoryMap"%><tr valign="top" bgcolor="#FFFFFF">
	<td align="left" valign="top" width="85">
		<%
		CatalogDirectoryMap map = null;
		
		try {
			map = CatalogDirectoryMap.getInstance();
		}
		catch (Exception e)
		{
		    logger.error("Error retrieving directory map");
		}
		String imageDir;
		if (map == null)
		{
		    imageDir = "/unknown";
		}
		else
		{
		    imageDir = map.getImagePath(Annot.getCatalog_id());
		}
		String imageName = Annot.getImage_name().trim();
		String adoreUrl = sysProps.getProperty("djatoka_server");
		String adoreImagePath  = sysProps.getProperty("djatoka_image_path");
		String imageUrl = adoreUrl + adoreImagePath + imageDir + imageName;
		
		String thumbRequest = adoreUrl + "/resover?url_ver=Z39.88-2004&svc_id=info:lanl-repo/svc/getRegion&svc_val_fmt=info:ofi/fmt:kev:mtx:jpeg2000&svc.scale=100&rft_id=" + imageUrl;
		
		
		
		
		String strid = null;
						if (annotationid.longValue() >= 10000) {
							strid = "stage/" + Annot.getImage_name();
							logger.debug("i am in if");%>
		<a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(strid)%>&centerp=<%=number1/2%>,<%=number2/2%>&reslvl=<%=number3%>&wid=400&hei=400')"> 
		
		<%
		String oldThumbReq = "<img src=\"" + imagepath + DatabaseSetup.checkForNull(catdir.trim()) + "&img=" + DatabaseSetup.checkForNull(strid.trim())
			+ "&thumbspec=\" main\"  alt=\"" + DatabaseSetup.checkForNull(image.trim()) + "\" target=\"_blank\">";
		%>
		    
		<img src="<%=imageUrl %>"/>
		</a>
		<br>
		<%} else {
							logger.debug("i am in else");%>
		<a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir.trim())%>
		&img=<%=DatabaseSetup.checkForNull(image.trim())%>&centerp=<%=number1/2%>,<%=number2/2%>&reslvl=<%=number3%>&wid=400&hei=400')"> 
		
		<%
		String oldThumbReq = "<img src=\"" + imagepath + DatabaseSetup.checkForNull(catdir.trim()) + "&img=" + DatabaseSetup.checkForNull(image.trim())
		    + "&thumbspec=\" main\"  alt=\"" + DatabaseSetup.checkForNull(image.trim()) + "\" target=\"_blank\">";
		    %>
		
		 <img src="<%=imageUrl %>"/>
		</a>
		<br>
		<%}%>
		<%Thread.sleep(100);%>
		<font FACE="sans-serif" size="-1" color="Red"><%=image%></font>

	</td>
	<%//}
					logger.debug("Results starts here");%>
	<%@ include file="results.jsp"%>
	<%logger.debug("Results end here");
					input.close();
				} catch (IOException e) {%>
<tr valign="top" bgcolor="#FFFFFF">
	<td align="left" valign="top" width="11%">
		<font FACE="trebuchet" size="-1" color="Red"><%=catdir%>-<%=image%> not found<br>
		</font>
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
