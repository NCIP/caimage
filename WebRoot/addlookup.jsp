<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<script>
function check_other(choice)
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
</script>

		<%@ page import="gov.nih.nci.caimage.db.*"%>
		<%@ page import="java.net.URLDecoder"%>
		<%@ page import="java.net.URLEncoder"%>
		<%@ page import="gov.nih.nci.caIMAGE.*"%>
		<%@ page import="java.util.Vector"%>
		<title>
			addlookup
		</title>
	</head>

	<body>
		<FORM name="main" method="POST" action="addlookupSubmit.jsp">
			<table width="400" border="0" cellspacing="0" cellpadding="3" class="tblSearch" align="center">

				<!--add search for image description, if not too complicated-->
				<tr>
					<td colspan="3">
						<h2 class="title">
							Enter Information for Stain:
						</h2>

					</td>
				</tr>
				<%Stain st = new Stain();
			String table_name = request.getParameter("table");

			Stain St = null;

			%>
				<TR ALIGN=LEFT VALIGN=TOP>
					<td ALIGN=left class="bodytxbold">
						Staining
					</td>
					<td ALIGN=LEFT>
						<SELECT NAME="stain" onChange="check_other(main.Other)">
							<option value="">
							</option>
							<%Vector stain = st
					.retrieveAllWhere("stain_name IS NOT NULL ORDER BY stain_name");
			for (int j = 0; j < stain.size(); j++) {
				St = (Stain) stain.elementAt(j);
				if (St.getStain_id() != null) {%>
							<option value="<%=URLEncoder.encode(St.getStain_id().toString())%>">
								<%=St.getStain_description()%>
							</option>
							<%}

			}

		%>


						</select>
					</td>
				</TR>
				<br>
				<%%>
				
					If Other
				</td>
				<TD colspan="2">
					<input type="Text" size="40" name="Other" value=""?" readonly ":"">
				</TD>


				<tr>
					<td ALIGN=CENTER COLSPAN="2">
						<input TYPE="submit" NAME="add_lookuptable" VALUE="Submit">
						&nbsp;&nbsp;
						<input TYPE=RESET VALUE="  Clear   " tabindex="4">
					</td>
				</tr>

				</FORM>
			</table>
	</body>
</html>
