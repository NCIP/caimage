/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

/**
 * 
 * $Id: SafeHTMLUtil.java,v 1.10 2008-08-27 13:58:21 pandyas Exp $
 *
 * $Log: not supported by cvs2svn $
 * Revision 1.9  2008/08/14 16:40:46  pandyas
 * remove debug lines
 *
 * Revision 1.8  2008/07/21 18:24:28  pandyas
 * Modified to prevent SQL injection
 * Scan performed on July 21, 2008
 *
 * Revision 1.7  2008/06/23 18:10:08  pandyas
 * Modified to prevent Cross-Site Scripting
 * Cleaned parameter name before proceeding - added filter for 'javascript'
 * Re: Apps Scan run 06/17/2008
 *
 * Revision 1.6  2008/06/06 17:40:16  pandyas
 * comment out logging
 *
 * Revision 1.5  2008/05/27 14:33:21  pandyas
 * Modified to prevent SQL injection
 * Added and modified clean methods
 * Re: Apps Scan run 05/23/2008
 *
 * Revision 1.4  2008/05/23 14:14:54  pandyas
 * Modified advanced search and TOC to prevent SQL injection
 * Added specific clean methods for text entry fields
 * Re: Apps Scan run 05/15/2008
 *
 * Revision 1.3  2008/05/22 18:22:28  pandyas
 * Modified advanced search and TOC to prevent SQL injection
 * Modified method name
 * Re: Apps Scan run 05/15/2008
 *
 * Revision 1.2  2008/05/21 19:33:27  pandyas
 * Added htmlparser.jar version for future reference
 *
 * Revision 1.1  2008/05/21 19:04:36  pandyas
 * Modified advanced search to prevent SQL injection
 * Concolidated all utility methods in new class
 * Re: Apps Scan run 05/15/2008
 *
 * 
 *  Author for class name and clean():  Ryan Landy
 *  Utility to clean malicious characters from code to prevent 
 *  SQL injection attacks
 *  Addeed utility methods from other sources to one central class
 *  htmlparser.jar  version 1.6  	release June 10, 2006
 */

package gov.nih.nci.caIMAGE.util;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.htmlparser.util.Translate; 
import java.net.*;

public class SafeHTMLUtil {
    public static final String unallowableCharacters = ";!\"\'@#\\$%^&*()+=/{}[]~|?`";
	
    public static String clean(String s)    {
    	String clean = Translate.decode(s).replace("<", "").replace(">", "");
        clean = StringUtils.replace(clean, "script", "");
        clean = StringUtils.replace(clean, "%27", "");        
        clean = StringUtils.replace(clean, "%", "");
        clean = StringUtils.replace(clean, "#", "");
        clean = StringUtils.replace(clean, ";", "");
        clean = StringUtils.replace(clean, "'", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "$", "");
        clean = StringUtils.replace(clean, "&", "");
        clean = StringUtils.replace(clean, "(", "");
        clean = StringUtils.replace(clean, ")", "");
        clean = StringUtils.replace(clean, "/", "");
        clean = StringUtils.replace(clean, "\\", "");
        clean = StringUtils.replace(clean, "&", "");
        clean = StringUtils.replace(clean, "=", "");        
        clean = StringUtils.replace(clean, "quot", "");         
        clean = StringUtils.replace(clean, "javascript", "");
        clean = StringUtils.replace(clean, "alert", "cleaned");
        clean = StringUtils.replace(clean, "CR", "");
        clean = StringUtils.replace(clean, "LF", "");
        clean = StringUtils.replace(clean, "<", "");
        clean = StringUtils.replace(clean, ">", "");
        if(clean.length()==0){
            clean = "empty";
        }
        return clean;       
    }
    
    // clean method that allows the /
    public static String cleanWithSlash(String s)    {
    	String clean = Translate.decode(s).replace("<", "").replace(">", "");
        clean = StringUtils.replace(clean, "script", "");
        clean = StringUtils.replace(clean, "%27", "");        
        clean = StringUtils.replace(clean, "%", "");
        clean = StringUtils.replace(clean, "#", "");
        clean = StringUtils.replace(clean, ";", "");
        clean = StringUtils.replace(clean, "'", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "$", "");
        clean = StringUtils.replace(clean, "&", "");
        clean = StringUtils.replace(clean, "(", "");
        clean = StringUtils.replace(clean, ")", "");
        clean = StringUtils.replace(clean, "\\", "");
        clean = StringUtils.replace(clean, "&", "");
        clean = StringUtils.replace(clean, "=", "");        
        clean = StringUtils.replace(clean, "quot", "");         
        clean = StringUtils.replace(clean, "javascript", "");
        clean = StringUtils.replace(clean, "alert", "cleaned");
        clean = StringUtils.replace(clean, "CR", "");
        clean = StringUtils.replace(clean, "LF", "");
        clean = StringUtils.replace(clean, "<", "");
        clean = StringUtils.replace(clean, ">", "");        
        if(clean.length()==0){
                clean = "empty";
        }
        return clean;       
    }
    // clean method that allows the apostrophe (')
    public static String cleanKeyword(String s)    {
        String clean = Translate.decode(s).replace("<", "").replace(">", "");
        clean = StringUtils.replace(clean, "script", "");
        clean = StringUtils.replace(clean, "%", "");
        clean = StringUtils.replace(clean, "#", "");
        clean = StringUtils.replace(clean, ";", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "$", "");
        clean = StringUtils.replace(clean, "&", "");
        clean = StringUtils.replace(clean, "(", "");
        clean = StringUtils.replace(clean, ")", "");
        clean = StringUtils.replace(clean, "/", "");
        clean = StringUtils.replace(clean, "\\", "");
        if(clean.length()==0){
                clean = "empty";
        }
        return clean;       
    }    

    // clean method that only cleans {, }, script, %, \, \\ 
    public static String cleanModelDescriptor(String s)    {
        String clean = Translate.decode(s).replace("{", "").replace("}", "");
        clean = StringUtils.replace(clean, "script", "");
        clean = StringUtils.replace(clean, "%", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "$", "");
        clean = StringUtils.replace(clean, "\\", "");
        if(clean.length()==0){
                clean = "empty";
        }
        return clean;       
    }    

    // clean method that allows ', &
    public static String cleanPhenotype(String s)    {
        String clean = Translate.decode(s).replace("<", "").replace(">", "");
        clean = StringUtils.replace(clean, "script", "");
        clean = StringUtils.replace(clean, "%", "");
        clean = StringUtils.replace(clean, "#", "");
        clean = StringUtils.replace(clean, ";", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "$", "");
        clean = StringUtils.replace(clean, "(", "");
        clean = StringUtils.replace(clean, ")", "");
        clean = StringUtils.replace(clean, "/", "");
        clean = StringUtils.replace(clean, "\\", "");
        if(clean.length()==0){
                clean = "empty";
        }
        return clean;       
    }    
    
    // clean method that allows <, >, (, ), /
    public static String cleanGeneName(String s)    {
        String clean = Translate.decode(s).replace("[", "").replace("]", "");
        clean = StringUtils.replace(clean, "script", "");       
        clean = StringUtils.replace(clean, "%", "");
        clean = StringUtils.replace(clean, "#", "");
        clean = StringUtils.replace(clean, ";", "");
        clean = StringUtils.replace(clean, "'", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "$", "");
        clean = StringUtils.replace(clean, "&", "");
        clean = StringUtils.replace(clean, "\\", "");
        if(clean.length()==0){
                clean = "empty";
        }
        return clean;       
    }
    
    // clean method that allows <, >, (, ), /
    public static String cleanLDAP(String s)    {
        String clean = Translate.decode(s).replace("[", "").replace("]", "");
        clean = StringUtils.replace(clean, "#", "");       
        clean = StringUtils.replace(clean, ",", "");
        clean = StringUtils.replace(clean, "+", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "\\", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "<", "");
        clean = StringUtils.replace(clean, ">", "");
        clean = StringUtils.replace(clean, ";", "");
        clean = StringUtils.replace(clean, "(", "");
        clean = StringUtils.replace(clean, ")", "");
        if(clean.length()==0){
                clean = "empty";
        }
        return clean;       
    }    
    
    // allows &, ", /, ?, and . that are used in redirects
    public static String cleanRedirect(String s)    {
        String clean = Translate.decode(s).replace("<", "").replace(">", "");
        clean = StringUtils.replace(clean, "script", "");
        clean = StringUtils.replace(clean, "probe", "");         
        clean = StringUtils.replace(clean, "%", "");
        clean = StringUtils.replace(clean, "#", "");
        clean = StringUtils.replace(clean, ";", "");
        clean = StringUtils.replace(clean, "'", "");
        clean = StringUtils.replace(clean, "\"", "");
        clean = StringUtils.replace(clean, "$", "");
        clean = StringUtils.replace(clean, "(", "");
        clean = StringUtils.replace(clean, ")", "");
        clean = StringUtils.replace(clean, "/", "");
        clean = StringUtils.replace(clean, "\\", "");
        if(clean.length()==0){
                clean = "empty";
        }
        return clean;       
    } 
    
    /**
     * A utlity method to check the valid value againts the dropdown options
     * Author for method: 
     * @param input - the data to be validated
     * @param source - the source against which the input to be validated
     * @param request - http request
     * @return boolean
     */
    public static boolean isValidValue(String input, String source, HttpServletRequest request)
    {
        String trimInput = input.trim();
        
        // validate for intentCode
        List dropDownList = (List) request.getSession().getAttribute(source);        
        String nv = null ;
        boolean validValue = true ;
        if (trimInput != null && trimInput.length() > 0 && dropDownList != null )
        {
            // assign the value to false
            validValue = false ;
            
            for (int i = 0 ; i < dropDownList.size() ; i++ )
            {               
                nv  = ((DropdownOption) dropDownList.get(i)).getValue();
                if (nv.equals(input))
                {
                    validValue = true ;
                    break ;
                }
            }
        }
        return validValue ;
    }
    
    /**
     * A utility method to check the valid value against a string values
     * Author for method: 
     * @param input - the data to be validated
     * @param source - the source against which the input to be validated
     * @param request - http request
     * @return boolean
     */    
    public static boolean isValidStringValue(String input , String source , HttpServletRequest request)
    {
        // validate for intentCode
    	System.out.println("SafeHTMLUtil.isValidStringValue.");
        List dropDownList = (List) request.getSession().getAttribute(source);        
        String nv = null ;
        boolean validValue = true ;
        if (input != null && input.length() > 0 && dropDownList != null )
        {
            // assign the value to false
            validValue = false ;
             
            for (int i = 0 ; i < dropDownList.size() ; i++ )
            {               
                nv  =  ((DropdownOption)dropDownList.get(i)).getLabel(); 
                if (nv.equals(input))
                {
                    validValue = true ;
                    break ;
                }
            }
        }
        return validValue ;
    }
    
    // This method needs testing for successful searches
    // This is a special case where one of the agent names contains a special character "/" or space
    //  i.e. Chemical / Drug, Growth Factor, and Signaling Molecule are valid selection options
    public static boolean isLetterOrDigitWithExceptions(String input)
    { 
        // validate for intentCode
        boolean validValue = true ;
        if (input != null && !input.equals("Chemical / Drug") && !input.equals("Growth Factor") && !input.equals("Signaling Molecule"))
        {
            for (int i = 0; i < input.length(); i++)
            {        	
	            if (!Character.isLetterOrDigit(input.charAt(i)))
	                return false;
            }
        } else if (input.equals("Chemical / Drug")){
        	input = "ChemicalDrug";
            for (int i = 0; i < input.length(); i++)
            {        	
	            if (!Character.isLetterOrDigit(input.charAt(i)))
	                return false;
            }        	
        } else if (input.equals("Growth Factor")){
        	input = "GrowthFactor";
            for (int i = 0; i < input.length(); i++)
            {        	
	            if (!Character.isLetterOrDigit(input.charAt(i)))
	                return false;
            }        	
        } else if (input.equals("Signaling Molecule")){
        	input = "SignalingMolecule";
            for (int i = 0; i < input.length(); i++)
            {        	
	            if (!Character.isLetterOrDigit(input.charAt(i)))
	                return false;
            }        	
        }
        
        return true; 
    }    
    
    // This method needs testing for successful searches
    public static boolean isJavaIdentifierPart(String input)
    { 
        for (int i = 0; i < input.length(); i++)
        {
                if (!Character.isJavaIdentifierPart(input.charAt(i)))
                return false;
        }
        return true;
    }  
    
    // This method needs testing for successful searches
    public static String trimInput(String input)
    { 
        for (int i = 0; i < input.length(); i++)
        {
                input = input.trim();
        }
        return input;
    }     
    
    
    // This method needs testing for successful searches
    public static boolean isLetterOrDigit(String input)
    {  
        for (int i = 0; i < input.length(); i++)
        {
                if (!Character.isLetterOrDigit(input.charAt(i)))
                return false;
        }
        return true;
    } 
    
    // This method needs testing for successful searches
    public static boolean isLetter(String input)
    {  
        for (int i = 0; i < input.length(); i++)
        {
                if (!Character.isLetter(input.charAt(i)))
                return false;
        }
        return true;
    }     

    public static boolean contains(String unallowableCharacters, String stringToTest) 
    {
	Boolean rv = false;
	
	if(unallowableCharacters!=null && stringToTest!=null) {
	    char[] filterString = unallowableCharacters.toCharArray();
	    filterString = stringToTest.toCharArray();
	    for(int i = 0; i<filterString.length;i++) {
		if(unallowableCharacters.indexOf(filterString[i])!=-1){
		    rv = true;
		}
	    }
	}
	return rv;		
    }

    public static boolean containsUnallowableCharacters(String stringToTest, Boolean decode) {
	Boolean rv = false;
	try {
	    if (decode)
		stringToTest = URLDecoder.decode(stringToTest, "UTF-8");
	    rv = contains(unallowableCharacters, stringToTest);
	    if (decode)
		stringToTest = URLEncoder.encode(stringToTest, "UTF-8");
	} catch (Exception e) {
	};
	return rv;
    }
}
