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
import gov.nih.nci.caimage.db.*;
import java.sql.*;

public class PublicationImage extends HttpServlet
{

    public void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException
    {
        String publication = request.getParameter("journal_id");
        if ((publication == null) || publication.length() == 0)
        {

            String[] abc = { "a", "b", "c" };
            //RequestDispatcher dispatcher = request.getRequestDispatcher("abc");
            //dispatcher.forward(request, response); 
            //loadSessionObjects ( abc);
        }
    }

    public static Vector loadSessionObjects(String[] names)
    {

        String imagename = null;
        //Vector imagevac = null;
        Vector objects = new Vector();
        Vector objectsadd = new Vector();

        for (int i = 0; i < names.length; i++)
        {
            try
            {
                Annotations annot = new Annotations();
                String pubsql = "PUBLICATION_ID IN ( SELECT PUBLICATION_ID FROM PUBLICATION WHERE PUBLICATION_name =" + names[i] + " )";
                objects = annot.retrieveAllWhere(pubsql);
                Annotations annots = null;
                for (int k = 0; k < objects.size(); k++)
                {

                    annots = (Annotations) objects.elementAt(k);


                    if (annots.getImage_name() != null)
                    {

                        objectsadd.addElement(annots.getImage_name());

                    }
                }//for
            }
            catch (SQLException e)
            {
                System.err.println("The SQL Exception " + e);
            }
        }
        return objectsadd;
    }


}
