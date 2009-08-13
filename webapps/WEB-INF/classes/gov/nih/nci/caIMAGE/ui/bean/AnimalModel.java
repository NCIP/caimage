package nci.mmhcc.ui.bean;

import java.beans.*;
import java.io.Serializable;
import java.util.HashMap;
/*
 * Animal
 * @author  yostj
 * @version 1.0
 * Created on March 20, 2001, 5:49 PM
 */

public class AnimalModel extends HashMap implements Serializable 
{

    private static final String PROP_SAMPLE_PROPERTY = "SampleProperty";

    private String sampleProperty;

    private PropertyChangeSupport propertySupport;

    /** Creates new Animal */
    public AnimalModel() 
    {
        propertySupport = new PropertyChangeSupport ( this );
    }

    public void addAttribute(String name, String value)
    {
        super.put(name,value);
    }
    
    public void getAttribute (String name)
    {
        super.get(name);
    }
    
    public String getSampleProperty () {
        return sampleProperty;
    }

    public void setSampleProperty (String value) {
        String oldValue = sampleProperty;
        sampleProperty = value;
        propertySupport.firePropertyChange (PROP_SAMPLE_PROPERTY, oldValue, sampleProperty);
    }


    public void addPropertyChangeListener (PropertyChangeListener listener) {
        propertySupport.addPropertyChangeListener (listener);
    }

    public void removePropertyChangeListener (PropertyChangeListener listener) {
        propertySupport.removePropertyChangeListener (listener);
    }

}

