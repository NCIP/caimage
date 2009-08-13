package gov.nih.nci.caIMAGE;
/**
  * Login
  * 
  * WARNING! Automatically generated file!
  * Do not edit!
  * Code Generator by J.A.Carter
  */

import java.sql.*;
import java.io.*;
import java.util.Vector;
import gov.nih.nci.caimage.db.DatabaseAccess;
import gov.nih.nci.caimage.db.DbGlobal;
import gov.nih.nci.caimage.db.*;

public class LoginEx extends DatabaseAccess implements Serializable
{
protected int columnCount = 0;
protected int count = 0;
protected String[] columnNames;
/**
  * Type : BIGINT Name : LOGINUID
  */
  protected Long loginuid;

/**
  * Type : VARCHAR Name : LASTNAME
  */
  protected String lastname;

/**
  * Type : VARCHAR Name : FIRSTNAME
  */
  protected String firstname;

/**
  * Type : VARCHAR Name : EMAIL
  */
  protected String email;

/**
  * Type : VARCHAR Name : PHONE
  */
  protected String phone;

/**
  * Type : VARCHAR Name : FAX
  */
  protected String fax;

/**
  * Type : VARCHAR Name : INSTITUTE
  */
  protected String institute;

/**
  * Type : VARCHAR Name : LABORATORY
  */
  protected String laboratory;

/**
  * Type : VARCHAR Name : PASSWORD
  */
  protected String password;

/**
  * Type : VARCHAR Name : ADDRESS1
  */
  protected String address1;

/**
  * Type : VARCHAR Name : ADDRESS2
  */
  protected String address2;

/**
  * Type : VARCHAR Name : CITY
  */
  protected String city;

/**
  * Type : VARCHAR Name : STATE
  */
  protected String state;

/**
  * Type : VARCHAR Name : ZIP
  */
  protected String zip;

/**
  * Type : VARCHAR Name : COUNTRY
  */
  protected String country;

/**
  * Type : VARCHAR Name : USERNAME
  */
  protected String username;

/**
  * Type : BIGINT Name : MMHCC_MEMBER
  */
  protected Long mmhcc_member;

/**
  * Type : BIGINT Name : PROJECTTYPEKEY
  */
  protected Long projecttypekey;

/**
  * Type : VARCHAR Name : PI_NAME
  */
  protected String pi_name;

/**
  * Type : VARCHAR Name : PI_EMAIL
  */
  protected String pi_email;

/**
  * Sets the value for loginuid
  */
public void setLoginuid(Long loginuid)
{
  this.loginuid=loginuid;
}

/**
  * Gets the value for loginuid
  */
public Long getLoginuid()
{
  return loginuid;
}

/**
  * Sets the value for lastname
  */
public void setLastname(String lastname)
{
  this.lastname=lastname;
}

/**
  * Gets the value for lastname
  */
public String getLastname()
{
  return lastname;
}

/**
  * Sets the value for firstname
  */
public void setFirstname(String firstname)
{
  this.firstname=firstname;
}

/**
  * Gets the value for firstname
  */
public String getFirstname()
{
  return firstname;
}

/**
  * Sets the value for email
  */
public void setEmail(String email)
{
  this.email=email;
}

/**
  * Gets the value for email
  */
public String getEmail()
{
  return email;
}

/**
  * Sets the value for phone
  */
public void setPhone(String phone)
{
  this.phone=phone;
}

/**
  * Gets the value for phone
  */
public String getPhone()
{
  return phone;
}

/**
  * Sets the value for fax
  */
public void setFax(String fax)
{
  this.fax=fax;
}

/**
  * Gets the value for fax
  */
public String getFax()
{
  return fax;
}

/**
  * Sets the value for institute
  */
public void setInstitute(String institute)
{
  this.institute=institute;
}

/**
  * Gets the value for institute
  */
public String getInstitute()
{
  return institute;
}

/**
  * Sets the value for laboratory
  */
public void setLaboratory(String laboratory)
{
  this.laboratory=laboratory;
}

/**
  * Gets the value for laboratory
  */
public String getLaboratory()
{
  return laboratory;
}

/**
  * Sets the value for password
  */
public void setPassword(String password)
{
  this.password=password;
}

/**
  * Gets the value for password
  */
public String getPassword()
{
  return password;
}

/**
  * Sets the value for address1
  */
public void setAddress1(String address1)
{
  this.address1=address1;
}

/**
  * Gets the value for address1
  */
public String getAddress1()
{
  return address1;
}

/**
  * Sets the value for address2
  */
public void setAddress2(String address2)
{
  this.address2=address2;
}

/**
  * Gets the value for address2
  */
public String getAddress2()
{
  return address2;
}

/**
  * Sets the value for city
  */
public void setCity(String city)
{
  this.city=city;
}

/**
  * Gets the value for city
  */
public String getCity()
{
  return city;
}

/**
  * Sets the value for state
  */
public void setState(String state)
{
  this.state=state;
}

/**
  * Gets the value for state
  */
public String getState()
{
  return state;
}

/**
  * Sets the value for zip
  */
public void setZip(String zip)
{
  this.zip=zip;
}

/**
  * Gets the value for zip
  */
public String getZip()
{
  return zip;
}

/**
  * Sets the value for country
  */
public void setCountry(String country)
{
  this.country=country;
}

/**
  * Gets the value for country
  */
public String getCountry()
{
  return country;
}

/**
  * Sets the value for username
  */
public void setUsername(String username)
{
  this.username=username;
}

/**
  * Gets the value for username
  */
public String getUsername()
{
  return username;
}

/**
  * Sets the value for mmhcc_member
  */
public void setMmhcc_member(Long mmhcc_member)
{
  this.mmhcc_member=mmhcc_member;
}

/**
  * Gets the value for mmhcc_member
  */
public Long getMmhcc_member()
{
  return mmhcc_member;
}

/**
  * Sets the value for projecttypekey
  */
public void setProjecttypekey(Long projecttypekey)
{
  this.projecttypekey=projecttypekey;
}

/**
  * Gets the value for projecttypekey
  */
public Long getProjecttypekey()
{
  return projecttypekey;
}

/**
  * Sets the value for pi_name
  */
public void setPi_name(String pi_name)
{
  this.pi_name=pi_name;
}

/**
  * Gets the value for pi_name
  */
public String getPi_name()
{
  return pi_name;
}

/**
  * Sets the value for pi_email
  */
public void setPi_email(String pi_email)
{
  this.pi_email=pi_email;
}

/**
  * Gets the value for pi_email
  */
public String getPi_email()
{
  return pi_email;
}

/**
  * Updates the object from a retrieved ResultSet.
  */
public void getFromResultSet (ResultSet r) throws SQLException
{
      loginuid=new Long(r.getLong("LOGINUID")); if (r.wasNull()) loginuid=null;
      lastname=r.getString("LASTNAME");
      firstname=r.getString("FIRSTNAME");
      email=r.getString("EMAIL");
      phone=r.getString("PHONE");
      fax=r.getString("FAX");
      institute=r.getString("INSTITUTE");
      laboratory=r.getString("LABORATORY");
      password=r.getString("PASSWORD");
      address1=r.getString("ADDRESS1");
      address2=r.getString("ADDRESS2");
      city=r.getString("CITY");
      state=r.getString("STATE");
      zip=r.getString("ZIP");
      country=r.getString("COUNTRY");
      username=r.getString("USERNAME");
      mmhcc_member=new Long(r.getLong("MMHCC_MEMBER")); if (r.wasNull()) mmhcc_member=null;
      projecttypekey=new Long(r.getLong("PROJECTTYPEKEY")); if (r.wasNull()) projecttypekey=null;
      pi_name=r.getString("PI_NAME");
      pi_email=r.getString("PI_EMAIL");
}

public void getFromResultPi_NMAESet (ResultSet r) throws SQLException
{

 pi_name =r.getString("PI_NAME");
}
/**
  * Retrieve from the database for table "LOGIN"
 */
public boolean retrieveByKey(Long loginuid) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "select * from LOGIN"+" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    ResultSet r = executeQuery(query);
    if (r.next())
    {
      getFromResultSet(r);
      TGstatus = true;
    }
    r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();  // actually returns the connection to the pool
  }
  return TGstatus;
}

/**
  * Retrieve from the database for table "Login"
  */
public Vector retrieveAllLikeKey(Long loginuid) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
LoginEx curRow;

  if (connect())
  {
    String query = "select * from LOGIN"+" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new LoginEx();
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
  * Updates the current object values into the database.
  */
public boolean updateByKey() throws SQLException
{
  boolean TGstatus = false;
  if (connect())
  {
    String query="update LOGIN set "+
"LOGINUID="+(loginuid==null?"null":loginuid.toString())+","+
"LASTNAME="+DatabaseAccess.formatString(lastname)+","+
"FIRSTNAME="+DatabaseAccess.formatString(firstname)+","+
"EMAIL="+DatabaseAccess.formatString(email)+","+
"PHONE="+DatabaseAccess.formatString(phone)+","+
"FAX="+DatabaseAccess.formatString(fax)+","+
"INSTITUTE="+DatabaseAccess.formatString(institute)+","+
"LABORATORY="+DatabaseAccess.formatString(laboratory)+","+
"PASSWORD="+DatabaseAccess.formatString(password)+","+
"ADDRESS1="+DatabaseAccess.formatString(address1)+","+
"ADDRESS2="+DatabaseAccess.formatString(address2)+","+
"CITY="+DatabaseAccess.formatString(city)+","+
"STATE="+DatabaseAccess.formatString(state)+","+
"ZIP="+DatabaseAccess.formatString(zip)+","+
"COUNTRY="+DatabaseAccess.formatString(country)+","+
"USERNAME="+DatabaseAccess.formatString(username)+","+
"MMHCC_MEMBER="+(mmhcc_member==null?"null":mmhcc_member.toString())+","+
"PROJECTTYPEKEY="+(projecttypekey==null?"null":projecttypekey.toString())+","+
"PI_NAME="+DatabaseAccess.formatString(pi_name)+","+
"PI_EMAIL="+DatabaseAccess.formatString(pi_email)+" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    TGstatus = doUpdateQuery(query);
    disconnect();
  }
  return TGstatus;
}

/**
  * Deletes from the database for table "LOGIN"
  */
public boolean deleteByKey(Long loginuid) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "delete from LOGIN where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    TGstatus = doUpdateQuery(query);
    disconnect();  // actually returns the connection to the pool
  }
  return TGstatus;
}

/**
  * Counts the number of entries for this table in the database.
  */
public int countByKey(Long loginuid) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from LOGIN" +" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
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

/**
  * Counts the number of entries for this table in the database.
  */
public int countLikeKey(Long loginuid) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from LOGIN" +" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
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

/**
  * Get all related  ANNOTATIONS which have same donator_id
  */
public Vector getRelatedANNOTATIONS__DONATOR_ID() throws SQLException
{
	Annotations x;
	x = new Annotations();
	return x.retrieveByANNOTATIONS__DONATOR_ID(loginuid);
}
/**
  * Retrieve from the database for table "LOGIN"
 */
public boolean retrieveByIndex(Long loginuid) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "select * from LOGIN"+" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    ResultSet r = executeQuery(query);
    if (r.next())
    {
      getFromResultSet(r);
      TGstatus = true;
    }
    r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();  // actually returns the connection to the pool
  }
  return TGstatus;
}

/**
  * Retrieve from the database for table "Login"
  */
public Vector retrieveAllLikeIndex(Long loginuid) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
LoginEx curRow;

  if (connect())
  {
    String query = "select * from LOGIN"+" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new LoginEx();
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
  * Updates the current object values into the database.
  */
public boolean updateByIndex() throws SQLException
{
  boolean TGstatus = false;
  if (connect())
  {
    String query="update LOGIN set "+
"LOGINUID="+(loginuid==null?"null":loginuid.toString())+","+
"LASTNAME="+DatabaseAccess.formatString(lastname)+","+
"FIRSTNAME="+DatabaseAccess.formatString(firstname)+","+
"EMAIL="+DatabaseAccess.formatString(email)+","+
"PHONE="+DatabaseAccess.formatString(phone)+","+
"FAX="+DatabaseAccess.formatString(fax)+","+
"INSTITUTE="+DatabaseAccess.formatString(institute)+","+
"LABORATORY="+DatabaseAccess.formatString(laboratory)+","+
"PASSWORD="+DatabaseAccess.formatString(password)+","+
"ADDRESS1="+DatabaseAccess.formatString(address1)+","+
"ADDRESS2="+DatabaseAccess.formatString(address2)+","+
"CITY="+DatabaseAccess.formatString(city)+","+
"STATE="+DatabaseAccess.formatString(state)+","+
"ZIP="+DatabaseAccess.formatString(zip)+","+
"COUNTRY="+DatabaseAccess.formatString(country)+","+
"USERNAME="+DatabaseAccess.formatString(username)+","+
"MMHCC_MEMBER="+(mmhcc_member==null?"null":mmhcc_member.toString())+","+
"PROJECTTYPEKEY="+(projecttypekey==null?"null":projecttypekey.toString())+","+
"PI_NAME="+DatabaseAccess.formatString(pi_name)+","+
"PI_EMAIL="+DatabaseAccess.formatString(pi_email)+" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    TGstatus = doUpdateQuery(query);
    disconnect();
  }
  return TGstatus;
}

/**
  * Deletes from the database for table "LOGIN"
  */
public boolean deleteByIndex(Long loginuid) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "delete from LOGIN where LOGINUID="+(loginuid==null?"null":loginuid.toString());
    TGstatus = doUpdateQuery(query);
    disconnect();  // actually returns the connection to the pool
  }
  return TGstatus;
}

/**
  * Counts the number of entries for this table in the database.
  */
public int countByIndex(Long loginuid) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from LOGIN" +" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
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

/**
  * Counts the number of entries for this table in the database.
  */
public int countLikeIndex(Long loginuid) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from LOGIN" +" where LOGINUID="+(loginuid==null?"null":loginuid.toString());
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

/**
  * Retrieve from the database for table "Login"
  */
public Vector retrieveAllWhere(String where) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
LoginEx curRow;

  if (connect())
  {
    String query = "select * from LOGIN"+" where "+where;
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new LoginEx();
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
  * Retrieve from the database for table "Login"
  */
public Vector retrieveAll() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
LoginEx curRow;

  if (connect())
  {
    String query = "select * from LOGIN";
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new LoginEx();
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
    String query="insert into LOGIN ( LOGINUID,LASTNAME,FIRSTNAME,EMAIL,PHONE,FAX,INSTITUTE,LABORATORY,PASSWORD,ADDRESS1,ADDRESS2,CITY,STATE,ZIP,COUNTRY,USERNAME,MMHCC_MEMBER,PROJECTTYPEKEY,PI_NAME,PI_EMAIL ) values ( "+(loginuid==null?"null":loginuid.toString())+","+DatabaseAccess.formatString(lastname)+","+DatabaseAccess.formatString(firstname)+","+DatabaseAccess.formatString(email)+","+DatabaseAccess.formatString(phone)+","+DatabaseAccess.formatString(fax)+","+DatabaseAccess.formatString(institute)+","+DatabaseAccess.formatString(laboratory)+","+DatabaseAccess.formatString(password)+","+DatabaseAccess.formatString(address1)+","+DatabaseAccess.formatString(address2)+","+DatabaseAccess.formatString(city)+","+DatabaseAccess.formatString(state)+","+DatabaseAccess.formatString(zip)+","+DatabaseAccess.formatString(country)+","+DatabaseAccess.formatString(username)+","+(mmhcc_member==null?"null":mmhcc_member.toString())+","+(projecttypekey==null?"null":projecttypekey.toString())+","+DatabaseAccess.formatString(pi_name)+","+DatabaseAccess.formatString(pi_email)+" )";
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
    String query="select count(*) from LOGIN" ;
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
public Vector retrievePI_name() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
LoginEx curRow= null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
     select = "select distinct PI_NAME" ;
    from = " from LOGIN";
	query = select + from  ;
	System.out.println(query);
        ResultSet r = executeQuery(query);
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
	System.out.println("the columnCount is"+columnCount);
    columnNames = new String[columnCount];
   	// Column index starts at 1 (a la SQL) not 0 (a la Java).
		for(int i=1; i<columnCount+1; i++) {
			columnNames[i-1] = resultsMetaData.getColumnName(i).trim();
            System.out.println("the value is"+resultsMetaData.getColumnName(i).trim());
			}
	while (r.next())
    {
      curRow = new LoginEx();
      curRow.getFromResultPi_NMAESet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
     r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();  // actually returns the connection to the pool
 }

  return retRows;
}


}
