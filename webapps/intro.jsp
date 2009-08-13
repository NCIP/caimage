 <html>
<head>
	<title>intro</title>

 <%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %> 
<%@ page import = "java.lang.*"  %>
<%@ page import = "java.net.URL"  %>
<%@ page import = "java.io.*"  %>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page import = "org.w3c.dom.*" %>
<%@ page import = "org.w3c.dom.Document" %>
<%@ page import = "org.xml.sax.*" %>
<%@ page import = "javax.xml.*" %>
<%@ page import = "java.net.URLDecoder"  %>
<%@ page import = "java.net.URLEncoder"  %>
 
<%@ page buffer="32kb"%>
</head>

<body>
<!--- <form method="post"  action = "intro.jsp"> --->
 <% 
//gov.nih.nci.caIMAGE.DatabaseSetup.setPageExpiration(response);
	//SessionManager.verifySession(request,response,"Error.jsp");
//response.setHeader("Cache-Control","no-cache"); 
//response.setHeader("Pragma","no-cache");%>
 
<%
System.out.println("**************I am in intro jsp***************");
//HttpSession mySession  = (HttpSession)request.getSession(); 
String mySession  = request.getRequestedSessionId(); 
//String lastName = null;
//String firstName = null;
Long submitterKey  = null;              
Long userTypeKey = null;                                
Long id =  new Long (request.getParameter("id"));  
System.err.println(" id from the script:" + id);
String copyStatus =(String)request.getParameter("copyStatus"); 
String deleteStatus =(String)request.getParameter("deleteStatus");  
System.err.println(" status  from copy:" + copyStatus+"deleteStatus:"+deleteStatus);                     
//DeleteRecord delete = new DeleteRecord(); 
  System.out.println(" session id"+ mySession.toString() );  
  System.out.println("I am here");
 //Constructor
   Annotations annot = new Annotations();   
   annot.retrieveByIndex(id);
   
	if( (copyStatus!=null) && (copyStatus.equals("true")))  { 
		    System.out.println("I am in clone");
		System.out.println("submitterKey:"+mySession);
		Annotations annot1 = new Annotations();
		Vector v = annot1.retrieveAll();
		KeyRetriever tk = new KeyRetriever();
		Long annotation_count = tk.getNextKey ("ANNOTATIONS");
		System.out.println("annotation count"+annotation_count);
		System.out.println(annot.getAnnotation_id() );
		annot.setAnnotation_id(annotation_count);
		String copy =  null;
		copy = annot.getImage_description();
		int a = copy.lastIndexOf("copy");
		if (a >0){
		copy = annot.getImage_description();
		} else
			{
			copy = annot.getImage_description()+"-copy" ;
			}
		System.out.println("index is"+a+copy.length() );
		annot.setImage_name("No Image");
		annot.setImage_description(copy);
		annot.insert();
		
		} 
	
	if( (deleteStatus!=null) && (deleteStatus.equals("true"))) 
	     {	
	  System.out.println("I am in delete");
		if((mySession != null) && (deleteStatus.equals("true")) ){  
			annot.deleteByKey(id);
			//Annotations annot2 = new Annotations();  
			//annot2.retrieveByIndex(id);
			System.out.println("the get image is"+annot.getImage_name());
			if ( !annot.getImage_name().equals("No Image") ){
				//this is for converter
				String convurl = getServletConfig().getServletContext().getInitParameter("convurl");
				System.out.println("conv url :********"+convurl.trim()); 
				String convPath = getServletConfig().getServletContext().getInitParameter("convpath");
				System.out.println("conv path :"+convPath); 
				String convOutputPath = convPath+"Output";
				String convusername = getServletConfig().getServletContext().getInitParameter("convusername");
				System.out.println("conv username :"+convusername); 
				String convpwd = getServletConfig().getServletContext().getInitParameter("convpwd");
				System.out.println("conv pwd :"+convpwd); 
				String path = getServletConfig().getServletContext().getInitParameter("ftppath");
				System.out.println("path :"+path); 
				//String newPath = "/Images/External/Donator/Tissue/Diagnosis/stage";
				//System.out.println("the new path is "+ newPath);
				//FTPUtil.transfer(filearray, null,  new Long(annot.count()+1), convurl.trim(), "/encode/enc6", "tomcat", "lpgtom");
				//First time transfer the file to the convertor
				//deleteAllFiles(File[] files,File[] files2,String dest, String path, String path2, String username, String password)
		  		String imagename = annot.getImage_name();
				String extension = imagename.substring(imagename.lastIndexOf("."), imagename.length());
				String imagenumber =imagename.substring(0,imagename.lastIndexOf("."));
				System.out.println("The image name is"+imagenumber);
				System.out.println("The extension is"+extension);
				File file = new File(imagename);
				//File file1 = new File(imagenumber+".jpg");
				File[] filearray = {file};
				FTPUtilDelete ftp = new FTPUtilDelete();
				boolean status = false;
					if(status==false && !extension.equals(".sid")){
					//This is for converter deletion
					ftp.deleteAllFiles(null, filearray , convurl.trim(), convPath.trim(), convPath.trim(),convusername.trim(), convpwd.trim());
					status = ftp.getStatus2();
					//remove the converted file from the encode/enc6/Output
					ftp.deleteAllFiles(null, filearray , convurl.trim(), convOutputPath.trim(), convOutputPath.trim(),convusername.trim(), convpwd.trim());
					status = ftp.getStatus2();
					}
				System.out.println("status:"+status);
					if(status ==false){
					//This is for image server deltetion
					System.out.println("------I am in delete imags in the sid server---"+annot.getCatalog_id());
						//Cannot delete the previously submitted images
						if(annot.getCatalog_id().equals(new Long(30)) ) {
						System.out.println("I am imageserver if loop");
						
						String imageserverpath = getServletConfig().getServletContext().getInitParameter("image_server_path");
						String imageserver = getServletConfig().getServletContext().getInitParameter("image_server");
						String imageserveruser = getServletConfig().getServletContext().getInitParameter("image_server_user");
						String imageserverpasswd = getServletConfig().getServletContext().getInitParameter("image_server_passwd");
						System.out.println("image server path:"+imageserverpath);
						System.out.println("image server :"+imageserver);
						System.out.println("image server user:"+imageserveruser);
						System.out.println("image server password:"+imageserverpasswd);
						System.out.println("image :"+filearray);
						//ftp.deleteAllFiles(null, filearray , imageserverpath.trim(), convOutputPath.trim(), convOutputPath.trim(),convusername.trim(), convpwd.trim());
						ftp.deleteAllFiles(null , filearray , imageserver.trim(), imageserverpath.trim(), imageserverpath.trim(), imageserveruser.trim(), imageserverpasswd.trim());
						status = ftp.getStatus2();
						System.out.println("status:"+status);
						} else {
						System.out.println("I am imageserver else loop");%>
						response.sendRedirect("unautomated_images.html");
						<%}
					}
				}//if my session
		}//if delete status
	}//if Noimage
	//else {
		
	//}
	//Long donatorid = (Long)session.getAttribute("nci.mmhcc.submitter.submitterKey");
	//System.out.println("the donator id in intro is"+donatorid);
	//System.out.println("The caiimage user id is"+ request.getParameter("userid") );
	%>
	
  <script language="JavaScript">
         location.replace("caimageUsers.jsp");
	</script> 		         
	<%
	//if(models!=null && models.hasMoreElements()){//repeat customer%>     
		<%//@ include file="returning_user.html"%>
     <%//}
	//else{  	                        
	//then first time user %>
		<%//@ include file="after_first_login.html"%> 
	<%//}%>      
    
<!--- </form>     --->
    
	</body>
</html>         
