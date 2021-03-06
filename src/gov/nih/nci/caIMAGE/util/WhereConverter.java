/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;

import java.util.*;
import java.lang.*;

public class WhereConverter
{

    public static String convert(String nextwhere,
                                 int cnt)
    {
        String where = "";
        if (cnt > 1 && where != null)
        {
            where += nextwhere + " AND ";

        }
        else if (cnt > 1)
        {
            where = nextwhere + " AND ";

        }
        else if (cnt == 1 && where != null)
        {

            where += nextwhere;

        }
        else
        {
            where = nextwhere;

        }

        return where;
    }
}
