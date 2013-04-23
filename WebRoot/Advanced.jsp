<%--L
  Copyright SAIC

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
}
</script>

<%@ page language="java"%>
<%@ page import="gov.nih.nci.caimage.db.*"%>
<%@ page import="gov.nih.nci.caIMAGE.*"%>
<%@ page import="gov.nih.nci.caIMAGE.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.net.URLEncoder"%>

<%request.getSession(true);%>


<%// constructor class
			Annotations annot = new Annotations();
			Species sp = new Species();
			Stain st = new Stain();
			Image_characteristic ic = new Image_characteristic();
			Login log = new Login();
			Strain str = new Strain();
			Gender gen = new Gender();
			Publication_journal pj = new Publication_journal();
			Publication pub = new Publication();

			%>

<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/search_images_adv.htm"%>
<form name="main" method="POST" action="Advancedresults.jsp?q=0">
	<center>
		<table BORDER=0 WIDTH="100%">

			<TR align="left" valign="top">
				<TD colspan="3" align="center" class="tophder">
					<font style="font-family: Verdana, Arial, Helvetica, sans-serif;" color="#ffffff"> Image</font>
				</TD>

			</TR>

			<TR ALIGN=LEFT VALIGN=TOP>
				<td ALIGN=left class="bodytxbold">
					Image Name / Number
				</td>
				<td ALIGN=LEFT>
					<input type=TEXT NAME=imagename>
				</td>
			</TR>


			<!--add search for image description, if not too complicated-->
			<TR ALIGN=LEFT VALIGN=TOP>
				<td ALIGN=left class="bodytxbold">
					Staining
				</td>
				<td ALIGN=LEFT>
					<SELECT NAME="stain">
						<option value="">
						</option>
						<%Vector stain = st
					.retrieveAllWhere("stain_name IS NOT NULL ORDER BY stain_description");
			for (int j = 0; j < stain.size(); j++) {
				Stain St = (Stain) stain.elementAt(j);
				if (St.getStain_id() != null) {%>
						<option value="<%=URLEncoder.encode(St.getStain_id().toString())%>">
							<%=St.getStain_description()%>
						</option>
						<%}
			}%>
					</select>
				</td>
			</TR>

			<TR align="left" valign="top">
				<TD colspan="3" align="center" class="tophder">
					<font style="font-family: Verdana, Arial, Helvetica, sans-serif;" color="#ffffff"> Specimen</font>
				</TD>

			</TR>
			<tr ALIGN=left VALIGN=TOP>
				<td class="bodytxbold">
					Species
				</td>

				<td ALIGN=left>
					<SELECT NAME="species" size=1>
						<option value=""></option>


						<%Vector species = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");%>

						<%for (int j = 0; j < species.size(); j++) {
				Species speciesTab = (Species) species.elementAt(j);
				if (speciesTab.getSpecies_id() != null) {%>
						<option value="<%=speciesTab.getSpecies_name()%>" <%=Selection.setSelected(String.valueOf(speciesTab.getSpecies_id()),speciesTab.getSpecies_name())%>>
							<%=speciesTab.getSpecies_name()%>
						</option>
						<%}
			}

			%>

					</select>
					<p>
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
			<TR ALIGN=LEFT VALIGN=TOP>
				<td ALIGN=left class="bodytxbold">
					Gender
				</td>
				<td ALIGN=LEFT>
					<SELECT NAME="gender" size=1>
						<option value="">
						</option>
						<%Vector gender = gen
					.retrieveAllWhere("gender_name IS NOT NULL ORDER BY gender_name");
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
				</td>
			</TR>



			<TR ALIGN=LEFT VALIGN=TOP>
				<td ALIGN=left class="bodytxbold">
					Mouse Strain
				</td>
				<td ALIGN=LEFT>
					<SELECT NAME="strain" size=1>
						<option value="">
						</option>
						<%Vector strain = str
					.retrieveAllWhere("strain_name IS NOT NULL ORDER BY strain_name");
			for (int j = 0; j < strain.size(); j++) {
				Strain Str = (Strain) strain.elementAt(j);
				if (Str.getStrain_id() != null) {%>
						<option value="<%=URLEncoder.encode(Str.getStrain_id().toString())%>">
							<%=Str.getStrain_name()%>
						</option>
						<%}

			}

			%>

					</select>
				</td>
			</TR>
			<!--add search for promoter and gene, if not too complicated; we can also add this in the next release; you decide-->
			<!--- TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold">Promoter</td>
	<td ALIGN=LEFT><input type="text" name="promoter" size="15">
	</td>
</TR>	
<TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold">Gene</td>
	<td ALIGN=LEFT><input type="text" name="gene" size="15">
	</td>
</TR>	 --->
			<TR align="left" valign="top">
				<TD colspan="3" align="center" class="tophder">
					<font style="font-family: Verdana, Arial, Helvetica, sans-serif;" color="#ffffff"> Submitter</font>
				</TD>

			</TR>
			<%Vector login = log
					.retrieveAllWhere("loginuid is not null order by pi_name");

			%>

			<TR ALIGN=LEFT VALIGN=TOP>
				<td ALIGN=left class="bodytxbold">
					PI's Name
				</td>

				<td ALIGN=LEFT>
					<SELECT NAME="donator" size=1>
						<option value="">
						</option>
						<%for (int j = 0; j < login.size(); j++) {
				Login LogIn = (Login) login.elementAt(j);
				if (LogIn.getLoginuid() != null) {
					if (LogIn.getPi_name() != null) {

						Vector v = annot
								.retrieveByANNOTATIONS__DONATOR_ID(LogIn
										.getLoginuid());
						if (v.size() != 0) {%>
						<option value="<%=LogIn.getLoginuid()%>">
							<%=LogIn.getPi_name()%>
						</option>
						<%}//if
					}//if
				}//if

			}//for

			%>

					</select>
					<p>
				</td>
			</TR>

			<TR ALIGN=LEFT VALIGN=TOP>
				<td ALIGN=left class="bodytxbold">
					Institute
				</td>

				<td ALIGN=LEFT>
					<SELECT NAME="donator_Institution" size=1>
						<option value="">
						</option>
						<%Hashtable v1 = new Hashtable();
			for (int j = 0; j < login.size(); j++) {
				Login LogIn = (Login) login.elementAt(j);

				if (LogIn.getLoginuid() != null) {
					if (LogIn.getInstitute() != null) {

						Vector v = annot
								.retrieveByANNOTATIONS__DONATOR_ID(LogIn
										.getLoginuid());

						if (v.size() != 0) {
							v1.put(LogIn.getInstitute(), LogIn.getInstitute());
						}//if
					}//if
				}//if
			}//for

			Enumeration enumKey = v1.keys();
			while (enumKey.hasMoreElements()) {
				String donating_inst = enumKey.nextElement().toString();
				if (donating_inst != null) {%>
						<option value="<%=donating_inst%>">
							<%=donating_inst%>
						</option>
						<%}
			}
			v1.clear();

		%>
					</select>
					<p>
				</td>
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
