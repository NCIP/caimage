<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %> 
<%@ page import = "java.lang.*"  %>
<%@ page import = "java.net.URL"  %>
<%@ page import = "java.io.*"  %>
<%@ page import = "javax.xml.parsers.*" %>
<%@ page buffer="none" %>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",System.currentTimeMillis());
String bName = request.getHeader("User-Agent");
 
System.out.println("bName:"+bName);
System.out.println("******catalogviewlung*********");

Metadata2Ex cx = new Metadata2Ex();
Vector rs = new Vector();
String imagewidth = null;
String imageheight = null;
String nunlevel = null;
String centerp = null;
String reslvl = null;
String catalog1 = null;
float reslvlc = 0;
String rgn = null;
rgn = (String)request.getParameter("rgn");
//System.out.println(rgn);
String image =(String) request.getParameter("img");
int ind = image.indexOf(".");
rs = cx.retrieveAllWhereImagekeyIs(image);
if(rs.isEmpty()){
image = image.substring(0, ind).toUpperCase() + image.substring(ind);
System.out.println("the image is all upper"+image);
rs = cx.retrieveAllWhereImagekeyIs(image);
} else if(rs.isEmpty()){
	image = image.substring(0, ind).toLowerCase() + image.substring(ind);
	System.out.println("the image is all lower"+image);
	rs = cx.retrieveAllWhereImagekeyIs(image);
	} else if(rs.isEmpty()){
	image = image.substring(0, 1).toUpperCase()+image.substring(1, ind).toLowerCase() + image.substring(ind);
	System.out.println("the image first upper is"+image);
	rs = cx.retrieveAllWhereImagekeyIs(image);
		}

//System.out.println("The values of catalog "+ cx.getCatalog());
//String imagePath1 = getServletConfig().getServletContext().getInitParameter("imageUploadPath1_UNIX");
String lizard = getServletConfig().getServletContext().getInitParameter("lizard");
String lizardstyle = getServletConfig().getServletContext().getInitParameter("lizard_Style");
System.out.println("Lizard path is"+lizard);
String imagepath = lizard+"/iserv/getimage?cat=";
System.out.println("lizard:"+imagepath);
String winplug = lizard+"/Content_Server/docs/downloads/MrSIDI.cab";
//String netplug = "http://nc-dev.nci.nih.gov/lizardtech/Content_Server/docs/downloads/NPMrSID.jar";
String netplug = lizard+"/Content_Server/docs/downloads/NPMrSID.jar";
String netplug1 = "http://ccm.ucdavis.edu/cfsidserver/downloads/NPMrSID.jar";

for(int j =0; j <rs.size(); j++){
		Metadata2Ex Metadata2Ex = (Metadata2Ex) rs.elementAt(j);
		imagewidth =Metadata2Ex.getImagewidth(); 
		imageheight=Metadata2Ex.getImageheight();
		nunlevel=Metadata2Ex.getNumlevel();
		catalog1 =Metadata2Ex.getCatalog();
		System.out.println("the catalog1 value is"+catalog1);
		}%>
</head>
<body>
<%

if(bName != null )
{

String catalog = (String)request.getParameter("cat");
String catdir = null;
Catalog1 ce = new Catalog1();
Vector catv = ce.retrieveAllWhere("CATALOG = '"+catalog+"'");
	System.out.println("the catalog vector value is"+catv+"size"+catv.size()+catalog);
	if(catv.size()> 0){
	System.out.println(" I am in not null");
	for(int k =0; k < catv.size(); k++){
				Catalog1 Ceta = null;
				System.out.println("The value of k "+ k );
					Ceta = (Catalog1) catv.elementAt(k);
					catdir = Ceta.getCat_dir().trim();
					System.out.println("the get dir value is"+catdir);
				}//for
	} else {
	System.out.println(" I am in null");
	catv = ce.retrieveAllWhere("CATALOG = '"+catalog1+"'");
	for(int k =0; k < catv.size(); k++){
				Catalog1 Ceta = null;
				System.out.println("The value of k "+ k );
					Ceta = (Catalog1) catv.elementAt(k);
					catdir = Ceta.getCat_dir().trim();
					System.out.println("the get value if null is"+catdir);
				}//for
	}

	System.out.println("width is"+imagewidth +" " +"height is"+imageheight);
	String rgn1 = "0,0,1,1";
			System.out.println("Region calculated is"+rgn1);
		String 	url =lizardstyle+"/calcrgn?cat="+catdir+"&img="+image+"&wid=400&hei=400&rgn="+rgn1+"&cmd=zoomin&props=cat(pon,son),item(en_Name,en_Description)&lang=en&style=view.xsl";
			System.out.println("url is"+url);
			response.sendRedirect(url);
		
}//if ends here	
%>
