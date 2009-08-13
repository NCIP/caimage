<td width="89%"  valign="top" bgcolor="#F7F7CD" class="bodytext">
			<%
				System.out.println("I am im the begining of Concept id"+Annot.getConcept_id());
				if((Annot.getConcept_id()!=null) || (Annot.getConcept_id()=="") ) {
					System.out.println("the diagnosis **********  "+Annot.getConcept_id().trim() );%>
					<% String diagnosis = Annot.getConcept_id().trim();
					System.out.println("the diagnosis from anotation table is"+diagnosis  );
					System.out.println("breaks here means the diagnosis id problem"+diagnosis);
						if( (diagnosis!=null) && (diagnosis.length()> 0) ){%>
						<span class="bodytxbold">Diagnosis:&nbsp;</span> 
						<%	if(!diagnosis.equals("000000")){
							Concept myConcept = myEvs.getConceptByCode("C"+diagnosis);
							System.out.println("the diagnosis **********  "+myConcept.getName() );
								if(myConcept!=null) { %>
								<%=myConcept.getName()%>
								<%} 
								} else if(diagnosis.equals("000000")) { 
								System.out.println("the tumer classification"+Annot.getTumor_classification());%>
								<%=Annot.getTumor_classification()%>
								<%}
							}%><br>
					<%System.out.println("I am im the end of Concept id");%>
				
				<%} %>
				<%
				if(Annot.getImage_annotations()!=null){%>
				<span class="bodytxbold">Description:&nbsp;</span> 
				 
				<%=DatabaseSetup.checkForNull(Annot.getImage_annotations())%>
				 <br>
				<%}
				if(Annot.getCurated_id()!=null){
				Curated cur = new Curated();
				Vector curat = cur.retrieveAllWhere("curated_id ="+ Annot.getCurated_id() );
				String curtype = null;
				for(int k =0; k < curat.size(); k++){
				Curated  Cur = null;
				Cur = (Curated) curat.elementAt(k);
				curtype = Cur.getCurated_type();
				}
				System.out.println("The curation id is"+curtype );%>
				<%}
				if(Annot.getOrgan()!=null){%>
					<span class="bodytxbold">Organ:&nbsp;</span> 
						<% String organname = Annot.getOrgan();
						Concept myConcept = myEvs.getConceptByCode("C"+organname);
						if(myConcept!=null) { %>
						<%=myConcept.getName()%> <br>
						<%} %>
				
				<%} 
				sp.retrieveByIndex(Annot.getSpecies_id()  );
				if(Annot.getSpecies_id()!=null){%>
				<span class="bodytxbold">Species:&nbsp;</span> 
				
				<%=sp.getSpecies_name()%>
				 <br>
				<%} 
				str.retrieveByIndex(Annot.getStrain_id()  );
				if (Annot.getStrain_id() != null) {  %>
				<span class="bodytxbold">Strain:&nbsp;</span> 
				
				<%=str.getStrain_name()%>
				<br>
				<%} 
				
				if(annotationid!=null){
					System.out.println(" I reached here Gene link"+annotationid + "Gene " + Annot.getGene() );
					Genelocuslink locuslink = new Genelocuslink();
					System.out.println(" I reached here Gene locus object"+locuslink);
					Vector locusv = null;
					locusv = locuslink.retrieveAllWhere("ANNOTATION_ID="+"'"+annotationid+"'"); 
					System.out.println(" I reached here  Gene locus link"+locusv.size());
					Long locuslinkid = null;
					String genename = null;
						for(int k =0; k < locusv.size(); k++){
						Genelocuslink  Loc = null;
						Loc = (Genelocuslink) locusv.elementAt(k);
						locuslinkid = Loc.getGenelocuslink_id();
						genename =  Loc.getGene_name();
						}
					if (locuslinkid != null) {
					System.out.println("I am in no Genelocus link id 1");%>
					<span class="bodytxbold">Gene:&nbsp;</span>
					<a href="http://cancermodels.nci.nih.gov/mmhcc/caBIO/GeneInfoContainer.jsp?LLID=
					<%=locuslinkid%>" target="_blank">
					<%if (Annot.getGene() != null) {  %>
						<%=Annot.getGene()%>
						<%}%>
						</a>
					<br>
					<% } else { %>
							<%if (Annot.getGene() != null) {  
							System.out.println("I am in no Genelocus link id");%>
							<span class="bodytxbold">Gene:&nbsp;</span>
							<span class="bodytext"><%=Annot.getGene()%></span><br>
							<%}//if %>
						<%	}//else
					}//if
				
				
				if(annotationid!=null){
					System.out.println(" I reached here locus link"+annotationid);
					Promoterlocuslink locuslink = new Promoterlocuslink();
					System.out.println(" I reached here locus object"+locuslink);
					Vector locusv = null;
					locusv = locuslink.retrieveAllWhere("ANNOTATION_ID="+"'"+annotationid+"'"); 
					System.out.println(" I reached here locus link"+locusv.size());
					Long locuslinkid = null;
					String genename = null;
						for(int k =0; k < locusv.size(); k++){
						Promoterlocuslink  Loc = null;
						Loc = (Promoterlocuslink) locusv.elementAt(k);
						locuslinkid = Loc.getPromoterlocuslink_id();
						genename =  Loc.getGene_name();
						}
					if (locuslinkid != null) {%>
					<span class="bodytxbold">Promoter:&nbsp;</span>
					<a href="http://cancermodels.nci.nih.gov/mmhcc/caBIO/GeneInfoContainer.jsp?LLID=
					<%=locuslinkid%>" target="_blank">
					<%if (Annot.getPromoter() != null) {  %>
						<%=Annot.getPromoter()%>
						<%} %>
					</a>
					<br>
					<% } else { 
							%>
							<%if (Annot.getPromoter() != null) {  %>
							<span class="bodytxbold">Promoter:&nbsp;</span>
							<span class="bodytext"><%=Annot.getPromoter()%></span><br>
							<%} %>
						<%	}
				}
				gen.retrieveByIndex(Annot.getGender_id());
				if (Annot.getGender_id() != null) {%>
				<span class="bodytxbold">Gender:&nbsp;</span> 
				
				<%=gen.getGender_name()%>
				<br>
				<%}	
				pub.retrieveByIndex(Annot.getPublication_id()); 
				if (Annot.getPublication_id() != null) {%>
				<span class="bodytxbold">Publication Id:&nbsp;</span> 
				
				<a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=Pubmed&list_uids=<%=pub.getPublication_name().trim()%>&dopt=Abstract" target="_blank" >
				<%=pub.getPublication_name()%></a>
				<br>
				<% } 
				mod.retrieveByIndex(Annot.getModel_id()  );
				if (Annot.getModel_id() != null) {%>
				<span class="bodytxbold">Model:&nbsp;</span> 
				
				<%=mod.getModel_name()%>
				<br>
				<% } 
				st.retrieveByIndex(Annot.getStain_id()  );
				if (Annot.getStain_id() != null) {%>
				<span class="bodytxbold">Staining:&nbsp;</span> 
				<%=st.getStain_description()%>
				 <br>
				<% } 
				log.retrieveByIndex(Annot.getDonator_id()  );
				if(Annot.getDonator_id()!=null)  {%>
				<span class="bodytxbold">Image Donated by lab of:&nbsp; </span> 
				<!--- <span class="bodytext"> 
				<%//=log.getPi_name()%>
				</span> 
				<span class="bodytxbold">Donator's Email:&nbsp; </span>  --->
					<%if(log.getEmail()!=null)  {%>
					
					<A href="mailto:<%=log.getPi_email()%>"><%=log.getPi_name()%></A>
					
					<br>
				<%	} 
				}
				ic.retrieveByIndex(Annot.getAnnotation_id() );
				if (ic.getImage_characteristic_width()!=null) {%>
				 <span class="bodytxbold">Image Width:&nbsp;</span> 
				
				 <%=ic.getImage_characteristic_width()%>&nbsp;
				
				<% }
				if (ic.getImage_characteristic_height()!=null) {%>
				<span class="bodytxbold">Image Height:&nbsp;</span> 
				
				<%=ic.getImage_characteristic_height()%>&nbsp;
				
				<% } 
				if (ic.getImage_characteristic_width() != null || ic.getImage_characteristic_height() != null  ) {%>
				<span class="bodytxbold">Unit Type:&nbsp;</span> 
				
				<%="Pixels"%>&nbsp;
				 
				<% } 
				if (ic.getImage_characteristic_numlevel() != null) {%>
				<span class="bodytxbold">Magnification Level:&nbsp;</span> 
				
				<%=ic.getImage_characteristic_numlevel()%>
				<br>
				<% }
				
				/*
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    		try{
	    		 DocumentBuilder builder = factory.newDocumentBuilder();
	     		Document doc = builder.newDocument();
				DOMWriter dm = null;
				Node myElement = Annot.toXML(doc); 
				sw = dm.nodeToString(myElement);
	    		System.out.println("xml " + sw+"\n");
				 } catch (ParserConfigurationException pce) {
	            // Parser with specified options can't be built
	            pce.printStackTrace();
	       		} 
				//Annot.xmlStart();
				*/
				%>
				<%System.out.println(" q and j"+ q +" " + j);
				if (sw != null  && j == q) {%>
				<!--- <textarea rows=30 cols=110> --->
				<%//=sw%>
				<!--- </textarea> ---><br>
				<%}%>
			</td>
