/*L
 * Copyright SAIC
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/caimage/LICENSE.txt for details.
 */

package gov.nih.nci.caIMAGE.util;


import java.lang.*;
import java.util.*;
import java.sql.*;
import gov.nih.nci.caimage.db.*;
import gov.nih.nci.caIMAGE.*;

public class ImageOrganDiagnosis
{
    public static Vector imageOrgan(Long annotationid) throws SQLException
    {
        Image_organ organses = new Image_organ();
        Vector vorgan = null;
        Image_organ Org = null;
        String organname = null;
        vorgan = organses.retrieveAllWhere("ANNOTATION_ID=" + "'" + annotationid + "'");


        return vorgan;
    }//

    public static Vector imageDiagnosis(Long annotationid) throws SQLException
    {
        Image_diagnosis diagnosises = new Image_diagnosis();
        Vector vdiagnosis = null;
        Image_diagnosis Dig = null;
        String diagnosis = null;
        vdiagnosis = diagnosises.retrieveAllWhere("ANNOTATION_ID=" + "'" + annotationid + "'");


        return vdiagnosis;
    }//

    public static boolean imageOrganUpdate(Long annotation_id,
                                           Image_organ organses) throws SQLException
    {
        //update onlt organ
        boolean TGstatus = false;
        Image_organ imageovec = null;
        Vector vorgan_id = organses.retrieveByIMAGE_ORGAN__ANNOTATION_ID(annotation_id);
        for (int k = 0; k < vorgan_id.size(); k++)
        {
            imageovec = (Image_organ) vorgan_id.elementAt(k);

        }//for
        if (organses.getOrgan() != null)
        {
            organses.setImageorgan_id(imageovec.getImageorgan_id());
            organses.setAnnotation_id(annotation_id);
            TGstatus = organses.updateByKey();
        }
        return TGstatus;

    }

    public static boolean imageOrganInsert(Long annotation_id,
                                           Image_organ organses,
                                           KeyRetriever tk) throws SQLException
    {
        //insert only organ
        boolean TGstatus = false;
        organses.setImageorgan_id(tk.getNextKey("IMAGE_ORGAN"));
        organses.setAnnotation_id(annotation_id);
        TGstatus = organses.insert();
        return TGstatus;

    }

    public static boolean imageDiagnosisUpdate(Long annotation_id,
                                               Image_diagnosis diagnosises) throws SQLException
    {
        //update only dignosis
        boolean TGstatus = false;
        Image_diagnosis imagedigvec = null;
        Vector vdiagnois_id = diagnosises.retrieveByIMAGE_DIAGNOSIS__ANNOTATION_ID(annotation_id);
        for (int k = 0; k < vdiagnois_id.size(); k++)
        {
            imagedigvec = (Image_diagnosis) vdiagnois_id.elementAt(k);

        }//for
        Long diagnosesId = diagnosises.getImagediagnosis_id();
        if (diagnosises.getDiagnosis() != null)
        {
            diagnosises.setImagediagnosis_id(imagedigvec.getImagediagnosis_id());
            diagnosises.setAnnotation_id(annotation_id);
            TGstatus = diagnosises.updateByKey();
        }
        return TGstatus;

    }

    public static boolean imageDiagnosisInsert(Long annotation_id,
                                               Image_diagnosis diagnosises,
                                               KeyRetriever tk) throws SQLException
    {
        //update only dignosis
        boolean TGstatus = false;
        diagnosises.setImagediagnosis_id(tk.getNextKey("IMAGE_DIAGNOSIS"));
        diagnosises.setAnnotation_id(annotation_id);
        TGstatus = diagnosises.insert();

        return TGstatus;

    }

    public static boolean imageOrganDelete(Long annotation_id) throws SQLException
    {
        //insert only organ
        boolean TGstatus = false;
        Image_organ imageovec = null;
        Vector vOrgan = ImageOrganDiagnosis.imageOrgan(annotation_id);
        for (int k = 0; k < vOrgan.size(); k++)
        {
            imageovec = (Image_organ) vOrgan.elementAt(k);
            TGstatus = imageovec.deleteByIndex(imageovec.getImageorgan_id());
        }//for

        return TGstatus;
    }

    public static boolean imageDiagnosisDelete(Long annotation_id) throws SQLException
    {
        //insert only organ
        boolean TGstatus = false;
        Image_diagnosis imagedigvec = null;
        Vector vDiagnosis = ImageOrganDiagnosis.imageDiagnosis(annotation_id);
        for (int k = 0; k < vDiagnosis.size(); k++)
        {
            imagedigvec = (Image_diagnosis) vDiagnosis.elementAt(k);
            TGstatus = imagedigvec.deleteByIndex(imagedigvec.getImagediagnosis_id());
        }//for

        return TGstatus;
    }

    public static boolean cloneInsert(Long id,
                                      Long annotation_count,
                                      KeyRetriever tk,
                                      boolean status_annot) throws SQLException
    {
        boolean status_org_dig = false;
        if (status_annot)
        {
            Image_organ organses = new Image_organ();
            Vector vorgan_id = organses.retrieveAllWhere("ANNOTATION_ID=" + "'" + id + "'");
            Image_organ imageovec = null;
            for (int k = 0; k < vorgan_id.size(); k++)
            {
                imageovec = (Image_organ) vorgan_id.elementAt(k);

            }//for
            organses.setOrgan(imageovec.getOrgan());
            if (imageovec.getOrgan() != null)
            {
                status_org_dig = ImageOrganDiagnosis.imageOrganInsert(annotation_count, organses, tk);
            }
            //diagnosis
            Image_diagnosis diagnosises = new Image_diagnosis();
            Vector vdiagnois_id = diagnosises.retrieveAllWhere("ANNOTATION_ID=" + "'" + id + "'");
            Image_diagnosis imagedigvec = null;
            for (int k = 0; k < vdiagnois_id.size(); k++)
            {
                imagedigvec = (Image_diagnosis) vdiagnois_id.elementAt(k);

            }//for
            if (imagedigvec.getDiagnosis() != null)
            {
                diagnosises.setDiagnosis(imagedigvec.getDiagnosis());
                diagnosises.setTumor_classification(imagedigvec.getTumor_classification());
                status_org_dig = ImageOrganDiagnosis.imageDiagnosisInsert(annotation_count, diagnosises, tk);
            }
        }//status
        return status_org_dig;
    }
}
