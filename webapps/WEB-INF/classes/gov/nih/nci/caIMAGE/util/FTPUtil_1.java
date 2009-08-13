package gov.nih.nci.caIMAGE.util;

  import java.io.*;
  import java.util.*;

  import com.oroinc.net.ftp.*;

/*
 * FTPUtil.java
 * Created on October 09, 2001
 * @author  Johnita Beasley
 * @version 1.0
 */

/**
 * The FTPUtil is a utility class which allows for the transfer of files from one
 * location to another (i.e. client machine to server machine).
 *
 * FTPUtil extends com.oroinc.net.ftp.FTPClient.
 */
 public class FTPUtil_1 extends FTPClient
  implements Runnable
{
    /** Array of files to be transferred. */
    private static File  fileArray_;
   
    /** Address of destination location. */
    private static String  serverURL_ = null;

    /** Password associated with destination machine access. */
    private static String  serverPassword_ = null;

    /** Username associated with destination machine access. */
    private static String  serverUsername_ = null;

    /** Process thread associated with the file transfer. */
    private static Thread  transfer_ = null;
	private static Thread  delete_ = null;
	private static String path_ = null;
	private static String path2_ = null;
	private static Long imageUID_ = null; 
    private static FTPUtil_1 onlyInstance = null;

   /**
    * Static factory method that makes a single instance of this class.
    * @return the instance of GenePersistence
    */
public static synchronized FTPUtil_1 getInstance()
    {
      if (onlyInstance == null)
         onlyInstance = new FTPUtil_1();

      return onlyInstance;
	}

    /** Class Constructor. */
    public FTPUtil_1(){}

    /**
     * This static method transfers an array of files, one-by-one, from the host
     * machine, to the detsination location.
     *
     * @param files     Files to be transferred.
     * @param dest      Destination URL.
     * @param username  Username required to access destination server.
     * @param password  Password required to access destination server.
     */
    public static void transfer(File files, Long imageUID,String dest, String path,  String username, String password)
    {
        // Provide class access to the remote host attributes and
        // the files to be uploaded.
        serverURL_ = dest;
        serverUsername_ = username;
        serverPassword_ = password;
        fileArray_ = files;
		path_ = path;
		imageUID_ = imageUID;

        // Instantiate the file transfer thread and run it.
        transfer_ = new Thread( new FTPUtil_1() );
		
        transfer_.run();
    }
	public void run()
    {
        File    file = null;

        boolean success;
        int     reply;
	 try
        {
            // Establish a connection with the ftp server
            this.connect(serverURL_);
            System.out.println(serverURL_);
			
            System.out.print(this.getReplyString());

            // Login to the ftp server ( Temporary )
            this.login(serverUsername_, serverPassword_);			
            System.out.println("path for working dir: "+path_);
			//This is pointing to default location /user/local/newLizardTech
			this.changeWorkingDirectory(path_);
			//this.changeWorkingDirectory(dir);
			System.out.println("working dir 2nd time:"+printWorkingDirectory());
			this.setFileType(FTP.BINARY_FILE_TYPE);	
            // Check the reply code to verify successful connection.
            reply = this.getReplyCode();
			System.out.println("reply:"+reply);
            if(!FTPReply.isPositiveCompletion(reply))
            {
                this.disconnect();
                System.err.println("FTP server refused connection.");
                //System.exit(1);
            }
			  // For each file in the file array, transfer to destination location.
			Hashtable files = getFilename(fileArray_);			
			if(files != null && files.size()>0)
			{   	
				for(int i= 0; i<files.size(); i++){
				String str1= (String)files.get("file");	
				System.out.println("image to capture :"+str1);
				    try{
					  this.setFileTransferMode(FTP.STREAM_TRANSFER_MODE);
					  Thread.sleep(150);
          			  this.setFileType(FTP.BINARY_FILE_TYPE);
					  Thread.sleep(150);
					  } catch (Exception e){
					  System.out.println ("the thread exception is"+e);
					  }
					    //File fileatt = new File(str1+"x");
						// fileatt.setReadOnly();
						//FileInputStream filetrans = new FileInputStream(fileArray_[i]) ;
					   System.out.println ("I am here");
					 FileOutputStream abcoutput = new  FileOutputStream(str1);				
					 success = this.retrieveFile(str1, abcoutput);
					 //InputStream filetrans = null ;
					 //filetrans  = this.retrieveFileStream(str1);
					 //Thread.sleep(1500);
					 //System.out.println(filetrans);
					 //success = this.storeUniqueFile(filetrans);
          
					     System.out.println ("I have retrieve the file"+str1+"true from error folder /false Ok converted "+success+"\n");
					    if ( success ){
				  		//fileArray_.setReadOnly();
						 success = this.storeFile(str1, new FileInputStream(fileArray_) );
	                	System.out.println ("\n" + str1 + " successfully transferred...");
						//System.out.println("**** the file exists"+finput.exists() );
						}
	                  	else
	                    	System.out.println ("Transfer failed for file..." + str1);
				 
					  
					  //filetrans.close() ;
			  		
				}//for
			}//if
			
	 } catch (Exception e) {
          if (this.isConnected())
          {
             System.err.println("Could not connect to server.");
              e.printStackTrace();
              //System.exit(1);
          }//if
        }//catch
	
	}
	//file are passed here
private Hashtable getFilename(File fileArray_){// put file array into a hashtable
	    Hashtable files = new Hashtable();
		if(fileArray_ != null){
		         String  file = fileArray_.toString();
				System.out.println("imageUID_:"+imageUID_);
				if(	imageUID_!= null){		
					String filetype = file.substring(file.lastIndexOf(".")+1);
					String file3 = null;
					if (filetype.equals("sid") ){
					file3 = imageUID_ + "."+file.substring(file.lastIndexOf(".")+1);// add an unique ID to the file
					System.out.println("file3:"+file3);
					} else
					{ 
					//appends the x to the file name
					//file3 = imageUID_ + "."+file2.substring(file2.lastIndexOf(".")+1)+"x";// add an unique ID to the file
					file3 = imageUID_ + "."+file.substring(file.lastIndexOf(".")+1);// add an unique ID to the file
					files.put("file", file3);
					}
					
				 }//if imageUID
				
		 }//if
		return files;		
		}//Hash table	

	
	
}
