/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.Servlet;

import java.util.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;

/**
 * DispatcherServlet.java
 * Created on May 29, 2001
 * @author  Himanso Sahni SAIC
 * @version 1.0
 */
public class DispatcherServlet extends HttpServlet{
public void doGet (HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException
    {
	String dispatchURL = request.getParameter ("url");
       if (dispatchURL == null)//if no URL is passed
         dispatchURL = "Error.html";
		//Status 205 clears the content of the form feilds by resetting the document
		//response.setStatus(205);
	
		RequestDispatcher dispatcher =
   		 	request.getRequestDispatcher(dispatchURL);
  			dispatcher.forward(request, response); 
	}
public void doPost (HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException
    {
	doGet(request,  response);
	}
} 
