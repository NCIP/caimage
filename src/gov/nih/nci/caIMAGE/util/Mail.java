/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;

/*
 * Mail.java
 * Created on Feb 24,2003
 * author  Ajay Gupta SAIC
 * @version 1.0
 */


import java.text.SimpleDateFormat;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Mail
{
    /**
     * @param host
     * @param from
     * @param to
     * @param cc
     * @param bcc
     * @param subject
     * @param content
     */
    public Mail(String host, String from, String to, String cc, String bcc, String subject, String content)
    {

        try
        { // Get system properties
            Properties props = System.getProperties();

            // Setup mail server
            props.put(Messages.getString("Mail.mail.smtp.host_1"), host); //$NON-NLS-1$

            // Get session
            Session session = Session.getDefaultInstance(props, null);

            // Define message
            MimeMessage message = new MimeMessage(session);

            // Set the from address

            message.setFrom(new InternetAddress(from));

            // Set the to address
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));

            message.addRecipient(Message.RecipientType.BCC, new InternetAddress(bcc));

            // Set the subject
            message.setSubject(subject);

            // Set the content
            message.setText(content);

            // Send message
            Transport.send(message);
        }
        catch (Exception e)
        {
            System.err.println(e);
        }
    }

    public Mail(String host, String from, String to, String cc, String subject, String content)
    {
        try
        { // Get system properties
            Properties props = System.getProperties();

            // Setup mail server
            props.put(Messages.getString("Mail.mail.smtp.host_2"), host); //$NON-NLS-1$

            // Get session
            Session session = Session.getDefaultInstance(props, null);

            // Define message
            MimeMessage message = new MimeMessage(session);

            // Set the from address

            message.setFrom(new InternetAddress(from));

            // Set the to address
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));


            message.addRecipient(Message.RecipientType.CC, new InternetAddress(cc));

            // Set the subject
            message.setSubject(subject);

            // Set the content
            message.setText(content);

            // Send message
            Transport.send(message);
        }
        catch (Exception e)
        {
            System.err.println(e);
        }

    }

    public Mail(String host, String from, String to, String subject, String content)
    {
        try
        { // Get system properties
            Properties props = System.getProperties();

            // Setup mail server
            props.put(Messages.getString("Mail.mail.smtp.host_3"), host); //$NON-NLS-1$

            // Get session
            Session session = Session.getDefaultInstance(props, null);

            // Define message
            MimeMessage message = new MimeMessage(session);

            // Set the from address

            message.setFrom(new InternetAddress(from));

            // Set the to address
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            // Set the subject
            message.setSubject(subject);

            // Set the content
            message.setText(content);

            // Send message
            Transport.send(message);
        }
        catch (Exception e)
        {
            System.err.println(e);
        }
    }

    public static String getCurrentDateTime()
    {

        SimpleDateFormat formatter1 = new SimpleDateFormat(Messages.getString("Mail.MMM_dd,_yyyy_4")); //$NON-NLS-1$
        java.util.Date currentTime = new java.util.Date();
        String dateString = formatter1.format(currentTime);
        return dateString;
    }

    public static void main(String args[]) throws Exception
    {
        String host = args[0];
        String from = args[1];
        String to = args[2];
        String bcc = args[3];
        String cc = args[4];
        String content = args[5];
        String subject = args[6];


        Mail mail_1 = new Mail(host, from, to, cc, subject, content);
        Mail mail_2 = new Mail(host, from, to, subject, content);
        Mail me = new Mail(host, from, to, cc, bcc, subject, content);
    }
}
