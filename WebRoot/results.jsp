<td width="89%" valign="top" bgcolor="#F7F7CD" class="bodytext">
	<%logger.debug("************** results.jsp**************");
			if (Annot.getAnnotation_id() != null) {
				logger.debug("the diagnosis annotation id number**  "
						+ Annot.getAnnotation_id());%>
	<%Vector vdiagnosis = null;
				Image_diagnosis Dig = null;
				String diagnosis = null;
				vdiagnosis = ImageOrganDiagnosis.imageDiagnosis(annotationid);
				logger.debug("vdiagnosis.size()" + vdiagnosis.size());
				int cnt1 = vdiagnosis.size();
				for (int k = 0; k < vdiagnosis.size(); k++) {
					Dig = (Image_diagnosis) vdiagnosis.elementAt(k);
			
					diagnosis = Dig.getDiagnosis();
				
					if ((diagnosis != null) && !diagnosis.equals("")
							&& (diagnosis.length() > 0)) {
						logger.debug("my concept" + diagnosis);
						if (!diagnosis.equals("000000")) {
							String conceptcode = "C" + diagnosis;
							//logger.debug("the concept object" + evsQuery);
							String myConcept = null;
							myConcept = ConceptNumberToNameConversion.ConceptNumberToNameConversion(appService,
											"NCI_Thesaurus", conceptcode);
							//Thread.sleep(1000);
						
							if (myConcept != null) {
								logger.debug("the diagnosis **********  "
										+ myConcept);
								String convert_diagnosis = CommaConcat.convert(
										myConcept, cnt1);
								logger.debug("convert_diagnosis"
										+ convert_diagnosis);
								if (convert_diagnosis != null) {
									if (k < 1) {%>
	<span class="bodytxbold">Diagnosis:&nbsp;</span>
	<%}//k %>
	<%=convert_diagnosis%>
	<br>
	<%}//convert 
							}//my concept.get name
						} //if concept
						else {

							%>
	<%logger.debug("the tumer classification for if "
									+ Dig.getTumor_classification());
							if (Dig.getTumor_classification() != null) {
								if (k < 1) {

								%>
	<span class="bodytxbold">Diagnosis:&nbsp;</span>
	<%}

								%>
	<%=Dig.getTumor_classification()%>
	<br>
	<%}//dig
						}//else
						cnt1 = cnt1 - 1;
					}//if
				}//for
			}//if %>
	<%if (Annot.getImage_annotations() != null) {%>
	<span class="bodytxbold">Description:&nbsp;</span>

	<%=DatabaseSetup.checkForNull(Annot.getImage_annotations())%>
	<br>

	<%}
			if (Annot.getCurated_id() != null) {
				Curated cur = new Curated();
				Vector curat = cur.retrieveAllWhere("curated_id ="
						+ Annot.getCurated_id());
				String curtype = null;
				for (int k = 0; k < curat.size(); k++) {
					Curated Cur = null;
					Cur = (Curated) curat.elementAt(k);
					curtype = Cur.getCurated_type();
				}

			%>
	<%}
			//organs
			if (Annot.getAnnotation_id() != null) {
				logger.debug("the organ annotation id number*  "
						+ Annot.getAnnotation_id());%>
	<%Vector vorgan = null;
				Image_organ Org = null;
				String organname = null;
				vorgan = ImageOrganDiagnosis.imageOrgan(annotationid);
				logger.debug("vorgan.size()" + vorgan.size());
				if (vorgan.size() > 0) {%>

	<%}
				int cnt1 = vorgan.size();
				for (int k = 0; k < vorgan.size(); k++) {
					Org = (Image_organ) vorgan.elementAt(k);
			
					organname = Org.getOrgan();
				
					if (organname == null || organname.equals("00000000")) {%>
	<span class="bodytxbold">Organ:&nbsp;</span> <span class="bodytext">Unspecified&nbsp;</span>
	<br>
	<%} else if ((organname != null) && (organname.length() > 0)) {
					
						String conceptname = "C" + organname;
						String myConcept = null;
						long startTime = System.currentTimeMillis(),endTime =0;
						
						myConcept = ConceptNumberToNameConversion.ConceptNumberToNameConversion(appService,
										"NCI_Thesaurus", conceptname);
						endTime = System.currentTimeMillis();
					
						
						//Thread.sleep(1000);
					
						if (myConcept != null) {
							logger.debug("the organ **********  " + myConcept);
							String convert_organ = CommaConcat.convert(
									myConcept, cnt1);
							if (convert_organ != null) {
								if (k < 1) {

								%>
	<span class="bodytxbold">Organ:&nbsp;</span>
	<%}

								%>
	<%=convert_organ%>
	<br>
	<%} //if  
						}//myconcept  
						cnt1 = cnt1 - 1;
					}//if
				}//for
			}//if %>

	<%//} 
			sp.retrieveByIndex(Annot.getSpecies_id());
			if (Annot.getSpecies_id() != null) {%>
	<span class="bodytxbold">Species:&nbsp;</span>

	<%=sp.getSpecies_name()%>
	<br>
	<%}
			str.retrieveByIndex(Annot.getStrain_id());
			if (Annot.getStrain_id() != null) {

				%>
	<span class="bodytxbold">Strain:&nbsp;</span>

	<%=str.getStrain_name()%>
	<br>
	<%}

			if (annotationid != null) {
				Genelocuslink locuslink = new Genelocuslink();
				Vector locusv = null;
				locusv = locuslink.retrieveAllWhere("ANNOTATION_ID=" + "'"
						+ annotationid + "'");
				Long locuslinkid = null;
				String genename = null;
				for (int k = 0; k < locusv.size(); k++) {
					Genelocuslink Loc = null;
					Loc = (Genelocuslink) locusv.elementAt(k);
					locuslinkid = Loc.getGenelocuslink_id();
					genename = Loc.getGene_name();
				}
				if (locuslinkid != null) {
					//logger.debug("I am in no Genelocus link id 1");%>
	<span class="bodytxbold">Gene:&nbsp;</span> <a href="http://cancermodels.nci.nih.gov/mmhcc/caBIO/GeneInfoContainer.jsp?LLID=
					<%=locuslinkid%>" target="_blank"> <%if (Annot.getGene() != null) {

						%> <%=Annot.getGene()%> <%}%> </a>
	<br>
	<%} else {

					%>
	<%if (Annot.getGene() != null) {

						%>
	<span class="bodytxbold">Gene:&nbsp;</span> <span class="bodytext"><%=Annot.getGene()%></span>
	<br>
	<%}//if %>
	<%}//else
			}//if

			if (annotationid != null) {

				Promoterlocuslink locuslink = new Promoterlocuslink();

				Vector locusv = null;
				locusv = locuslink.retrieveAllWhere("ANNOTATION_ID=" + "'"
						+ annotationid + "'");

				Long locuslinkid = null;
				String genename = null;
				for (int k = 0; k < locusv.size(); k++) {
					Promoterlocuslink Loc = null;
					Loc = (Promoterlocuslink) locusv.elementAt(k);
					locuslinkid = Loc.getPromoterlocuslink_id();
					genename = Loc.getGene_name();
				}
				if (locuslinkid != null) {%>
	<span class="bodytxbold">Promoter:&nbsp;</span> <a href="http://cancermodels.nci.nih.gov/mmhcc/caBIO/GeneInfoContainer.jsp?LLID=
					<%=locuslinkid%>" target="_blank"> <%if (Annot.getPromoter() != null) {

						%> <%=Annot.getPromoter()%> <%}

				%> </a>
	<br>
	<%} else {%>
	<%if (Annot.getPromoter() != null) {%>
	<span class="bodytxbold">Promoter:&nbsp;</span> <span class="bodytext"><%=Annot.getPromoter()%></span>
	<br>
	<%}
				}
			}
			gen.retrieveByIndex(Annot.getGender_id());
			if (Annot.getGender_id() != null) {%>
	<span class="bodytxbold">Gender:&nbsp;</span>
	<%=gen.getGender_name()%>
	<br>
	<%}
			pub.retrieveByIndex(Annot.getPublication_id());
			if (Annot.getPublication_id() != null) {%>
	<span class="bodytxbold">Publication Id:&nbsp;</span> <a href="http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=Pubmed&list_uids=<%=pub.getPublication_name().trim()%>&dopt=Abstract" target="_blank"> <%=pub.getPublication_name()%></a>
	<br>
	<%}
			st.retrieveByIndex(Annot.getStain_id());
			if (Annot.getStain_id() != null) {%>
	<span class="bodytxbold">Staining:&nbsp;</span>
	<%=st.getStain_description()%>
	<br>
	<%}
			log.retrieveByIndex(Annot.getDonator_id());
			if (Annot.getDonator_id() != null) {%>
	<span class="bodytxbold">Image Donated by lab of:&nbsp; </span>
	<%if (log.getEmail() != null) {%>
	<A href="mailto:<%=log.getPi_email()%>"><%=log.getPi_name()%></A>
	<br>
	<%}
			}
			ic.retrieveByIndex(Annot.getAnnotation_id());
			if (ic.getImage_characteristic_width() != null) {%>
	<span class="bodytxbold">Image Width:&nbsp;</span>
	<%=ic.getImage_characteristic_width()%>
	&nbsp;
	<%}
			if (ic.getImage_characteristic_height() != null) {%>
	<span class="bodytxbold">Image Height:&nbsp;</span>
	<%=ic.getImage_characteristic_height()%>
	&nbsp;
	<%}
			if (ic.getImage_characteristic_width() != null
					|| ic.getImage_characteristic_height() != null) {%>
	<span class="bodytxbold">Unit Type:&nbsp;</span>
	<%="Pixels"%>
	&nbsp;
	<%}
			if (ic.getImage_characteristic_numlevel() != null) {%>
	<span class="bodytxbold">Magnification Level:&nbsp;</span>

	<%=ic.getImage_characteristic_numlevel()%>
	<br>
	<%}

			%>
	<%logger.debug(" q and j" + q + " " + j);
			if (sw != null && j == q) {%>

	<br>
	<%}%>
</td>

