<script language="JavaScript" src="scripts/EVSTreeScript.js">
</script>

<script language="JavaScript">
//previously it was evs
//var skinName = 'evs';
var skin = 'evsMOD';
title = "NCI Center for Bioinformatics";
var inConceptName = '';
var inConceptCode='';
var inDisplayName='';
var rootNode = '';
var roleType = '';
var form = '';
var diagnosisDisplayValue = '';
leafNode=false;
var fieldsToBlank = new Array();
fieldsToBlank[0]="tumorClassification";
fieldsToBlank[1]="diagnosisName";
fieldsToBlank[2]="diagnosisCode";

function selection(){
var speciesIndex = document.main.species.selectedIndex;
var speciesValue = document.main.species[speciesIndex].value;
form = document.forms[0];
form = form.name;
inDisplayName = document.main.organ.name;
inConceptName = document.main.organTissueName.name;
inConceptCode = document.main.organTissueCode.name;
diagnosisDisplayValue = document.main.tumorClassification.value;

if ((speciesValue== "") || (speciesValue == null) || (speciesValue== "Mouse")) {

		if(diagnosisDisplayValue.length == 0) {
		showTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode)
		}
		else {
		showTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, fieldsToBlank);
		}
}else if ((speciesValue== "human") || (speciesValue == "Human")) {
		if(diagnosisDisplayValue.length == 0) {
		showHumanTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode)
		}
		else {
		showHumanTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, fieldsToBlank);
		}
	} else {
	alert('No Tissue Tree available for ' + speciesValue );
		}
}

function dig(){
var speciesIndex = document.main.species.selectedIndex;
var speciesValue = document.main.species[speciesIndex].value;
var organvalue = document.main.organTissueName.value;
form = document.forms[0];
form = form.name;
displayName = document.main.tumorClassification.name;
conceptName = document.main.diagnosisName.name;
conceptCode = document.main.diagnosisCode.name;
//leafNode=true;
	if ((speciesValue== "") || (speciesValue == null)|| (speciesValue== "Mouse")) {
	//temporarily hard coded till the EVS tree resolved
	 organvalue = 'MouseDiagnosis'; 
		if (organvalue){
	  	showDiagnosisTree(form, conceptCode, conceptName, displayName, leafNode, organvalue)
	  	} 
 	}else if ((speciesValue== "human") || (speciesValue == "Human")) {
 	//organvalue = 'HumanDiagnosis';
 	//showHumanDiagnosisTree(form, conceptCode, conceptName, displayName, leafNode, organvalue)
	alert('The vocabulary is currently unavailable.');
	} 
	else {
	alert('No Diagnosis Tree available for ' + speciesValue );
	}
}
</script>

<%@ page language="java"%>
<%@ page import="gov.nih.nci.caimage.db.*"%>
<%@ page import="gov.nih.nci.caIMAGE.*"%>
<%@ page import="gov.nih.nci.caIMAGE.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="org.apache.log4j.Logger"%>


<%request.getSession(true);%>

<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/search_images.htm"%>
<%simpleandfile sf = new simpleandfile();
			sf.log("start");
			Logger logger = Logger.getLogger(simpleandfile.class);

			%>
<form name="main" method="POST" action="simpleresults.jsp?q=0">
	<center>
		<table BORDER=0 WIDTH="38%">
			<caption>
				&nbsp;
			</caption>
			<!--- <tr>
<td VALIGN=TOP COLSPAN="2" class ="title">

<center>Simple Image Search</center>
</td>
</tr> --->

			

			<tr ALIGN=left VALIGN=TOP>
				<td class="bodytxbold">
					Species
				</td>

				<td ALIGN=left>
					<SELECT NAME="species" size=1>
						<option value=""></option>
						<%logger.debug("****Simple.jsp*********");
			Species sp = new Species();

			Vector species = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");%>
						<%for (int j = 0; j < species.size(); j++) {
				Species speciesTab = (Species) species.elementAt(j);
				if (speciesTab.getSpecies_id() != null) {

					%>
						<option value="<%=speciesTab.getSpecies_name()%>" <%=Selection.setSelected(String.valueOf(speciesTab.getSpecies_id()),speciesTab.getSpecies_name())%>>
							<%=speciesTab.getSpecies_name()%>
						</option>
						<%}
				//logger.debug(speciesTab.getSpecies_id()	+ speciesTab.getSpecies_name());
			}

		%>
					</select>
					<p>
				</td>
			</tr>
			<TR id="OrganSelect" align="left" valign="TOP">
				<TD class="bodytxbold">
					Organ / Tissue
				</TD>
				<TD align="left">

					<a href="javascript:selection()"><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;
					<INPUT name="organ" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />



					<INPUT name="organTissueName" type="hidden" />
					<INPUT name="organTissueCode" type="hidden" />
				</TD>
			</TR>
			<TR id="DiagnosisSelect" align="left" valign="TOP">
				<TD class="bodytxbold">
					Diagnosis
				</TD>
				<TD align="left">

					<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;
					<INPUT name="tumorClassification" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />
					<input type="hidden" name="diagnosisName" />
					<input type="hidden" name="diagnosisCode" />
				</TD>
			</TR>



			<tr>
				<td ALIGN=CENTER COLSPAN="2">
					<input TYPE="submit" NAME="select_annotation_type" VALUE="Search">
					&nbsp;&nbsp;
					<input TYPE=RESET VALUE="  Clear   " tabindex="4">
				</td>
			</tr>
		</table>
	</center>
	<p>
</form>

<%@ include file="html/simple_search2.htm"%>
</body>

</html>
