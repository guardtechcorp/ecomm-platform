var currentUploads = 0; // current # of attachment sections on the web page
var nameDesc = ''; // Name property for the Description Input field
var nameFile = ''; // Name property for the File Input field
var scrollPosVert = 0; // stores the current scroll position on the form

// SCROLL FUNCTIONS
function saveScrollPos(offset)
{
	scrollPosVert=(document.all)?document.body.scrollTop:window.pageYOffset-offset;
}

function setScrollPos()
{
	window.scrollTo(0, scrollPosVert);
	setTimeout('window.scrollTo(0, scrollPosVert)',1);
}

// This function adds a new attachment section to the form. It is called when the user clicks the "Attach a file" button...
function addUpload(maxUploads, fileFieldName, descFieldName)
{
	nameFile = fileFieldName;
	if (typeof descFiledName!="undefined")
       nameDesc = descFieldName;

    currentUploads++;
	if (currentUploads>maxUploads) return;
	if (currentUploads==maxUploads)
	   document.getElementById('addupload').style.visibility='hidden';

    // First, clone the hidden attachment section
	var newFields = document.getElementById('attachment').cloneNode(true);
	newFields.id = '';
	// Make the new attachments section visible
	newFields.style.display = 'block';

	// loop through tags in the new Attachment section and set ID and NAME properties
	var newField = newFields.childNodes;
	for (var i=0;i<newField.length;i++)
	{
		if (newField[i].name==nameFile)
		{
		   newField[i].id=nameFile+currentUploads;
		   newField[i].name=nameFile+currentUploads;
		}

		if (newField[i].name==nameDesc)
		{
		   newField[i].id=nameDesc+currentUploads;
           newField[i].name=nameDesc+currentUploads;
		}

		if (newField[i].id=='dropcap')
		{
			newField[i].id='dropcap'+currentUploads;
			newField[i].childNodes[0].data=currentUploads;
		}
	}

	// Insert our new Attachment section into the Attachments Div on the form...
	var insertHere = document.getElementById('attachmentmarker');
	insertHere.parentNode.insertBefore(newFields,insertHere);
}

// This function removes an attachment from the form and updates the ID and Name properties of all other Attachment sections
function removeFile(container, item)
{// get the ID number of the upload section to remove
    var tmp = item.getElementsByTagName('input')[0];  
    var basefieldname = '';
    if (tmp.type=='text') 
	  basefieldname = nameDesc;
	else 
	  basefieldname = nameFile;

	var iRemove=Number(tmp.id.substring(basefieldname.length, tmp.id.length));

	// Shift all INPUT field IDs and NAMEs down by one (for fields with a higher ID than the one being removed)
    var sParentId = 'attachparent';//'attachments';
    var x = document.getElementById(sParentId).getElementsByTagName('input');
	for (i=0;i<x.length;i++)
	{
		if (x[i].type=='text') basefieldname=nameDesc; else basefieldname=nameFile;
		var iEdit = Number(x[i].id.substring(basefieldname.length, x[i].id.length));
		if (iEdit>iRemove)
		{
			x[i].id=basefieldname+(iEdit-1);
			x[i].name=basefieldname+(iEdit-1);
		}
	}

	// Run through all the DropCap divs (the number to the right of the attachment section) and update that number...
	x=document.getElementById(sParentId).getElementsByTagName('span');
	for (i=0;i<x.length;i++)
	{// Verify this is actually the "dropcap" div
		if (x[i].id.substring(0, String('dropcap').length)=='dropcap')
		{
			ID = Number(x[i].id.substring(String('dropcap').length, x[i].id.length));
			// check to see if current attachment had a higher ID than the one we're removing (and thus needs to have its ID dropped)
			if (ID>iRemove)
			{
			  x[i].id='dropcap'+(ID-1);
			  x[i].childNodes[0].data=(ID-1);
			}
		}
	}

	currentUploads--;
	saveScrollPos(0);
    container = document.getElementById(sParentId);

    container.removeChild(item);
    setScrollPos();

	document.getElementById('addupload').style.visibility='visible';
//	if (currentUploads==0)
//	   document.getElementById('addupload').childNodes[0].data='Attach File';
}

function cleanAllAttaches()
{
  var sParentId = 'attachparent';
  var container = document.getElementById(sParentId);

  var x=document.getElementById(sParentId).getElementsByTagName('a');
  for (var i=x.length-1; i>=0; i--)
  {
    container.removeChild(x[i].parentNode);
  }

  currentUploads = 0;
  document.getElementById('addupload').style.visibility='visible';
}

/*
<input type="file" name="attachment" id="attachment" onchange="document.getElementById('moreUploadsLink').style.display = 'block';" />
<div id="moreUploads"></div>
<div id="moreUploadsLink" style="display:none;"><a href="javascript:addFileInput();">Attach another File</a></div>

var upload_number = 2;
function addFileInput() {
                 var d = document.createElement("div");
                 var file = document.createElement("input");
                 file.setAttribute("type", "file");
                 file.setAttribute("name", "attachment"+upload_number);
                 file.setAttribute("size", "50");
                 d.appendChild(file);
                 document.getElementById("moreUploads").appendChild(d);
                 upload_number++;
}
*/