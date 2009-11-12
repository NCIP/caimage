package gov.nih.nci.caIMAGE.util;

 import gov.nih.nci.evs.query.* ;
 import gov.nih.nci.evs.domain.*;
 import  gov.nih.nci.system.applicationservice.*;
 import  java.util.* ;
 import  gov.nih.nci.evs.domain.DescLogicConcept ;

public class ConceptNumberToNameConversion
{
 
    public static  String ConceptNumberToNameConversion(ApplicationService appService, String vocabulary, String conceptNumber){
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
                    /*
                    if(property.getName().equals("Preferred_Name")){
                        myConcept = (String)property.getValue();
                        break;
                    }*/
                    
                      if(property.getName().equals("Display_Name")){
                                myConcept = property.getValue();
                            }//if
              }//for
        }//if
    } catch (Exception e) {
        System.err.println("Error displaying the name");
        e.printStackTrace();
    }
    return myConcept;
    }
}
