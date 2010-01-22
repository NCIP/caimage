//     var skin = 'evs1';
    windowTitle = "NCI Center for Bioinformatics";

    // targetFormName (String) - The name of the form with the target form fields (organ, organTissueName, organTissueCode) * NO SPACES *
    // species (String) - desired species * NO SPACES *

    function showTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode)
	
    {
      
	//var rootNode = 'Murine_Tissue_Type';
	var rootNode = 'MouseTissue';
	var roleType= '';
	var sementicType = 'T023,T024,T025';
	var title = 'Tissue Select';
	var params = ["true", "true", "-1", "0"];
	var postMsg = false;
	
	showTree(form, inConceptCode, inConceptName, inDisplayName, rootNode, roleType, sementicType, skin, params, leafNode, title, '', postMsg, '')
    }
//for field to blank
function showTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, fieldsToBlank)
 {
      	//var rootNode = 'Murine_Tissue_Type';
      	var rootNode = 'MouseTissue';
	var roleType= '';
	var sementicType = 'T023,T024,T025';
	var title = 'Tissue Select';
	var params = ["true", "true", "-1", "0"];
	var postMsg = false;

	
	showTree(form, inConceptCode, inConceptName, inDisplayName, rootNode, roleType, sementicType, skin, params, leafNode, title, fieldsToBlank, postMsg, '')
    }
function showHumanTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode)
	
    {
      
	var rootNode = 'Organ_System';
	var roleType= 'Anatomic_Structure_is_Physical_Part_Of';
	//var roleType= 'Anatomic_Structure_Has_Location,Anatomic_Structure_Is_Physical_Part_Of';
	var sementicType = 'T023,T017';
	var title = 'Human Tissue Select';
	var params = ["true", "true", "-1", "0"];
	var postMsg = false;
	
	showTree(form, inConceptCode, inConceptName, inDisplayName, rootNode, roleType, sementicType, skin, params, leafNode, title, '', postMsg, '')
    }
//for field to blank
function showHumanTissueTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, fieldsToBlank)
 {
      	var rootNode = 'HumanTissue';
	var roleType= 'Anatomic_Structure_Is_Physical_Part_Of';
	var sementicType = 'T023,T017';
	var title = 'Human Tissue Select';
	var params = ["true", "true", "-1", "0"];
	var postMsg = false;

	
	showTree(form, inConceptCode, inConceptName, inDisplayName, rootNode, roleType, sementicType, skin, params, leafNode, title, fieldsToBlank, postMsg, '')
    }


    // pop-up window utilitiy function
    function windowOpen(url,w,h,title)
    {
      window.name = 'root';
      remote = window.open(url,'none','width= '+w+',height='+h+', resizable=yes,scrollbars=yes');
      if (remote != null) {
  		remote.title = title;
        if (remote.opener == null) {
          remote.opener = self;
          remote.name = 'popup';
        }
      }
      remote.focus();
    }

    function showDiagnosisTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, rootNode)
	{

	var rootTop = '';
	//var rootTop = 'Mouse_Disorder_by_Site';
	var roleType= '';
	//var roleType= 'EO_Disease_Has_Associated_EO_Anatomy';
	var sementicType = 'T047,T191';
	var title = 'Diagnosis Select';
	var params = ["true", "true", "-1", "0"];
	var postMsg = false;

	
	showTree(form, inConceptCode, inConceptName, inDisplayName, rootNode, roleType, sementicType,  skin, params, leafNode, title, '', postMsg, rootTop)

		
	}
	
	 function showHumanDiagnosisTree(form, inConceptCode, inConceptName, inDisplayName, leafNode, rootNode)
		{
	
		var rootTop = '';
		var roleType= '';
		//var roleType= 'Disease_Has_Associated_Anatomic_Site';
		var sementicType = 'T047,T191';
		var title = 'Diagnosis Select';
		var params = ["true", "true", "-1", "0"];
		var postMsg = false;
	
		
		showTree(form, inConceptCode, inConceptName, inDisplayName, rootNode, roleType, sementicType,  skin, params, leafNode, title, '', postMsg, rootTop)
	
			
	}
function showTree(form, conceptCode, conceptName, displayName, rootNode, roleType, sementicType,  skin, params, leafNode, title, fieldsToBlank, postMsg, rootTop)

    {
	
	var now = new Date();
      var glob = now.getHours()+now.getSeconds()+now.getMilliseconds();
      var targetURL;
	var descendants;
	var isaFlag;
	var depthLevel;
	var attribute;
     	//for (j=0;j < params.length; j++){
	descendants = params[0];
	isaFlag = params[1];
	depthLevel = params[2];
	attribute = params[3];
	//}

if((fieldsToBlank==undefined)||(fieldsToBlank=='')){

	if((rootTop==undefined)||(rootTop=='')){
	
		if((roleType==undefined)||(roleType=='')){

//alert(1)
		targetURL = '/EVSTree/webtree/WebTreeMain.jsp?treeParams=treeNameKey='+rootNode+';conceptName='+conceptName+';conceptCode='+conceptCode+';displayName='+displayName+';descendants='+descendants+';isaFlag='+isaFlag+';depthLevel='+depthLevel+';attributes='+attribute+';onlyLeaf='+leafNode+';sementicType='+sementicType+';formName='+form+';postMsg='+postMsg+';&skin='+skin+'&windowTitle='+title+'&rand='+glob;
		} else {
//alert(2)
		targetURL = '/EVSTree/webtree/WebTreeMain.jsp?treeParams=treeNameKey='+rootNode+';conceptName='+conceptName+';conceptCode='+conceptCode+';displayName='+displayName+';descendants='+descendants+';isaFlag='+isaFlag+';depthLevel='+depthLevel+';attributes='+attribute+';onlyLeaf='+leafNode+';roleType='+roleType+';sementicType='+sementicType+';formName='+form+';postMsg='+postMsg+';&skin='+skin+'&windowTitle='+title+'&rand='+glob;
		}
	} else {
//alert(3)
	targetURL = '/EVSTree/webtree/WebTreeMain.jsp?treeParams=treeNameKey='+rootNode+';rootTop='+rootTop+';conceptName='+conceptName+';conceptCode='+conceptCode+';displayName='+displayName+';descendants='+descendants+';isaFlag='+isaFlag+';depthLevel='+depthLevel+';attributes='+attribute+';onlyLeaf='+leafNode+';roleType='+roleType+';sementicType='+sementicType+';formName='+form+';postMsg='+postMsg+';&skin='+skin+'&windowTitle='+title+'&rand='+glob;
	
	}
}
else {
//alert(4)
	if((roleType==undefined)||(roleType=='')){
			targetURL = '/EVSTree/webtree/WebTreeMain.jsp?treeParams=treeNameKey='+rootNode+';conceptName='+conceptName+';conceptCode='+conceptCode+';displayName='+displayName+';descendants='+descendants+';isaFlag='+isaFlag+';depthLevel='+depthLevel+';attributes='+attribute+';onlyLeaf='+leafNode+';sementicType='+sementicType+';formName='+form+';fieldsToBlank='+fieldsToBlank+';postMsg='+postMsg+';&skin='+skin+'&windowTitle='+title+'&rand='+glob;

			} else {
//alert(5)
			targetURL = '/EVSTree/webtree/WebTreeMain.jsp?treeParams=treeNameKey='+rootNode+';conceptName='+conceptName+';conceptCode='+conceptCode+';displayName='+displayName+';descendants='+descendants+';isaFlag='+isaFlag+';depthLevel='+depthLevel+';attributes='+attribute+';onlyLeaf='+leafNode+';roleType='+roleType+';sementicType='+sementicType+';formName='+form+';fieldsToBlank='+fieldsToBlank+';postMsg='+postMsg+';&skin='+skin+'&windowTitle='+title+'&rand='+glob;
//alert(2)
			}
	
	}

	
//alert(targetURL)
      // open target window
      windowOpen(targetURL, 810, 500, title);
    }



