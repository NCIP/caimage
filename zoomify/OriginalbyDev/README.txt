Deanna Siemaszko 4/2/2010

Graham Vaughn, temporary contractor on the caImage project, set up 4 files in svn that are somewhat custom.  The other files found within the full installation directory of this repo can be found from a zip file provided by Zoomify Support, "ZoomifyEnterprise4-Win.zip".  Most the files in the zip aren't used. 

From inside the zip file,  ZoomifyEnterprise4-Win/2\ Viewers/2\ Zoomify\ Simple\ Viewer/1\ Simple\ Viewer-Folder\ Storage/ into /usr/local/tomcat-5.5.27/webapps/zoomify/Viewer/ZoomifySimpleViewer/SimpleViewer-FolderStorage/

Three class files also need to be moved into /usr/local/tomcat-5.5.27/webapps/zoomify/WEB-INF/classes/zoomifyservlet/

./ZoomifyEnterprise4-Win/4 Website Publishing/5 Tile Handler Servlet - PFF Viewing/zoomifyservlet/ZoomifyServlet.class
./ZoomifyEnterprise4-Win/4 Website Publishing/5 Tile Handler Servlet - PFF Viewing/zoomifyservlet/ZoomifyHTTPRequestHandler.class
./ZoomifyEnterprise4-Win/4 Website Publishing/5 Tile Handler Servlet - PFF Viewing/zoomifyservlet/ZoomifyPostServlet.class


