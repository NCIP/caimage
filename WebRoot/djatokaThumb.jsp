<%@page import="gov.nih.nci.caIMAGE.util.CatalogDirectoryMap"%><tr valign="top" bgcolor="#FFFFFF">
	<td align="left" valign="top" width="85">
		<%
		logger.debug("Annot == null" + (Annot == null));
		catalog = Annot.getCatalog_id();
		annotationid = Annot.getAnnotation_id();
		
		CatalogDirectoryMap map = null;
		
		try {
			map = CatalogDirectoryMap.getInstance();
		}
		catch (Exception e)
		{
		    logger.error("Error retrieving directory map",e);
		}
		String imageDir;
		if (map == null)
		{
		    imageDir = "/unknown";
		}
		else
		{
		    imageDir = map.getImagePath(catalog.longValue());
		}
		String imageName = Annot.getImage_name().trim();
		String adoreUrl = sysProps.getProperty("djatoka_server");
		String adoreImagePath  = sysProps.getProperty("djatoka_image_path");
		String adoreImageBase  = sysProps.getProperty("djatoka_image_base");
		String imageUrl = adoreImageBase + "/" + adoreImagePath + "/" + imageDir + "/" + imageName;
		
		String viewerLink;
		String thumbRequest;
		if (!imageName.endsWith(".tif"))
		{
		    viewerLink = "javascript:showWindow('" + imageUrl + "')";
		    thumbRequest = adoreUrl + "/resolver?url_ver=Z39.88-2004&svc_id=info:lanl-repo/svc/getRegion&svc_val_fmt=info:ofi/fmt:kev:mtx:jpeg2000&svc.scale=100&rft_id=" + imageUrl;
			
		}
		else
		{
		    viewerLink = "javascript:showWindow('" + adoreUrl + "/viewer.html?rft_id=" + imageUrl + "');";
		    //viewerLink = "javascript:showWindow('viewer.jsp?rft_id=" + imageUrl + "');";
		    thumbRequest = adoreUrl + "/resolver?url_ver=Z39.88-2004&svc_id=info:lanl-repo/svc/getRegion&svc_val_fmt=info:ofi/fmt:kev:mtx:jpeg2000&svc.scale=100&rft_id=" + imageUrl;
			
		}
		
		%>
		
		<%-- <a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir.trim())%>&img=<%=DatabaseSetup.checkForNull(strid)%>&centerp=<%=500/2%>,<%=500/2%>&reslvl=<%=500/2%>&wid=400&hei=400')"> 
		--%>
		<a href="<%=viewerLink %>">
		<%--
		String oldThumbReq = "<img src=\"" + imagepath + DatabaseSetup.checkForNull(catdir.trim()) + "&img=" + DatabaseSetup.checkForNull(strid.trim())
			+ "&thumbspec=\" main\"  alt=\"" + DatabaseSetup.checkForNull(image.trim()) + "\" target=\"_blank\">";
		--%>
		    
		<img src="<%=thumbRequest %>" width="100"/>
		</a>
		<br>
		
		<%-- <a href="javascript:showWindow('catalogviewdir.jsp?cat=<%=DatabaseSetup.checkForNull(catdir.trim())%>
		&img=<%=DatabaseSetup.checkForNull(image.trim())%>&centerp=<%=number1/2%>,<%=number2/2%>&reslvl=<%=number3%>&wid=400&hei=400')"> 
		--%>
		<%-- <a href="#">
		
		String oldThumbReq = "<img src=\"" + imagepath + DatabaseSetup.checkForNull(catdir.trim()) + "&img=" + DatabaseSetup.checkForNull(image.trim())
		    + "&thumbspec=\" main\"  alt=\"" + DatabaseSetup.checkForNull(image.trim()) + "\" target=\"_blank\">";
		    
		
		 <img src="<%=thumbRequest %>"/>
		</a>
		<br> --%>
		
		<font FACE="sans-serif" size="-1" color="Red"><%=imageName%></font>

	</td>
	
	<%@ include file="results.jsp"%>
	<%-- 
<tr valign="top" bgcolor="#FFFFFF">
	<td align="left" valign="top" width="11%">
		<font FACE="trebuchet" size="-1" color="Red"><%=catdir%>-<%=image%> not found<br>
		</font>
	</td>
	<%@ include file="results.jsp"%>
</tr> --%>

</tr>

		