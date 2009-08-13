package gov.nih.nci.caIMAGE.util;

/*
 * SessionManagement.java
 * Created on March 20, 2001, 5:19 PM
 * @author  John Yost SAIC
 * @version 1.0
 */

import java.util.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.*;
public class SessionManager
{
    private HttpSession session;
    private static int inactive = -1;  //will not expire;
    public SessionManager(HttpServletRequest req, int interval) 
    {
        //this.session = session;
       req.getSession().setMaxInactiveInterval(interval);
        req.getSession().setAttribute("nci.mmhcc.sessionId", req.getSession().getId());
        
    }
	
/** The verifySession method determines if there is an existing session and
 * whether the session id matches the id bound to the session object.  This ensures
 * that the client does not have multiple sessions.  If the session is invalid, then 
 * user is redirected to specified page.
 */    
    public static void verifySession (HttpServletRequest req, HttpServletResponse res, String url)
    {
		SessionManager.setSessionProperties(req.getSession(),inactive);
        if (req.getSession().isNew() || !((req.getSession().getId()).equals(req.getSession().getAttribute("nci.mmhcc.sessionId"))))//!nci.mmhcc.loginId.equals(req.getSession().getId()))
        {
            try {
			RequestDispatcher dispatcher = 	req.getRequestDispatcher(url);
  			dispatcher.forward(req, res); 
             res.sendRedirect(url);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
       
    /*
     * The createSession method handles client entering site from a non-java application.  The aSession boolean is from a
     * hidden value field.  This method will create a session if the client does not have a current session and is a valid
     * user from another application that should be granted access to the site or to privileged areas of site
     */
    
    public static void createSession (HttpServletRequest req, String client)
    {
        Boolean aSession = new Boolean (client);
        
        if (req.getSession(false) == null && aSession.booleanValue() == true)
        {
            req.getSession(true);
        }
    }   
    
    public static void setId (HttpServletRequest req)
    {
       req.getSession().setAttribute("nci.mmhcc.loginId",req.getSession().getId());
    }
    
    public static String getId (HttpServletRequest req)
    {
        return (String) req.getSession().getAttribute("nci.mmhcc.loginId");
    }   
    
    public static void setSessionProperties(HttpSession session, int inactive)
    {
        session.setAttribute("nci.mmhcc.loginId",session.getId());
        session.setMaxInactiveInterval(inactive);
    }
    
/** This version of setSessionIdentity is used when the individual identity
 * attributes are bound directly to the session.
 */    
    public static void setSessionIdentity (HttpSession session, Hashtable properties)
    {
        Set keys = properties.keySet();
        Iterator iterator = keys.iterator();
        
        while (iterator.hasNext())
        {
            String name = (String) iterator.next();            
            session.setAttribute(name,properties.get(name));
        }
    }
    
/** This version of setSessionIdentity is used if the identity attributes are
 * encapsulated within a javabean object.
 */    
    public static void setSessionIdentity (HttpSession session, Hashtable properties, String name)
    {          
        session.setAttribute(name,properties);
    }
 
    public static void setSessionIdentity (HttpSession session, String name, String password)
    {
        session.setAttribute("name",name);
        session.setAttribute("password",password);
    }
    
    public static Vector loadSessionObjects (HttpSession session, String[] names)
    {
        Vector objects = new Vector();
        
        for (int i=0; i < names.length; i++)
        {
            try {
                objects.add(Class.forName(names[i]));
            } catch (ClassNotFoundException e){
                System.out.println("The Class " + names[i] + " Not Found-- Check Classpath");
            }
        }        
        return objects;
    }
    
    public static void confirmSessionObjects(HttpSession session)
    {
    }
	/** This will set the inactive 
 */    
    public static void setSessionIdentity (HttpSession session, int inact)
    {          
       inactive = inact;
    }
}

