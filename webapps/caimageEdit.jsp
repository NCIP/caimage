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
<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %>   
<%@ page import = "java.lang.*"  %>
<%@ page import = "java.net.URLEncoder"  %>
<%@ page import = "com.apelon.dts.client.Concept" %>
<%@ page import = "gov.nih.nci.ncicb.evs.*" %>
<%@ page import = "javax.servlet.ServletException"%>
<%  request.getSession(true);%>

<%
SessionManager.verifySession(request,response,"Error.jsp");
// constructor class
Species sp = new Species();
Stain st = new Stain();
Concept_mapping cm  = new Concept_mapping();
Image_characteristic ic = new Image_characteristic() ;
Model mod = new Model();
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
boolean status = annot.retrieveByKey(new Long(id) );
System.out.println("The id is"+id);
 if(status){
 EvsUtil myEvs = new EvsUtil("evs.properties");
%>
 
 <link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/submit_images_top.htm"%>
<%
//String mode = request.getParameter("mode");
System.out.println(mode);
//String id = request.getParameter("id");
System.out.println(id);
if (mode.equals("edit") ) {
System.out.println("I am in if loop Edit data"+mode+id);
//response.sendRedirect("caimageEditData.jsp?id="+id+"&mode="+mode);%>
<form name="main" method="POST" ENCTYPE ="multipart/form-data" action="caimageEditData.jsp?id=<%=id%>&mode=<%=mode%>"  >
<%} else { 
System.out.println("I am in else loop submit"+mode+id);
//response.sendRedirect("caimageEditSubmitResults_1.jsp?id="+id+"&mode="+mode);%>
<form name="main" method="POST" ENCTYPE ="multipart/form-data" action="caimageEditSubmitResults.jsp?id=<%=id%>&mode=<%=mode%>"  >
<%}%>


<br>
		<TR>
			<TD  class="bluhderslrg" colspan="3" align="center" valign="bottom">Image Editing
			</TD>
		</TR>
		<tr><td class="bodytxrequ" align="right" colspan="3">* required field</td></tr>
		<TR align="left" valign="top">
			<TD colspan="3" align="center" class="tophder"><font color="#FFFFFF">Specimen</font></TD>
			
		</TR>
		<TR align="left" valign="top">
			<td width="30">&nbsp;</td>
			<TD class="bodytxrequ">Species*
			</TD>
			<TD>
				<SELECT NAME="species" size=1 >
<option value =""></option>	
 
 <% 
 System.out.println("the get value is"+sp);
Vector species   = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");
 System.out.println("the species selected value is"+annot.getSpecies_id() );

for(int j =0; j <species.size(); j++){
		Species speciesTab = (Species) species.elementAt(j);
		System.out.println(" for loop  "+speciesTab.getSpecies_id()+speciesTab.getSpecies_name()+annot.getSpecies_id());
		if (speciesTab.getSpecies_id().equals(annot.getSpecies_id()) ) { 
		System.out.println("if  "+speciesTab.getSpecies_id()+speciesTab.getSpecies_name());%>
			<option  value="<%=speciesTab.getSpecies_name()%>" selected ><%=speciesTab.getSpecies_name()%></option>
			<%} else {
			System.out.println("else  "+speciesTab.getSpecies_id()+speciesTab.getSpecies_name());%>
			<option  value="<%=speciesTab.getSpecies_name()%>" ><%=speciesTab.getSpecies_name()%></option>
			<%}//else
	}//for
System.out.println("I am at the endof species");
%>
		
</select>
			</TD>
		</TR>
		
		<TR id="OrganSelect"  valign="TOP">
			<td>&nbsp;</td>
			<TD id="OrganSelect" class="bodytxrequ">Organ / Tissue*</TD>
			<TD align="left" >
  		 <% Concept myConcept = myEvs.getConceptByCode("C"+annot.getOrgan());
			if(myConcept!=null) { %>
			  <a href="javascript:abc()"><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;
			  <INPUT name="organ" value="<%=myConcept.getName()%>" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/>
			<%} else{%>
			  <a href="javascript:abc()"><img name="browse" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;
			  <INPUT name="organ" value="" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/>
			<%}%>	
			<INPUT name="organTissueName" type="hidden"/>
			<%
		 	if(annot.getOrgan()!= null) { %>
			<INPUT name="organTissueCode" value="<%=annot.getOrgan()%>" type="hidden"/>
			<%} else{ %>
			<INPUT name="organTissueCode" value="" type="hidden"/>
			<%}%>
			</TD>
		</TR>	
		
		
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD id="DiagnosisSelect" class="bodytxbold">Diagnosis
			</TD>
			<TD>
		  <% Concept myConceptdig = myEvs.getConceptByCode("C"+annot.getConcept_id());
			if(myConceptdig!=null) { %>
			<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;
			<INPUT name="TumorClassification" value="<%=myConceptdig.getName()%>" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
			<%} else{%>
			<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;
			<INPUT name="TumorClassification" value="" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
			<%}%>	
			<input type="hidden" name="DiagnosisName"/>        
		    <%if(annot.getConcept_id()!=null){%>
			<input type="hidden" name="DiagnosisCode" value="<%=annot.getConcept_id()%>"/>
			<%} else{%>
			<input type="hidden" name="DiagnosisCode" value=""/>
			<%}%>
			</TD>
		</TR>						
    
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytxbold">Gender
			</TD>
			<td ALIGN=LEFT>	<SELECT NAME="gender"  size=1  >
			<option value =""> </option>
			<%
			System.out.println(" I am in gender");
			Vector gender   = gen.retrieveAllWhere("gender_name IS NOT NULL ORDER BY gender_name");
			for(int j =0; j < gender.size(); j++){
					System.out.println(" I am in gender"+gender.size());
					Gender Gen = (Gender) gender.elementAt(j);
					System.out.println(" gender id"+Gen.getGender_id() );
					if(annot.getGender_id()!=null){
						if(Gen.getGender_id().equals(annot.getGender_id()) ){%>
						<option value= "<%=Gen.getGender_id().toString()%>"selected><%=Gen.getGender_name()%> </option>
						<%} else {%>
							<option value= "<%=Gen.getGender_id().toString()%>" ><%=Gen.getGender_name()%> </option>				
						<%}	%>
					<%	System.out.println("gender name:"+Gen.getGender_name()); 
					} else	{%>
								<option value= "<%=Gen.getGender_id().toString()%>" ><%=Gen.getGender_name()%> </option>				
					<%		}
				}
			System.out.println("I am at the endof gender");
			%>	
			
			</select><p></td>
			
		</TR>
		
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytxbold">Mouse Strain
			</TD>
			<td ALIGN=LEFT>	<SELECT NAME="strain"  size=1 onChange="check_otherstrain(main.Otherstrain)"  >
			<option value =""> </option>
			<option value= "0">Other</option>
			<%
			Vector strain   = str.retrieveAllWhere("strain_name IS NOT NULL ORDER BY strain_name");
			for(int j =0; j < strain.size(); j++){
				Strain Str = (Strain) strain.elementAt(j);
				System.out.println("strain id from annotation:"+ annot.getStrain_id() ); 
				if(annot.getStrain_id()!=null){
					if(Str.getStrain_id().equals(annot.getStrain_id() ) ){%>
					<option value= "<%=URLEncoder.encode(Str.getStrain_id().toString())%>" selected ><%=Str.getStrain_name()%> </option>
					<%} else{%>
					<option value= "<%=URLEncoder.encode(Str.getStrain_id().toString())%>"><%=Str.getStrain_name()%> </option>
						<%} 
						System.out.println("strain:"+Str.getStrain_name()+Str.getStrain_id()  ); 
				}else { %>
				<option value= "<%=URLEncoder.encode(Str.getStrain_id().toString())%>" ><%=Str.getStrain_name()%> </option>
				<%}
			}%>	
			</select></td>
		</TR>
		<tr align="left" valign="top">
			<td>&nbsp;</td>
			<td class="bodytxbold">If Other Strain</td>
 			<TD><input type="Text" size="40" name="Otherstrain" value="" ?" readonly ":"">	
	 		</TD>
		</tr> 
		
		
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytext" ><b>Promoter</b><br> (for genetically engineered Models only)
			</TD>
			<TD>
			<INPUT TYPE="Text" ALIGN=left NAME="promoter" 
				<%if(annot.getPromoter()!=null){ %>
		 		value = <%=annot.getPromoter().trim()%>
		 		<%} else{ %>
		 	value = ""
		 	<%}%>  > 
			
			</TD>
		</TR>
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytext"><b>Gene</b><br>(for genetically engineered Models only)</font>
			</TD>
			<TD>
			<INPUT TYPE="Text" ALIGN=left NAME="gene" 
				<%if(annot.getGene()!=null){ %>
		 		value = <%=annot.getGene().trim()%>
		 		<%} else{ %>
		 		value = ""
		 	<%}%>  > 
			</TD>
		</TR>
		<TR align="left" valign="top">
			<TD align="center" colspan="3"  class="tophder" ><font color="#FFFFFF">Publication</font>
			</TD>
			
		</TR>
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytext"><b>PMID</b> <br>(PubMed Identifier)
			</TD>
			<TD valign="top">
			
			<%
				pub.retrieveByKey(annot.getPublication_id() );
				System.out.println("publication number  "+pub.getPublication_id() );
				System.out.println("publication name  "+ pub.getPublication_name() );
				if(annot.getPublication_id()!= null ) {%>	
				<INPUT TYPE ALIGN=center NAME="PMID"  Value = <%=pub.getPublication_name()%>  >
				<%}else{%>
				<INPUT TYPE ALIGN=center NAME="PMID"  Value = <%=""%>  >
				<%}%>
		
			<a name="Pubmed" id="Pubmed" href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?CMD=&DB=PubMed" target="_blank"><img src="images/pubmed_70.gif" alt="Open PubMed Browser" width="70" height="24" border="1"></a>
			<%System.out.println("publication name  "+request.getParameter("PMID"));%>	
	
			</TD>
		</TR>
		
		
		
		<TR align="left" valign="top">
			<TD colspan="3" class="tophder" align="center"><font color="#FFFFFF">Image</font>
			</TD>
			
		</TR>
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytxbold">Image Modality
			</TD>
			<TD><select name="modality" size="1"><option value="Histology">Histology
</select>
			</TD>
		</TR>
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytxbold">Image Title
			</TD>
			<td><%
			 System.out.println("the image desc value is"+annot.getImage_description() );
	 			%>
				<TEXTAREA TYPE ALIGN=center NAME="imagedesc" ROWS= 2 COLS = 30 WRAP> <%=annot.getImage_description()%></TEXTAREA>
			</td>
		</TR> 
		<TR align="left" valign="top">
			<td>&nbsp;</td>
			<TD class="bodytxbold">Image Description
			</TD>
			<td><%
			 System.out.println("the image annot value is"+annot.getImage_annotations() );	 %>
				<%
				if (annot.getImage_annotations()!= null){ 
				System.out.println("I am in not null now");%>
				<TEXTAREA NAME="imageannot" ROWS= 5 COLS = 30 WRAP><%=annot.getImage_annotations()%></TEXTAREA>
				<%}else { 
				System.out.println("I am in null now");%>
				<TEXTAREA NAME="imageannot" ROWS= 5 COLS = 30 ></TEXTAREA> 
				<%}%>
			</td>
		</TR>
		<tr><td>&nbsp;</td><td class="bodytxbold">Staining</td>
		<td ALIGN=LEFT>	<SELECT NAME="stain"   onChange="check_otherstain(main.Other)">
		<option value =""> </option>
		<option value= "0">Other</option>
		<%
		Vector stain   = st.retrieveAllWhere("stain_name IS NOT NULL ORDER BY stain_name");
		for(int j =0; j < stain.size(); j++){
			Stain St = (Stain) stain.elementAt(j);
			if(annot.getStain_id()!=null){
				if(St.getStain_id().equals(annot.getStain_id()) ){%>
				<option value= "<%=URLEncoder.encode(St.getStain_id().toString())%>" selected ><%=St.getStain_description()%> </option>
				<%} else{%>
					<option value= "<%=URLEncoder.encode(St.getStain_id().toString())%>" ><%=St.getStain_description()%> </option>
				<%}
			} else {%>
			<option value= "<%=URLEncoder.encode(St.getStain_id().toString())%>" ><%=St.getStain_description()%> </option>
			<%}
		System.out.println("stain:"+St.getStain_id()+stain.size()); 
		}
		%>	
		</select></td>
		</tr>
			<tr align="left" valign="top">
						<td>&nbsp;</td>
						<td class="bodytxbold">If Other Staining</td>
			 			<TD><input type="Text" size="40" name="Other" value="" ?" readonly ":"">	
				 		</TD>
			</tr>

<tr>
<%if ( mode.equals("clone") || mode.equals("") ) {
System.out.println("I am in if loop Edit data"+mode+id);
//response.sendRedirect("caimageEditData.jsp?id="+id+"&mode="+mode);%>
<td>&nbsp;</td><td class="bodytxrequ">Image Upload*</td>
<td ALIGN=left><INPUT TYPE="FILE" NAME="myUploadObject"  MULTIPLE>	</td>
<td ALIGN=left>
				<%
				String lizard = getServletConfig().getServletContext().getInitParameter("lizard");
				String imagepath = lizard+"/iserv/getthumb?cat=";
				System.out.println("lizard image path:"+imagepath); 
				cat.retrieveByKey(annot.getCatalog_id());
				System.out.println("The image name is"+annot.getImage_name() );%>
		<%if ( !annot.getImage_name().equals("No Image") ){ 	%>
		<img src= "<%=imagepath%><%=DatabaseSetup.checkForNull(cat.getCatalog_directory().trim())%>&img=<%=DatabaseSetup.checkForNull(annot.getImage_name().trim())%>&thumbspec="main"  alt="<%=DatabaseSetup.checkForNull(annot.getImage_name())%>" border="0" target="_blank"> </a><br>
		<%}%>
		</td>
<%} else { 
System.out.println("I am in else loop submit"+mode+id);
}%>
<!--- <td ALIGN=left><INPUT TYPE="FILE" NAME="myUploadObject"  MULTIPLE>	</td>
 --->		
</tr>
<tr>
<td colspan="3" align="center">
<INPUT onClick="alert('save: ' + document.form1.myUploadObject.value)" type="submit" value="Submit" name="select_annotation_type">&nbsp;&nbsp;
<INPUT onClick="alert('reset: ' + document.form1.myUploadObject.value)" tabindex="4" type="reset" value="  Clear   "></td></tr>

</TABLE>

		
</FORM>

<%@ include file="html/simple_search2.htm"%>
</body>
<%} else {%>
<center><H1>Record <%=id%> not found!</h1></center>
<%}%>
</html>

