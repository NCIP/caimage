<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See https://github.com/NCIP/caimage/LICENSE.txt for details.
L--%>

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

String image =(String) request.getParameter("img");
int ind = image.indexOf(".");
rs = cx.retrieveAllWhereImagekeyIs(image);
if(rs.isEmpty()){
image = image.substring(0, ind).toUpperCase() + image.substring(ind);

rs = cx.retrieveAllWhereImagekeyIs(image);
} else if(rs.isEmpty()){
	image = image.substring(0, ind).toLowerCase() + image.substring(ind);

	rs = cx.retrieveAllWhereImagekeyIs(image);
	} else if(rs.isEmpty()){
	image = image.substring(0, 1).toUpperCase()+image.substring(1, ind).toLowerCase() + image.substring(ind);

	rs = cx.retrieveAllWhereImagekeyIs(image);
		}



InputStream in = null;
Properties sysProps = new Properties();
try {
	in = Thread.currentThread().getContextClassLoader().getResourceAsStream("system.properties");
	sysProps.load(in);
} catch (Exception e) {
	System.err.println("Error loading system.properties file");
	e.printStackTrace();
}
String lizard = sysProps.getProperty("lizard");
String lizardstyle = sysProps.getProperty("lizard_Style");

String imagepath = lizard+"/iserv/getimage?cat=";

String winplug = lizard+"/Content_Server/docs/downloads/MrSIDI.cab";

String netplug = lizard+"/Content_Server/docs/downloads/NPMrSID.jar";
String netplug1 = "http://ccm.ucdavis.edu/cfsidserver/downloads/NPMrSID.jar";

for(int j =0; j <rs.size(); j++){
		Metadata2Ex Metadata2Ex = (Metadata2Ex) rs.elementAt(j);
		imagewidth =Metadata2Ex.getImagewidth(); 
		imageheight=Metadata2Ex.getImageheight();
		nunlevel=Metadata2Ex.getNumlevel();
		catalog1 =Metadata2Ex.getCatalog();
	
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
	
	if(catv.size()> 0){
	
	for(int k =0; k < catv.size(); k++){
				Catalog1 Ceta = null;
				System.out.println("The value of k "+ k );
					Ceta = (Catalog1) catv.elementAt(k);
					catdir = Ceta.getCat_dir().trim();
				
				}//for
	} else {
	
	catv = ce.retrieveAllWhere("CATALOG = '"+catalog1+"'");
	for(int k =0; k < catv.size(); k++){
				Catalog1 Ceta = null;
			
					Ceta = (Catalog1) catv.elementAt(k);
					catdir = Ceta.getCat_dir().trim();
				
				}//for
	}

	String rgn1 = "0,0,1,1";
			
		String 	url =lizardstyle+"/calcrgn?cat="+catdir+"&img="+image+"&wid=400&hei=400&rgn="+rgn1+"&cmd=zoomin&props=cat(pon,son),item(en_Name,en_Description)&lang=en&style=view.xsl";
			
			response.sendRedirect(url);
		
}//if ends here	
%>
