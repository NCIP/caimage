<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>

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
leafNode=true;
var fieldToBlank = new Array();
fieldToBlank[0]="tumorClassification";
fieldToBlank[1]="diagnosisName";
fieldToBlank[2]="diagnosisCode";

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
		showTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, fieldToBlank);
		}
}else if ((speciesValue== "human") || (speciesValue == "Human")) {
		if(diagnosisDisplayValue.length == 0) {
		showHumanTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode)
		}
		else {
		showHumanTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, fieldToBlank);
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
	if(organvalue){
		if ((speciesValue== "") || (speciesValue == null)|| (speciesValue== "Mouse")) {
		//temporarily hard coded till the EVS tree resolved
		 organvalue = 'Mouse_Disorder_by_Site'; 
			if (organvalue){
		  	showDiagnosisTree(form, conceptCode, conceptName, displayName, leafNode, organvalue)
		  	} 
	 	}else if ((speciesValue== "human") || (speciesValue == "Human")) {
	 	organvalue = 'Disorder_by_Site';
	 	showHumanDiagnosisTree(form, conceptCode, conceptName, displayName, leafNode, organvalue)
		} 
		else {
		alert('No Diagnosis Tree available for ' + speciesValue );
		}
	}else {
	alert('Please select the organ value first');
	}
}
function check_otherstain(choice)
{
 if(document.main.stain.value == "0")
  {
  //document.write("choice is"+choice);
   choice.readOnly=false;
  }
  else
   {
   //document.write("choice is"+choice);
    choice.readOnly=true;
    choice.value="";
   }
}
function check_otherstrain(choice)
{
 if(document.main.strain.value == "0")
  {
  //document.write("choice is"+choice);
   choice.readOnly=false;
  }
  else
   {
   //document.write("choice is"+choice);
    choice.readOnly=true;
    choice.value="";
   }
}
</script>

<%@ page language="java"%>
<%@ page import="gov.nih.nci.caimage.db.*"%>
<%@ page import="gov.nih.nci.caIMAGE.*"%>
<%@ page import="gov.nih.nci.caIMAGE.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.net.URLEncoder"%>

<%request.getSession(false);%>

<%SessionManager.verifySession(request, response, "Error.jsp");
			// constructor class
			Species sp = new Species();
			Stain st = new Stain();
			Image_characteristic ic = new Image_characteristic();
			Strain str = new Strain();
			Gender gen = new Gender();
			Publication_journal pj = new Publication_journal();
			Publication pub = new Publication();
			Observation obj = new Observation();
			Journal jour = new Journal();
			Catalog cat = new Catalog();

			%>


<%@ include file="html/submit_images_top.htm"%>

<form name="main" method="POST" ENCTYPE="multipart/form-data" action="caimageSubmitResults.jsp">

	<br>
	<TR>
		<TD class="bluhderslrg" colspan="3" align="center" valign="bottom">
			Image Submission
		</TD>
	</TR>
	<tr>
		<td class="bodytxrequ" align="right" colspan="3">
			* required field
		</td>
	</tr>
	<TR align="left" valign="top">
		<TD colspan="3" align="center" class="tophder">
			<font color="#FFFFFF">Specimen</font>
		</TD>

	</TR>
	<TR align="left" valign="top">
		<td width="30">
			&nbsp;
		</td>
		<TD class="bodytxrequ">
			Species*
		</TD>
		<TD>
			<SELECT NAME="species" size=1>
				<option value=""></option>
				<%
			Vector species = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");%>

				<%for (int j = 0; j < species.size(); j++) {
				Species speciesTab = (Species) species.elementAt(j);
				if (speciesTab.getSpecies_id() != null) {
					if (speciesTab.getSpecies_name().equalsIgnoreCase("mouse")
							|| speciesTab.getSpecies_name().equalsIgnoreCase(
									"human")) {

						%>

				<option value="<%=speciesTab.getSpecies_name()%>">
					<%=speciesTab.getSpecies_name()%>
				</option>
				<%}
			
				}
			}//for	

			%>
			</select>
		</TD>
	</TR>
	<TR id="OrganSelect" align="left" valign="TOP">
		<td>
			&nbsp;
		</td>
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
		<td>
			&nbsp;
		</td>
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

	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytxbold">
			Gender
		</TD>
		<TD>
			<SELECT NAME="gender" size=1>
				<option value="">
				</option>
				<%
			Vector gender = gen.retrieveAllWhere("gender_name IS NOT NULL ORDER BY gender_name");
			for (int j = 0; j < gender.size(); j++) {
				Gender Gen = (Gender) gender.elementAt(j);
				if (Gen.getGender_id() != null) {%>
				<option value="<%=URLEncoder.encode(Gen.getGender_id().toString())%>">
					<%=Gen.getGender_name()%>
				</option>
				<%}
				
			}

			%>

			</select>
			<p>
		</TD>
	</TR>
	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytxbold">
			Mouse Strain
		</TD>
		<TD>
			<SELECT NAME="strain" size=1 onChange="check_otherstrain(main.Otherstrain)">
				<option value="">
				</option>
				<option value="0">
					Other
				</option>
				<%Vector strain = str
					.retrieveAllWhere("strain_name IS NOT NULL ORDER BY strain_name");
			for (int j = 0; j < strain.size(); j++) {
				Strain Str = (Strain) strain.elementAt(j);
				if (Str.getStrain_id() != null) {

					if (Str.getStrain_name().equals("Other")) {
						System.out.println("I reached here");%>
				<option value="<%=URLEncoder.encode(Str.getStrain_id().toString())%>">
					<%=Str.getStrain_name()%>
				</option>
				<%} else {%>
				<option value="<%=URLEncoder.encode(Str.getStrain_id().toString())%>">
					<%=Str.getStrain_name()%>
				</option>
				<%}
				}
		
			}

			%>

			</select>
		</TD>
	</TR>

	<tr align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<td class="bodytxbold">
			If Other Strain
		</td>
		<TD>
			<input type="Text" size="40" name="Otherstrain" value=""?" readonly ":"">
		</TD>
	</tr>
	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytext">
			<b>Promoter</b>
			<br>
			(for genetically engineered Models only)
		</TD>
		<TD>
			<INPUT TYPE="Text" ALIGN=left NAME="promoter">
		
		</TD>
	</TR>
	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytext">
			<b>Gene</b>
			<br>
			(for genetically engineered Models only)</font>
		</TD>
		<TD>
			<INPUT TYPE="Text" ALIGN=left NAME="gene">
	
		</TD>
	</TR>
	<TR align="left" valign="top">
		<TD align="center" colspan="3" class="tophder">
			<font color="#FFFFFF">Publication</font>
		</TD>

	</TR>
	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytext">
			<b>PMID</b>
			<br>
			(PubMed Identifier)
		</TD>
		<TD valign="top">

			<input type="text" name="PMID" size="25" maxlength="30">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a name="Pubmed" id="Pubmed" href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?CMD=&DB=PubMed" target="_blank"><img src="images/pubmed_70.gif" alt="Open PubMed Browser" width="70" height="24" border="1"></a>
		

		</TD>
	</TR>



	<TR align="left" valign="top">
		<TD colspan="3" class="tophder" align="center">
			<font color="#FFFFFF">Image</font>
		</TD>

	</TR>
	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytxbold">
			Image Modality
		</TD>
		<TD>
			<select name="modality" size="1">
				<option value="Histology">
					Histology
			</select>
		</TD>
	</TR>
	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytxrequ">
			Image Name*
		</TD>
		<TD>
			<INPUT align="center" name="imagetitle" size="25" maxlength="255">

		</TD>
	</TR>
	<TR align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<TD class="bodytxbold">
			Image Description
		</TD>
		<TD>
			<TEXTAREA name="imagedesc" cols="30" rows="5"></TEXTAREA>
	
		</TD>
	</TR>
	<tr>
		<td>
			&nbsp;
		</td>
		<td class="bodytxbold">
			Staining
		</td>
		<td>
			<SELECT NAME="stain" onChange="check_otherstain(main.Other)">
				<option value="">
				</option>
				<option value="0">
					Other
				</option>

				<%Vector stain = st
					.retrieveAllWhere("stain_name IS NOT NULL ORDER BY stain_name");
			for (int j = 0; j < stain.size(); j++) {
				Stain St = (Stain) stain.elementAt(j);
				if (St.getStain_id() != null) {%>
				<option value="<%=URLEncoder.encode(St.getStain_id().toString())%>">
					<%=St.getStain_description()%>
				</option>
				<%}
	
			}

		%>
			</select>
		</td>
	</tr>
	<tr align="left" valign="top">
		<td>
			&nbsp;
		</td>
		<td class="bodytxbold">
			If Other Staining
		</td>
		<TD>
			<input type="Text" size="40" name="Other" value=""?" readonly ":"">
		</TD>
	</tr>
	<tr>
		<td>
			&nbsp;
		</td>
		<td class="bodytxrequ">
			Image Upload*
		</td>
		<td>
			<INPUT type="file" name="myUploadObject" multiple>
		</td>
	</tr>
	<tr>
		<td colspan="3" align="center">
			<INPUT onClick="alert('save: ' + document.form1.myUploadObject.value)" type="submit" value="Submit" name="select_annotation_type">
			&nbsp;&nbsp;
			<INPUT onClick="alert('reset: ' + document.form1.myUploadObject.value)" tabindex="4" type="reset" value="  Clear   ">
		</td>
	</tr>

	</TABLE>


</FORM>

<%@ include file="html/edit_bot.htm"%>


</body>
</html>

