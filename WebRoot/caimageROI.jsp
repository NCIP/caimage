<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<script l<script language="JavaScript" src="/ncicb/EvsTree.js">
</script> 

 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
            "http://www.w3.org/TR/html4/loose.dtd">

			
<script language="JavaScript" >
function abc(){
var speciesIndex = document.main.species.selectedIndex;
var speciesValue = document.main.species[speciesIndex].value;
if ((speciesValue== "") || (speciesValue == null)) {
showTissueTree('main', 'mouse', 1)
}else {
showTissueTree('main', speciesValue, 1)
	}
}
function dig(){
var speciesIndex = document.main.species.selectedIndex;
var speciesValue = document.main.species[speciesIndex].value;
if ((speciesValue== "") || (speciesValue == null)) {
showDiagnosisTree('main',  'mouse', 2)
}else {
showDiagnosisTree('main', speciesValue, 2)
	}
}
</script> 

<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %>   
<%@ page import = "java.lang.*"  %>
<%@ page import = "java.net.URLEncoder"  %>

<%  request.getSession(true);%>

<%@ include file="tabsimagesubmission.htm"%>
<%
//SessionManager.verifySession(request,response,"Error.jsp");
// constructor class
Species sp = new Species();
Image_modality  mod = new Image_modality();
%>
  
	<LINK rel="stylesheet" type="text/css" href="images/submission[3].css">
</head>
<body onLoad="MM_preloadImages('images/arrowOver.gif','images/infoOver.gif','images/searchOver.gif','images/adminOver.gif','images/searchtextOver.gif','images/admintextOver.gif','images/disclaimerOver.gif','images/submittextOver.gif','images/submitOver.gif','images/new_over.gif','images/new_up.gif')">

&nbsp;
<form name="main" method="POST" action="caimageSubmit.jsp"  >
<right><b></b><font color="red" >Required fields *</font></b></right>
<center><table BORDER=0 WIDTH="50%" >
<caption>&nbsp;</caption>

<tr>
<td VALIGN=TOP align = center COLSPAN="2" class ="title">
<center>Region Of Interest </center>
</td>
</tr>
<TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=RIGHT class="blbo"><b> Width :&nbsp;<font color="red" >*</font></b></td>
	<td>
		<INPUT TYPE="Text" ALIGN=center NAME="xcoor" > 
	
		</td>
	</TR>
	<TR ALIGN=LEFT VALIGN=TOP>
	<td ALIGN=RIGHT class="blbo"><b> Heigtht :&nbsp;<font color="red" >*</font></b></td>
	<td>
		<INPUT TYPE="Text" ALIGN=center NAME="ycoor"  >
		
		</td>
	</TR>
	<TR ALIGN=LEFT VALIGN=TOP>
	<td ALIGN=RIGHT class="blbo"><b> Magnification Level :&nbsp;<font color="red" >*</font></b></td>
	<td>
		<INPUT TYPE="Text" ALIGN=center NAME="magni"  >
		
		</td>
	</TR>
	<tr ALIGN=right VALIGN=TOP>
	<td class="blbo"><b>Modality:&nbsp;<font color="red" >*</font></b></td>
	<td ALIGN=left><SELECT NAME="modality" size=1 >
	<option value =""></option>	
 
	 <% 
	
	Vector modalities   = mod.retrieveAllWhere("IMAGE_MODALITY_TYPE  IS NOT NULL ORDER BY IMAGE_MODALITY_TYPE");%>
	
	<%
	for(int j =0; j <modalities.size(); j++){
			Image_modality  modalitiesTab = (Image_modality) modalities.elementAt(j);
			if(modalitiesTab.getImage_modality_id() !=null){%>
			<option  value=<%=modalitiesTab.getImage_modality_type()%>  ><%=modalitiesTab..getImage_modality_type()%></option>
			<%}
			
		}
	%>
			
	</select><p></tr>

<tr ALIGN=right VALIGN=TOP>
<td class="blbo"><b>Species:&nbsp;<font color="red" >*</font></b></td>

<td ALIGN=left><SELECT NAME="species" size=1 >
<option value =""></option>	
 
 <% 

Vector species   = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");%>

<%
for(int j =0; j <species.size(); j++){
		Species speciesTab = (Species) species.elementAt(j);
		if(speciesTab.getSpecies_id() !=null){%>
		<option  value="<%=speciesTab.getSpecies_name()%>"  ><%=speciesTab.getSpecies_name()%></option>
		<%}
	
	}
%>
		
</select><p></tr>

<TR id="OrganSelect" align="right" valign="TOP">
			<TD class="blbo"><b>Site of Lesion / Tumor: <font color="red" >*</font></b></TD>
			<TD align="left" >
  		  <a href="javascript:abc()"><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="organ" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/>
				<INPUT name="organTissueName" type="hidden"/>
		 		<INPUT name="organTissueCode" type="hidden"/>
			</TD>
		</TR>				
		
		<TR id="DiagnosisSelect" align="right" valign="TOP">
			<TD class="blbo"><b>Diagnosis: <font color="red" >*</font></b></TD>
			<TD align="left">
				<!--- 
				<a href="javascript:showDiagnosisTree('main', document.forms['main'].species.value, 2)"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="TumorClassification" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
				 --->
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="TumorClassification" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
				
				<input type="hidden" name="diagnosisName"/>        
		    <input type="hidden" name="diagnosisCode"/>   
			</TD>
		</TR>							
<TR ALIGN=LEFT VALIGN=TOP>
	<td ALIGN=RIGHT class="blbo"><b> ROI Description :&nbsp;<font color="red" >*</font></b></td>
	<td>
		<TEXTAREA ALIGN=center NAME="roidesc"  ROWS =2 COLS =27 >
		<%System.out.println("image desc  "+request.getParameter("roidesc"));%>	
		</textarea>
		</td>
	</TR>  

<tr>
<td ALIGN=CENTER COLSPAN="2">
<input TYPE="submit" NAME="select_annotation_type" VALUE="Submit" onClick="alert('save: ' + document.main.myUploadObject.value)">&nbsp;&nbsp;
<input TYPE=RESET VALUE="  Clear   " tabindex="4"   onClick="alert('reset: ' + document.main.myUploadObject.value)" ></td>
</tr>
</table></center>
<p></form>

</body>

</html>

