<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
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
// this is to take care of the catlog directory, image name and region.
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",System.currentTimeMillis());
String bName = request.getHeader("User-Agent");
 
System.err.println("******catalogview- emice*********");

Annotations annot = new Annotations();
Vector rs = new Vector();
String imagewidth = null;
String imageheight = null;
String nunlevel = null;
String centerp = null;
String reslvl = null;
String catdir = null;
float reslvlc = 0;
String rgn = null;
Long annotid  = null;
rgn = (String)request.getParameter("rgn");

String image =(String) request.getParameter("img");
rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
int ind = image.indexOf(".");
if(rs.isEmpty()){
image = image.substring(0, ind).toUpperCase() + image.substring(ind);

rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
} else if(rs.isEmpty()){
	image = image.substring(0, ind).toLowerCase() + image.substring(ind);

	rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
	} else if(rs.isEmpty()){
	image = image.substring(0, 1).toUpperCase()+image.substring(1, ind).toLowerCase() + image.substring(ind);

	rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
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
//String netplug = "http://nc-dev.nci.nih.gov/lizardtech/Content_Server/docs/downloads/NPMrSID.jar";
String netplug = lizard+"/Content_Server/docs/downloads/NPMrSID.jar";
String netplug1 = "http://ccm.ucdavis.edu/cfsidserver/downloads/NPMrSID.jar";
for(int j =0; j <rs.size(); j++){
		Annotations Annot = (Annotations) rs.elementAt(j);
		annotid = Annot.getAnnotation_id();
		Image_characteristic ic = new Image_characteristic();
		ic.retrieveByKey(annotid);
		imagewidth =ic.getImage_characteristic_width();
		imageheight=ic.getImage_characteristic_height();
		nunlevel=ic.getImage_characteristic_numlevel();
	}//for
		%>
</head>
<body>
<%

if(bName != null )
{
String catalog = (String)request.getParameter("cat").trim();

Catalog cat = new Catalog();
Vector catv = cat.retrieveAllWhere("CATALOG_NAME like" +  " '"+"%"+catalog+"%"+"'");
				for(int k =0; k < catv.size(); k++){
				Catalog Ceta = null;
			
					Ceta = (Catalog) catv.elementAt(k);
					catdir = Ceta.getCatalog_directory().trim();
				
				}
	
	//this is incase the image width and height is null
		if ((imagewidth == null) || (imageheight == null)) {
		
		URL url = null;
		BufferedReader input = null;
		boolean flag = false;
		String  line = new String();
		String imageurl = lizardstyle+"/calcrgn?cat=";
	
		String calcrgn =  null;
			   calcrgn = DatabaseSetup.checkForNull(catdir.trim())+"&"+"img="+DatabaseSetup.checkForNull(image.trim())+"&wid=400&hei=400&style=none";
			
				try{
				url = new URL(imageurl+calcrgn);
		
				Object abc = url.getContent();
				int number1 = 0 ;
				int number2 = 0;
				int number3 = 0;
				String region = null;
				if(url.openConnection() !=null){
				
					input = new BufferedReader(new InputStreamReader(url.openStream()), 1000 );
					//Helps bringing all the images
					Thread.sleep(100);
			
				
					StringBuffer buffer = new StringBuffer();
						while (( line = input.readLine() ) != null ){
					
							buffer.append( line.toString() );
							buffer.append( "<!DOCTYPE ImageServer SYSTEM" +"\"calcrgn.dtd\">" );
							flag = true;
							}
							String outputmod = buffer.delete(url.openStream().available()+40, buffer.capacity()).toString(); 
							// temporary closed but show xml
					
							int width = 0;
							int width1 = 0;
						 	width= outputmod.lastIndexOf("width"); 
						 	width1=outputmod.indexOf(" ", width+7);
							int height = 0;
							int height1= 0;
							height = outputmod.lastIndexOf("height");
					
							height1= outputmod.indexOf(" ",height+8);
						
							number1= Integer.parseInt(outputmod.substring(width+7, width1-1)); 
							number2 = Integer.parseInt(outputmod.substring(height+8, height1-1)); 
							
					imagewidth = Integer.toString(number1) ;
					imageheight =Integer.toString(number2) ;
					}
					input.close();
					} catch (IOException e) {
			e.printStackTrace();
			}//try ends 
						
		}//if imagewidth and image height is null
	if (rgn != null){
		
		String url = lizardstyle+"/calcrgn?cat="+catdir+"&img="+image+"&rgn="+rgn+"&wid=400&hei=400&props=cat(pon,son),item(en_Name,en_Description)&lang=en&style=view.xsl";
		
		response.sendRedirect(url);
		} else {
			
			String center = request.getParameter("centerp");
			reslvlc = Float.parseFloat(request.getParameter("reslvl"));
			String centerx = center.substring(0, center.lastIndexOf(","));
			String centery = center.substring(center.lastIndexOf(",")+1);
			double newx = 0;
			if(imagewidth != null){
			newx = (Double.parseDouble(centerx)/Double.parseDouble(imagewidth));
			} else
				{
				newx = (Double.parseDouble(centerx)/Double.parseDouble(centerx)/2);
				}
			double newy = 0;
			if(imageheight != null){
			newy = (Double.parseDouble(centery)/Double.parseDouble(imageheight));
			} else
				{
				newy = (Double.parseDouble(centery)/Double.parseDouble(centery)/2);
		
				}
		
			double x1 = 0;
			double x2 = 0;
			double y2 = 0;
			double y1 = 0;
				if (reslvlc ==0){
		
				x1 = newx-(.015625);
				x2 = newx+(.015625);
				y2 = newy+(.015625);
				y1 = newy-(.015625);
				}else{
			
				x1 = newx-((.015625)*reslvlc*2);
				x2 = newx+((.015625)*reslvlc*2);
				y2 = newy+((.015625)*reslvlc*2);
				y1 = newy-((.015625)*reslvlc*2);
				}
			String rgn1 = Double.toString(x1)+","+Double.toString(y1)+","+Double.toString(x2)+","+Double.toString(y2);
			
			String url =lizardstyle+"/calcrgn?cat="+catdir+"&img="+image+"&wid=400&hei=400&rgn="+rgn1+"&cmd=zoomin&props=cat(pon,son),item(en_Name,en_Description)&lang=en&style=view.xsl";
		
			response.sendRedirect(url);
			}//else end
}//if ends here	
%>
