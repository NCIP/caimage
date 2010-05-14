package gov.nih.nci.caIMAGE.util;


/*
 * MailUtil.java
 * Created on Feb 24, 2002
 * author  ajay gupta SAIC
 * @version 1.0
 */
  import java.io.*;
  import java.text.*;
  import java.util.*;
  import javax.activation.*;
  import javax.mail.*;
  import javax.mail.internet.*;

public class MailUtil
{
  //----------------------------------------------------------------------
  //                        PRIVATE ATTRIBUTES
  //----------------------------------------------------------------------
  private MimeMessage message_ = null;
  private MimeBodyPart mbp_ = null;
  private FileDataSource fds_ = null;
  private Transport transport_;

  private String host_ = null;
  private String from_ = null;
  private String to_ = null;
  private String cc_ = null;
  private String bcc_ = null;
  private String subject_ = null;
  private String content_ = null;
  private String[] attachments_ = null;

  //----------------------------------------------------------------------
  //                           CONSTRUCTORS
  //----------------------------------------------------------------------
  public MailUtil() {}

  public MailUtil(String host, String content, String from, String to)
  {
      this (host, content, from, to, null);
  }

  public MailUtil(String host, String content, String from, String to, String subject)
  {
      this (host, content, from, to, null, null, subject, null);
  }

  public MailUtil(String host, String content, String from, String to,
                  String subject, String[] attachments)
  {
      this (host, content, from, to, null, null, subject, attachments);
  }

  public MailUtil(String host, String content, String from, String to, String cc,
                  String bcc, String subject, String[] attachments)
  {
      // Initialize the mail attributes.
      setHost(host);
      setContent(content);
      setFromAddress(from);
      setToAddress(to);
      setCC(cc);
      setBCC(bcc);
      setSubject(subject);
      setAttachments(attachments);
  }

  //----------------------------------------------------------------------
  //                          PUBLIC METHODS
  //----------------------------------------------------------------------
  public void setMailProperties()
  {
      // Get system properties
      Properties props = System.getProperties();

      // Setup mail server
      props.put("mail.smtp.host", host_);

      // Get session
      Session session = Session.getDefaultInstance(props, null);

      // Define message
      message_ = new MimeMessage(session);
  }

  public void sendTextMessage()
  {
      try {
        // Setup mail properties.
        setMailProperties();

        // Set the from address
        message_.setFrom(new InternetAddress(from_));

        // Set the to address
	message_.addRecipient(Message.RecipientType.TO,
          new InternetAddress(to_));
        if ( cc_ != null )
          message_.addRecipient(Message.RecipientType.CC,
            new InternetAddress(cc_));
        if ( bcc_ != null )
          message_.addRecipient(Message.RecipientType.BCC,
            new InternetAddress(bcc_));

        // Set the subject
        if ( subject_ != null )
          message_.setSubject(subject_);

        // Set the date
        message_.setSentDate(new Date());

        // Set the content
        message_.setText(content_);

        // Send message
        Transport.send(message_);

    } catch(Exception e){
      System.err.println(e);
    }
  }

  public void sendTextMessageWithAttachments()
  {
      try {
        // Setup mail properties.
        setMailProperties();

        // Set the from address
        message_.setFrom(new InternetAddress(from_));

        // Set the to address
	message_.addRecipient(Message.RecipientType.TO,
          new InternetAddress(to_));
        if ( cc_ != null )
          message_.addRecipient(Message.RecipientType.CC,
            new InternetAddress(cc_));
        if ( bcc_ != null )
          message_.addRecipient(Message.RecipientType.BCC,
            new InternetAddress(bcc_));

        // Set the subject
        if ( subject_ != null )
          message_.setSubject(subject_);

        // Set the date
        message_.setSentDate(new Date());

        // Set the content

        // Attachments...?
        if ( (attachments_ != null) && (attachments_.length > 0) )
        {
            // Create the Multipart to add the parts to.
            Multipart mp = new MimeMultipart();

            // Create and fill the first message part;
            mbp_ = new MimeBodyPart();
            mbp_.setText(content_);

            // Attach the part to the multipart;
            mp.addBodyPart(mbp_);

            for ( int i=0; i < attachments_.length; i++ )
            {
                mbp_ = new MimeBodyPart();
                fds_ = new FileDataSource(attachments_[i]);
                mbp_.setDataHandler(new DataHandler(fds_));
                mbp_.setFileName(fds_.getName());
                mp.addBodyPart(mbp_);
            }
            message_.setContent(mp);
        }
        else
        {
            message_.setText(content_);
        }

        // Send message
        Transport.send(message_);

    } catch(Exception e){
      System.err.println(e);
    }
  }

  public void sendHtmlMessage()
  {
      
      try {
        // Setup mail properties.
        setMailProperties();

        // Set the from address
        message_.setFrom(new InternetAddress(from_));

        // Set the to address
	message_.addRecipient(Message.RecipientType.TO,
          new InternetAddress(to_));
        if ( cc_ != null )
          message_.addRecipient(Message.RecipientType.CC,
            new InternetAddress(cc_));
        if ( bcc_ != null )
          message_.addRecipient(Message.RecipientType.BCC,
            new InternetAddress(bcc_));

        // Set the subject
        if ( subject_ != null )
          message_.setSubject(subject_);

        // Set the header
        message_.setHeader("Mime-Version", "1.0");
        message_.setHeader("Content-Transfer-Encoding", "quoted-printable");
        message_.setHeader("X-Mailer", "sendhtml");
        message_.setHeader("Content-Type", "text/html");

        // Set the date
        message_.setSentDate(new Date());

        // Set the content
        message_.setDataHandler(new DataHandler(
            new ByteArrayDataSource(content_, "text/html")));

        // Send message
        message_.saveChanges();
        transport_.send(message_);

    } catch(Exception e){
      System.out.println(e);
    }
  }

  //----------------------------------------------------------------------
  //                            ACCESSORS
  //----------------------------------------------------------------------
  public void setHost(String host)
  {
      this.host_ = host;
  }

  public String getHost()
  {
      return this.host_;
  }

  public void setFromAddress(String from)
  {
      this.from_ = from;
  }

  public String getFromAddress()
  {
      return this.from_;
  }

  public void setToAddress(String to)
  {
      this.to_ = to;
  }

  public String getToAddress()
  {
      return this.to_;
  }

  public void setCC(String cc)
  {
      this.cc_ = cc;
  }

  public String getCC()
  {
      return this.cc_;
  }

  public void setBCC(String bcc)
  {
      this.bcc_ = bcc;
  }

  public String getBCC()
  {
      return this.bcc_;
  }

  public void setSubject(String subject)
  {
      this.subject_ = subject;
  }

  public String getSubject()
  {
      return this.subject_;
  }

  public void setContent(String content)
  {
      this.content_ = content;
  }

  public String getContent()
  {
      return this.content_;
  }

  public void setAttachments(String[] attachments)
  {
      this.attachments_ = attachments;
  }

  public String[] getAttachments()
  {
      return this.attachments_;
  }

  // Main -- For Testing Purposes Only!
  public static void main (String[] args)
  {
      String host = "mailfwd.nih.gov";
      String from = "beasleyj@mail.nih.gov";
      String to = "beasleyj@mail.nih.gov";
      String bcc = "jbeasley@inableinc.com";
      String cc = "baddison@inableinc.com";
      String content = "<HTML><HEAD><TITLE>Test HTML</TITLE></HEAD><BODY><P><H1>MMHCC Repository Strain</H1><H3>Donating Investigator</H3><BR><BR><B>Name:</B> Johnita Beasley</BODY></HTML>";
      String subject = "Test HTML Message";
      String[] attachments = {"c:\\Program Files\\JavaSoft\\JRE\\1.3.1\\lib\\security\\cacerts",
                              "c:\\Program Files\\JavaSoft\\JRE\\1.3.1\\lib\\security\\java.policy"};

      MailUtil mail = new MailUtil(host, content, from, to, subject);
      mail.sendHtmlMessage();
  }
}

