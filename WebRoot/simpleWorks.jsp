<%--L
  Copyright SAIC

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

<!-- 
<script language="JavaScript" src="/EVSTree/EvsTree.js">
</script> 
-->
<script language="JavaScript" src="scripts/EVSTreeScript.js">
</script>

 
<script language="JavaScript" >
//previously it was evs
//var skinName = 'evs';
var skinName = 'evs1';
windowTitle = "NCI Center for Bioinformatics";
//function cacheTree(){
//showTissueTree('main', 'rootNode=Murine_Tissue_Type;descendants=true;isaFlag=false;depthLevel=6;roleType=Anatomic_Structure_is_Physical_Part_of')
//showDiagnosisTree('main',  'rootNode=Mouse_Disorder_by_Site;descendants=true;isaFlag=true;depthLevel=10;roleType=EO_Disease_Has_Associated_EO_Anatomy')
//showTissueTree('main', 'rootNode=Murine_Tissue_Type;descendants=true;isaFlag=false;depthLevel=6;roleType=Anatomic_Structure_is_Physical_Part_of')
//showTissueTree('main', 'rootNode=Organ_System;descendants=true;isaFlag=true;depthLevel=4;roleType=Anatomic_Structure_is_Physical_Part_of')
//showHumanDiagnosisTree('main', 'rootNode=Disorder_by_Site;descendants=true;isaFlag=true;depthLevel=4;roleType=Disease_Has_Associated_Anatomic_Site')
	//}


function buildSelect() { 
alert(document.main.species.selectedIndex) ; //return
x = document.main.species.selectedIndex;
if (x == "4") { 
//alert(document.main.organ.name) ;
//alert(document.getElementById('browse').src) ;
	var abc = document.getElementById('OrganSelect') ;
	alert(document.forms[0].elements[1].name);
	alert(document.forms[0].elements[2].name);
	alert(document.forms[0].elements[3].name);
	alert(document.forms[0].elements[4].name);
	document.forms[0].elements[1].name.disabled="disabled";
	alert(document.forms[0].elements[1].value);
	alert(document.forms[0].elements[1].type);
	alert(document.forms[0].elements.length);
	for (i=0; i<document.forms[0].elements.length; i++){
		if (document.forms[0].elements[i].type=="text" ){
		//document.forms[0].elements[i].value=disabled;
		alert(document.forms[0].elements[i].name); //alert error message
		alert("value"+document.forms[0].elements[i].value); //alert error message
		document.forms[0].elements[i].name.disabled=("return");
		//document.forms[0].elements[i].onchange= ("return");
		
		//new Function("this.value=this.defaultValue");
		} else {
		alert(document.forms[0].elements[i].type + document.forms[0].elements[i].name); //alert error message
		}
	}
	//alert(document.main.browse.click);
	//document.getElementById('browse').src="";
	//document.main.organ.focus();
	
	  
}
}


function selection(){
var speciesIndex = document.main.species.selectedIndex;
var speciesValue = document.main.species[speciesIndex].value;
//alert('selection name' + speciesValue);
//alert(document.forms[0].elements[0].value);
//alert(document.forms[0].elements[0].name);
//alert(document.forms[0].name);
//alert(document.forms[0].value);
if ((speciesValue== "") || (speciesValue == null) || (speciesValue== "Mouse")) {
//showTissueTree('main', 'mouse', 1)
//alert('selection name if' + speciesValue );
	showTissueTree('main', 'rootNode=Murine_Tissue_Type;attribute=3;descendants=true;isaFlag=true;depthLevel=4;roleType=Anatomic_Structure_is_Physical_Part_of, Anatomic_Structure_Has_Location,  part_of')
	}else if ((speciesValue== "human") || (speciesValue == "Human")) {
	//alert('selection name if' + speciesValue );
	showTissueTree('main', 'rootNode=Organ_System;descendants=true;isaFlag=true;depthLevel=4;roleType=Anatomic_Structure_is_Physical_Part_of')
	//showTissueTree('main', speciesValue, 1)
	//showTissueTree('main', 'mouse', 1)
	} else {
	alert('No Tissue Tree available for ' + speciesValue );
	//showTissueTree('main', speciesValue, 1)
		}
}
function dig(){
var speciesIndex = document.main.species.selectedIndex;
var speciesValue = document.main.species[speciesIndex].value;
var organvalue = document.main.organTissueName.value;
//alert('selection name' + speciesValue + organvalue);
if ((speciesValue== "") || (speciesValue == null)|| (speciesValue== "Mouse")) {
//showDiagnosisTree('main',  'mouse', 2)
 //alert('selection name dig  if' + speciesValue );
  	//showDiagnosisTree('main',  'rootNode=Mouse_Disorder_by_Site;descendants=true;isaFlag=true;depthLevel=10;roleType=EO_Disease_Has_Associated_EO_Anatomy')
//var abc = 'rootNode='+organvalue+';descendants=true;isaFlag=true;depthLevel=10;roleType=EO_Disease_Has_Associated_EO_Anatomy';
  // alert('abc'+abc);
   showDiagnosisTree('main',  'rootNode=Murine_Tissue_Type;attribute=3;descendants=true;isaFlag=true;depthLevel=4;roleType=EO_Disease_Has_Associated_EO_Anatomy')

}else if ((speciesValue== "human") || (speciesValue == "Human")) {
	//showDiagnosisTree('main', speciesValue, 2)
	//alert('selection name dig  else' + speciesValue );
	// showHumanDiagnosisTree('main', 'rootNode=Disorder_by_Site;descendants=true;isaFlag=true;depthLevel=4;roleType=Disease_Has_Associated_Anatomic_Site')
	showDiagnosisTree('main', 'rootNode='+organvalue+';descendants=true;isaFlag=true;depthLevel=4;roleType=Disease_Has_Associated_Anatomic_Site')
	} else {
	alert('No Diagnosis Tree available for ' + speciesValue );
	//showTissueTree('main', speciesValue, 2)
		}
}
</script> 

<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %>   
<%@ page import = "java.lang.*"  %>
<%@ page import = "org.apache.log4j.Logger"  %>


<%  request.getSession(true);%>

<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/search_images.htm"%>
<%
simpleandfile sf = new simpleandfile();
sf.log("start");
Logger logger = Logger.getLogger(simpleandfile.class);

%>
<form name="main" method="POST"  action="simpleresults.jsp?q=0"  >
<center><table BORDER=0 WIDTH="38%" >
<caption>&nbsp;</caption>
<!--- <tr>
<td VALIGN=TOP COLSPAN="2" class ="title">
<center>Simple Image Search</center>
</td>
</tr> --->

<TD class="bodytxbold">Database: </TD>
			<TD align="left"class="bodytxbold" >
<%=DatabaseSelection.setSelected()%></TD>

<tr ALIGN=left VALIGN=TOP>
<td class="bodytxbold">Species</td>

<td ALIGN=left><SELECT NAME="species"  size=1 >
<option value =""></option>
 <% 
logger.debug("****Simple.jsp*********");
Species sp = new Species();

logger.debug("the get value is"+sp);

Vector species   = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");%>
<%
for(int j =0; j <species.size(); j++){
		Species speciesTab = (Species) species.elementAt(j);
		if(speciesTab.getSpecies_id() !=null){
			//if (speciesTab.getSpecies_name().equalsIgnoreCase("mouse")|| speciesTab.getSpecies_name().equalsIgnoreCase("human") || speciesTab.getSpecies_name().equals("trial")){ %>
			
			<option  value="<%=speciesTab.getSpecies_name()%>"<%=Selection.setSelected(String.valueOf(speciesTab.getSpecies_id()),speciesTab.getSpecies_name())%>><%=speciesTab.getSpecies_name()%></option>
			<%//}
		}
		logger.debug(speciesTab.getSpecies_id()+speciesTab.getSpecies_name());
}

%>
</select><p></td>
</tr>
<TR id="OrganSelect" align="left" valign="TOP">
			<TD class="bodytxbold"> Organ / Tissue </TD>
			<TD align="left" >
			<% //evsQuery.searchDescLogicConcepts("NCI_Thesaurus","Heart",10,1,"Disease_Has_Associated_Anatomic_Site",1);
%>
			 			  
			   <a href="javascript:selection()" ><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="organ" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/>
			
			
			
				<INPUT name="organTissueName" type="hidden"/>
				<INPUT name="organTissueCode" type="hidden"/>
			</TD>
		</TR>				
		<TR id="DiagnosisSelect" align="left" valign="TOP">
			<TD class="bodytxbold">Diagnosis</TD>
			<TD align="left">
			 
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="tumorClassification" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
				<input type="hidden" name="diagnosisName"/>        
		    	<input type="hidden" name="diagnosisCode"/>   
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
