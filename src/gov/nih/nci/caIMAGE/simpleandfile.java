//	Himanso Sahni
//	SAIC NCI
//	MMHCC
//  Jan 16,2000
 
  
package gov.nih.nci.caIMAGE;

import java.lang.*;
import java.util.*;
import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.apache.log4j.SimpleLayout;
import org.apache.log4j.FileAppender;
public class simpleandfile {
   static Logger logger = Logger.getLogger(simpleandfile.class);
     SimpleLayout layout = null;

   public static  void log(String depbugstatement) {
   SimpleLayout layout = new SimpleLayout();

      FileAppender appender = null;
      try {
          String userDir = System.getProperty("user.dir");
		 //FileInputStream fis = null;
             if(userDir.indexOf(":")!= -1){ 
                     appender = new FileAppender(layout,"..\\server\\default\\log\\caIMAGE.log",false);
             } else {
                 appender = new FileAppender(layout,"../log/caIMAGE.log",false);
             }
             
      } catch(Exception e) {
	     e.printStackTrace();
	  }

      logger.addAppender(appender);
      logger.setLevel((Level) Level.DEBUG);
	  logger.debug(depbugstatement);
	}
   /*
   public static void main(String args[]) {
      SimpleLayout layout = new SimpleLayout();

      FileAppender appender = null;
      try {
         appender = new FileAppender(layout,"output1.txt",false);
      } catch(Exception e) {}

      logger.addAppender(appender);
      logger.setLevel((Level) Level.DEBUG);

      logger.debug("Here is some DEBUG");
      logger.info("Here is some INFO");
      logger.warn("Here is some WARN");
      logger.error("Here is some ERROR");
      logger.fatal("Here is some FATAL");
   }*/
}
