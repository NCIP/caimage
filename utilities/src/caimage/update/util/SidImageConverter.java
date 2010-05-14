package caimage.update.util;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

/**
 * 
 */

/**
 * Examines a file directory and all subdirectories and attempts to convert all files with
 * extension .sid to an alternate image format. The base directory, and the directory to which
 * converted images should be copied, should both be specified in the file caimage_update.properties.
 * The directory structure of the base directory will be maintained in the conversion directory.
 * 
 * The details of successful conversion will be written to a csv file, Conversion_Success_Results (one
 * copy with a date in the title to avoid overwrites, another without a date for use by other utilities.)
 * The details of failed conversions will be written to a csv file, Conversion_Errors.
 * 
 * @author vaughng
 * Oct 8, 2009
 */
public class SidImageConverter
{

    private static String FMT = "TIFF";
    private static String FILE_EXT = ".tif";
    //private static String ALT_FMT = "bmp";
    //private static String ALT_EXT = ".bmp";
    private static String ALT_FMT_2 = "jpg";
    private static String ALT_EXT_2 = ".jpg";
    
    private static Boolean MUTEX = new Boolean(false);
    private static boolean running = false;
    private static Timer timer = new Timer();
    private static long WAIT_TIME = 1000 * 60 * 10;
    
    private static Map<String,File> conversionMap = new LinkedHashMap<String,File>();
    private static List<ConversionResult> conversionResults = new ArrayList<ConversionResult>();
    private static CatalogMap catalogMap;
    /**
     * @param args
     */
    public static void main(String[] args)
    {
        try
        {
            catalogMap = new CatalogMap();
            
            SidImageConverter converter = new SidImageConverter();
            
            System.out.println("Props: ");
            System.out.println(PropertyUtils.getProperty("sid.dir"));
            System.out.println(PropertyUtils.getProperty("convert.dir"));
            System.out.println(PropertyUtils.getProperty("mrsid.app"));
            
            File startDir = new File(PropertyUtils.getProperty("sid.dir"));
            File convertDir = new File(PropertyUtils.getProperty("convert.dir"));
            File app = new File(PropertyUtils.getProperty("mrsid.app"));
            
            System.out.println("start directory: " + startDir.getAbsolutePath());
            System.out.println("conversion directory: " + convertDir.getAbsolutePath());
            System.out.println("app file" + app.getAbsolutePath());
            
            if (!startDir.exists())
            {
                System.out.println("invalid startdir, exiting program.");
                System.exit(0);
            }
            
            if (!app.exists())
            {
                System.out.println("invalid appfile, exiting program.");
                System.exit(0);
            }
            
            if (!convertDir.exists())
                convertDir.mkdirs();
            
            // Perform the image conversion, populating a list
            // of conversion details
            converter.convert(startDir, convertDir, FMT, FILE_EXT);
            
            // For all files not successfully converted to the desired format,
            // attempt alternate formats
            /*for (ConversionResult conversionResult : conversionResults)
            {
                if (conversionResult.successCode != 0)
                {
                    File file = new File(conversionResult.originalFile);
                    converter.convertFile(file, conversionMap.get(file.getAbsolutePath()), ALT_FMT, ALT_EXT, conversionResult);
                }
            }*/
            /*for (ConversionResult conversionResult : conversionResults)
            {
                if (conversionResult.successCode != 0)
                {
                    File file = new File(conversionResult.originalFile);
                    converter.convertFile(file, conversionMap.get(file.getAbsolutePath()), ALT_FMT_2, ALT_EXT_2, conversionResult);
                }
            }
            for (ConversionResult conversionResult : conversionResults)
            {
                if (conversionResult.successCode != 0)
                {
                    File file = new File(conversionResult.originalFile);
                    converter.copyFile(file, conversionMap.get(file.getAbsolutePath()));
                }
            }*/
            
            SimpleDateFormat df = new SimpleDateFormat("MM.dd.yy.HH.mm.ss");
            String successFileName = "Conversion_Success_Results_" + df.format(Calendar.getInstance().getTime()) + ".csv";
            File successFile = new File(successFileName);
            if (!successFile.exists())
            {
                successFile.createNewFile();
            }
            // Write a dated file that will not be overwritten
            converter.writeSuccessFile(successFile);
            
            successFileName = "Conversion_Success_Results.csv";
            successFile = new File(successFileName);
            if (!successFile.exists())
            {
                successFile.createNewFile();
            }
            // Write an undated file for use by other utilities
            converter.writeSuccessFile(successFile);
            
            String errorFileName = "Conversion_Errors_" + df.format(Calendar.getInstance().getTime()) + ".csv";
            File errorFile = new File(errorFileName);
            if (!errorFile.exists())
            {
                errorFile.createNewFile();
            }
            converter.writeErrorFile(errorFile);
            System.exit(0);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }
    
    /**
     * The starting directory is recursively searched for .sid files, and conversion to an
     * the given image format is attempted. Detailed results of the conversion are stored
     * in the conversionResults list.
     * 
     * @param startDir Directory to be serached for .sid files.
     * @param convertDir Directory into which converted files will be placed, keeping the original directory structure.
     * @param format Target image format.
     * @param ext Target file extension.
     */
    private void convert(File startDir, File convertDir, String format, String ext)
    {
        File[] toConvert = startDir.listFiles();
        if (toConvert != null)
        {
            for (File file : toConvert)
            {
                if (file.isDirectory())
                {
                    File newConvertDir = new File(convertDir.getPath() + File.separator + file.getName());
                    if (!newConvertDir.exists())
                        newConvertDir.mkdirs();
                    
                    convert(file, newConvertDir, format, ext);
                }
                else
                {
                    //convertFile(file,convertDir,format,ext,null);
                    checkFile(file, convertDir, null);
                }
            }
            
        }
        else
        {
            System.out.println("Empty directory: " + startDir);
        }
        
    }
    
    /**
     * Converts a flat file (not a directory) to the given image format.
     * @param file File to be converted.
     * @param convertDir Directory into which the converted file will be placed.
     * @param format Target image format.
     * @param ext Target file extension.
     * @param result ConversionResult in which to store the results, or null if a new one should be created.
     */
    private void convertFile(File file, File convertDir, String format, String ext, ConversionResult result)
    {
        if (file.getName().indexOf(".") < 0)
            return;
        conversionMap.put(file.getAbsolutePath(), convertDir);
        
        if (checkFile(file, convertDir, result))
            return;
        
        
        String noExt = file.getName().substring(0,file.getName().lastIndexOf("."));       
        String newFileName = convertDir.getAbsolutePath() + File.separator + noExt + ext;
        
        if (file.getName().endsWith(".sid") && !(new File(newFileName).exists()))
        {
            if (result == null)
            {
                result = new ConversionResult();
                result.originalFile = file.getAbsolutePath();
                result.originalName = file.getName();
                result.catalogId = getCatalogId(file);
                conversionResults.add(result);
            }
            String c = PropertyUtils.getProperty("mrsid.app");
            System.out.println("Mr sid application: " + c);
            String[] cmdarray = new String[]{c,"-i",file.getAbsolutePath(),"-o",newFileName,"-of",format};
            
            Process process;
            try
            {
                System.out.println("Converting file " + file.getPath() + " ...");
                process = Runtime.getRuntime().exec(cmdarray);
                startTimer(Thread.currentThread(),process);
                process.waitFor();
                
                stopTimer();
            }
            catch (Exception e)
            {
                System.out.println("An exception occured during an attempted conversion.");
                System.out.println("Target file: " + file.getAbsolutePath());
                result.errorFiles.add(newFileName);
                result.errorMessages.add(e.getClass() + " " + e.getMessage());
                result.successCode = 999;
                result.success = false;
                e.printStackTrace();
                return;
            }
            
            try
            {
            BufferedReader inputStreamReader  = new BufferedReader(new InputStreamReader(process.getInputStream()));
            BufferedReader errStreamReader  = new BufferedReader(new InputStreamReader(process.getErrorStream()));
            
            StringBuffer output = new StringBuffer();
            StringBuffer error = new StringBuffer();
            
            for(String line;(line=inputStreamReader.readLine())!=null;)
            {
               output.append(line);
            }
            for(String line;(line=errStreamReader.readLine())!=null;)
            {
                error.append(line);
            }
            
            int exitCode = process.exitValue();
            System.out.println("Process complete with exit code: " + exitCode);
            result.successCode = exitCode;
            if (exitCode == 0)
            {
                result.success = true;
                result.successFile = newFileName;
                result.successOutput = output.toString();  
                result.successExt = ext;
                System.out.println("Converted " + file.getPath() + " to " + newFileName);
            }
            else
            {
                result.success = false;
                result.errorFiles.add(newFileName);
                result.errorMessages.add(error.toString());
                System.out.println("Conversion from " + file.getAbsolutePath() + " to " + newFileName + " failed.");
                System.out.println("Code: " + exitCode + " , error: " + error.toString());
            }
            
            }
            catch (Exception e)
            {
                System.out.println("An exception occured retrieving output/status from process.");
                e.printStackTrace();
                result.errorFiles.add(newFileName);
                result.errorMessages.add(e.getClass() + " " + e.getMessage());
                result.successCode = 999;
                result.success = false;
            }
            
        }
        else
        {
            copyFile(file, convertDir);
            /*
            File newFile = new File(convertDir + File.separator + file.getName());
            if (!newFile.exists())
            {
                try
                {
                    BufferedOutputStream writer = new BufferedOutputStream(new FileOutputStream(newFile));
                    int bite = 16384;
                    int read;
                    byte[] b = new byte[bite];
                    BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
                    while((read = in.read(b)) > 0)
                    {
                        writer.write(b);
                    }
                    in.close();
                    writer.flush();
                    writer.close();
                }
                catch (IOException e)
                {
                    System.out.println("File could not be created: " + newFile.getAbsolutePath());
                }
                
            }
            
        */}
        
    }
    
    private boolean checkFile(File file, File convertDir, ConversionResult result)
    {
        if (file.getName().indexOf(".") < 0)
            return false;
        
        
        
        
        String noExt = file.getName().substring(0,file.getName().lastIndexOf("."));   
        
        if (file.getName().endsWith(".sid")){
        for (String ext : new String[]{FILE_EXT, ALT_EXT_2})
        {
            String newFileName = convertDir.getAbsolutePath() + File.separator + noExt + ext;
            
            File convertedFile = new File(newFileName);
            if (convertedFile.exists())
            {
                if (result == null)
                {
                    result = new ConversionResult();
                    result.successCode = 0;
                    result.originalFile = file.getAbsolutePath();
                    result.originalName = file.getName();
                    result.catalogId = getCatalogId(convertedFile);
                    conversionResults.add(result);
                }
                result.success = true;
                result.successFile = newFileName;
                result.successExt = ext;
                System.out.println("Converted " + file.getPath() + " to " + newFileName); 
                
                String badCopy = convertDir.getAbsolutePath() + File.separator + noExt + ".sid";
                File badFile = new File(badCopy);
                if (badFile.exists())
                {
                    System.out.println("Deleting redundant copy " + badFile.getAbsolutePath());
                    boolean deleted = badFile.delete();
                    System.out.println("Deleted? - " + deleted);
                }
                return true;
            }
        }}
        
        String copy = convertDir.getAbsolutePath() + File.separator + file.getName();
        File copied = new File(copy);
        if (!copied.exists())
        {
            if (result == null)
            {
                result = new ConversionResult();
                result.successCode = 1;
                result.originalFile = file.getAbsolutePath();
                result.originalName = file.getName();
                //result.catalogId = getCatalogId(convertedFile);
                conversionResults.add(result);
            }
            result.success = false;
            //result.successFile = newFileName;
            //result.successExt = ext;
            result.errorFiles.add(copy);
            result.errorMessages.add("File was not converted or copied.");
            System.out.println("File was not converted or copied: " + file.getAbsolutePath()); 
        }
        else if (copy.endsWith(".sid"))
        {
            if (result == null)
            {
                result = new ConversionResult();
                result.successCode = 1;
                result.originalFile = file.getAbsolutePath();
                result.originalName = file.getName();
                //result.catalogId = getCatalogId(convertedFile);
                conversionResults.add(result);
            }
            result.success = false;
            //result.successFile = newFileName;
            //result.successExt = ext;
            result.errorFiles.add(copy);
            result.errorMessages.add("Sid file was copied, not converted");
            System.out.println("Sid file was copied, not converted: " + file.getAbsolutePath()); 
        }
        return false;
    }
    
    private void copyFile(File file, File convertDir)
    {
        File newFile = new File(convertDir + File.separator + file.getName());
        if (!newFile.exists())
        {
            try
            {
                BufferedOutputStream writer = new BufferedOutputStream(new FileOutputStream(newFile));
                int bite = 16384;
                int read;
                byte[] b = new byte[bite];
                BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
                while((read = in.read(b)) > 0)
                {
                    writer.write(b);
                }
                in.close();
                writer.flush();
                writer.close();
            }
            catch (IOException e)
            {
                System.out.println("File could not be created: " + newFile.getAbsolutePath());
            }
            
        }
        
    }
    
    private void writeSuccessFile(File successFile) throws IOException
    {
        String[] successHeaders = new String[]{"Original File","New File","New Ext","Original Name","MrSid Output","catalog_id"};
        Writer writer = new OutputStreamWriter(new FileOutputStream(successFile));
        
        String columnHeaders = delimit(successHeaders, ",");
        writer.write(columnHeaders);
        writer.write('\n');
        
        for (ConversionResult result : conversionResults)
        {
            if (result.successCode == 0)
            {
                String[] resultArray = new String[]{result.originalFile, result.successFile, result.successExt,result.originalName,result.successOutput,
                        result.catalogId > 0 ? Integer.toString(result.catalogId) : ""};
                String results = delimit(resultArray, ",");
                writer.write(results);
                writer.write('\n');
            }               
        }  
        writer.flush();
        writer.close();
    }
    
    private void writeErrorFile(File errorFile) throws IOException
    {
        String[] errorHeaders = new String[]{"Original File","Attempted File","Error Message","Final Attempt Succeeded?"};
        Writer writer = new OutputStreamWriter(new FileOutputStream(errorFile));
        
        String columnHeaders = delimit(errorHeaders, ",");
        writer.write(columnHeaders);
        writer.write('\n');
        for (ConversionResult result : conversionResults)
        {
            if (!result.errorFiles.isEmpty())
            {
                for (int i = 0; i < result.errorFiles.size(); i++)
                {
                    String[] resultArray = new String[]{result.originalFile, result.errorFiles.get(i), result.errorMessages.get(i),
                            Boolean.toString(result.success)};
                    String results = delimit(resultArray, ",");
                    writer.write(results);
                    writer.write('\n');
                }
                
                
            }               
        }      
        writer.flush();
        writer.close();
    }
    
    private static int getCatalogId(File file)
    {
        return catalogMap.getCatalogId(file.getParentFile());
    }
    
    public static String delimit(String[] tokens, String delimiter)
    {
      String retVal = null;
      
      if (tokens != null)
      {
        retVal = "";
        if (delimiter == null)
          delimiter = "";
        
        for (int i = 0; i < tokens.length; i++)
        {
          if (tokens[i] == null)
            tokens[i] = "";
          
          if (tokens[i].indexOf(",") >= 0 && !tokens[i].startsWith("\""))
            tokens[i] = "\"" + tokens[i] + "\"";
          
          retVal = retVal.concat(tokens[i]);
          if (i < tokens.length - 1)
          {
            retVal = retVal.concat(delimiter);
          }
        }
      }
      
      return retVal;
    }
    
    private static void startTimer(Thread t, Process proc)
    {
        final Thread runningThread = t;
        final Process process = proc;
        synchronized (MUTEX)
        {
            running = true;
            TimerTask task = new TimerTask(){

                public void run()
                {
                    if (running)
                    {
                        process.destroy();
                        runningThread.interrupt();
                        System.out.println("WARN ... Interrupting conversion thread after 10 minutes.");
                    }
                        
                }
                
            };
            timer = new Timer();
            timer.schedule(task, WAIT_TIME);
        }
    }
    
    private static void stopTimer()
    {
        synchronized (MUTEX)
        {
            running = false;
            timer.cancel();
        }
    }
    
    static class ConversionResult
    {
        String originalFile, successFile, originalName, successOutput = "none", successExt;
        List<String> errorFiles = new ArrayList<String>(), errorMessages = new ArrayList<String>();
        int successCode = -1, catalogId = -1;
        boolean success = false;
        
    }

}
