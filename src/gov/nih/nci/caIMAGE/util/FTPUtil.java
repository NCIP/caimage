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
public class FTPUtil extends FTPClient implements Runnable
{
    /** Array of files to be transferred. */
    private static File[] fileArray_;
    private static File[] fileArray2_;

    /** Address of destination location. */
    private static String serverURL_ = null;

    /** Password associated with destination machine access. */
    private static String serverPassword_ = null;

    /** Username associated with destination machine access. */
    private static String serverUsername_ = null;

    /** Process thread associated with the file transfer. */
    private static Thread transfer_ = null;
    private static Thread delete_ = null;
    private static String path_ = null;
    private static String path2_ = null;
    private static Long imageUID_ = null;
    private static FTPUtil onlyInstance = null;

    /**
     * Static factory method that makes a single instance of this class.
     * @return the instance of GenePersistence
     */
    public static synchronized FTPUtil getInstance()
    {
        if (onlyInstance == null)
            onlyInstance = new FTPUtil();

        return onlyInstance;
    }

    /** Class Constructor. */
    public FTPUtil()
    {}

    /**
     * This static method transfers an array of files, one-by-one, from the host
     * machine, to the detsination location.
     *
     * @param files     Files to be transferred.
     * @param dest      Destination URL.
     * @param username  Username required to access destination server.
     * @param password  Password required to access destination server.
     */
    public static void transfer(File[] files,
                                File[] files2,
                                Long imageUID,
                                String dest,
                                String path,
                                String username,
                                String password)
    {
        // Provide class access to the remote host attributes and
        // the files to be uploaded.
        serverURL_ = dest;
        serverUsername_ = username;
        serverPassword_ = password;
        fileArray_ = files;
        fileArray2_ = files2;
        path_ = path;
        imageUID_ = imageUID;

        // Instantiate the file transfer thread and run it.
        transfer_ = new Thread(new FTPUtil());

        transfer_.run();
    }

    public void run()
    {
        File file = null;

        boolean success;
        int reply;

        try
        {
            // Establish a connection with the ftp server
            this.connect(serverURL_);
           

            // Login to the ftp server ( Temporary )
            this.login(serverUsername_, serverPassword_);
          
            //This is pointing to default location /user/local/newLizardTech
            boolean flag = this.changeWorkingDirectory(path_);
         
            this.changeWorkingDirectory(path_);
         
            this.setFileType(FTP.BINARY_FILE_TYPE);
            // Check the reply code to verify successful connection.
            reply = this.getReplyCode();
          
            if (!FTPReply.isPositiveCompletion(reply))
            {
                this.disconnect();
                System.err.println("FTP server refused connection.");
                //System.exit(1);
            }

            // For each file in the file array, transfer to destination location.
            Hashtable files = getFilename(fileArray_);
            Hashtable files2 = getFilename(fileArray2_);
            if (files != null && files.size() > 0)
            {
                for (int i = 0; i < files.size(); i++)
                {
                    String str1 = (String) files.get("\"" + i + "\"");
                 
                    if (files2 != null && files2.size() == 0)// put images on the server
                    {
                        try
                        {
                            this.setFileTransferMode(FTP.STREAM_TRANSFER_MODE);
                            Thread.sleep(150);
                            this.setFileType(FTP.BINARY_FILE_TYPE);
                            Thread.sleep(150);
                        }
                        catch (Exception e)
                        {
                            System.err.println("the thread exception is" + e);
                        }
                        //File fileatt = new File(str1+"x");
                        // fileatt.setReadOnly();
                        //FileInputStream filetrans = new FileInputStream(fileArray_[i]) ;

                        success = this.storeFile(str1, new FileInputStream(fileArray_[i]));
                        Thread.sleep(1500);
                        //filetrans.close() ;
                        if (success)
                        {
                            //this.changeWorkingDirectory(path_+"/Input");
                            System.err.println("\n" + str1 + " successfully transferred...");
                        }
                        else
                            System.err.println("Transfer failed for file..." + str1);
                    }

                    if (files2 != null && files2.size() > 0)// delete the old images first , then putting the new one on there
                    {
                        for (int k = 0; k < files2.size(); k++)

                        {
                            String str2 = (String) files2.get("\"" + k + "\"");
                        
                            success = this.deleteFile(str2);
                            this.setFileType(FTP.BINARY_FILE_TYPE);
                            success = this.storeFile(str1, new FileInputStream(fileArray_[i]));
                            if (success)
                                System.err.println("\n" + str2 + " successfully  deleted.. and " + str1 + "sucessfully transferred");
                            else
                                System.err.println("Transfer failed for file...");


                            // }//if

                        }//for
                    }//if
                }//for
            }//if

            if (files.size() == 0 && files2 != null && files2.size() > 0)//delete file
            {
                for (int i = 0; i < files2.size(); i++)
                {
                    String str2 = (String) files2.get("\"" + i + "\"");
                 
                    if (files != null && files.size() == 0)
                    {
                        success = this.deleteFile(str2);
                        if (success)
                            System.err.println("\n" + str2 + " successfully deleted...");
                        else
                            System.err.println("Delete failed for file..." + str2);
                    }//if
                }//for
            }//if						

        }
        catch (Exception e)
        {
            if (this.isConnected())
            {
                try
                {
                    this.disconnect();
                    System.err.println("disconnect ftp");
                }
                catch (IOException f)
                {
                    f.printStackTrace();
                    // do nothing
                }
                System.err.println("Could not connect to server.");
                e.printStackTrace();
                //System.exit(1);
            }
            else
                e.printStackTrace();
        }

        try
        {
            this.disconnect();

        }
        catch (Exception io)
        {
            io.printStackTrace();
        }
    }

    //file are passed here
    private Hashtable getFilename(File[] fileArray_)
    {// put file array into a hashtable
        Hashtable files = new Hashtable();
        if (fileArray_ != null)
        {
            for (int i = 0; i < fileArray_.length; i++)
            {
                File file = fileArray_[i];
                String file2 = file.getName().trim();// remove any white space
                 if (imageUID_ != null)
                {
                    String filetype = file2.substring(file2.lastIndexOf(".") + 1);
                    String file3 = null;
                    if (filetype.equals("sid"))
                    {
                        file3 = imageUID_ + "." + file2.substring(file2.lastIndexOf(".") + 1);// add an unique ID to the file
                       
                    }
                    else
                    {
                        //appends the x to the file name
                        //file3 = imageUID_ + "."+file2.substring(file2.lastIndexOf(".")+1)+"x";// add an unique ID to the file
                        file3 = imageUID_ + "." + file2.substring(file2.lastIndexOf(".") + 1);// add an unique ID to the file

                    }
                    files.put("\"" + i + "\"", file3);
                }
                else
                {
                    System.out.println("this is for deleting");
                    files.put("\"" + i + "\"", file2);
                }

            }
        }
        return files;
    }

    public void deleteAllFiles(File[] files,
                               File[] files2,
                               String dest,
                               String path,
                               String path2,
                               String username,
                               String password)
    {
        // Provide class access to the remote host attributes and
        // the files to be uploaded.
        serverURL_ = dest;
        serverUsername_ = username;
        serverPassword_ = password;
        fileArray_ = files;
        fileArray2_ = files2;
        path_ = path;
        path2_ = path2;
        imageUID_ = null;
        delete();

    }

    private void delete()
    {
        {
            File file = null;
            boolean flag = false;
            boolean flag2 = false;
            boolean success;
            int reply;

            try
            {
                // Establish a connection with the ftp server
                this.connect(serverURL_);
             

                System.err.print(this.getReplyString());

                // Login to the ftp server ( Temporary )
                this.login(serverUsername_, serverPassword_);
                if (fileArray_ != null && fileArray_.length > 0 && flag2 == false)
                {
                  
                    flag = this.changeWorkingDirectory(path_);
                }
                if (flag && flag2 == false)
                {
                    Hashtable files = getFilename(fileArray_); // delete files 				
                    for (int i = 0; i < files.size(); i++)
                    {
                        String str = (String) files.get("\"" + i + "\"");
                     
                        success = this.deleteFile(str);
                        if (success)
                            System.err.println("\n" + str + " successfully deleted...");
                        else
                            System.err.println("Delete failed for file..." + str);
                    }//for
                    flag = false;
                }//if	flag			
                if (fileArray2_ != null && fileArray2_.length > 0 && flag == false)
                {
                  
                    flag2 = this.changeWorkingDirectory(path2_);
                  
                }
                if (flag2 && flag == false)
                {
                   
                    Hashtable files2 = getFilename(fileArray2_); // delete files 				
                    for (int i = 0; i < files2.size(); i++)
                    {
                        String str2 = (String) files2.get("\"" + i + "\"");
                    
                        success = this.deleteFile(str2);
                        if (success)
                            System.err.println("\n" + str2 + " successfully deleted...");
                        else
                            System.err.println("Delete failed for file..." + str2);
                    }//for			     
                    flag2 = false;
                }//if	flag2						
                // Check the reply code to verify successful connection.
                reply = this.getReplyCode();
                System.err.println("reply:" + reply);
                if (!FTPReply.isPositiveCompletion(reply))
                {
                    this.disconnect();
                    System.err.println("FTP server refused connection.");
                    //System.exit(1);
                }


            }
            catch (IOException e)
            {
                if (this.isConnected())
                {
                    try
                    {
                        this.disconnect();
                        System.err.println("disconnect ftp");
                    }
                    catch (IOException f)
                    {
                        // do nothing
                    }
                    System.err.println("Could not connect to server.");
                    e.printStackTrace();
                    //System.exit(1);
                }
            }

            try
            {
                this.disconnect();

            }
            catch (IOException io)
            {

            }
        }


    }
}
