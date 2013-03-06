<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<%@ page language="java"%>
<%@ page import="gov.nih.nci.caIMAGE.util.*"%>
<%@ page import="java.io.*"%>
<html>
<head>
	<title>Zoomify Annotation System</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div align="center">
<table width="500" border=0 align="center" cellpadding=1 cellspacing=0 bgcolor=#000000 >
  <tr>
	<td>
	  <table width=100% border=0 align="center" cellpadding=0 cellspacing=0 bgcolor=#ffffff>
		<tr>
		  <td>

			<%
				String img = request.getParameter("img");
				if (img != null && !img.equals(""))
                                   if (SafeHTMLUtil.containsUnallowableCharacters(img, true))
                                        throw new IOException("invalid img:" + img);

				String noExt = img.substring(0,img.lastIndexOf("."));
				
			    String host = request.getParameter("host");
			    if (host != null && !host.equals(""))
                                   if (SafeHTMLUtil.containsUnallowableCharacters(host, true))
                                        throw new IOException("invalid host:" + host);
			    host = "http://" + host + "/zoomify/";

			    String catalog = request.getParameter("catalog");
			    if (catalog != null && !catalog.equals(""))
                                   if (SafeHTMLUtil.containsUnallowableCharacters(catalog, true))
                                        throw new IOException("invalid catalog:" + catalog);

			    String imgPath = "/ZoomImages/zoomify/" + catalog + "/" + img;
			    String xmlPath = "/ZoomImages/zoomify/" + catalog + "/xmldata/" + noExt + ".xml";
			%>
			 <object style="display:block;" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="950" height="600" id="ZoomifyAnnotationViewer">
				<param name="flashvars" value="zoomifyImagePath=<%=imgPath%>&zoomifyEditMode=0&zoomifySkipUsername=1&zoomifyServerIP=<%=host %>&zoomifyTileHandlerPath=/servlet/zoomifyservlet.ZoomifyServlet&zoomifyMenuVisible=0zoomifyRulerVisible=0&zoomifyAnnotationsHide=1&zoomifyToolbarX=0&zoomifyToolbarY=100&zoomifyNavigatorHeight=100&zoomifyNavigatorX=0&zoomifyNavigatorY=0&zoomifyMenuX=0&zoomifyMenuY=170&zoomifyRulerX=0&zoomifyRulerY=220">
				<param name="menu" value="false">
				<param name="allowFullScreen" value="true" >
				<param name="src" value="ZoomifyAnnotationViewer.swf">
				<embed flashvars="zoomifyImagePath=<%=imgPath%>&zoomifyEditMode=0&zoomifySkipUsername=1&zoomifyServerIP=<%=host %>&zoomifyTileHandlerPath=/servlet/zoomifyservlet.ZoomifyServlet&zoomifyMenuVisible=0zoomifyRulerVisible=0&zoomifyAnnotationsHide=1&zoomifyToolbarX=0&zoomifyToolbarY=100&zoomifyNavigatorHeight=100&zoomifyNavigatorX=0&zoomifyNavigatorY=0&zoomifyMenuX=0&zoomifyMenuY=170&zoomifyRulerX=0&zoomifyRulerY=220" src="ZoomifyAnnotationViewer.swf" menu="false" allowFullScreen="true" pluginspage="http://www.adobe.com/go/getflashplayer" type="application/x-shockwave-flash" width="950" height="600" name="ZoomifyAnnotationViewer"></embed>
			 </object>


		  </td>
		</tr>
	  </table>
	</td>
  </tr>
</table>
</div>
</body>
</html>
