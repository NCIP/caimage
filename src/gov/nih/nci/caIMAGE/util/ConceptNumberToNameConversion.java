package gov.nih.nci.caIMAGE.util;

 //import gov.nih.nci.evs.query.* ;
 //import gov.nih.nci.evs.domain.*;
 //import  gov.nih.nci.system.applicationservice.*;
 //import  java.util.* ;
 //import  gov.nih.nci.evs.domain.DescLogicConcept ;
import  java.util.* ;
import org.LexGrid.LexBIG.LexBIGService.*;
import org.LexGrid.LexBIG.Impl.*;
import org.LexGrid.LexBIG.DataModel.Collections.*;
import org.LexGrid.LexBIG.Utility.*;
import org.LexGrid.LexBIG.DataModel.Core.*;
import org.LexGrid.concepts.Concept;
import org.LexGrid.LexBIG.caCore.interfaces.*;

import org.LexGrid.LexBIG.caCore.interfaces.LexEVSApplicationService;
import org.LexGrid.LexBIG.caCore.interfaces.LexEVSDistributed;
import org.LexGrid.LexBIG.caCore.interfaces.LexEVSService;

import gov.nih.nci.evs.security.SecurityToken;
import gov.nih.nci.system.applicationservice.ApplicationService;
import gov.nih.nci.system.client.ApplicationServiceProvider;

public class ConceptNumberToNameConversion
{
	private String csName = "NCI Thesaurus";
	private static final String serviceUrl = " http://lexevsapi51.nci.nih.gov/lexevsapi51";
    private String csVersion;
	private LexBIGService lbs;

	public ConceptNumberToNameConversion() throws Exception {
		this.lbs = (LexBIGService)ApplicationServiceProvider.getApplicationServiceFromUrl(serviceUrl, "EvsServiceInfo");
		this.csVersion =  getSupportedCodingSchemes();
	}
	
    public String getSupportedCodingSchemes() throws Exception {
        CodingSchemeRenderingList csrl = lbs.getSupportedCodingSchemes();
        for(int i = 0; i < csrl.getCodingSchemeRenderingCount(); i++)
        {   
            //get a version of the NCI Thesaurus on the server
            if(csrl.getCodingSchemeRendering(i).getCodingSchemeSummary().getFormalName().equals(csName) ){
                if(csrl.getCodingSchemeRendering(i).getRenderingDetail().getVersionTags().getTagCount() > 0)
                {return csrl.getCodingSchemeRendering(i).getCodingSchemeSummary().getRepresentsVersion();}
            }
        }
        throw new IllegalStateException("No versions of coding scheme not found: "+csName);
    }
 
    public static  String ConceptNumberToNameConversion(LexBIGService lbSvc, String vocabulary, String conceptNumber){

        String myConcept = null;
        LexEVSApplicationService lexevsAppService;
        
        try { 
        	if (lbSvc != null) {
        		CodedNodeSet cns =  lbSvc.getCodingSchemeConcepts(vocabulary, null); 

        		ConceptReferenceList crefs = ConvenienceMethods.createConceptReferenceList(new String[] { conceptNumber}, vocabulary); 
        		cns.restrictToCodes(crefs); 
        		ResolvedConceptReferenceList matches = cns.resolveToList(null, null, null, 1);
        	
        		if (matches.getResolvedConceptReferenceCount() > 0) {
        			ResolvedConceptReference ref = (ResolvedConceptReference)matches.enumerateResolvedConceptReference().nextElement();
    	    		Concept entry = ref.getReferencedEntry();
    	    		for (int i = 0; i < entry.getPresentationCount(); i++) {
    	    			if (entry.getPresentation(i).getPropertyName().equals("Display_Name"))
    	    				myConcept = entry.getPresentation(i).getValue().getContent();
    	    		}
    	    		//int count = entry.getPropertyCount();
    	    		//for (int i = 0; i < count; i++) {
    	    			//System.out.println("PropertyName:" + entry.getProperty(i).getPropertyName()+">>>>" + entry.getProperty(i).getValue().getContent());
    	    		//}
    	    	} else {
    	    		//System.out.println("No match found!");
    	    	}
        	}
        
        } catch (Exception e) {
            System.err.println("Error displaying the name.");
            e.printStackTrace();
        }
        //public static  String ConceptNumberToNameConversion(ApplicationService appService, String vocabulary, String conceptNumber){
        	 
    	/*
        String myConcept = null;
        EVSQuery evsQuery = new EVSQueryImpl();
    
    evsQuery.getDescLogicConcept(vocabulary,conceptNumber, true);
    
    try { 
        java.util.List dlcList = (java.util.List) appService.evsSearch(evsQuery);
        if(dlcList.size()>0){
            DescLogicConcept dlc = (DescLogicConcept) dlcList.get(0);
            Vector propertyCollection = dlc.getPropertyCollection();
            for(int i=0; i<propertyCollection.size(); i++){
                    Property property = (Property) propertyCollection.get(i);
      */
                    /*
                    if(property.getName().equals("Preferred_Name")){
                        myConcept = (String)property.getValue();
                        break;
                    }*/
      /*              
                      if(property.getName().equals("Display_Name")){
                                myConcept = property.getValue();
     */                                
//                            }//if
      //        }//for
      //  }//if
    /*
    } catch (Exception e) {
        System.err.println("Error displaying the name");
        e.printStackTrace();
    }
    */
    return myConcept;
    }
    
    public static void main(String[] args) throws Exception {

		ConceptNumberToNameConversion test = new ConceptNumberToNameConversion();
		
		String concept = test.ConceptNumberToNameConversion(test.lbs, test.csName, "C22551");
		if (concept != null) System.out.println("***********Concept:" + concept);
		System.out.println("Done.");
	}

}
