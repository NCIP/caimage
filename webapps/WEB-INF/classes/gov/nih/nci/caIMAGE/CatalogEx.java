//	Ajay Gupta
//	SAIC NCI
//	MMHCC
// March 8,2000


package gov.nih.nci.caIMAGE;



import java.util.*;
import java.sql.*;
import gov.nih.nci.caimage.db.*;
 /**
  * Combines class Catalog, class Metadata, class imagedata
  */
public class CatalogEx extends DatabaseAccess {
    protected int columnCount = 0;
	protected int count = 0;
    protected String[] columnNames;
    protected String uri;
    protected String image;
    protected String imagedesc;
    protected String nunlevel;
    protected String catdir;
    protected String catalog;
    protected String catdesc;
	protected String catalogs;
	protected String  mimagewidth;
	protected String mimageheight;
	protected String  mnunlevel;
    protected String  mregion;
	protected String  mrefcat;
	protected String catalogdescription;
	protected String model;
	protected Long key;
	
public int getColumnCount() {
    return(columnCount);
    }

public void setCatalog(String catalog)
{
  this.catalog=catalog;
}


public String getCatalog()
{
  return catalog;
}
public void setCatdir(String catdir)
{
  this.catdir=catdir;
}


public String getCatdir()
{
  return catdir;
}


public void setCatdesc(String catdesc)
{
  this.catdesc=catdesc;
}

public String getCatdesc()
{
  return catdesc;
}

public void setUri(String uri)
{
  this.uri=uri;
}


public String getUri()
{
  return uri;
}
public void setImage(String image)
{
  this.image=image;
}


public String getImage()
{
  return image;
}
public void setNunLevel(String nunlevel)
{
  this.nunlevel=nunlevel;
}


public String getNunLevel()
{
  return nunlevel;
}
public void setImageDesc(String imagedesc)
{
  this.imagedesc=imagedesc;
}


public String getImageDesc()
{
  return imagedesc;
}


public String getCatalogs()
{
  return catalogs;
}
public void setImageWidth(String mimagewidth)
{
  this.mimagewidth=mimagewidth;
}
public String getImageWidth()
{
  return mimagewidth;
}
public void setImageHeight(String mimageheight)
{
  this.mimageheight=mimageheight;
}
public String getImageHeight()
{
  return mimageheight;
}
public void setMnunLevel(String mnunlevel)
{
  this.mnunlevel=mnunlevel;
}
public String getMnunLevel()
{
  return mnunlevel;
}
public void setRegion(String region)
{
  this.mregion=mregion;
}
public String getRegion()
{
  return mregion;
}
public void setRefcat(String mrefcat)
{
  this.mrefcat=mrefcat;
}
public String getRefcat()
{
  return mrefcat;
}

public String getCatalogDesc()
{
  return catalogdescription;
}
public String getModel()
{
  return model;
}
public void setKey(Long key)
{
  this.key=key;
}
public Long getKey()
{
  return key;
}

public void getFromResultSet (ResultSet r) throws SQLException
{

      catalog=r.getString("CATALOG");
      catdir=r.getString("CATDIR");
      catdesc=r.getString("CATDESC");
      uri=r.getString("URI");
      image=r.getString("IMAGE_NAME");
      nunlevel=r.getString("NUNLEVEL");
      imagedesc= r.getString("IMAGE_DESCRIPTION");
}
public void getFromResultImageSet (ResultSet r) throws SQLException
{
      mimagewidth=r.getString("IMAGEWIDTH");
	  mimageheight=r.getString("IMAGEHEIGHT");
	  mnunlevel=r.getString("NUNLEVEL");
      mregion=r.getString("REGION");
	  mrefcat=r.getString("REF_CAT");
}
public void getFromResultCatalogSet (ResultSet r) throws SQLException
{

      catalogs=r.getString("CATALOG");
	  catalogdescription= r.getString("CATDESC");
	  key=new Long(r.getLong("KEY"));
	  if (r.wasNull()) key=null;
	       
}
public void getFromResultModelSet (ResultSet r) throws SQLException
{

      model=r.getString("MODEL");
	 
      
}

public Vector retrieveAllWhereModelkeyIs(String modelkey) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
CatalogEx curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select c.CATALOG, c.CATDIR, c.CATDESC, m.URI, m.IMAGE_NAME, m.NUNLEVEL, m.IMAGE_DESCRIPTION" ;
    from = " from catalog c , metadata m ";
	where = "where c.catdesc = " + "'" +  modelkey +  "'"  ;
    joins = " and c.catalog = m.ref_cat " ;

    query = select + from + where + joins ;
	System.out.println(query);
        ResultSet r = executeQuery(query);
	//populate column names
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
        //System.out.println("the column count is"+columnCount);
        columnNames = new String[columnCount];
        //System.out.println("The col name is"+columnNames);

	// Column index starts at 1 (a la SQL) not 0 (a la Java).
		for(int i=1; i<columnCount+1; i++) {
			columnNames[i-1] =
			resultsMetaData.getColumnName(i).trim();
                        System.out.println("the value is"+resultsMetaData.getColumnName(i).trim());
			}
	//populate object
    while (r.next())
    {
      curRow = new CatalogEx();
      curRow.getFromResultSet(r);
      retRows.addElement(curRow);
      System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveAllWhereImagekeyIs(String imagekey) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
CatalogEx curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "SELECT imageWidth , imageHeight , nunLevel , region , ref_cat " ;
    from = " from metadata ";
	where = "where uri = " + "'" +  imagekey +  "'"  ;
    
    query = select + from + where ;
	System.out.println(query);
        ResultSet r = executeQuery(query);
	//populate column names
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
        //System.out.println("the column count is"+columnCount);
        columnNames = new String[columnCount];
        //System.out.println("The col name is"+columnNames);

	// Column index starts at 1 (a la SQL) not 0 (a la Java).
		for(int i=1; i<columnCount+1; i++) {
			columnNames[i-1] =
			resultsMetaData.getColumnName(i).trim();
                        System.out.println("the value is"+resultsMetaData.getColumnName(i).trim());
			}
	//populate object
    while (r.next())
    {
      curRow = new CatalogEx();
      curRow.getFromResultImageSet(r);
      retRows.addElement(curRow);
      System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveCatalog(String modelkey) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
CatalogEx curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct key, catalog, CATDESC" ;
    from = " from catalog  ";
	where = "where model = " + "'" +  modelkey +  "'"  ;
    query = select + from + where ;
	System.out.println(query);
        ResultSet r = executeQuery(query);
	//populate column names
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
    columnNames = new String[columnCount];
   	// Column index starts at 1 (a la SQL) not 0 (a la Java).
		for(int i=1; i<columnCount+1; i++) {
			columnNames[i-1] =
			resultsMetaData.getColumnName(i).trim();
            System.out.println("the value is"+resultsMetaData.getColumnName(i).trim());
			}
	//populate object
    while (r.next())
    {
      curRow = new CatalogEx();
      curRow.getFromResultCatalogSet(r);
      retRows.addElement(curRow);
      System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public int count(String model) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from CATALOG" +" where model="+"'"+(model==null?"null":model.toString()+"'");
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
public Vector retrieveModel() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
CatalogEx curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct model" ;
    from = " from catalog  ";
	query = select + from  ;
	System.out.println(query);
        ResultSet r = executeQuery(query);
	//populate column names
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
    columnNames = new String[columnCount];
   	// Column index starts at 1 (a la SQL) not 0 (a la Java).
		for(int i=1; i<columnCount+1; i++) {
			columnNames[i-1] =
			resultsMetaData.getColumnName(i).trim();
            System.out.println("the value is"+resultsMetaData.getColumnName(i).trim());
			}
	//populate object
    while (r.next())
    {
      curRow = new CatalogEx();
      curRow.getFromResultModelSet(r);
      retRows.addElement(curRow);
      System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}


}
