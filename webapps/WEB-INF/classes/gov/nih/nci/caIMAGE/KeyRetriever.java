//	Himanso Sahni
//	SAIC NCI
//	MMHCC
// Jan 16,2000
package gov.nih.nci.caIMAGE;



import java.util.*;
import java.sql.*;
import gov.nih.nci.caimage.db.*;


public class KeyRetriever{

  private static Hashtable tableSequences;

  static
  {
    tableSequences = new Hashtable();
    tableSequences.put ("ANNOTATIONS", "ANNOTATION_ID");
	tableSequences.put ("PUBLICATION", "PUBLICATION_ID");
	tableSequences.put ("STAIN", "STAIN_ID");
	tableSequences.put ("STRAIN", "STRAIN_ID");
   }

  /**
   * Retrieves the next key value in an automatic numeric sequence for a
   * given table. These keys are provided in the database via a separate
   * sequence table. This call increments the key value, guaranteeing that
   * the returned value is unique (avoiding database race conditions).
   *
   * @param	tableName	name of the database table (case-insensitive)
   * @return	a Long containing the new key value, or null if the given table has no sequence
   */
  public Long getNextKey (String tableName)
  {
    // To do this:
    // 1. Open a new connection with NO autocommit.
    // 2. UPDATE the key value (by incrementing it) in the sequence table.
    // 3. SELECT the key value from the table.
    // 4. Commit the connection and close.
    // 5. Return the key!
    // This sequence of actions should implicitly lock the table row in step 2
    // and unlock it in 4, thereby guaranteeing uniqueness.

    tableName = tableName.toUpperCase();
    String keyName = (String) tableSequences.get (tableName);
	System.out.println("keyName:"+keyName);
    if (keyName == null)
      {
	System.err.println ("No sequence is in place for table " +
			       tableName);
	return null;
      }

    Long keyValue = null;
    DatabaseAccess access = new DatabaseAccess();
    try {
      // 1. Open a connection with NO autocommit.
      access.connect();
      access._con.setAutoCommit (false);

      // 2. UPDATE the key value (by incrementing it) in the sequence table.
      String updateQuery =
	"UPDATE TABLE_KEY " +
	"SET KEY_VALUE = KEY_VALUE + 1 " +
	"WHERE KEY_NAME = '" + keyName + "'";
	//System.out.println("updateQuery:"+updateQuery);
      access.doUpdateQuery (updateQuery);

      // 3. SELECT the key value from the table.
      String selectQuery =
	"SELECT KEY_VALUE FROM TABLE_KEY " +
	"WHERE KEY_NAME = '" + keyName + "'";
	//System.out.println("selectQuery:"+selectQuery);
      ResultSet rset = access.executeQuery (selectQuery);
      if (rset.next())
	{
	  keyValue = new Long (rset.getLong ("KEY_VALUE"));
	 // System.out.println("keyValue:"+keyValue);
	}
      else
	{
	  System.err.println ("Couldn't locate sequence " + keyName +
				 " in sequence table");
	  keyValue = null;
	}

      // 4. Commit the connection and close.
      access._con.commit();
    } catch (SQLException exc) {
      System.err.println (exc.getMessage());
    } finally {
      try {access.disconnect();} catch (SQLException exc) {}
    }

    return keyValue;
  }
  
}
