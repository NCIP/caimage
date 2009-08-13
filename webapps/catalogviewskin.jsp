<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "nci.mmhcc.* " %>
<%@ page import = "nci.mmhcc.util.* " %>
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
System.out.println("******catalogviewskin*********");

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
image = image.substring(0, ind).toUpperCase() + image.substring(ind);
System.out.println("the image is"+image);
rs = cx.retrieveAllWhereImagekeyIs(image);
if(rs.isEmpty()){
image = image.substring(0, ind).toLowerCase() + image.substring(ind);
System.out.println("the image is"+image);
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
	System.out.println("the catalog vector value is"+catv+"size"+catv.size());
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
	if (rgn != null){
		System.out.println("I am in region loop");
		System.out.println("Region is"+request.getParameter("rgn"));
		String url = lizardstyle+"/calcrgn?cat="+catdir+"&img="+image+"&rgn="+rgn+"&wid=400&hei=400&props=cat(pon,son),item(en_Name,en_Description)&lang=en&style=view.xsl";
		System.out.println("url is"+url);
		response.sendRedirect(url);
		} else {
			System.out.println("I am in center loop");
			String center = request.getParameter("centerp");
			reslvlc = Float.parseFloat(request.getParameter("reslvl"));
			System.out.println("The resolution level is "+reslvlc );
			System.out.println("Center Point is"+request.getParameter("centerp"));
			String centerx = center.substring(0, center.lastIndexOf(","));
			System.out.println("Center X is"+centerx);
			String centery = center.substring(center.lastIndexOf(",")+1);
			System.out.println("Center Y is"+centery);
			double newx = 0;
			if(imagewidth != null){
			newx = (Double.parseDouble(centerx)/Double.parseDouble(imagewidth));
			} else
				{
				newx = (Double.parseDouble(centerx)/Double.parseDouble(centerx));
				}
			double newy = 0;
			if(imageheight != null){
			newy = (Double.parseDouble(centery)/Double.parseDouble(imageheight));
			} else
				{
				newy = (Double.parseDouble(centery)/Double.parseDouble(centery));
				}
			System.out.println("new centerx is"+newx +" " +"new centery  is"+newy);
			double x1 = 0;
			double x2 = 0;
			double y2 = 0;
			double y1 = 0;
				if (reslvlc ==0){
				System.out.println("i am in zero loop");
				x1 = newx-(.015625);
				x2 = newx+(.015625);
				y2 = newy+(.015625);
				y1 = newy-(.015625);
				}else{
				System.out.println("i am in  non zero loop"+reslvlc);
				x1 = newx-((.015625)*reslvlc*2);
				x2 = newx+((.015625)*reslvlc*2);
				y2 = newy+((.015625)*reslvlc*2);
				y1 = newy-((.015625)*reslvlc*2);
				}
			String rgn1 = Double.toString(x1)+","+Double.toString(y1)+","+Double.toString(x2)+","+Double.toString(y2);
			System.out.println("Region calculated is"+rgn1);
			String url =lizardstyle+"/calcrgn?cat="+catdir+"&img="+image+"&wid=400&hei=400&rgn="+rgn1+"&cmd=zoomin&props=cat(pon,son),item(en_Name,en_Description)&lang=en&style=view.xsl";
			System.out.println("url is"+url);
			response.sendRedirect(url);
			}//else end
}//if ends here	
%>
