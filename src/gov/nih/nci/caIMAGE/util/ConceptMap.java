/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;


import java.lang.*;
import java.util.*;
import gov.nih.nci.caimage.db.*;
import java.sql.*;

public class ConceptMap
{
    public static String convert(String name) throws SQLException
    {
        String result = "";
        Conceptid_mapping cm = new Conceptid_mapping();
        Vector con = cm.retrieveAllWhere("CONCEPTID = '" + name + "'");

        Conceptid_mapping Con = null;
        if (!con.isEmpty())
        {
            for (int k = 0; k < con.size(); k++)
            {

                Con = (Conceptid_mapping) con.elementAt(k);
                result = Con.getConceptname().trim();
            } //for
        }//if
        return result;
    }//
}
