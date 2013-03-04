/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See https://github.com/NCIP/caimage/LICENSE.txt for details.
 */

 package gov.nih.nci.caIMAGE.util;
 
 import java.util.*;  
 import java.lang.*; 
 import gov.nih.nci.caimage.db.*;
 
  public class CommaConcat{
    
	public static String convert(String criteria, int cnt){
       String criteriamod = "";
	   if(criteria != null && cnt > 1 && !criteria.equals("null")) {
		criteriamod = criteria +"," ;
		}else {  
		criteriamod = criteria ;
		} 
	   return 	criteriamod;
		}
	 }
