<script language="JavaScript" src="/ncicb/EvsTree.js">
</script> 
 
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

<%  request.getSession(true);%>

<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/search_images.htm"%>
	
<form name="main" method="POST"  action="simpleresults.jsp?q=0"  >
<center><table BORDER=0 WIDTH="38%" >
<caption>&nbsp;</caption>
<!--- <tr>
<td VALIGN=TOP COLSPAN="2" class ="title">
<center>Simple Image Search</center>
</td>
</tr> --->

<tr ALIGN=left VALIGN=TOP>
<td class="bodytxbold">Species</td>

<td ALIGN=left><SELECT NAME="species" size=1 >
<option value =""></option>
 
 <% 
Species sp = new Species();
System.out.println("the get value is"+sp);
Vector species   = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");%>
<%
for(int j =0; j <species.size(); j++){
		Species speciesTab = (Species) species.elementAt(j);
		if(speciesTab.getSpecies_id() !=null){
			if (speciesTab.getSpecies_name().equals("Mouse")|| speciesTab.getSpecies_name().equals("Human") ){ %>
			<option  selected value="<%=speciesTab.getSpecies_name()%>" ><%=speciesTab.getSpecies_name()%></option>
			<%}
		}
		System.out.println(speciesTab.getSpecies_id()+speciesTab.getSpecies_name());
}
%>
</select><p></td>
</tr>
<TR id="OrganSelect" align="left" valign="TOP">
			<TD class="bodytxbold">Organ / Tissue </TD>
			<TD align="left" >
		   <a href="javascript:abc()"><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="organ" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/>
				<INPUT name="organTissueName" type="hidden"/>
		 		<INPUT name="organTissueCode" type="hidden"/>
			</TD>
		</TR>				
		<TR id="DiagnosisSelect" align="left" valign="TOP">
			<TD class="bodytxbold">Diagnosis </TD>
			<TD align="left">
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="TumorClassification" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
				<input type="hidden" name="DiagnosisName"/>        
		    <input type="hidden" name="DiagnosisCode"/>   
			</TD>
		</TR>							
    


<tr>
<td ALIGN=CENTER COLSPAN="2">
<input TYPE="submit" NAME="select_annotation_type" VALUE="Search">&nbsp;&nbsp;
<input TYPE=RESET VALUE="  Clear   " tabindex="4" ></td>
</tr>
</table></center>
<p></form>

<%@ include file="html/simple_search2.htm"%>
</body>

</html>
