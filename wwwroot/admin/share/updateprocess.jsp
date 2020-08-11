<html>
<head>
<title>Upload File Popup Window</title>
<link rel="stylesheet" href="uploadfile.css" type="text/css">
<SCRIPT Language="JavaScript" src="uploadfile.js"></SCRIPT>
</head>
<body>
<table width="500">
  <tr>
    <td><span id="statusarea"></span></td>
  </tr>
</table>
<SCRIPT>
var qsParm = new Array();
var query = window.location.search.substring(1);
var parms = query.split('&');
for (var i=0; i<parms.length; i++) {
    var pos = parms[i].indexOf('=');
    if (pos > 0) {
       var key = parms[i].substring(0,pos);
       var val = parms[i].substring(pos+1);
       qsParm[key] = val;
    }
}
var sFilename = "" + qsParm['file'];
repeatCheck(sFilename, 1, 'http://www.omniserve.com/prg/uploadfile?action=status&type=object', 'statusarea');
</SCRIPT>
</body>
</html>