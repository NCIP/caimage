package gov.nih.nci.caIMAGE;
/**
  * Donator
  * 
  * WARNING! Automatically generated file!
  * Do not edit!
  * Code Generator by J.A.Carter
  */

 import java.sql.*;
import java.io.*;
import java.util.*;
import gov.nih.nci.caimage.db.*;


public class DonatorEx extends DatabaseAccess implements Serializable
{
protected int columnCount = 0;
protected int count = 0;
protected String[] columnNames;
/**
  * Type : BIGINT Name : DONATORUID
  */
  protected Long donatoruid;

/**
  * Type : VARCHAR Name : DI
  */
  protected String di;

/**
  * Type : VARCHAR Name : DI_REF
  */
  protected String di_ref;

/**
  * Type : VARCHAR Name : TYPE
  */
  protected String type;

/**
  * Sets the value for donatoruid
  */
public void setDonatoruid(Long donatoruid)
{
  this.donatoruid=donatoruid;
}

/**
  * Gets the value for donatoruid
  */
public Long getDonatoruid()
{
  return donatoruid;
}

/**
  * Sets the value for di
  */
public void setDi(String di)
{
  this.di=di;
}

/**
  * Gets the value for di
  */
public String getDi()
{
  return di;
}

/**
  * Sets the value for di_ref
  */
public void setDi_ref(String di_ref)
{
  this.di_ref=di_ref;
}

/**
  * Gets the value for di_ref
  */
public String getDi_ref()
{
  return di_ref;
}

/**
  * Sets the value for type
  */
public void setType(String type)
{
  this.type=type;
}

/**
  * Gets the value for type
  */
public String getType()
{
  return type;
}

/**
  * Updates the object from a retrieved ResultSet.
  */
public void getFromResultSet (ResultSet r) throws SQLException
{
      donatoruid=new Long(r.getLong("DONATORUID")); if (r.wasNull()) donatoruid=null;
      di=r.getString("DI");
      di_ref=r.getString("DI_REF");
      type=r.getString("TYPE");
}

/**
  * Retrieve from the database for table "Donator"
  */
 public void getFromResultDiSet (ResultSet r) throws SQLException
{

 di =r.getString("DONATOR_NAME");
}
public void getFromResultDi_refSet (ResultSet r) throws SQLException
{

 di_ref =r.getString("DONATING_INSTITUTION_DESCRIPTN");
}
public Vector retrieveAllWhere(String where) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
DonatorEx curRow;

  if (connect())
  {
    String query = "select * from DONATOR"+" where "+where;
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new DonatorEx();
      curRow.getFromResultSet(r);
      retRows.addElement(curRow);
    }
    r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();  // actually returns the connection to the pool
  }
  return retRows;
}

/**
  * Retrieve from the database for table "Donator"
  */
public Vector retrieveAll() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
DonatorEx curRow;

  if (connect())
  {
    String query = "select * from DONATOR";
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new DonatorEx();
      curRow.getFromResultSet(r);
      retRows.addElement(curRow);
    }
    r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();  // actually returns the connection to the pool
  }
  return retRows;
}

/**
  * Inserts the current object values into the database.
  */
public boolean insert () throws SQLException
{
  boolean TGstatus = false;
  if (connect())
  {
    String query="insert into DONATOR ( DONATORUID,DI,DI_REF,TYPE ) values ( "+(donatoruid==null?"null":donatoruid.toString())+","+DatabaseAccess.formatString(di)+","+DatabaseAccess.formatString(di_ref)+","+DatabaseAccess.formatString(type)+" )";
    TGstatus = doUpdateQuery(query);
    disconnect();
  }
  return TGstatus;
}

/**
  * Counts the number of entries for this table in the database.
  */
public int count() throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from DONATOR" ;
    ResultSet r = executeQuery(query);
    if (r.next())
    {
      count = r.getInt(1);
    }
    r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();
  }
  return count;
}
public Vector retrieveDi() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
DonatorEx curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct donator_name" ;
    from = " from donator  ";
	query = select + from  ;
	System.out.println(query);
        ResultSet r = executeQuery(query);
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
    columnNames = new String[columnCount];
   	// Column index starts at 1 (a la SQL) not 0 (a la Java).
		for(int i=1; i<columnCount+1; i++) {
			columnNames[i-1] =
			resultsMetaData.getColumnName(i).trim();
            System.out.println("the value is"+resultsMetaData.getColumnName(i).trim());
			}
	while (r.next())
    {
      curRow = new DonatorEx();
      curRow.getFromResultDiSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }
  return retRows;
}
public Vector retrieveDi_Ref() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
DonatorEx curRow= null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct DONATING_INSTITUTION_DESCRIPTN" ;
    from = " from donating_Institution  ";
	query = select + from  ;
	System.out.println(query);
        ResultSet r = executeQuery(query);
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
    columnNames = new String[columnCount];
   	// Column index starts at 1 (a la SQL) not 0 (a la Java).
		for(int i=1; i<columnCount+1; i++) {
			columnNames[i-1] =
			resultsMetaData.getColumnName(i).trim();
            System.out.println("the value is"+resultsMetaData.getColumnName(i).trim());
			}
	while (r.next())
    {
      curRow = new DonatorEx();
      curRow.getFromResultDi_refSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}

}
