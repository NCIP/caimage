/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

/**
 * 
 * $Id: NewDropdownUtil.java,v 1.61 2009-05-28 18:49:31 pandyas Exp $
 * 
 * $Log: not supported by cvs2svn $
 * Revision 1.60  2009/03/13 15:02:04  pandyas
 * modified for #19758  	Remove the filter from the PI drop-down list on admin (Edit Models) search criteria screen
 *
 * Revision 1.59  2008/08/27 13:56:42  pandyas
 * Updated comments for method
 *
 * Revision 1.58  2008/08/14 17:09:40  pandyas
 * remove debug lines
 *
 * Revision 1.57  2008/08/12 19:40:31  pandyas
 * Fixed #15053  	Search for models with transgenic or targeted modification on advanced search page confusing
 *
 * Revision 1.56  2008/05/21 19:07:43  pandyas
 * Modified advanced search to prevent SQL injection
 * Converted text entry to dropdown lists for easier validation
 * Re: Apps Scan run 05/15/2008
 *
 * Revision 1.55  2007/10/18 18:28:04  pandyas
 * Modified to prevent cross--site scripting attacks
 *
 * Revision 1.54  2007/10/17 18:36:55  pandyas
 * Trying to set constanst for PI list to use in validation of searchForm
 *
 * Revision 1.53  2007/08/27 15:41:03  pandyas
 * hide debug code printout
 *
 * Revision 1.52  2007/08/07 20:02:45  pandyas
 * removed blank in editor and screener admin list until validation is worked out
 *
 * Revision 1.51  2007/07/31 12:01:20  pandyas
 * VCDE silver level  and caMOD 2.3 changes
 *
 * Revision 1.50  2007/05/21 17:37:04  pandyas
 * Modified simple and adv search species drop down to pull from DB (approved model species only)
 *
 * Revision 1.49  2007/03/28 18:03:09  pandyas
 * Modified for the following Test Track items:
 * #462 - Customized search for carcinogens for Jackson Lab data
 * #494 - Advanced search for Carcinogens for Jackson Lab data
 *
 * Revision 1.48  2006/11/09 17:15:56  pandyas
 * Commented out debug
 *
 * Revision 1.47  2006/10/17 16:10:31  pandyas
 * modified during development of caMOD 2.2 - various
 *
 * Revision 1.46  2006/05/24 18:54:37  georgeda
 * Added staining method
 *
 * Revision 1.45  2006/05/24 16:53:09  pandyas
 * Converted StainingMethod to lookup - modified code to pull dropdown list from DB
 * All changes from earlier version were merged into this version manually
 *
 * Revision 1.44  2006/05/23 18:16:38  georgeda
 * Removed hardcode of other into species dropdown
 *
 * Revision 1.43  2006/05/19 16:41:54  pandyas
 * Defect #249 - add other to species on the Xenograft screen
 *
 * Revision 1.42  2006/05/15 15:45:40  georgeda
 * Cleaned up contact info management
 *
 * Revision 1.41  2006/05/10 14:16:14  schroedn
 * New Features - Changes from code review
 *
 * Revision 1.40  2006/04/17 19:08:38  pandyas
 * caMod 2.1 OM changes
 *
 * Revision 1.39  2005/11/29 20:47:21  georgeda
 * Removed debug
 *
 * Revision 1.38  2005/11/16 21:36:40  georgeda
 * Defect #47, Clean up EF querying
 *
 * Revision 1.37  2005/11/16 19:26:30  pandyas
 * added javadocs
 *
 * 
 */
 
package gov.nih.nci.caIMAGE.util;
 
import gov.nih.nci.caIMAGE.Constants;
//import gov.nih.nci.camod.domain.*;
//import gov.nih.nci.camod.service.*;
//import gov.nih.nci.camod.service.impl.CurationManagerImpl;
//import gov.nih.nci.camod.service.impl.QueryManagerSingleton;
//import gov.nih.nci.common.persistence.Search;
//import gov.nih.nci.camod.service.SpeciesManager;
import gov.nih.nci.caimage.db.*;
 
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.*;
 
import javax.servlet.http.HttpServletRequest;
 
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
 
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
 
public class NewDropdownUtil
{
 
    private static final Log log = LogFactory.getLog(NewDropdownUtil.class);
 
    private static Map ourFileBasedLists = new HashMap();
 
    public static void setup(HttpServletRequest inRequest) throws Exception {
    	System.out.println("In NewDropdownUtil.setup");
    	
    	NewDropdownUtil.populateDropdown(inRequest, Constants.Dropdowns.GENDERQUERYDROP,
                 Constants.Dropdowns.ADD_BLANK_OPTION);
    	NewDropdownUtil.populateDropdown(inRequest, Constants.Dropdowns.SPECIESQUERYDROP,
                Constants.Dropdowns.ADD_BLANK_OPTION);
        NewDropdownUtil.populateDropdown(inRequest, Constants.Dropdowns.INSTITUTIONQUERYDROP,
                        Constants.Dropdowns.ADD_BLANK_OPTION);
        NewDropdownUtil.populateDropdown(inRequest, Constants.Dropdowns.PRINCIPALINVESTIGATORDROP,
                Constants.Dropdowns.ADD_BLANK_OPTION);
        NewDropdownUtil.populateDropdown(inRequest, Constants.Dropdowns.STAININGDROP,
                Constants.Dropdowns.ADD_BLANK_OPTION);
        NewDropdownUtil.populateDropdown(inRequest, Constants.Dropdowns.STRAINDROP,
                Constants.Dropdowns.ADD_BLANK_OPTION);   
    }
    
    public static void populateDropdown(HttpServletRequest inRequest,
                                        String inDropdownKey,
                                        String inFilter) throws Exception
    {
 
        log.debug("Entering NewDropdownUtil.populateDropdown");
 
        log.debug("Generating a dropdown for the following key: " + inDropdownKey);
 
        List theList = null;
        if (inDropdownKey.indexOf(".txt") != -1)
        {
            theList = getTextFileDropdown(inRequest, inDropdownKey);
        }
        else if (inDropdownKey.indexOf(".db") != -1)
        {
            theList = getDatabaseDropdown(inRequest, inDropdownKey, inFilter);
        }
 
        // Add a blank as the first line
        if (Constants.Dropdowns.ADD_BLANK.equals(inFilter))
        {
            addBlank(theList);
        }
 
        // Add a blank as the first line
        else if (Constants.Dropdowns.ADD_BLANK_OPTION.equals(inFilter))
        {
            addBlankOption(theList);
        }
 
        // Add a blank as the first line
        else if (Constants.Dropdowns.ADD_OTHER.equals(inFilter))
        {
            addOther(theList);
        }
 
        // Add a blank as the first line
        else if (Constants.Dropdowns.ADD_OTHER_OPTION.equals(inFilter))
        {
            addOtherOption(theList);
        }
 
        else if (Constants.Dropdowns.ADD_BLANK_AND_OTHER.equals(inFilter))
        {
            addOther(theList);
            addBlank(theList);
        }
 
        else if (Constants.Dropdowns.ADD_BLANK_AND_OTHER_OPTION.equals(inFilter))
        {
            addOtherOption(theList);
            addBlankOption(theList);
        }
 
        if (theList == null)
        {
            throw new IllegalArgumentException("Unknown dropdown list key: " + inDropdownKey);
        }
 
        inRequest.getSession().setAttribute(inDropdownKey, theList);
 
        log.trace("Exiting NewDropdownUtil.populateDropdown");
    }
 
    private static List getDatabaseDropdown(HttpServletRequest inRequest,
                                            String inDropdownKey,
                                            String inFilter) throws Exception
    {
 
        log.debug("Entering NewDropdownUtil.getDatabaseDropdown");
 
        List theReturnList = null;
 
        //modified for species from DB
        if (inDropdownKey.equals(Constants.Dropdowns.SPECIESQUERYDROP))
        {
            theReturnList = getQueryOnlySpeciesList(inRequest, inFilter);
            log.debug("NewDropdownUtil.getDatabaseDropdown.SpeciesDrop:" + theReturnList.size());
        }
        else if (inDropdownKey.equals(Constants.Dropdowns.GENDERQUERYDROP)) 
        {
        	theReturnList = getQueryGenderList(inRequest, inFilter);
        	log.debug("NewDropdownUtil.getDatabaseDropdown.GenderDrop:" + theReturnList.size());
        }
        else if (inDropdownKey.equals(Constants.Dropdowns.INSTITUTIONQUERYDROP)) 
        {
        	theReturnList = getQueryInstitutionList(inRequest, inFilter);
        	log.debug("NewDropdownUtil.getDatabaseDropdown.InstitutionDrop:" + theReturnList.size());
        }
        else if (inDropdownKey.equals(Constants.Dropdowns.PRINCIPALINVESTIGATORDROP)) 
        {
        	theReturnList = getQueryPIList(inRequest, inFilter);
        	log.debug("NewDropdownUtil.getDatabaseDropdown.PRINCIPALINVESTIGATORDROP:" + theReturnList.size());
        }
        else if (inDropdownKey.equals(Constants.Dropdowns.STAININGDROP)) 
        {
        	theReturnList = getQueryStainingList(inRequest, inFilter);
        	log.debug("NewDropdownUtil.getDatabaseDropdown.STAININGDROP:" + theReturnList.size());
        }
        else if (inDropdownKey.equals(Constants.Dropdowns.STRAINDROP)) 
        {
        	theReturnList = getQueryStrainList(inRequest, inFilter);
        	log.debug("NewDropdownUtil.getDatabaseDropdown.STRAINDROP:" + theReturnList.size());
        }
        else
        {
            log.error("No matching dropdown for key: " + inDropdownKey);
            theReturnList = new ArrayList<Object>();
        }
 
        log.debug("Exiting NewDropdownUtil.getDatabaseDropdown");
        return theReturnList;
    }
 
    // Get the context so we can get to our managers
    private static WebApplicationContext getContext(HttpServletRequest inRequest)
    {
        return WebApplicationContextUtils.getRequiredWebApplicationContext(inRequest.getSession().getServletContext());
    }
 
    // Get a text file dropdown
    private static synchronized List getTextFileDropdown(HttpServletRequest inRequest,
                                                         String inDropdownKey) throws Exception
    {
        log.trace("Entering NewDropdownUtil.getTextFileDropdown");
 
        List theReturnList = new ArrayList<Object>();
 
        if (ourFileBasedLists.containsKey(inDropdownKey))
        {
            log.debug("Dropdown already cached");
            List theCachedList = (List) ourFileBasedLists.get(inDropdownKey);
            theReturnList.addAll(theCachedList);
        }
        else
        {
            String theFilename = inRequest.getSession().getServletContext().getRealPath("/config/dropdowns") + "/" + inDropdownKey;
 
            List theList = readListFromFile(theFilename);
 
            // Built a list. Add to static hash
            if (theList.size() != 0)
            {
                log.debug("Caching new dropdown: " + theList);
                ourFileBasedLists.put(inDropdownKey, theList);
                theReturnList.addAll(theList);
            }
        }
 
        log.trace("Exiting NewDropdownUtil.getTextFileDropdown");
        return theReturnList;
    }
 
    // Read from a file
    static private List readListFromFile(String inFilename) throws Exception
    {
        List theReturnList = new ArrayList<Object>();
 
        log.debug("Filename to read dropdown from: " + inFilename);
 
        BufferedReader in = new BufferedReader(new FileReader(inFilename));
 
        boolean isDropdownOption = false;
 
        String str;
        while ((str = in.readLine()) != null)
        {
            log.debug("readListFromFile method: Reading value from file: " + str);
 
            // It's a DropdownOption file
            if (str.indexOf("DROPDOWN_OPTION") > 0)
            {
                isDropdownOption = true;
            }
            else if (isDropdownOption == true)
            {
                StringTokenizer theTokenizer = new StringTokenizer(str);
                String theLabel = theTokenizer.nextToken(",");
                String theValue = theTokenizer.nextToken(",");
 
                DropdownOption theDropdownOption = new DropdownOption(theLabel, theValue);
                theReturnList.add(theDropdownOption);
            }
            else
            {
                theReturnList.add(str);
            }
        }
        in.close();
 
        return theReturnList;
    }
 
    /**
     * Returns a list of all Gender  
     * Used for submission and search screens
     * 
     * @return genders
     * @throws Exception
     */
    private static List getQueryGenderList(HttpServletRequest inRequest,
                                                String inAddBlank) throws Exception
    {
        log.debug("Entering NewDropdownUtil.getQueryGenderList");
 
        // Get values for dropdown lists for Gender
        Gender gen = new Gender();
        Vector gender = gen.retrieveAllWhere("gender_name IS NOT NULL ORDER BY gender_name");
        List<DropdownOption> theReturnList = new ArrayList<DropdownOption>();
        for (int j = 0; j < gender.size(); j++) {
			Gender Gen = (Gender) gender.elementAt(j);
			if (Gen.getGender_id() != null) {
				DropdownOption theOption = new DropdownOption(Gen.getGender_name(), Gen.getGender_id().toString());
				theReturnList.add(theOption);	
			}
		}

	
        log.debug("Exiting getQueryGenderList.size " + theReturnList.size());
        return theReturnList;
    } 
    
    /**
     * Returns a list of all Species  
     * Used for submission and search screens
     * 
     * @return speciesNames
     * @throws Exception
     */
    private static List getQueryOnlySpeciesList(HttpServletRequest inRequest,
                                                String inAddBlank) throws Exception
    {
        log.debug("Entering NewDropdownUtil.getQueryOnlySpeciesList");
        
        Species sp = new Species();
        
        Vector species = sp.retrieveAllWhere("species_name IS NOT NULL ORDER BY species_name");
        
        // Get values for dropdown lists for Species
        List<DropdownOption> theReturnList = new ArrayList<DropdownOption>();
        for (int j = 0; j < species.size(); j++) {
			Species speciesTab = (Species) species.elementAt(j);
			if (speciesTab.getSpecies_id() != null) {
				DropdownOption theOption = new DropdownOption(speciesTab.getSpecies_name(), speciesTab.getSpecies_id().toString());
				theReturnList.add(theOption);
			}
        }
		log.debug("Exiting getQueryOnlySpeciesList.size " + theReturnList.size());
        return theReturnList;
    }
 
 
    /**
     * Returns a list of all Institution  
     * Used for submission and search screens
     * 
     * @return Institution
     * @throws Exception
     */
    private static List getQueryInstitutionList(HttpServletRequest inRequest,
                                                String inAddBlank) throws Exception
    {
        log.debug("Entering NewDropdownUtil.getQueryInstitutionList");

        Annotations annot = new Annotations();
		Login login = new Login();
        // Get values for dropdown lists for Institution
        List<DropdownOption> theReturnList = new ArrayList<DropdownOption>();

        Vector logins = login.retrieveAllWhere("loginuid is not null order by pi_name");

    	Hashtable v1 = new Hashtable();
		for (int j = 0; j < logins.size(); j++) {
			Login LogIn = (Login) logins.elementAt(j);

			if (LogIn.getLoginuid() != null) {
				if (LogIn.getInstitute() != null) {

					Vector v = annot.retrieveByANNOTATIONS__DONATOR_ID(LogIn.getLoginuid());

					if (v.size() != 0) {
						DropdownOption theOption = new DropdownOption(LogIn.getInstitute(), LogIn.getInstitute());
						theReturnList.add(theOption);
					}//if
				}//if
			}//if
		}//for
        
        
		log.debug("Exiting getQueryInstitutionList.size " + theReturnList.size());
        return theReturnList;
    }
 
    /**
     * Returns a list of all Institution  
     * Used for submission and search screens
     * 
     * @return Institution
     * @throws Exception
     */
    private static List getQueryPIList(HttpServletRequest inRequest,
                                                String inAddBlank) throws Exception
    {
        log.debug("Entering NewDropdownUtil.getQueryPIList");

        Annotations annot = new Annotations();
		Login login = new Login();
        // Get values for dropdown lists for Institution
        List<DropdownOption> theReturnList = new ArrayList<DropdownOption>();

        Vector logins = login.retrieveAllWhere("loginuid is not null order by pi_name");

    	Hashtable v1 = new Hashtable();
		for (int j = 0; j < logins.size(); j++) {
			Login LogIn = (Login) logins.elementAt(j);

			if (LogIn.getLoginuid() != null) {
				if (LogIn.getInstitute() != null) {

					Vector v = annot.retrieveByANNOTATIONS__DONATOR_ID(LogIn.getLoginuid());

					if (v.size() != 0) {
						DropdownOption theOption = new DropdownOption(LogIn.getPi_name(), LogIn.getLoginuid().toString());
						theReturnList.add(theOption);
					}//if
				}//if
			}//if
		}//for
        
        
		log.debug("Exiting getQueryPIList.size " + theReturnList.size());
        return theReturnList;
    }
    
    /**
     * Returns a list of all Staining  
     * Used for submission and search screens
     * 
     * @return Staining
     * @throws Exception
     */
    private static List getQueryStainingList(HttpServletRequest inRequest,
                                                String inAddBlank) throws Exception
    {
        log.debug("Entering NewDropdownUtil.getQueryStainingList");

        // Get values for dropdown lists for Staining
        List<DropdownOption> theReturnList = new ArrayList<DropdownOption>();
        Stain st = new Stain();
		Vector stain = st.retrieveAllWhere("stain_name IS NOT NULL ORDER BY stain_description");
		for (int j = 0; j < stain.size(); j++) {
			Stain St = (Stain) stain.elementAt(j);
			if (St.getStain_id() != null) {
				DropdownOption theOption = new DropdownOption(St.getStain_description(), St.getStain_id().toString());
				theReturnList.add(theOption);
			}
		}
		log.debug("Exiting getQueryStainingList.size " + theReturnList.size());
        return theReturnList;
    }

    
    /**
     * Returns a list of all Strain  
     * Used for submission and search screens
     * 
     * @return Strain
     * @throws Exception
     */
    private static List getQueryStrainList(HttpServletRequest inRequest,
                                                String inAddBlank) throws Exception
    {
        log.debug("Entering NewDropdownUtil.getQueryStrainList");

        // Get values for dropdown lists for Strain
        List<DropdownOption> theReturnList = new ArrayList<DropdownOption>();
        Strain str = new Strain();
		Vector strain = str.retrieveAllWhere("strain_name IS NOT NULL ORDER BY strain_name");
		for (int j = 0; j < strain.size(); j++) {
			Strain Str = (Strain) strain.elementAt(j);
			if (Str.getStrain_id() != null) {
				DropdownOption theOption = new DropdownOption(Str.getStrain_name(), Str.getStrain_id().toString());
				theReturnList.add(theOption);
			}
		}
		log.debug("Exiting getQueryStrainList.size " + theReturnList.size());
        return theReturnList;
    }
 
    /**
     * Add Other to the list in the first spot if it's not already there.
     * Removes it and put's it in the first spot if it is.
     */
    private static void addOther(List inList)
    {
 
        if (!inList.contains(Constants.Dropdowns.OTHER_OPTION))
        {
            inList.add(0, Constants.Dropdowns.OTHER_OPTION);
        }
        else
        {
            inList.remove(Constants.Dropdowns.OTHER_OPTION);
            inList.add(0, Constants.Dropdowns.OTHER_OPTION);
        }
    }
 
    /**
     * Add Not Specified to the list in the first spot if it's not already there.
     * Removes it and put's it in the second spot if it is.
     */
    private static void addNotSpecified(List inList)
    {
 
        if (!inList.contains(Constants.Dropdowns.NOT_SPECIFIED_OPTION))
        {
            inList.add(0, Constants.Dropdowns.NOT_SPECIFIED_OPTION);
        }
        else
        {
            inList.remove(Constants.Dropdowns.NOT_SPECIFIED_OPTION);
            inList.add(0, Constants.Dropdowns.NOT_SPECIFIED_OPTION);
        }
    }
 
    /**
     * Add Other to the list in the first spot if it's not already there.
     * Removes it and put's it in the first spot if it is.
     */
    private static void addOtherOption(List inList)
    {
 
        DropdownOption theDropdownOption = new DropdownOption(Constants.Dropdowns.OTHER_OPTION, Constants.Dropdowns.OTHER_OPTION);
 
        if (!inList.contains(theDropdownOption))
        {
            inList.add(0, theDropdownOption);
        }
        else
        {
            inList.remove(theDropdownOption);
            inList.add(0, theDropdownOption);
        }
    }
 
    /**
     * Add "" to the list in the first spot if it's not already there. Removes
     * it and put's it in the first spot if it is.
     */
    private static void addBlank(List inList)
    {
 
        if (!inList.contains(""))
        {
            inList.add(0, "");
        }
        else
        {
            inList.remove("");
            inList.add(0, "");
        }
    }
 
    /**
     * Add "" to the list in the first spot if it's not already there. Removes
     * it and put's it in the first spot if it is.
     */
    private static void addBlankOption(List inList)
    {
 
        DropdownOption theDropdownOption = new DropdownOption("", "");
 
        if (!inList.contains(theDropdownOption))
        {
            inList.add(0, theDropdownOption);
        }
        else
        {
            inList.remove(theDropdownOption);
            inList.add(0, theDropdownOption);
        }
    }
 
}
