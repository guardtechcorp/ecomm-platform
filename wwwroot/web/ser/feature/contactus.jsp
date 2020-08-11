<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo" %>
<%@ include file="../include/pageheader.jsp"%>
<% {
//BasicWeb.showAllParameters(request, out);
  CompanyInfo cpInfo = mcBean.getCompany(cfInfo.MemberID);
%>
 <TABLE cellspacing=4 cellpadding=4 width="100%" valgin="top">
   <TR>
     <TD>
       <b><font face=arial size=2><%=Utilities.getValue(cpInfo.CompanyName)%><br>
       <%=Utilities.getValue(cpInfo.Address)%><br>
       <%=Utilities.getValue(cpInfo.City)%>, <%=Utilities.getValue(cpInfo.State)%> <%=Utilities.getValue(cpInfo.ZipCode)%></font></b>
       <br><br><font face=arial size=2><%=mcBean.getLabel("cm-email")%>: <b><%=Utilities.getValue(cpInfo.EMail)%></b></font>
       <br><font face=arial size=2><%=mcBean.getLabel("cm-phone")%>: <b><%=Utilities.getValue(cpInfo.Phone)%></b></font>
       <%if (cpInfo.Fax!=null&&cpInfo.Fax.length()>0){%> <%=mcBean.getLabel("cm-fax")%>: <b><%=Utilities.getValue(cpInfo.Fax)%></b> <%}%>
       <br><br>
       <font face=arial size=2><b><%=Utilities.getValue(cpInfo.CompanyDesc)%></b></font>
       <br> 
     </TD>
   </TR>
<% if (Utilities.getValue(cpInfo.ContactUsPage).length()>4) { %>
   <TR>
     <TD><%=cpInfo.ContactUsPage%></TD>
   </TR>
<% } %>
<% if (cpInfo.PhotoImageID>0) { %>
   <TR>
     <TD align="center">
       <fieldset style="margin:0px" width="98%"><legend><font size="3"><%=mcBean.getLabel("cu-orgphoto")%></font></legend>
       <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #E8E8E8;">
        <TR>
          <TD><%=mcBean.getImageFileHtml(cpInfo.PhotoImageID, 700, 600)%></TD>
        </TR>
        </TABLE>
        </fieldset>
     </TD>
   </TR>
<% if (cpInfo.ShowMap!=0) {
  String sAddress = cpInfo.Address + ", " + cpInfo.City + ", " + cpInfo.State + " " + cpInfo.ZipCode + ", " + cpInfo.Country;
  String sGoogleMapKey = cpInfo.GoogleMapKey;
  if (sGoogleMapKey==null || sGoogleMapKey.length()<10)
     sGoogleMapKey = "ABQIAAAATSTlO_nMg5E7JdvPe1MuqRQsLxuMSvocc63hZl-w474THAT4GhT1H2jLvoujrGmGOyetBsle5RJ2OA";
%>
   <TR>
    <TD align="center">
     <fieldset style="margin:0px" width="98%"><legend><font size="3"><%=mcBean.getLabel("cu-locationmap")%></font></legend>
     <TABLE width="100%" border="0" cellspacing="0" cellpadding="0" style="border:1px solid #E8E8E8;">
     <TR>
      <TD><div id="gmap_canvas" style="width: 100%; height: 400px"></div></TD>
     </TR>
     </TABLE>
     </fieldset>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=<%=sGoogleMapKey%>" type="text/javascript"></script>
<SCRIPT>
var gl_map = null;
var gl_geocoder = null;
function initializeGMap() {
    gl_map = new GMap2(document.getElementById("gmap_canvas"));
    gl_map.setCenter(new GLatLng(37.4419, -122.1419), 13);
    gl_map.addControl(new GLargeMapControl());
    gl_map.addControl(new GMapTypeControl());
//gl_map.disableDragging();
    gl_map.doubleClickZoomEnabled();
    gl_map.enableScrollWheelZoom();
    gl_geocoder = new GClientGeocoder();
    showAddressOnGMap('<%=sAddress%>');
    gl_map.refresh();
}
function showAddressOnGMap(address)
{
  if (gl_geocoder) {
    gl_geocoder.getLatLng(
      address,
      function(point) {
        if (!point) {
//		  alert(address + " not found");
        } else {
          gl_map.setCenter(point, 14);
          var marker = new GMarker(point);
          gl_map.addOverlay(marker);
//          marker.openInfoWindowHtml(address);
        }
      }
    );
  }
}
initializeGMap();
</SCRIPT>
    </TD>
   </TR>
 <% } %>
 <% } %>
 </TABLE>
<% } %>