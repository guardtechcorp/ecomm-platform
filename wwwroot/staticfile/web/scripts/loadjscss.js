
var filesadded="" //list of files already added

function checkloadjscssfile(filename, filetype){
 if (filesadded.indexOf("["+filename+"]")==-1){
  loadjscssfile(filename, filetype)
  filesadded+="["+filename+"]" //List of files added in the form "[filename1],[filename2],etc"
 }
 else
  alert("file already added!")
}


function loadjscssfile(filename, filetype){
 if (filetype=="js"){ //if filename is a external JavaScript file
  var fileref=document.createElement('script')
  fileref.setAttribute("type","text/javascript")
  fileref.setAttribute("src", filename)
 }
 else if (filetype=="css"){ //if filename is an external CSS file
  var fileref=document.createElement("link")
  fileref.setAttribute("rel", "stylesheet")
  fileref.setAttribute("type", "text/css")
  fileref.setAttribute("href", filename)
 }
 if (typeof fileref!="undefined")
  document.getElementsByTagName("head")[0].appendChild(fileref)
}

function removejscssfile(filename, filetype){
 var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none" //determine element type to create nodelist from
 var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none" //determine corresponding attribute to test for
 var allsuspects=document.getElementsByTagName(targetelement)
 for (var i=allsuspects.length; i>=0; i--){ //search backwards within nodelist for matching elements to remove
  if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(filename)!=-1)
   allsuspects[i].parentNode.removeChild(allsuspects[i]) //remove element by calling parentNode.removeChild()
 }
}

function createjscssfile(filename, filetype){
 if (filetype=="js"){ //if filename is a external JavaScript file
  var fileref=document.createElement('script')
  fileref.setAttribute("type","text/javascript")
  fileref.setAttribute("src", filename)
 }
 else if (filetype=="css"){ //if filename is an external CSS file
  var fileref=document.createElement("link")
  fileref.setAttribute("rel", "stylesheet")
  fileref.setAttribute("type", "text/css")
  fileref.setAttribute("href", filename)
 }
 return fileref
}

function replacejscssfile(oldfilename, newfilename, filetype){
 var targetelement=(filetype=="js")? "script" : (filetype=="css")? "link" : "none" //determine element type to create nodelist using
 var targetattr=(filetype=="js")? "src" : (filetype=="css")? "href" : "none" //determine corresponding attribute to test for
 var allsuspects=document.getElementsByTagName(targetelement)
 for (var i=allsuspects.length; i>=0; i--){ //search backwards within nodelist for matching elements to remove
  if (allsuspects[i] && allsuspects[i].getAttribute(targetattr)!=null && allsuspects[i].getAttribute(targetattr).indexOf(oldfilename)!=-1){
   var newelement=createjscssfile(newfilename, filetype)
   allsuspects[i].parentNode.replaceChild(newelement, allsuspects[i])
  }
 }
}

/*
checkloadjscssfile("myscript.js", "js") //success
checkloadjscssfile("myscript.js", "js") //redundant file, so file not added
*/

function dynamicAddScript()
{
var userinput = document.getElementById("userinput").value;
var request = "http://api.search.yahoo.com/ImageSearchService/V1/imageSearch?appid=YahooDemo&query=" + userinput
+ "&output=json&callback=getImages";
var head = document.getElementsByTagName("head").item(0);
var script = document.createElement("script");
script.setAttribute("type", "text/javascript");
script.setAttribute("src", request);
head.appendChild(script);

/*
var js = document.createElement("script");
js.type="text/javascript";
var d = new Date():
var q = encodeURIComponent("some query");
js.src = "update.php?q="+q+"&d="+d.valueOf();
document.appendChild(js);

var my_JSON_object = !(/[^,:{}\[\]0-9.\-+Eaeflnr-u \n\r\t]/.test(text.replace(/"(\\.|[^"\\])*"/g, ' '))) && eval('(' + text + ')');
*/
}

function getImage(JSONData)
{
  if (JSONData != null)
  {
    var div = document.getElementById("PlaceImages");
    for (i=0; i<10; i++)
    {
       var image = document.createElement("image");
       image.setAttribute("src", JSONData.ResultSet.Result[i].Url);
       image.setAttribute("width", 100);
       image.setAttribute("height", 100);
       div.appendChild(image);
     }
   }
}
