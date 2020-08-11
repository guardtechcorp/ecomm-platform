function getHttpObject()
{
    var xmlhttp;
    if (window.XMLHttpRequest)
    { // Mozilla, Safari,...
       xmlhttp = new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    { // IE
      try { // ? IE
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
      }
      catch (e)
      {
        try { // ? IE
          xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {}
      }
   }

   return xmlhttp;
}

function getUrlContent(sUrl)
{
   var xmlhttp = getHttpObject();
   xmlhttp.open("GET", sUrl, false);
   xmlhttp.setRequestHeader("Accept-Charset","UTF-8");
   xmlhttp.send(null);
   strDoc = xmlhttp.responseText;
   return strDoc;
}

function getUrlContent2(sUrl, call)
{
   var xmlp = getHttpObject();
   xmlp.open("GET", sUrl, true);
   xmlp.setRequestHeader("Accept-Charset","UTF-8");
   xmlp.onreadystatechange = call;
   xmlp.send(null);

   return xmlp;
}

var g_wcxmlp = null;
function onDIResponse()
{
   if (g_wcxmlp==null) return;
   if (g_wcxmlp.readyState != 4)  { return; }
   if (g_wcxmlp.status==200)
   {
//alert("Finished.");
     document.getElementById('webcenter_table').innerHTML = g_wcxmlp.responseText;
   }
}

function getAdsTable(dn, st, wh, ht)
{
   var ajaxUrl = "http://" + dn + "/service/ads/_" + slot + "?dn=ads.cybeye.com&size=" + wh + "x" + ht + "&output=js" + "&"+new Date().getTime();
//   var sContent = getUrlContent(sAjaxUrl);
//   document.write(sContent);
   var aTable = "<table width='100%'><tr><td id='webcenter_table'></td></tr></table>";
   document.write(aTable);
   g_uwxmlp = getUrlContent2(ajaxUrl, onDIResponse);
}

function getAdsIframe(dn, st, wh, ht)
{
   var ajaxUrl = "http://" + dn + "/service/ads/_" + st + "/?size=" + wh + "x" + ht + "&output=js" + "&te"+new Date().getTime();
   //var ajaxUrl = "/service/ads/_" + st + "/?dn=" + dn + "&size=" + wh + "x" + ht + "&output=js" + "&"+new Date().getTime();
   var aFrame = '<iframe src="'+ajaxUrl+'" name="WebCenterFrame" id="WebCenterFrame" width="100%" height="100%" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>';
   document.write(aFrame);
}

function showTestAds(dn, st, idhtml)
{
//   var ajaxUrl = "/service/ads/_" + st + "/?dn=" + dn + "&output=js" + "&"+new Date().getTime();
   var ajaxUrl = "http://" + dn + "/service/ads/_" + st + "/?output=js" + "&"+new Date().getTime();
//alert("ajaxUrl =" + ajaxUrl);
   var content = getUrlContent(ajaxUrl);
   document.getElementById(idhtml).innerHTML = content;
//    $.ajax({
//          url: ajaxUrl,
//          method: 'GET',
//          success: function (content) {
//            $('#' + idhtml).html(content);
//          }
//     });
   return false;
}

if (typeof webcenter_ad_domain !== 'undefined')
{
  getAdsIframe(webcenter_ad_domain, webcenter_ad_slot, webcenter_ad_width, webcenter_ad_height);
}
