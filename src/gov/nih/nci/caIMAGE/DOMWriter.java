/*L
 * Copyright SAIC (Corporate).
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See https://github.com/NCIP/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE;

import java.io.*;
import org.w3c.dom.*;
import org.w3c.dom.Document;
import org.xml.sax.*;
import javax.xml.parsers.*;
import javax.xml.*;


public class DOMWriter
{


    public DOMWriter()
    {}

    /**
     * Return a string containing this node serialized as XML.
     */
    public static String nodeToString(Node node)
    {
        //create the string write for the output stream
        StringWriter sw = new StringWriter();

        serializeAsXML(node, sw);

        return sw.toString();

    }

    /**
     * Serialize this node into the writer as XML.
     */
    public static void serializeAsXML(Node node,
                                      Writer writer)
    {
        boolean aflag = true;
        boolean autoflush = true;
        print(node, new PrintWriter(writer, autoflush), aflag);
    }

    /**
     * Printer clss to produce the output
     */
    private static void print(Node node,
                              PrintWriter out,
                              boolean aflag)
    {
        if (node == null)
        {
            return;
        }
        //checks to see if it has children
        boolean hasChildren = false;

        int type = node.getNodeType();

        switch (type)
        {
            //checks the document node
            case Node.DOCUMENT_NODE:
            {
                // out.print("<?xml version=\"1.0\" ");
                // out.print("encoding=\"UTF-8\"?>");

                NodeList children = node.getChildNodes();

                if (children != null)
                {

                    int numChildren = children.getLength();
                    out.println("the value" + numChildren);

                    for (int i = 0; i < numChildren; i++)
                    {

                        print(children.item(i), out, false);
                    }
                }
                break;
            }
            //check and format the element node
            case Node.ELEMENT_NODE:
            {
                //Attributes name  begins here
                NamedNodeMap attrs = node.getAttributes();
                int len = (attrs != null) ? attrs.getLength() : 0;
                //Prints the doctype and xml version flag to go only one time
                if (len == 1 && aflag == true)
                {

                    String s = doctype(node);
                    out.print(s);
                }

                //Beginging of element and attributes both formation
                out.print('\n');
                out.print('<' + node.getNodeName());

                for (int i = 0; i < len; i++)
                {

                    Attr attr = (Attr) attrs.item(i);
                    out.print(' ' + attr.getNodeName() + "=\"" + normalize(attr.getValue()) + '\"');
                }

                //Attributes ends here and element start here
                NodeList children = node.getChildNodes();

                if (children != null)
                {
                    int numChildren = children.getLength();

                    hasChildren = (numChildren > 0);

                    if (hasChildren)
                    {
                        //end of element name
                        out.print('>');

                    }
                    for (int i = 0; i < numChildren; i++)
                    {
                        //Begining of the element value and call the print method recursively
                        print(children.item(i), out, false);
                    }

                }
                else
                {
                    //out.print('\n');
                    hasChildren = false;

                }
                //checks to see if it has children
                if (!hasChildren)
                {
                    out.print("/>");
                    //out.print('\n');
                }
                break;
            }
            //formed the entity reference node
            case Node.ENTITY_REFERENCE_NODE:
            {
                out.print('&');
                out.print(node.getNodeName());
                out.print(';');
                break;
            }
            //forms the cdata section node
            case Node.CDATA_SECTION_NODE:
            {
                out.print("<![CDATA[");
                out.print(node.getNodeValue());
                out.print("]]>");
                break;
            }
            //forms the text node and call method normalize to get the formation of text which is a element value
            case Node.TEXT_NODE:
            {

                out.print(normalize(node.getNodeValue()));
                break;
            }
            //forms the commnet code
            case Node.COMMENT_NODE:
            {
                out.print("<!--");
                out.print(node.getNodeValue());
                out.print("-->");
                break;
            }
            //forms the processing instruction
            case Node.PROCESSING_INSTRUCTION_NODE:
            {
                out.print("<?");
                out.print(node.getNodeName());

                String data = node.getNodeValue();

                if (data != null && data.length() > 0)
                {
                    out.print(' ');
                    out.print(data);
                }

                out.println("?>");
                break;
            }
        }
        //forms the element node and make the last element  child
        if (type == Node.ELEMENT_NODE && hasChildren == true)
        {
            out.print("</");
            out.print(node.getNodeName());
            out.print('>');
            //ending of the element
            out.print('\n');
            hasChildren = false;
        }

    }

    /**
     * Create the xml version and doc type for the correct Node like Agents, genes etc.
     */
    public static String doctype(Node node)
    {
        StringBuffer str = new StringBuffer();
        // if (Node.DOCUMENT_TYPE_NODE == node.getNodeType() && node.getChildNodes().getLength() > 0)

        str.append("<?xml version=\"1.0\" ");
        str.append("encoding=\"UTF-8\"?>" + "\n");
        str.append("<!DOCTYPE ");
        str.append(node.getNodeName());
        str.append(" SYSTEM ");
        str.append("\"" + node.getNodeName().substring(14, node.getNodeName().length()) + ".dtd" + "\"");
        str.append(">");
        return (str.toString());
    }

    //checks to see the charcter in the xml document and interpret them successfully
    private static String normalize(String s)
    {

        StringBuffer str = new StringBuffer();
        int len = (s != null) ? s.length() : 0;

        for (int i = 0; i < len; i++)
        {
            char ch = s.charAt(i);

            switch (ch)
            {
                case '<':
                {
                    str.append("&lt;");
                    break;
                }
                case '>':
                {
                    str.append("&gt;");
                    break;
                }
                case '&':
                {
                    str.append("&amp;");
                    break;
                }
                case '"':
                {
                    str.append("&quot;");
                    break;
                }
                case '\n':
                {
                    if (i > 0)
                    {
                        char lastChar = str.charAt(str.length() - 1);

                        if (lastChar != '\r')
                        {
                            str.append("\n");
                        }
                        else
                        {
                            str.append("\n");
                        }
                    }
                    else
                    {
                        str.append('\n');
                    }
                    break;
                }
                default:
                {
                    str.append(ch);
                }
            }
        }
        return (str.toString());

    }

}
