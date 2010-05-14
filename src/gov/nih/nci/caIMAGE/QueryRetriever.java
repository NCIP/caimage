//	Himanso Sahni
//	SAIC NCI
//	MMHCC
// Jan 16,2000
package gov.nih.nci.caIMAGE;



import java.util.*;
import java.sql.*;
import gov.nih.nci.caimage.db.*;
import java.io.*;


public class QueryRetriever{

 
  /**
   * Retrieves the next key value in an automatic numeric sequence for a
   * given table. These keys are provided in the database via a separate
   * sequence table. This call increments the key value, guaranteeing that
   * the returned value is unique (avoiding database race conditions).
   *
   * @param	tableName	name of the database table (case-insensitive)
   * @return	a Long containing the new key value, or null if the given table has no sequence
   */
  public static String getQuery (String queryParam)
  {
  String querysep = null;
  if(queryParam !=  null && !queryParam.equals("") && !queryParam.equals("null") ) {
	
		StringBuffer whereBuf = new StringBuffer();
		String queryParamsep = null;
			if(queryParam.indexOf(",")!=-1){// this is for generic diagnosis search
		     StringTokenizer tokens = new StringTokenizer(queryParam,",");
			 	while(tokens.hasMoreTokens()){
			  	queryParamsep = tokens.nextToken();
			  	whereBuf.append("'"+ queryParamsep.substring(queryParam.indexOf("C")+1) +"'"+",");
			 	}//while
			  	whereBuf.deleteCharAt (whereBuf.length()-1);
		
			  querysep= whereBuf.toString();
			  }//if
		     else {
			 querysep= queryParam;
			 }//else
		}//if query param
		return querysep;
	}//get query
}//query retriver
