<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See https://github.com/NCIP/caimage/LICENSE.txt for details.
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
if(document.main.tumorClassification){
diagnosisDisplayValue = document.main.tumorClassification.value;
}
//alert(diagnosisDisplayValue)
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
var organSelectedValue = document.main.organ.value;
if(organSelectedValue){
form = document.forms[0];
form = form.name;
	if(document.main.tumorClassification){
	inDisplayName = document.main.tumorClassification.name;
	}
conceptName = document.main.diagnosisName.name;
conceptCode = document.main.diagnosisCode.name;
//leafNode=true;
	if ((speciesValue== "") || (speciesValue == null)|| (speciesValue== "Mouse")) {
	//temporarily hard coded till the EVS tree resolved
	 organvalue = 'Mouse_Disorder_by_Site'; 
		if (organvalue){
	  	showDiagnosisTree(form, conceptCode, conceptName, inDisplayName, leafNode, organvalue)
	  	} 
 	}else if ((speciesValue== "human") || (speciesValue == "Human")) {
 	organvalue = 'Disorder_by_Site';
 	showHumanDiagnosisTree(form, conceptCode, conceptName, inDisplayName, leafNode, organvalue)
	} 
	else {
	alert('No Diagnosis Tree available for ' + speciesValue );
	}
}//if organ selected value
else {
alert('Please select the organ Value')
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
<%@ page import="com.apelon.dts.client.Concept"%>

<%@ page import="javax.servlet.ServletException"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="gov.nih.nci.evs.query.*"%>
<%@ page import="gov.nih.nci.evs.domain.*"%>
<%@ page import="gov.nih.nci.system.applicationservice.*"%>

<%@ page import="javax.swing.tree.*"%>
<%@ page import="gov.nih.nci.evs.domain.DescLogicConcept"%>
<%@ page import="gov.nih.nci.common.net.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%request.getSession(true);
			Logger logger = Logger.getLogger(simpleandfile.class);%>

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
			Annotations annot = new Annotations();

			String id = request.getParameter("id");
			String mode = request.getParameter("mode");
			boolean status = annot.retrieveByKey(new Long(id));

			if (status) {

				EVSQuery evsQuery = new EVSQueryImpl();

				%>

<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/submit_images_top.htm"%>
<%System.err.println("*************I am in caimageEdit.jsp****************");
				ApplicationService appService = null;

				InputStream in = null;
				Properties sysProps = new Properties();
				try {
					in = Thread.currentThread().getContextClassLoader()
							.getResourceAsStream("system.properties");
					sysProps.load(in);
				} catch (Exception e) {
					System.err.println("Error loading system.properties file");
					e.printStackTrace();
				}
				try {

					String qa = sysProps.getProperty("qaserver");
					appService = ApplicationService.getRemoteInstance(qa);
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				if (mode.equals("edit")) {%>
<form name="main" method="POST" ENCTYPE="multipart/form-data" action="caimageEditData.jsp?id=<%=id%>&mode=<%=mode%>">
	<%} else {%>
	<form name="main" method="POST" ENCTYPE="multipart/form-data" action="caimageEditSubmitResults.jsp?id=<%=id%>&mode=<%=mode%>">
		<%}%>


		<br>
		<TR>
			<TD class="bluhderslrg" colspan="3" align="center" valign="bottom">
				Image Editing
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

					<%Vector species = sp
						.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");

				for (int j = 0; j < species.size(); j++) {
					Species speciesTab = (Species) species.elementAt(j);

					if (speciesTab.getSpecies_id()
							.equals(annot.getSpecies_id())) {

						%>
					<option value="<%=speciesTab.getSpecies_name()%>" selected>
						<%=speciesTab.getSpecies_name()%>
					</option>
					<%} else {

						%>
					<option value="<%=speciesTab.getSpecies_name()%>">
						<%=speciesTab.getSpecies_name()%>
					</option>
					<%}//else
				}//for

				%>

				</select>
			</TD>
		</TR>

		<TR id="OrganSelect" valign="TOP">
			<td>
				&nbsp;
			</td>
			<TD id="OrganSelect" class="bodytxrequ">
				Organ / Tissue*
			</TD>
			<TD align="left">
				<%Vector vorgan = null;
				Image_organ Org = null;
				String organname = null;
				vorgan = ImageOrganDiagnosis.imageOrgan(new Long(id));

				for (int k = 0; k < vorgan.size(); k++) {
					Org = (Image_organ) vorgan.elementAt(k);

					organname = Org.getOrgan();
				}
				String conceptcode = "C" + organname;
				String myConcept = null;
				evsQuery.getConceptNameByCode("NCI_Thesaurus", conceptcode);

				java.util.List evsResults = (java.util.List) appService
						.evsSearch(evsQuery);
				if (evsResults.size() > 0) {

					myConcept = (String) evsResults.get(0);

				}

				if (myConcept != null) {

					%>
				<a href="javascript:selection()"><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;
				<INPUT name="organ" value="<%=myConcept%>" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />
				<%} else {%>
				<a href="javascript:selection()"><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;
				<INPUT name="organ" value="" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />
				<%}%>
				<INPUT name="organTissueName" type="hidden" />
				<%if (organname != null) {

					%>
				<INPUT name="organTissueCode" value="<%=organname%>" type="hidden" />
				<%} else {

				%>
				<INPUT name="organTissueCode" value="" type="hidden" />
				<%}%>
			</TD>
		</TR>
		<TR align="left" valign="top">
			<td>
				&nbsp;
			</td>
			<TD id="DiagnosisSelect" class="bodytxbold">
				Diagnosis
			</TD>
			<TD>
				<%Vector vdiagnosis = null;
				Image_diagnosis Dig = null;
				String diagnosis = null;
				vdiagnosis = ImageOrganDiagnosis.imageDiagnosis(new Long(id));

				for (int k = 0; k < vdiagnosis.size(); k++) {
					Dig = (Image_diagnosis) vdiagnosis.elementAt(k);

					diagnosis = Dig.getDiagnosis();

				}
				String myConceptDigCode = "C" + diagnosis;
				String myConceptdig = null;
				if (diagnosis != null) {

					if (myConceptDigCode != null) {
						evsQuery.getConceptNameByCode("NCI_Thesaurus",
								myConceptDigCode);

						evsResults = (java.util.List) appService
								.evsSearch(evsQuery);
						if (evsResults.size() > 0) {

							myConceptdig = (String) evsResults.get(0);

						}
					}

					if ((myConceptdig == null) && !(diagnosis.equals("000000"))) {%>
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;
				<INPUT name="tumorClassification" value="" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />
				<input type="hidden" name="diagnosisCode" />
				<input type="hidden" name="diagnosisName" />
				<%}

					if (myConceptdig != null) {

						%>
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;
				<INPUT name="tumorClassification" value="<%=myConceptdig%>" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />
				<input type="hidden" name="diagnosisCode" />
				<input type="hidden" name="diagnosisName" />
				<%} else {
						if (diagnosis.equals("000000")) {
							String diagnosis_desc = Dig
									.getTumor_classification();

							%>
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;

				<INPUT name="tumorClassification" value="<%=diagnosis%> " type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />
				<input type="hidden" name="diagnosisCode" />
				<input type="hidden" name="diagnosisName" />
				<%}
					}
				}//diagnosis is not null checking
				else {

					%>
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0" /></a>&nbsp;
				<INPUT name="tumorClassification" value="<%=myConceptdig%>" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255" />
				<input type="hidden" name="diagnosisCode" />
				<input type="hidden" name="diagnosisName" />
				<%}

				%>
				<br>

			</TD>
		</TR>

		<TR align="left" valign="top">
			<td>
				&nbsp;
			</td>
			<TD class="bodytxbold">
				Gender
			</TD>
			<td ALIGN=LEFT>
				<SELECT NAME="gender" size=1>
					<option value="">
					</option>
					<%Vector gender = gen
						.retrieveAllWhere("gender_name IS NOT NULL ORDER BY gender_name");
				for (int j = 0; j < gender.size(); j++) {
					Gender Gen = (Gender) gender.elementAt(j);
					if (annot.getGender_id() != null) {
						if (Gen.getGender_id().equals(annot.getGender_id())) {%>
					<option value="<%=Gen.getGender_id().toString()%>" selected>
						<%=Gen.getGender_name()%>
					</option>
					<%} else {%>
					<option value="<%=Gen.getGender_id().toString()%>">
						<%=Gen.getGender_name()%>
					</option>
					<%}

					%>
					<%} else {%>
					<option value="<%=Gen.getGender_id().toString()%>">
						<%=Gen.getGender_name()%>
					</option>
					<%}
				}

				%>

				</select>
				<p>
			</td>

		</TR>

		<TR align="left" valign="top">
			<td>
				&nbsp;
			</td>
			<TD class="bodytxbold">
				Mouse Strain
			</TD>
			<td ALIGN=LEFT>
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
					if (annot.getStrain_id() != null) {
						if (Str.getStrain_id().equals(annot.getStrain_id())) {%>
					<option value="<%=URLEncoder.encode(Str.getStrain_id().toString())%>" selected>
						<%=Str.getStrain_name()%>
					</option>
					<%} else {%>
					<option value="<%=URLEncoder.encode(Str.getStrain_id().toString())%>">
						<%=Str.getStrain_name()%>
					</option>
					<%}

					} else {

						%>
					<option value="<%=URLEncoder.encode(Str.getStrain_id().toString())%>">
						<%=Str.getStrain_name()%>
					</option>
					<%}
				}%>
				</select>
			</td>
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
				<INPUT TYPE="Text" ALIGN=left NAME="promoter" <%if(annot.getPromoter()!=null){ %> value=<%=annot.getPromoter().trim()%> <%} else{ %> value="" <%}%>>

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
				<INPUT TYPE="Text" ALIGN=left NAME="gene" <%if(annot.getGene()!=null){ %> value=<%=annot.getGene().trim()%> <%} else{ %> value="" <%}%>>
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

				<%pub.retrieveByKey(annot.getPublication_id());

				if (annot.getPublication_id() != null) {%>
				<INPUT TYPE ALIGN=center NAME="PMID" Value=<%=pub.getPublication_name()%>>
				<%} else {%>
				<INPUT TYPE ALIGN=center NAME="PMID" Value=<%=""%>>
				<%}%>

				<a name="Pubmed" id="Pubmed" href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?CMD=&DB=PubMed" target="_blank"><img src="images/pubmed_70.gif" alt="Open PubMed Browser" width="70" height="24" border="1"></a>


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
			<TD class="bodytxbold">
				Image Title
			</TD>
			<td>

				<TEXTAREA TYPE ALIGN=center NAME="imagedesc" ROWS=2 COLS=30 WRAP> <%=annot.getImage_description()%>
				</TEXTAREA>
			</td>
		</TR>
		<TR align="left" valign="top">
			<td>
				&nbsp;
			</td>
			<TD class="bodytxbold">
				Image Description
			</TD>
			<td>

				<%if (annot.getImage_annotations() != null) {

					%>
				<TEXTAREA NAME="imageannot" ROWS=5 COLS=30 WRAP>
					<%=annot.getImage_annotations()%>
				</TEXTAREA>
				<%} else {

				%>
				<TEXTAREA NAME="imageannot" ROWS=5 COLS=30></TEXTAREA>
				<%}%>
			</td>
		</TR>
		<tr>
			<td>
				&nbsp;
			</td>
			<td class="bodytxbold">
				Staining
			</td>
			<td ALIGN=LEFT>
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
					if (annot.getStain_id() != null) {
						if (St.getStain_id().equals(annot.getStain_id())) {%>
					<option value="<%=URLEncoder.encode(St.getStain_id().toString())%>" selected>
						<%=St.getStain_description()%>
					</option>
					<%} else {%>
					<option value="<%=URLEncoder.encode(St.getStain_id().toString())%>">
						<%=St.getStain_description()%>
					</option>
					<%}
					} else {%>
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
			<%if (mode.equals("clone") || mode.equals("")) {

					%>
			<td>
				&nbsp;
			</td>
			<td class="bodytxrequ">
				Image Upload*
			</td>
			<td ALIGN=left>
				<INPUT TYPE="FILE" NAME="myUploadObject" MULTIPLE>
			</td>
			<td ALIGN=left>
				<%String lizard = sysProps.getProperty("lizard");
					String imagepath = lizard + "/iserv/getthumb?cat=";

					cat.retrieveByKey(annot.getCatalog_id());

					%>
				<%if (!annot.getImage_name().equals("No Image")) {

						%>
				<img src="<%=imagepath%><%=DatabaseSetup.checkForNull(cat.getCatalog_directory().trim())%>&img=<%=DatabaseSetup.checkForNull(annot.getImage_name().trim())%>&thumbspec=" main"  alt="<%=DatabaseSetup.checkForNull(annot.getImage_name())%>" border="0"
					target="_blank">
				</a>
				<br>
				<%}%>
			</td>
			<%} else {
					//System.out.println("I am in else loop submit" + mode + id);
				}%>

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

	<%@ include file="html/simple_search2.htm"%>
	</body>
	<%} else {%>
	<center>
		<H1>
			Record
			<%=id%>
			not found!
		</h1>
	</center>
	<%}%>
	</html>