<script language="JavaScript" src="/ncicb/EvsTree.js">
</script> 
 <!--- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
            "http://www.w3.org/TR/html4/loose.dtd"> --->
			
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


<%
// constructor class
Annotations annot = new Annotations();
Species sp = new Species();
Stain st = new Stain();
Concept_mapping cm  = new Concept_mapping();
Image_characteristic ic = new Image_characteristic() ;
Model mod = new Model();
//Donator don = new Donator();
//Donating_institution doni = new Donating_institution();
Login log = new Login();
Strain str = new Strain();
Gender gen = new Gender();
Publication_journal pj = new Publication_journal();
Publication pub = new Publication();

%>
    <!--- <LINK rel="stylesheet" type="text/css" href="images/submission[3].css"> --->
<!--- </head> --->
<!--- <body onLoad="MM_preloadImages('images/arrowOver.gif','images/infoOver.gif','images/searchOver.gif','images/adminOver.gif','images/searchtextOver.gif','images/admintextOver.gif','images/disclaimerOver.gif','images/submittextOver.gif','images/submitOver.gif','images/new_over.gif','images/new_up.gif')">
&nbsp; --->
<!--- <body> --->
<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/search_images_adv.htm"%>
<form name="main" method="POST"  action="Advancedresults.jsp?q=0"  >
<center><table BORDER=0 WIDTH="100%">
<!--- <tr>
<td VALIGN=TOP COLSPAN="2" class ="title">
<center>Advanced Image Search</center>
</td>
</tr> --->
<TR align="left" valign="top">
			<TD colspan="3" align="center" class="tophder" >
			<font style="font-family: Verdana, Arial, Helvetica, sans-serif;" color="#ffffff">
			Image</font></TD>
			
		</TR>
		
	<TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold">Image Name / Number</td>
	<td ALIGN=LEFT><input type=TEXT NAME=imagename >
	</td>
</TR>
<%
	System.out.println("the get value is"+log);
	Vector login   = log.retrieveAll() ;
	%>	
	
	<!--add search for image description, if not too complicated-->
<TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold">Staining</td>
	<td ALIGN=LEFT>	<SELECT NAME="stain" >
	<option value =""> </option>
	<%
	Vector stain   = st.retrieveAllWhere("stain_name IS NOT NULL ORDER BY stain_name");
	for(int j =0; j < stain.size(); j++){
			Stain St = (Stain) stain.elementAt(j);
			if(St.getStain_id()!=null){%>
			<option value= "<%=URLEncoder.encode(St.getStain_id().toString())%>"><%=St.getStain_description()%> </option>
			<%}
			System.out.println("stain:"+St.getStain_id()+stain.size()); 
	}
	%>	
	
	
	</select></td>
</TR>	
		
<TR align="left" valign="top">
			<TD colspan="3" align="center" class="tophder">
			<font style="font-family: Verdana, Arial, Helvetica, sans-serif;" color="#ffffff">
			Specimen</font></TD>
			
		</TR>
<tr ALIGN=left VALIGN=TOP>
<td class="bodytxbold">Species</td>

<td ALIGN=left><SELECT NAME="species" size=1 >
<option value =""></option>	
 
 
 <% 
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
		
</select><p></tr>

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
				<!--- 
				<a href="javascript:showDiagnosisTree('main', document.forms['main'].species.value, 2)"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="TumorClassification" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
				 --->
				<a href="javascript:dig()"><img name="browseDiagnosis" src="images/selectUP.gif" vspace="0" hspace="0" border="0"/></a>&nbsp;<INPUT name="TumorClassification" type="TEXT" onFocus="blur()" disabled="true" size="25" maxlength="255"/> 
				
				<input type="hidden" name="DiagnosisName"/>        
		    <input type="hidden" name="DiagnosisCode"/>   
			</TD>
		</TR>							
  <TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold">Gender</td>
	<td ALIGN=LEFT>	<SELECT NAME="gender"  size=1  >
	<option value =""> </option>
	<%
	Vector gender   = gen.retrieveAllWhere("gender_name IS NOT NULL ORDER BY gender_name");
	for(int j =0; j < gender.size(); j++){
			Gender Gen = (Gender) gender.elementAt(j);
			if(Gen.getGender_id()!=null){%>
			<option value= "<%=URLEncoder.encode(Gen.getGender_id().toString())%>"><%=Gen.getGender_name()%> </option>
			<%}	
			System.out.println("gender name:"+Gen.getGender_name()); 
				}
	%>	
	
	</select><p></td>
</TR>			



<TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold">Mouse Strain</td>
	<td ALIGN=LEFT>	<SELECT NAME="strain"  size=1  >
	<option value =""> </option>
	<%
	Vector strain   = str.retrieveAllWhere("strain_name IS NOT NULL ORDER BY strain_name");
	for(int j =0; j < strain.size(); j++){
			Strain Str = (Strain) strain.elementAt(j);
			if(Str.getStrain_id()!=null){%>
			<option value= "<%=URLEncoder.encode(Str.getStrain_id().toString())%>"><%=Str.getStrain_name()%> </option>
			<%}
			System.out.println("strain:"+Str.getStrain_name() ); 
	}
	%>	
	
	</select></td>
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
			<font style="font-family: Verdana, Arial, Helvetica, sans-serif;" color="#ffffff">
			Submitter</font></TD>
			
		</TR>


<TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold"> PI's Name</td>

	<td ALIGN=LEFT><SELECT NAME="donator"  size=1  >
	<option value ="">           </option>
	<%
	System.out.println("the get value is"+log);
	for(int j =0; j < login.size(); j++){
			Login LogIn = (Login) login.elementAt(j);
			if(LogIn.getLoginuid()!=null){
				if( LogIn.getPi_name()!=null) { 
				  System.out.println("The institute is"+LogIn.getPi_name() );
				   Vector v = annot.retrieveByANNOTATIONS__DONATOR_ID(LogIn.getLoginuid() ) ;
				   System.out.println("the  donator vector is"+v.size());
				   	if (v.size()  != 0 ) {%>
						<option value = "<%=LogIn.getLoginuid()%>"><%=LogIn.getPi_name()%>  </option>
						<%
					 	}//if
					}//if
				}//if
			System.out.println("donator:"+LogIn.getLoginuid() ); 
	}//for
	%>	
	
	</select><p></td>
</TR>

<TR ALIGN=LEFT VALIGN=TOP>
<td ALIGN=left class="bodytxbold">Institute</td>

	<td ALIGN=LEFT><SELECT NAME="donator_Institution"  size=1  >
	<option value ="">           </option>
	<%
	Hashtable v1 = new Hashtable();
	for(int j =0; j < login.size(); j++){
			Login LogIn = (Login) login.elementAt(j);
			
			if(LogIn.getLoginuid()!=null){
			  if( LogIn.getInstitute()!=null) { 
			  System.out.println("The institute is"+LogIn.getInstitute() );
			   Vector v = annot.retrieveByANNOTATIONS__DONATOR_ID(LogIn.getLoginuid() ) ;
			   System.out.println("the  donating instititute vector is"+v.size());
			    	if (v.size()  != 0 ) {
						v1.put(LogIn.getInstitute(),LogIn.getInstitute());
						System.out.println("The element is contiained"+v1.contains(LogIn.getInstitute()) );
					}//if
				}//if
			 }//if
			System.out.println("donator:"+URLEncoder.encode(LogIn.getLastname()) +LogIn.getInstitute()  ); 
	}//for
	System.out.println("the vector size is"+v1.size() );	
	System.out.println("the vector size is"+v1.elements() );	
	Enumeration enum = v1.keys();
	while (enum.hasMoreElements() )
		{
		String donating_inst = enum.nextElement().toString();
			 if( donating_inst  != null) {%>
		 	<option value = "<%=donating_inst%>"><%=donating_inst %>  </option>
			<%
			 }
		}
		v1.clear();
	%>	
	</select><p></td>
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
