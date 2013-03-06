<%--L
  Copyright SAIC (Corporate).

  Distributed under the OSI-approved BSD 3-Clause License.
  See http://ncip.github.com/caimage/LICENSE.txt for details.
L--%>


<%@ page language="java" %>
<%@ page import ="gov.nih.nci.caimage.db.* "%> 
<%@ page import = "gov.nih.nci.caIMAGE.* " %>
<%@ page import = "gov.nih.nci.caIMAGE.util.* " %>
<%@ page import = "java.util.*" %>   
  
   


<link rel="stylesheet" href="caIMAGE.css" type="text/css">
<%@ include file="html/search_clinical_images.htm"%>	 
<FORM Name="main" method="POST" action="img_search_select.jsp">   
<%if(request.getParameter("search_images") != null){
   System.out.println("11111 here");
   if(request.getParameter("image_type")!= null){
      if(request.getParameter("image_type").equals("1")){%>
     <jsp:forward page="simple.jsp"/> 
    <%}
   else{%>
     <jsp:forward page="clinical_img_login_a.jsp"/> 
    <%}
	}
   }  
%>       

	<TABLE align="center" width="85%" cellpadding="5" cellspacing="5" border="0">		
		
		<TR>
			<TD class="bodytxbold">			Select Image Type:
			</TD>
			<TD>
				
				 <SELECT name="image_type" size="1">
					<OPTION value="">
					<OPTION value="1">Histology Image
					<OPTION value="2">Clinical Image					
				</SELECT>
			</TD>
		</TR>
				
		
		
		<TR>
			<TD>				&nbsp;
			</TD>
			<TD>
				<INPUT type ="SUBMIT"  name="search_images" value="   Search   ">
				<INPUT type="RESET" value="  Clear  ">
			</TD>
		</TR>
	</TABLE>
</FORM>
<%@ include file="html/simple_search2.htm"%>
</body>

</html>
