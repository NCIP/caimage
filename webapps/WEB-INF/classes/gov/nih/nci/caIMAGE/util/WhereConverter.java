 package gov.nih.nci.caIMAGE.util;
 
 import java.util.*;  
 import java.lang.*; 
 
  public class WhereConverter{
    
	public static String convert(String nextwhere, int cnt){
       String where = "";
	   if(cnt > 1 && where != null){
				where += nextwhere+ " AND ";
				//System.out.println(" where"+where+"count"+cnt);  
				} 
		   else if(cnt > 1 ){
				where = nextwhere +" AND ";
				//System.out.println(" where"+where+"count"+cnt); 
				 }
		   else if (cnt == 1 && where != null){
		   		//System.out.println(" where before"+where+"count"+cnt); 
		       where += nextwhere ;
			   //System.out.println(" and where"+where+"count"+cnt); 
			   }
			   else {
		       where = nextwhere;
			   //System.out.println(" and where"+where+"count"+cnt); 
			   }
	   
	   return where;
		}
	  }
