package nci.mmhcc.ui.bean;

import java.util.Hashtable;
import java.util.Set;
import javax.servlet.http.*;

/*
 * UIBean
 * Created on March 21, 2001, 4:25 PM
 * @author  John Yost
 * @version 1.0
 *
 * The UIBean class is a java bean backed by a Hashtable containing data from form input.  The UIBean class is especially 
 * useful in situations where form input is captured over several JSP or HTML pages.  Putting the data into a UIBean object 
 * will prevent having a large amount of data being bound directly to the user session.
 */

public class UIBean extends Hashtable implements HttpSessionBindingListener
{
    private String name;
    
    public UIBean() {}
    
    public void setProperty (String name, Object object)
    {
        super.put (name,object);
    }
    
    public Object getProperty (String name)
    {
        return super.get(name);
    }
    
    public Set getPropertyNames()
    {
        return super.keySet();
    }
    
    public boolean hasProperty(String name)
    {
        return super.containsKey(name);
    }
    
    public boolean propertyNotNull(String name)
    {
        return super.get(name) != null;
    }
    
    public void setName (String name)
    {
        this.name = name;
    }
    
    public UIBean getUIBean (String name)
    {
        if (this.name == name)
        {
            return this;
        }
        return null;
    }

/** The valueUnbound method is invoked when the UIBean is unBound or removed
 * from the session.  Some implementations will persist the object to a
 * database, bind to another object, etc...
 */    
    public void valueUnbound(HttpSessionBindingEvent p1) 
    {       
    }
    
    public void valueBound(HttpSessionBindingEvent p1) 
    {
    }
    
}

