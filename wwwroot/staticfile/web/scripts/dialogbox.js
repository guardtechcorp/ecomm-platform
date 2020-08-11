// build/show the dialog box, populate the data and call the fadeDialog function //
var DIALOG_TIMER = 50;
var DIALOG_SPEED = 10;
// show the dialog box //
function showDialog(dialogboxid, authideseconds) 
{
//alert("dialogboxid=" + dialogboxid);
  var dialog = document.getElementById(dialogboxid);
  dialog.style.zIndex = 1000;
  dialog.style.visibility = "visible";

  if (authideseconds>=0)
  {
      dialog.style.opacity = .00;
      dialog.style.filter = 'alpha(opacity=0)';
      dialog.alpha = 0;
      dialog.timer = setInterval(function() {fadeDialog(1, dialogboxid)}, DIALOG_TIMER);
      if (authideseconds>0) 
         window.setTimeout(function() {hideDialog(dialogboxid)}, (authideseconds * 1000));
  }
}

// hide the dialog box //
function hideDialog(dialogboxid) 
{
//alert("dialogboxid=" + dialogboxid);
  var dialog = document.getElementById(dialogboxid);
  if (dialog.timer)
     clearInterval(dialog.timer);

  dialog.timer = setInterval( function() {fadeDialog(0, dialogboxid)}, DIALOG_TIMER);
}

function showMask(maskareaid)
{
  var dialogmask;
  if(!document.getElementById('dialogmask')) {
    dialogmask = document.createElement('div');
    dialogmask.id = 'dialog-mask';
    document.body.appendChild(dialogmask);
  } else {
    dialogmask = document.getElementById('dialog-mask');
    dialogmask.style.visibility = "visible";
  }

  var width, height;
  var maskarea = document.getElementById(maskareaid);
  if (maskarea!=null)
  {
	width = maskarea.offsetWidth;
	height = maskarea.offsetHeight;
  }
  else
  {
	width = pageWidth();
	height = pageHeight();
  }	

  dialogmask.style.zIndex = 100;
  dialogmask.style.width = (width+10) + 'px';
  dialogmask.style.height = (height+10) + 'px';  
}

function hideMask()
{
    var dialogmask = document.getElementById('dialog-mask');
    if (dialogmask)
    {
      document.getElementById('dialog-mask').style.visibility = "hidden";
      document.body.removeChild(dialogmask);
    }
}

// fade-in the dialog box //
function fadeDialog(flag, dialogboxid) 
{
  var dialog = document.getElementById(dialogboxid);
  var value;
  if(flag>0) {
    value = dialog.alpha + DIALOG_SPEED;
  } else {
    value = dialog.alpha - DIALOG_SPEED;
  }

  dialog.alpha = value;
  dialog.style.opacity = (value / 100);
  dialog.style.filter = 'alpha(opacity=' + value + ')';
  if (value >= 99) 
  {
    clearInterval(dialog.timer);
    dialog.timer = null;
  } 
  else if(value <= 1) 
  {
    dialog.style.visibility = "hidden";

/*
    var dialogmask = document.getElementById('dialog-mask');
	if (dialogmask)
	{
      document.getElementById('dialog-mask').style.visibility = "hidden";
      document.body.removeChild(dialogmask);
    }
*/
    hideMask();

	clearInterval(dialog.timer);
  }
}

function doProcess(dialogid, maskareaid)
{
  var dialogArea = document.getElementById(dialogid);
  var objMainArea = document.getElementById(maskareaid);
  var left = getLinkOffset(objMainArea, "left") + (objMainArea.offsetWidth-dialogArea.offsetWidth)/2;
  var top  = getLinkOffset(objMainArea, "top");
  if (top<topPosition())
     top = topPosition();
  top += 30;    
  dialogArea.style.top = top + "px";
  dialogArea.style.left = left + "px";
      
  showMask();//maskareaid);
  showDialog(dialogid, -1);
}

function closeProcess(dialogid)
{
  hideDialog(dialogid);
}

function displayDialog(title,message,type,autohide, maskareaid) 
{
  var dialogid = "dialog-body";
  var dialog;
  var dialogheader;
  var dialogclose;
  var dialogtitle;
  var dialogcontent;
  var dialogmask;
  if(!document.getElementById(dialogid)) {
    dialog = document.createElement('div');
    dialog.id = dialogid;//'dialog';
    dialogheader = document.createElement('div');
    dialogheader.id = 'dialog-header';
    dialogtitle = document.createElement('div');
    dialogtitle.id = 'dialog-title';
    dialogclose = document.createElement('div');
    dialogclose.id = 'dialog-close'
    dialogcontent = document.createElement('div');
    dialogcontent.id = 'dialog-content';
  
	document.body.appendChild(dialog);
    dialog.appendChild(dialogheader);
    dialogheader.appendChild(dialogtitle);
    dialogheader.appendChild(dialogclose);
    dialog.appendChild(dialogcontent);;
//    dialogclose.setAttribute("onclick","hideDialog('dialog')");
//    dialogclose.onclick = new Function("hideDialog('dialog')");
    dialogclose.onclick = function() {hideDialog(dialogid)};
  } else {
    dialog = document.getElementById(dialogid);
    dialogheader = document.getElementById('dialog-header');
    dialogtitle = document.getElementById('dialog-title');
    dialogclose = document.getElementById('dialog-close');
    dialogcontent = document.getElementById('dialog-content'); 
  }

  var width = pageWidth();
  var height = pageHeight();
  var left = leftPosition();
  var top = topPosition();
  var dialogwidth = dialog.offsetWidth;
  var dialogheight = dialog.offsetHeight;
  var topposition = top + (height / 3) - (dialogheight / 2);
  var leftposition = left + (width / 2) - (dialogwidth / 2);
  dialog.style.top = (topPosition() + 100) + "px";
  dialog.style.left = leftposition + "px";
  dialogheader.className = "dialog-" + type + "header";
  dialogtitle.innerHTML = title;
  dialogcontent.className = "dialog-" + type;
  dialogcontent.innerHTML = message;

  showMask(maskareaid);
  showDialog(dialogid, autohide); 
}