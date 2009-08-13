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
 
System.out.println("bName:"+bName);
System.out.println("******catalogview- emice*********");

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
System.out.println(rgn);
String image =(String) request.getParameter("img");
rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
int ind = image.indexOf(".");
if(rs.isEmpty()){
image = image.substring(0, ind).toUpperCase() + image.substring(ind);
System.out.println("the image is all upper"+image);
rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
} else if(rs.isEmpty()){
	image = image.substring(0, ind).toLowerCase() + image.substring(ind);
	System.out.println("the image is all lower"+image);
	rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
	} else if(rs.isEmpty()){
	image = image.substring(0, 1).toUpperCase()+image.substring(1, ind).toLowerCase() + image.substring(ind);
	System.out.println("the image first upper is"+image);
	rs = annot.retrieveAllWhere("IMAGE_NAME = '"+image+"'");
		}

//System.out.println("The values of catalog "+ annot.getCatalog());
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
System.out.println("The size is"+rs.size());
for(int j =0; j <rs.size(); j++){
		Annotations Annot = (Annotations) rs.elementAt(j);
		annotid = Annot.getAnnotation_id();
		Image_characteristic ic = new Image_characteristic();
		ic.retrieveByKey(annotid);
		imagewidth =ic.getImage_characteristic_width();
		imageheight=ic.getImage_characteristic_height();
		nunlevel=ic.getImage_characteristic_numlevel();
		//catalog =Metadata2Ex.getCatalog();
		System.out.println("the catalog value is"+imagewidth+imageheight);
		
		
		}//for
		%>
</head>
<body>
<%

if(bName != null )
{
String catalog = (String)request.getParameter("cat").trim();
System.out.println("the catalog is"+catalog);
Catalog cat = new Catalog();
Vector catv = cat.retrieveAllWhere("CATALOG_NAME like" +  " '"+"%"+catalog+"%"+"'");
System.out.println("the catv is"+catv.size());
				for(int k =0; k < catv.size(); k++){
				Catalog Ceta = null;
				System.out.println("The value of k "+ k );
					Ceta = (Catalog) catv.elementAt(k);
					catdir = Ceta.getCatalog_directory().trim();
					System.out.println("the get value is"+catdir);
				}
	System.out.println("width is"+imagewidth +" " +"height is"+imageheight);
	//this is incase the image width and height is null
		if ((imagewidth == null) || (imageheight == null)) {
		System.out.println("the image width and height is null");
		URL url = null;
		BufferedReader input = null;
		boolean flag = false;
		String  line = new String();
		String imageurl = lizard+"/iserv/calcrgn?cat=";
		System.out.println("lizard image url:"+imageurl);
		String calcrgn =  null;
			   calcrgn = DatabaseSetup.checkForNull(catdir.trim())+"&"+"img="+DatabaseSetup.checkForNull(image.trim())+"&wid=400&hei=400&style=none";
				System.out.println("the calcrgn is:"+calcrgn);
				try{
				url = new URL(imageurl+calcrgn);
				System.out.println("The url is"+url);
				Object abc = url.getContent();
				int number1 = 0 ;
				int number2 = 0;
				int number3 = 0;
				String region = null;
				if(url.openConnection() !=null){
					System.out.println("the object returned is:"+abc.toString());
					input = new BufferedReader(new InputStreamReader(url.openStream()), 1000 );
					//Helps bringing all the images
					Thread.sleep(100);
					//System.out.println("The flag  is *****"+flag);
					System.out.println("The input is *****"+input);
					System.out.println("the available byte is:"+url.openStream().available());
					StringBuffer buffer = new StringBuffer();
						while (( line = input.readLine() ) != null ){
							//System.out.println("The line is"+line.toString()+"\n");
							buffer.append( line.toString() );
							buffer.append( "<!DOCTYPE ImageServer SYSTEM" +"\"calcrgn.dtd\">" );
							flag = true;
							}
							String outputmod = buffer.delete(url.openStream().available()+40, buffer.capacity()).toString(); 
							// temporary closed but show xml
							//System.out.println("the output modified is"+outputmod);
							//String ret = SAXParseUtil.parseurl(outputmod);
							int width = 0;
							int width1 = 0;
						 	width= outputmod.lastIndexOf("width"); 
						 	width1=outputmod.indexOf(" ", width+7);
							int height = 0;
							int height1= 0;
							height = outputmod.lastIndexOf("height");
							System.out.println("The start of height is at"+height);
							height1= outputmod.indexOf(" ",height+8);
							System.out.println("The end of height is at"+height1);
							number1= Integer.parseInt(outputmod.substring(width+7, width1-1)); 
							number2 = Integer.parseInt(outputmod.substring(height+8, height1-1)); 
							System.out.println("The width is "+number1 +" and  height is "+number2);
					imagewidth = Integer.toString(number1) ;
					imageheight =Integer.toString(number2) ;
					}
					input.close();
					} catch (IOException e) {
			e.printStackTrace();
			}//try ends 
						
		}//if imagewidth and image height is null
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
			System.out.println(" I am in if loop width");
			} else
				{
				newx = (Double.parseDouble(centerx)/Double.parseDouble(centerx)/2);
				System.out.println(" I am in else loop width");
				}
			double newy = 0;
			if(imageheight != null){
			newy = (Double.parseDouble(centery)/Double.parseDouble(imageheight));
			} else
				{
				newy = (Double.parseDouble(centery)/Double.parseDouble(centery)/2);
				System.out.println(" I am in else loop height");
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
