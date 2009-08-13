package gov.nih.nci.caIMAGE.util;

  import java.io.*;
  import java.lang.*;

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
 public class FTPUtil_3 extends FTPClient
  implements Runnable
{
    /** Array of files to be transferred. */
    private static File  file_;

    /** Address of destination location. */
    private static String  serverURL_ = null;
	
	/** Password associated with destination machine access. */
    private static String  destPassword = null;

    /** Username associated with destination machine access. */
    private static String  destUsername = null;

	static boolean success;

    /** Process thread associated with the file transfer. */
    private static Thread  transfer_ = null;
	 private static String path_ = null;
	 private static Long imageUID_ = null; 
	 private static String paths_ = null; 
	 private static String orgimage = null;
    /** Class Constructor. */
    public FTPUtil_3(){}

    /**
     * This static method transfers an array of files, one-by-one, from the host
     * machine, to the detsination location.
     *
     * @param files     Files to be transferred.
     * @param dest      Destination URL.
     * @param username  Username required to access destination server.
     * @param password  Password required to access destination server.
     */
    public static void transfer(String org_image,File files, Long imageUID, String ftpdest, String pathsource, String pathdestination, String destusername, String destpassword)
    {
        // Provide class access to the remote host attributes and
        // the files to be uploaded.
        serverURL_ = ftpdest;
		destUsername = destusername;
		destPassword = destpassword;
        file_ = files;
		path_ = pathsource;
		imageUID_ = imageUID;
		paths_ = pathdestination;
		orgimage = org_image;
		System.out.println ("org image  "+orgimage);
		System.out.println ("files  "+files);
		System.out.println ("dest"+ftpdest);
		System.out.println ("path to find the ftp file     "+path_);
		System.out.println ("path dest /usr/local   "+paths_);
        // Instantiate the file transfer thread and run it.
        transfer_ = new Thread( new FTPUtil_3() );
        transfer_.run();
    }

    public void run()
    {
        File    file = null;

         int     reply;

        try
        {
        		System.out.println("Now i will go from convertor to lpgdev101"+serverURL_+"\n");
					this.connect(serverURL_);
		            System.out.println("Server to conncet"+serverURL_);
					System.out.print(this.getReplyString());
			            // Login to the ftp server ( Temporary )
			           System.out.println("user name"+destUsername);
					   System.out.println("passord"+destPassword);
					   this.login(destUsername, destPassword);
			          	// Check the reply code to verify successful connection.
			           reply = this.getReplyCode();
					   System.out.println ("Reply code  "+reply);
			           if(!FTPReply.isPositiveCompletion(reply))
			            {
			                this.disconnect();
			                System.err.println("Destnation server refused connection.");
			             }
					 			
					this.changeWorkingDirectory(paths_);
				  	System.out.println ("Second time(usr) working dir "+printWorkingDirectory());
	        
					this.setFileType(FTP.BINARY_FILE_TYPE);
					String sidfile = imageUID_ +".sid" ;
					FileInputStream abcinput = new FileInputStream(path_+"/"+sidfile);
	               	success = this.storeFile(sidfile, abcinput);
	                abcinput.close();
				    System.out.println ("changeWorkingDirectory after "+printWorkingDirectory());
	           		System.out.println ("\n" + sidfile + " successfully transferred...");
					failedoperation();
				} catch (IOException e) {
	          			if (this.isConnected())
	          			{
	               		System.err.println("Could not connect to server.");
	              		e.printStackTrace();
	           			}//if is connected
        			}//catch

        
    }//run
	public static boolean failedoperation() {
		return success;
		}
		
}//FTPUtil_3
