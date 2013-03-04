/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See https://github.com/NCIP/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;

import java.util.*;
import javax.servlet.http.*;
import javax.servlet.ServletContext;
import java.io.*;

/**
 * ServletManager.java
 * Created on March 30, 2001, 10:02 AM
 * @author  John Yost SAIC
 * @version 1.0
 */
public class ServletManager
{

    public ServletManager() {}
    
    public void setHeaders (HttpServletResponse response, HashMap parameters)
    {
        Set keys = parameters.keySet();
        Iterator iterator = keys.iterator();
        
        while (iterator.hasNext())
        {
            String name = (String) iterator.next();
            response.setHeader(name,(String) parameters.get(name));
        }
    }  
    
    public Properties loadProperties (String classpath)
        throws ServletLoadException
    {
        InputStream is = getClass().getResourceAsStream(classpath);
        Properties p = new Properties();
        try {
            p.load(is);
        } catch (IOException e)
        {
            throw new ServletLoadException("Properties File Did Not Load");
        }
        return p;
    }
    
    public void bindToServletContext (ServletContext context, String name, Object object)
    {
        context.setAttribute(name, object);
    }
}

