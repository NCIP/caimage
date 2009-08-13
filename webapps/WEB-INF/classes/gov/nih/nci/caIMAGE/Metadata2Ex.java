package gov.nih.nci.caIMAGE;
/**
  * Metadata2
  * 
  * WARNING! Automatically generated file!
  * Do not edit!
  * Code Generator by J.A.Carter
  */

import java.sql.*;
import java.io.*;
import java.util.*;
import gov.nih.nci.caimage.db.*;

// XML SDK classes
import org.w3c.dom.*;
import org.w3c.dom.Document;
import org.xml.sax.*;
import javax.xml.parsers.*;
import javax.xml.*;

public class Metadata2Ex extends DatabaseAccess 
{
protected int columnCount = 0;
protected int count = 0;
protected String[] columnNames;
/**
  * Type : VARCHAR Name : TABLE_KEY
  */
  protected String table_key;

/**
  * Type : VARCHAR Name : CATALOG
  */
  protected String catalog;

/**
  * Type : VARCHAR Name : IMAGE
  */
  protected String image;

/**
  * Type : VARCHAR Name : DI
  */
  protected String di;

/**
  * Type : VARCHAR Name : DI_REF
  */
  protected String di_ref;

/**
  * Type : VARCHAR Name : PMID
  */
  protected String pmid;

/**
  * Type : VARCHAR Name : IMAGE_NAME
  */
  protected String image_name;

/**
  * Type : VARCHAR Name : IMAGE_DIAGNOSIS
  */
  protected String image_diagnosis;

/**
  * Type : VARCHAR Name : IMAGE_ANNOTATIONS
  */
  protected String image_annotations;

/**
  * Type : VARCHAR Name : ORGAN
  */
  protected String organ;

/**
  * Type : VARCHAR Name : SPECIES
  */
  protected String species;

/**
  * Type : VARCHAR Name : STRAIN
  */
  protected String strain;

/**
  * Type : CHAR(3) Name : GENDER
  */
  protected String gender;

/**
  * Type : VARCHAR Name : MODEL
  */
  protected String model;

/**
  * Type : VARCHAR Name : PROMOTER
  */
  protected String promoter;

/**
  * Type : VARCHAR Name : GENE
  */
  protected String gene;

/**
  * Type : VARCHAR Name : STAIN
  */
  protected String stain;

/**
  * Type : VARCHAR Name : NUMLEVEL
  */
  protected String numlevel;

/**
  * Type : VARCHAR Name : IMAGEWIDTH
  */
  protected String imagewidth;

/**
  * Type : VARCHAR Name : IMAGEHEIGHT
  */
  protected String imageheight;

/**
  * Type : VARCHAR Name : IMAGETYPE
  */
  protected String imagetype;
protected String tissue;
 protected String observation;
 protected String journal;
/**
  * Sets the value for table_key
  */
public void setTable_key(String table_key)
{
  this.table_key=table_key;
}

/**
  * Gets the value for table_key
  */
public String getTable_key()
{
  return table_key;
}

/**
  * Sets the value for catalog
  */
public void setCatalog(String catalog)
{
  this.catalog=catalog;
}

/**
  * Gets the value for catalog
  */
public String getCatalog()
{
  return catalog;
}

/**
  * Sets the value for image
  */
public void setImage(String image)
{
  this.image=image;
}

/**
  * Gets the value for image
  */
public String getImage()
{
  return image;
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
  * Sets the value for pmid
  */
public void setPmid(String pmid)
{
  this.pmid=pmid;
}

/**
  * Gets the value for pmid
  */
public String getPmid()
{
  return pmid;
}

/**
  * Sets the value for image_name
  */
public void setImage_name(String image_name)
{
  this.image_name=image_name;
}

/**
  * Gets the value for image_name
  */
public String getImage_name()
{
  return image_name;
}

/**
  * Sets the value for image_diagnosis
  */
public void setImage_diagnosis(String image_diagnosis)
{
  this.image_diagnosis=image_diagnosis;
}

/**
  * Gets the value for image_diagnosis
  */
public String getImage_diagnosis()
{
  return image_diagnosis;
}

/**
  * Sets the value for image_annotations
  */
public void setImage_annotations(String image_annotations)
{
  this.image_annotations=image_annotations;
}

/**
  * Gets the value for image_annotations
  */
public String getImage_annotations()
{
  return image_annotations;
}

/**
  * Sets the value for organ
  */
public void setOrgan(String organ)
{
  this.organ=organ;
}

/**
  * Gets the value for organ
  */
public String getOrgan()
{
  return organ;
}

/**
  * Sets the value for species
  */
public void setSpecies(String species)
{
  this.species=species;
}

/**
  * Gets the value for species
  */
public String getSpecies()
{
  return species;
}

/**
  * Sets the value for strain
  */
public void setStrain(String strain)
{
  this.strain=strain;
}

/**
  * Gets the value for strain
  */
public String getStrain()
{
  return strain;
}

/**
  * Sets the value for gender
  */
public void setGender(String gender)
{
  this.gender=gender;
}

/**
  * Gets the value for gender
  */
public String getGender()
{
  return gender;
}

/**
  * Sets the value for model
  */
public void setModel(String model)
{
  this.model=model;
}

/**
  * Gets the value for model
  */
public String getModel()
{
  return model;
}

/**
  * Sets the value for promoter
  */
public void setPromoter(String promoter)
{
  this.promoter=promoter;
}

/**
  * Gets the value for promoter
  */
public String getPromoter()
{
  return promoter;
}

/**
  * Sets the value for gene
  */
public void setGene(String gene)
{
  this.gene=gene;
}

/**
  * Gets the value for gene
  */
public String getGene()
{
  return gene;
}

/**
  * Sets the value for stain
  */
public void setStain(String stain)
{
  this.stain=stain;
}

/**
  * Gets the value for stain
  */
public String getStain()
{
  return stain;
}

/**
  * Sets the value for numlevel
  */
public void setNumlevel(String numlevel)
{
  this.numlevel=numlevel;
}

/**
  * Gets the value for numlevel
  */
public String getNumlevel()
{
  return numlevel;
}

/**
  * Sets the value for imagewidth
  */
public void setImagewidth(String imagewidth)
{
  this.imagewidth=imagewidth;
}

/**
  * Gets the value for imagewidth
  */
public String getImagewidth()
{
  return imagewidth;
}

/**
  * Sets the value for imageheight
  */
public void setImageheight(String imageheight)
{
  this.imageheight=imageheight;
}

/**
  * Gets the value for imageheight
  */
public String getImageheight()
{
  return imageheight;
}

/**
  * Sets the value for imagetype
  */
public void setImagetype(String imagetype)
{
  this.imagetype=imagetype;
}

/**
  * Gets the value for imagetype
  */
public String getImagetype()
{
  return imagetype;
}
public void setTissue(String tissue)
{
  this.tissue=tissue;
}

/**
  * Gets the value for tissue
  */
public String getTissue()
{
  return tissue;
}
public void setObservation(String observation)
{
  this.observation=observation;
}

/**
  * Gets the value for observation
  */
public String getObservation()
{
  return observation;
}
public void setJournal(String journal)
{
  this.journal=journal;
}
public String getJournal()
{
  return journal;
}
/**
  * Updates the object from a retrieved ResultSet.
  */
public void getFromResultSet (ResultSet r) throws SQLException
{
      table_key=r.getString("TABLE_KEY");
      catalog=r.getString("CATALOG");
      image=r.getString("IMAGE");
      di=r.getString("DI");
      di_ref=r.getString("DI_REF");
      pmid=r.getString("PMID");
      image_name=r.getString("IMAGE_NAME");
      image_diagnosis=r.getString("IMAGE_DIAGNOSIS");
      image_annotations=r.getString("IMAGE_ANNOTATIONS");
      organ=r.getString("ORGAN");
      species=r.getString("SPECIES");
      strain=r.getString("STRAIN");
      gender=r.getString("GENDER");
      model=r.getString("MODEL");
      promoter=r.getString("PROMOTER");
      gene=r.getString("GENE");
      stain=r.getString("STAIN");
      numlevel=r.getString("NUMLEVEL");
      imagewidth=r.getString("IMAGEWIDTH");
      imageheight=r.getString("IMAGEHEIGHT");
      imagetype=r.getString("IMAGETYPE");
	   tissue=r.getString("TISSUE");
      observation=r.getString("OBSERVATION");
}

/**
  * Retrieve from the database for table "Metadata2Ex2"
 */
public boolean retrieveByKey(String table_key) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "select * from METADATA2"+" where TABLE_KEY="+DatabaseAccess.formatString(table_key);
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
  * Retrieve from the database for table "Metadata2"
  */
public Vector retrieveAllLikeKey(String table_key) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow;

  if (connect())
  {
    String query = "select * from METADATA2"+" where TABLE_KEY like "+DatabaseAccess.formatString(table_key);
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new Metadata2Ex();
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
    String query="update METADATA2 set "+
"TABLE_KEY="+DatabaseAccess.formatString(table_key)+","+
"CATALOG="+DatabaseAccess.formatString(catalog)+","+
"IMAGE="+DatabaseAccess.formatString(image)+","+
"DI="+DatabaseAccess.formatString(di)+","+
"DI_REF="+DatabaseAccess.formatString(di_ref)+","+
"PMID="+DatabaseAccess.formatString(pmid)+","+
"IMAGE_NAME="+DatabaseAccess.formatString(image_name)+","+
"IMAGE_DIAGNOSIS="+DatabaseAccess.formatString(image_diagnosis)+","+
"IMAGE_ANNOTATIONS="+DatabaseAccess.formatString(image_annotations)+","+
"ORGAN="+DatabaseAccess.formatString(organ)+","+
"SPECIES="+DatabaseAccess.formatString(species)+","+
"STRAIN="+DatabaseAccess.formatString(strain)+","+
"GENDER="+DatabaseAccess.formatString(gender)+","+
"MODEL="+DatabaseAccess.formatString(model)+","+
"PROMOTER="+DatabaseAccess.formatString(promoter)+","+
"GENE="+DatabaseAccess.formatString(gene)+","+
"STAIN="+DatabaseAccess.formatString(stain)+","+
"NUMLEVEL="+DatabaseAccess.formatString(numlevel)+","+
"IMAGEWIDTH="+DatabaseAccess.formatString(imagewidth)+","+
"IMAGEHEIGHT="+DatabaseAccess.formatString(imageheight)+","+
"IMAGETYPE="+DatabaseAccess.formatString(imagetype)+","+
"TISSUE="+DatabaseAccess.formatString(tissue)+","+
"OBSERVATION="+DatabaseAccess.formatString(observation)+" where TABLE_KEY="+DatabaseAccess.formatString(table_key);
 
    TGstatus = doUpdateQuery(query);
    disconnect();
  }
  return TGstatus;
}

/**
  * Deletes from the database for table "METADATA2"
  */
public boolean deleteByKey(String table_key) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "delete from METADATA2 where TABLE_KEY="+DatabaseAccess.formatString(table_key);
    TGstatus = doUpdateQuery(query);
    disconnect();  // actually returns the connection to the pool
  }
  return TGstatus;
}

/**
  * Counts the number of entries for this table in the database.
  */
public int countByKey(String table_key) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from METADATA2" +" where TABLE_KEY="+DatabaseAccess.formatString(table_key);
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
public int countLikeKey(String table_key) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from METADATA2" +" where TABLE_KEY like "+DatabaseAccess.formatString(table_key);
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
  * Retrieve from the database for table "METADATA2"
 */
public boolean retrieveByIndex(String table_key,String image,String catalog) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "select * from METADATA2"+" where TABLE_KEY="+DatabaseAccess.formatString(table_key)+" and IMAGE="+DatabaseAccess.formatString(image)+" and CATALOG="+DatabaseAccess.formatString(catalog);
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
  * Retrieve from the database for table "Metadata2"
  */
public Vector retrieveAllLikeIndex(String table_key,String image,String catalog) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow;

  if (connect())
  {
    String query = "select * from METADATA2"+" where TABLE_KEY like "+DatabaseAccess.formatString(table_key)+" and IMAGE like "+DatabaseAccess.formatString(image)+" and CATALOG like "+DatabaseAccess.formatString(catalog);
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new Metadata2Ex();
      curRow.getFromResultSet(r);
      retRows.addElement(curRow);
    }
    r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();  // actually returns the connection to the pool
  }
  return retRows;
}

public void getFromResultModelSet (ResultSet r) throws SQLException
{

     species=r.getString("SPECIES_NAME");
	 
      
}
public void getFromResultOrganSet (ResultSet r) throws SQLException
{

     organ=r.getString("ORGAN");
	 
      
}
public void getFromResultDignosisSet (ResultSet r) throws SQLException
{

 image_diagnosis =r.getString("IMAGE_DIAGNOSIS");
	 
      
}
public void getFromResultStainSet (ResultSet r) throws SQLException
{

 stain =r.getString("STAIN_NAME");
}
public void getFromResultStrainSet (ResultSet r) throws SQLException
{

 strain =r.getString("STRAIN_NAME");
}
public void getFromResultGeneSet (ResultSet r) throws SQLException
{

 gene =r.getString("GENE");
}
public void getFromResultPromoterSet (ResultSet r) throws SQLException
{

 promoter =r.getString("PROMOTER");
}
public void getFromResultGenderSet (ResultSet r) throws SQLException
{

 gender =r.getString("GENDER_NAME");
}
public void getFromResultPmidSet (ResultSet r) throws SQLException
{

 pmid =r.getString("PMID");
}
public void getFromResultJournalSet (ResultSet r) throws SQLException
{

 journal =r.getString("JOURNALNAME");
}
public void getFromResultTissueSet (ResultSet r) throws SQLException
{

 tissue =r.getString("TISSUE");
}

public void getFromResultObservationSet (ResultSet r) throws SQLException
{

 observation =r.getString("OBSERVATION_NAME");
}

public void getFromResultImageSet (ResultSet r) throws SQLException
{
      imagewidth=r.getString("IMAGEWIDTH");
	  imageheight=r.getString("IMAGEHEIGHT");
	  numlevel=r.getString("NUMLEVEL");
  	  catalog=r.getString("CATALOG");
}
/**
  * Updates the current object values into the database.
  */
public boolean updateByIndex() throws SQLException
{
  boolean TGstatus = false;
  if (connect())
  {
    String query="update METADATA2 set "+
"TABLE_KEY="+DatabaseAccess.formatString(table_key)+","+
"CATALOG="+DatabaseAccess.formatString(catalog)+","+
"IMAGE="+DatabaseAccess.formatString(image)+","+
"DI="+DatabaseAccess.formatString(di)+","+
"DI_REF="+DatabaseAccess.formatString(di_ref)+","+
"PMID="+DatabaseAccess.formatString(pmid)+","+
"IMAGE_NAME="+DatabaseAccess.formatString(image_name)+","+
"IMAGE_DIAGNOSIS="+DatabaseAccess.formatString(image_diagnosis)+","+
"IMAGE_ANNOTATIONS="+DatabaseAccess.formatString(image_annotations)+","+
"ORGAN="+DatabaseAccess.formatString(organ)+","+
"SPECIES="+DatabaseAccess.formatString(species)+","+
"STRAIN="+DatabaseAccess.formatString(strain)+","+
"GENDER="+DatabaseAccess.formatString(gender)+","+
"MODEL="+DatabaseAccess.formatString(model)+","+
"PROMOTER="+DatabaseAccess.formatString(promoter)+","+
"GENE="+DatabaseAccess.formatString(gene)+","+
"STAIN="+DatabaseAccess.formatString(stain)+","+
"NUMLEVEL="+DatabaseAccess.formatString(numlevel)+","+
"IMAGEWIDTH="+DatabaseAccess.formatString(imagewidth)+","+
"IMAGEHEIGHT="+DatabaseAccess.formatString(imageheight)+","+
"IMAGETYPE="+DatabaseAccess.formatString(imagetype)+","+
"TISSUE="+DatabaseAccess.formatString(tissue)+","+
"OBSERVATION="+DatabaseAccess.formatString(observation)+" where TABLE_KEY="+DatabaseAccess.formatString(table_key)+" and IMAGE="+DatabaseAccess.formatString(image)+" and CATALOG="+DatabaseAccess.formatString(catalog);

    TGstatus = doUpdateQuery(query);
    disconnect();
  }
  return TGstatus;
}

/**
  * Deletes from the database for table "METADATA2"
  */
public boolean deleteByIndex(String table_key,String image,String catalog) throws SQLException
{
boolean TGstatus = false;

  if (connect())
  {
    String query = "delete from METADATA2 where TABLE_KEY="+DatabaseAccess.formatString(table_key)+" and IMAGE="+DatabaseAccess.formatString(image)+" and CATALOG="+DatabaseAccess.formatString(catalog);
    TGstatus = doUpdateQuery(query);
    disconnect();  // actually returns the connection to the pool
  }
  return TGstatus;
}

/**
  * Counts the number of entries for this table in the database.
  */
public int countByIndex(String table_key,String image,String catalog) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from METADATA2" +" where TABLE_KEY="+DatabaseAccess.formatString(table_key)+" and IMAGE="+DatabaseAccess.formatString(image)+" and CATALOG="+DatabaseAccess.formatString(catalog);
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
public int countLikeIndex(String table_key,String image,String catalog) throws SQLException
{
  int count = -1;
  if (connect())
  {
    String query="select count(*) from METADATA2" +" where TABLE_KEY like "+DatabaseAccess.formatString(table_key)+" and IMAGE like "+DatabaseAccess.formatString(image)+" and CATALOG like "+DatabaseAccess.formatString(catalog);
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
  * Retrieve from the database for table "Metadata2"
  */
public Vector retrieveAllWhere(String where) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow;

  if (connect())
  {
    String query = "select * from METADATA2"+" where "+where;
    System.out.println(query);
	ResultSet r = executeQuery(query);
	ResultSetMetaData resultsMetaData =  r.getMetaData();
	columnCount = resultsMetaData.getColumnCount();
 	while (r.next())
    {
      curRow = new Metadata2Ex();
      curRow.getFromResultSet(r);
      retRows.addElement(curRow);
    }
    r.close();  // closes the result set
    queryStatement.close();  // closes the statement (and cursor)
    disconnect();  // actually returns the connection to the pool
  }
  return retRows;
}
public Vector retrieveAllWhereImagekeyIs(String imagekey) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "SELECT imageWidth , imageHeight , numLevel , catalog " ;
    from = " from metadata2 ";
	where = "where IMAGE = " + "'" +  imagekey +  "'"  ;
    
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
      curRow = new Metadata2Ex();
      curRow.getFromResultImageSet(r);
      retRows.addElement(curRow);
      System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}

/**
  * Retrieve from the database for table "Metadata2"
  */
public Vector retrieveAll() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow;

  if (connect())
  {
    String query = "select * from METADATA2";
    ResultSet r = executeQuery(query);
    while (r.next())
    {
      curRow = new Metadata2Ex();
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
    String query="insert into METADATA2 ( TABLE_KEY,CATALOG,IMAGE,DI,DI_REF,PMID,IMAGE_NAME,IMAGE_DIAGNOSIS,IMAGE_ANNOTATIONS,ORGAN,SPECIES,STRAIN,GENDER,MODEL,PROMOTER,GENE,STAIN,NUMLEVEL,IMAGEWIDTH,IMAGEHEIGHT,IMAGETYPE,TISSUE,OBSERVATION ) values ( "+DatabaseAccess.formatString(table_key)+","+DatabaseAccess.formatString(catalog)+","+DatabaseAccess.formatString(image)+","+DatabaseAccess.formatString(di)+","+DatabaseAccess.formatString(di_ref)+","+DatabaseAccess.formatString(pmid)+","+DatabaseAccess.formatString(image_name)+","+DatabaseAccess.formatString(image_diagnosis)+","+DatabaseAccess.formatString(image_annotations)+","+DatabaseAccess.formatString(organ)+","+DatabaseAccess.formatString(species)+","+DatabaseAccess.formatString(strain)+","+DatabaseAccess.formatString(gender)+","+DatabaseAccess.formatString(model)+","+DatabaseAccess.formatString(promoter)+","+DatabaseAccess.formatString(gene)+","+DatabaseAccess.formatString(stain)+","+DatabaseAccess.formatString(numlevel)+","+DatabaseAccess.formatString(imagewidth)+","+DatabaseAccess.formatString(imageheight)+","+DatabaseAccess.formatString(imagetype)+","+DatabaseAccess.formatString(tissue)+","+DatabaseAccess.formatString(observation)+" )";
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
    String query="select count(*) from METADATA2" ;
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
public Vector retrieveSpecies() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct species_name" ;
    from = " from species  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultModelSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveOrgan() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct organ" ;
    from = " from metadata2  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultOrganSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveDignosis() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct image_diagnosis" ;
    from = " from metadata2  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultDignosisSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrievePmid() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct pmid" ;
    from = " from metadata2  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultPmidSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }
   return retRows;
}
  public Vector retrieveJournal(String input) throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
 select =  "SELECT DISTINCT JOURNALTYPE.journalname  " ;
from = "FROM PUBLICATIONS, JOURNALTYPE   " ;
 where = "WHERE JOURNALTYPE.id = PUBLICATIONS.JOURNALID AND PUBLICATIONS.PUBLICATIONID = " + "'"+ input +"'" ;
   	query = select + from + where ;
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
      curRow = new Metadata2Ex();
      curRow.getFromResultJournalSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }
  return retRows;
}
public Vector retrieveGender() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct gender_name" ;
    from = " from gender  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultGenderSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrievePromoter() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct promoter" ;
    from = " from metadata2  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultPromoterSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveGene() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct gene" ;
    from = " from metadata2  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultGeneSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveTissue() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct tissue" ;
    from = " from metadata2  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultTissueSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveObservation() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct Observation_name" ;
    from = " from observation  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultObservationSet(r);
      retRows.addElement(curRow);
      System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveStain() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct stain_name" ;
    from = " from stain  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultStainSet(r);
      retRows.addElement(curRow);
      //System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}
public Vector retrieveStrain() throws SQLException
{
boolean TGstatus = false;
Vector retRows = new Vector();
Metadata2Ex curRow = null;
String query, select, from, where, joins, orderby;
  if (connect())
  {
    select = "select distinct strain_name" ;
    from = " from strain  ";
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
      curRow = new Metadata2Ex();
      curRow.getFromResultStrainSet(r);
      retRows.addElement(curRow);
     // System.out.println("The return row is"+retRows);
     }
    disconnect();  // actually returns the connection to the pool
  }

  return retRows;
}

public void xmlStart()
   {

   try {
   DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    try{
     DocumentBuilder builder = factory.newDocumentBuilder();
     Document doc = builder.newDocument();

     Element myElement = toXML(doc);
    System.out.println("xml " + myElement+"\n");

       } catch (ParserConfigurationException pce) {
            // Parser with specified options can't be built
            pce.printStackTrace();
       }
    } catch (Exception e) {
     System.out.println(e.toString());
     e.printStackTrace();
    }
   }
 public Element toXML(Document doc) throws SQLException
    {
       Element item = null;
       Element element = null;

        element = doc.createElement(getClass().getName());

        if (getImage()!=null) {
          element.setAttribute("image", getImage().toString());
		  System.out.println("1");
       }
       if (getImage_name()!=null) {
          item = doc.createElement("imageName");
          item.appendChild(doc.createTextNode(getImage_name().toString()));
          element.appendChild(item);
		    System.out.println("2");
       }
        if (getImage_diagnosis()!=null) {
          item = doc.createElement("imageDiagnosis");
          item.appendChild(doc.createTextNode(getImage_diagnosis().toString()));
          element.appendChild(item);
		    System.out.println("3");
       }
	   if (getImage_annotations()!=null) {
          item = doc.createElement("imageAnnotation");
          item.appendChild(doc.createTextNode(getImage_annotations().toString()));
          element.appendChild(item);
		    System.out.println("4");
       }
	   if (getSpecies()!=null) {
          item = doc.createElement("species");
          item.appendChild(doc.createTextNode(getSpecies().toString()));
          element.appendChild(item);
		    System.out.println("5");
       }
	   if (getOrgan()!=null) {
          item = doc.createElement("organ");
          item.appendChild(doc.createTextNode(getOrgan().toString()));
          element.appendChild(item);
		    System.out.println("6");
       }
	   if (getStain()!=null) {
          item = doc.createElement("stain");
          item.appendChild(doc.createTextNode(getStain().toString()));
          element.appendChild(item);
		    System.out.println("7");
       }
	   if (getStrain()!=null) {
          item = doc.createElement("strain");
          item.appendChild(doc.createTextNode(getStrain().toString()));
          element.appendChild(item);
		    System.out.println("8");
       }
	   if (getPmid()!=null ) {
	   		
			Vector journal   = retrieveJournal(getPmid());
			for(int k =0; k < journal.size(); k++){
			Metadata2Ex Journal = (Metadata2Ex) journal.elementAt(k);
			System.out.println(Journal.getJournal());
			item = doc.createElement("journal");
          	item.setAttribute("Name", Journal.getJournal().toString() );
			item.appendChild(doc.createTextNode(getPmid().toString()));
		  	element.appendChild(item);
			}
         
		    System.out.println("9"+getJournal() );
       }
	   if (getTissue()!=null) {
          item = doc.createElement("tissue");
          item.appendChild(doc.createTextNode(getTissue().toString()));
          element.appendChild(item);
		    System.out.println("10");
       }
	   if (getObservation()!=null) {
          item = doc.createElement("observation");
          item.appendChild(doc.createTextNode(getObservation().toString()));
          element.appendChild(item);
		    System.out.println("11");
       }
       return element;
    }
	public static void main (String args[])
    {
      System.out.println("Testing the Agent Domain Object");
      try {
        Metadata2Ex finalMeta = new Metadata2Ex();
        //Agent finalAgent = new Agent(Long.valueOf("0"));
        finalMeta.xmlStart();
        } catch (Exception exc) {
        System.out.println("Test failed in the main of Agent.java: " + exc.getMessage());
      }
    }
}
