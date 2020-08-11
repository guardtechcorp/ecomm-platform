<%@ page import="com.zyzit.weboffice.bean.AdsBean" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.model.AdsInfo" %>
<%@ page import="com.zyzit.weboffice.service.AdsDelivery" %>
<%@ page import="com.zyzit.weboffice.bean.AdsConfigBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head><title>Ads Showing Block</title></head>
  <body>
<%
   // AdsBean bean = new AdsBean(session, 20);
//bean.showAllParameters(request, out);
//bean.dumpAllParameters(request);
    String sDomainName = request.getParameter("domainname");

    int nStatus = Utilities.getInt(request.getParameter("status"), 0);
    int nId = Utilities.getInt(request.getParameter("adsid"), 0);
    int nWidth = Utilities.getInt(request.getParameter("width"), 720);
    int nHeight = Utilities.getInt(request.getParameter("height"), 90);

    String sMessage = request.getParameter("message");
    AdsInfo adsInfo = null;
    if (nId>0)
    {
       adsInfo = AdsDelivery.getAdsById(sDomainName, nId);
       if (adsInfo==null)
       {
          nStatus = AdsDelivery.Status.ADSID.GetValue();
          sMessage = AdsDelivery.Status.ADSID.GetName();
       }
    }
%>
<%
if (adsInfo!=null) {

   String sBorderAttr = "border:" + adsInfo.Border + "px";
   if (adsInfo.BorderStyle>=0)
      sBorderAttr += " " + AdsInfo.ABorderStyle.GetNameByValue(adsInfo.BorderStyle).toLowerCase();
   if (Utilities.getValueLength(adsInfo.BorderColor)>5)
      sBorderAttr += " " + adsInfo.BorderColor;
   String sLinkUrl = "";
   String sLinkUrlWithLink = "";
   if (Utilities.getValueLength(adsInfo.LinkUrl)>0)
   {
      sLinkUrl = AdsConfigBean.getAdsAccessUrl(sDomainName, request, adsInfo.AdsID);
      if (sLinkUrl.indexOf("?")==-1)
        sLinkUrl += "?act=2";
      else
        sLinkUrl += "&act=2";

       String sTarget = "";
       if (adsInfo.ShowWay!=AdsInfo.AShowWay.SAMETAB.GetValue())
          sTarget = " target='_CT_ADWin'";

      sLinkUrlWithLink = "<a href='" + sLinkUrl + "'" + sTarget + ">" + adsInfo.LinkUrl + "</a>";
   }
%>
<table width="<%=nWidth%>" height="<%=nHeight%>" border="0" style="<%=sBorderAttr%>" bgcolor="<%=adsInfo.BackColor%>" align="center">
  <tr>
   <td><h3 align="center"><%=Utilities.getValue(adsInfo.Title)%></h3>       
   AdsID: <b><%=adsInfo.Slot%></b>,  Type: <b><%=AdsInfo.AContentType.GetNameByIndex(adsInfo.ContentType)%></b>
   <br>Description: <b><%=Utilities.getValue(adsInfo.Description)%></b>
   <br>Size: <b><%=adsInfo.Width%> X <%=adsInfo.Height%></b>
   <br>Link Url: <b><%=sLinkUrlWithLink%></b>
   </td>
  </tr>
<% if (Utilities.getValueLength(adsInfo.Filename)>0) {
    String sImageUrl = AdsConfigBean.getAdsAccessImageUrl(sDomainName, request, adsInfo.Filename);
    String sTarget = "";
    if (adsInfo.ShowWay!=AdsInfo.AShowWay.SAMETAB.GetValue())
       sTarget = "target='_CT_ADWin'";
%>
  <tr>
   <td>
     <a href="<%=sLinkUrl%>" <%=sTarget%>><img src="<%=sImageUrl%>" alt="<%=adsInfo.Title%>"></a>
   </td>
  </tr>
<% } %>
</table>
<% } else { %>
<table width="<%=nWidth%>" height="<%=nHeight%>" border="1">
  <tr>
   <td>
   <p>
      <%=sMessage%>
   </p>
<% } %>
     </td>
    </tr>
  </table>
  </body>
</html>
