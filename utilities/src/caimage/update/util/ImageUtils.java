package caimage.update.util;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.metadata.IIOMetadata;
import javax.imageio.stream.ImageInputStream;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;

/**
 * 
 */

/**
 * Utilities for determining image metadata.
 * 
 * @author vaughng
 * @version $Revision$
 * Last depot modification: $DateTime$
 *
 * <!--Revision history:
 * Dec 2, 2009 vaughng: Initial version
 * -->
 */
public class ImageUtils
{

    private static final String TIF_WIDTH_NODE = "ImageWidth";
    private static final String TIF_HEIGHT_NODE = "ImageLength";
    
    public static int getTifWidth(File file) throws IOException
    {
        return getTifDimension(file, TIF_WIDTH_NODE);
    }
    
    public static int getTifLength(File file) throws IOException
    {
        return getTifDimension(file, TIF_HEIGHT_NODE);
    }
    
    public static int getTifWidth(InputStream stream) throws IOException
    {
        return getTifDimension(stream, TIF_WIDTH_NODE);
    }
    
    public static int getTifLength(InputStream stream) throws IOException
    {
        return getTifDimension(stream, TIF_HEIGHT_NODE);
    }
    
    private static int getTifDimension(InputStream stream, String dimension) throws IOException
    {

        int dim = -1;
        ImageInputStream iis = ImageIO.createImageInputStream(stream);
        Iterator<ImageReader> readers = ImageIO.getImageReaders(iis);

        if (readers.hasNext()) {

            // pick the first available ImageReader
            ImageReader reader = readers.next();

            // attach source to the reader
            reader.setInput(iis, true);

            // read metadata of first image
            IIOMetadata metadata = reader.getImageMetadata(0);

            String[] names = metadata.getMetadataFormatNames();
            int length = names.length;
            for (int i = 0; i < length; i++) {
                if (names[i].indexOf("_tiff_") >= 0)
                {
                    dim = getTifDimension(metadata.getAsTree(names[i]),dimension);
                    if (dim > -1)
                        break;
                }
            }
        }
        return dim;
    }
    
    private static int getTifDimension(File file, String dimension) throws IOException
    {

        int dim = -1;
        ImageInputStream iis = ImageIO.createImageInputStream(file);
        Iterator<ImageReader> readers = ImageIO.getImageReaders(iis);

        if (readers.hasNext()) {

            // pick the first available ImageReader
            ImageReader reader = readers.next();

            // attach source to the reader
            reader.setInput(iis, true);

            // read metadata of first image
            IIOMetadata metadata = reader.getImageMetadata(0);

            String[] names = metadata.getMetadataFormatNames();
            int length = names.length;
            for (int i = 0; i < length; i++) {
                if (names[i].indexOf("_tiff_") >= 0)
                {
                    dim = getTifDimension(metadata.getAsTree(names[i]),dimension);
                    if (dim > -1)
                        break;
                }
            }
        }
        return dim;
    }
    
    private static int getTifDimension(Node node, String nodeName)
    {
        int dim = -1;
        if (node.getNodeName().equalsIgnoreCase("tiffifd"))
        {
            Node child = node.getFirstChild();
            while (child != null)
            {
                if (child.getNodeName().equalsIgnoreCase("tifffield"))
                {
                    NamedNodeMap map = child.getAttributes();
                    if (map.getNamedItem("name") != null && map.getNamedItem("name").getNodeValue().equalsIgnoreCase(nodeName))
                    {
                        Node widthChild = child.getFirstChild();
                        if (widthChild != null)
                        {
                            widthChild = widthChild.getFirstChild();
                            map = widthChild.getAttributes();
                            if (map.getNamedItem("value") != null)
                            {
                                dim = Integer.parseInt(map.getNamedItem("value").getNodeValue());
                                break;
                            }
                        }
                    }
                    else
                    {
                        child = child.getNextSibling();
                    }
                }
            }
            
        }
        else 
        {
            Node child = node.getFirstChild();
            if (child != null)
                dim = getTifDimension(child, nodeName);
            else
            {
                child = node.getNextSibling();
                if (child != null)
                    dim = getTifDimension(child, nodeName);
            }
        }
        return dim;
    }
}
