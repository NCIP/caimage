<%--L
  Copyright SAIC

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
    <%@ page language="java"%>
    <%@ page import="java.io.*"%>
    <%@ page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >

 <head>
  <meta name="author" content="Ruven Pillay &lt;ruven@users.sourceforge.netm&gt;"/>
  <meta name="author" content="Ryan Chute &lt;rchute@users.sourceforge.netm&gt;"/>
  <meta name="keywords" content="djatoka IIPImage Ajax IIP Zooming Streaming High Resolution Mootools"/>
  <meta name="description" content="djatoka IIPImage Viewer: High Resolution Remote Image Streaming Viewing"/>
  <meta name="copyright" content="&copy; 2003-2008 Ruven Pillay"/>

  <link rel="stylesheet" type="text/css" media="all" href="css/iip.compressed.css" />
  <link rel="shortcut icon" href="images/djatoka.16x16.png" />
  <title>djatoka Viewer, based on IIPMooViewer 1.1</title>

  <script type="text/javascript" src="javascript/mootools-1.2-core-compressed.js"></script>
  <script type="text/javascript" src="javascript/mootools-1.2-more-compressed.js"></script>
  <script type="text/javascript" src="javascript/iipmooviewer-1.1.js"></script>
<% 
			InputStream in = null;
			Properties sysProps = new Properties();
			try {
				in = Thread.currentThread().getContextClassLoader()
						.getResourceAsStream("system.properties");
				sysProps.load(in);
			} catch (Exception e) {
				System.err.println("Error loading system.properties file");
				e.printStackTrace();
			}
			
			String adoreUrl = sysProps.getProperty("djatoka_server");
			String adoreServer = adoreUrl + "/resolver";
			%>
  <script type="text/javascript">

    // The iipsrv server path (/fcgi-bin/iipsrv.fcgi by default)
    var server = '<%=adoreServer%>';

    // The *full* image path on the server. This path does *not* need to be in the web
    // server root directory. On Windows, use Unix style forward slash paths without
    // the "c:" prefix
    var images = '';

    // Copyright or information message
    var credit = '';
    
    // Obtain URL Parameters if present
    var query = location.href.substring(location.href.indexOf("?")+1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
      var pair = vars[i].split("=");
      if (pair[0] == "url" || pair[0] == "rft_id")
         images = pair[1];
         if (images.indexOf("#") > 0)
           images = images.substring(0,images.length-1);
    }
	
    // Create our viewer object - note: must assign this to the 'iip' variable.
    // See documentation for more details of options
    iip = new IIP( "targetframe", {
		image: images,
		server: server,
		credit: credit, 
		zoom: 1,
		render: 'random',
        showNavButtons: true
    });

  </script>

 </head>

 <body>
   <div style="width:99%;height:99%;margin-left:auto;margin-right:auto" id="targetframe"></div>
 </body>

</html>
