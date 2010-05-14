 package gov.nih.nci.caIMAGE.util;
 
 
 import java.lang.*;
 import java.util.*;
 import java.sql.*;
 import gov.nih.nci.caIMAGE.simpleandfile;
 import org.apache.log4j.Logger;
 
  public class Selection{
  public static Logger logger = Logger.getLogger(simpleandfile.class);
    public static String setSelected(String availCvgLvl, String selCvgLvl)
{
	String selected = "";
	if (selCvgLvl.equalsIgnoreCase("Mouse"))
	selected = "SELECTED";
	//logger.debug("The selected value of Mouse"+selCvgLvl);
	
	return selected;
	}

 }
	  
	  
	 
	 
    
