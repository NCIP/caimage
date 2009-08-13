 package gov.nih.nci.caIMAGE.util;
 
 
 import java.lang.*;
 import java.util.*;
 import gov.nih.nci.caimage.db.*;  
 import java.sql.*;
 
  public class ConceptMap{
    public static String convert(String name) throws SQLException  {
        String result ="";	 
	   	Conceptid_mapping cm = new Conceptid_mapping();
		Vector con = cm.retrieveAllWhere("CONCEPTID = '"+name+"'");
		System.out.println(con);
		Conceptid_mapping Con = null;
		if(!con.isEmpty()) {
			for(int k =0; k < con.size(); k++){
			System.out.println("The value of k "+ k );
			Con = (Conceptid_mapping) con.elementAt(k);
			result = Con.getConceptname().trim(); 
			} //for
		}//if
	    return result;
	    }//
	  }
	  
	  
	 
	 
    
