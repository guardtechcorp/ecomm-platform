<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.PhotoBean"%>
<%@ page import="com.zyzit.weboffice.model.FileStorageInfo" %>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%
{
    PhotoBean bean = new PhotoBean(session);

    MemberInfo info = null;
    if (sRealAction.startsWith("Update"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;      // The information is not updated, because there is no any changes.
        }
        else
        {
            sDisplayMessage = mcBean.getLabel("mp-updatemsg");//DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "photo information");
        }
        info = (MemberInfo) ret.getUpdateInfo();
//System.out.println("Info = " + info);
    }
    else if (sRealAction.startsWith("Remove"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
        else
        {
            sDisplayMessage = mcBean.getLabel("mp-removemsg");//"Your photo image file was removed successfully.";
        }
        info = (MemberInfo) ret.getUpdateInfo();
    }
    else
    {
        info = bean.get(mbInfo.MemberID);
    }

    int nFileMaxSize = 1024; //(KB)
//System.out.println("sImageHtml="+ sImageHtml);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/member.js" type="text/javascript"></SCRIPT>
<FORM name="form_photo" method="post" action="<%=mcBean.encodedUrl("index.jsp?action=Update_Photo&maxsize="+nFileMaxSize)%>" enctype="multipart/form-data" onSubmit="return validatePhoto(this);" target1="target_upload">
 <INPUT type="hidden" name="subdir" value="photo">
 <table class="table-outline" width="100%" align="center">
 <TR>
   <TD colspan="3" height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
 </TR>
 <tr>
   <td width="16%" align="right" valign="top"><%=mcBean.getLabel("mp-photoimage")%>:</td>
   <td width="1%">&nbsp;</td>
   <td><input type="hidden" name="photoid" value="<%=info.PhotoID%>">
    <input type="file" name="photofile" size="60"><br> (<%=mcBean.getLabel("mp-bestsize")%>: <b>110 x 85</b> <%=mcBean.getLabel("mp-pixels")%>)

<% if (info.PhotoID>0) {
   FileStorageInfo fsInfo = mcBean.getPhotoInfo(mbInfo);
%>
     [<%=mcBean.getPreviewLink("PhotoImage", mcBean.getLabel("mp-photopicture"), info.PhotoID, mcBean.getLabel("cm-preview"))%>, <a href='<%=bean.encodedUrl("index.jsp?action=Remove_Photo&fileid="+info.PhotoID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>.');"><%=mcBean.getLabel("cm-delete")%></a>]
<% } %>
   </td>
 </tr>
<% if (info.PhotoID>0) {
    FileStorageInfo fsInfo = mcBean.getPhotoInfo(mbInfo);
%>
 <tr>
  <td width="16%" align="right" valign="top"></td>
  <td width="1%">&nbsp;</td>
  <td align="center" valign="top">
   <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
    <tr>
     <td width=150>
     <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
       <tr>
         <td valign="middle" bgcolor="#4279bd" width=150 height=20>&nbsp;<img height=10 src="/staticfile/web/images/tp05.gif" width=10>
         <b><font color="#ffffff"><%=mcBean.getLabel("mp-photopicture")%></font></b></td>
       </tr>
       <tr>
         <td valign="top" bgColor="#ffffff">
         <%=mcBean.getPhotoImageHtml(mbInfo, 200, 220)%>
         </td>
       </tr>
       <tr>
         <td height=5></td>
       </tr>
     </table>
     </td>
     <td width="20"></td>
     <td valign="top"> <font size="2"><%=mcBean.getLabel("mp-photoinfo")%>:<br>
        <br><br><%=mcBean.getLabel("mp-originalsize")%>:<b><%=fsInfo.Width%> x <%=fsInfo.Height%></b> (<%=mcBean.getLabel("mp-pixels")%>)
        <br><br><%=mcBean.getLabel("mp-filesize")%>: <b><%=Utilities.convertFileSize(fsInfo.ContentSize)%></b>
       </font>
     </td>
    </tr>
   </table>
   </td>
 </tr>
<% } %>
 <tr>
   <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
 </tr>
 <tr>
 <td height="24" width="16%" align="right" valign="top"><%=mcBean.getLabel("mp-describe")%>:<br>(<%=mcBean.getLabel("mp-maxchar")%>: 255)</td>
 <td width="1%">&nbsp;</td>
 <td><textarea name="slogan" rows="2" cols="70" wrap="virtual"><%=Utilities.getValue(info.Slogan)%></textarea></td>
 </tr>
 <tr>
   <td height="24" width="16%" align="right"></td>
   <td width="1%">&nbsp;</td>
   <td><%=mcBean.getLabel("cm-font")%>:
     <select name="sloganfont">
       <%=mcBean.getFontMeun(info.SloganFont)%>
     </select> &nbsp;<%=mcBean.getLabel("cm-size")%>:
     <select name="slogansize">
       <%=mcBean.getSizeMenu(info.SloganSize)%>
     </select> &nbsp;<%=mcBean.getLabel("cm-style")%>:
     <select name="sloganstyle">
         <%=mcBean.getFontStyleMenu(info.SloganStyle)%>
     </select>
  </td>
 </tr>
 <tr>
   <td height="24" width="16%" align="right"></td>
   <td width="1%">&nbsp;</td>
   <td> <%=mcBean.getLabel("cm-fontcolor")%>:
    <input type="text" name="slogancolor" value="<%=Utilities.getValue(info.SloganColor)%>" maxlength="7" size="6" style="color: <%=mbInfo.SloganColor%>" onClick="javascript:loadSelectColor(this, 2);" title="<%=mcBean.getLabel("cm-selectcolor")%>">
     &nbsp;<%=mcBean.getLabel("cm-backcolor")%>: <input type="text" name="sloganbkcolor" value="<%=Utilities.getValue(info.SloganBkColor)%>" maxlength="7" size="6" style="color: <%=info.SloganBkColor%>" onClick="javascript:loadSelectColor(this, 2);" title="<%=mcBean.getLabel("cm-selectcolor")%>">
  </td>
 </tr>
 <tr>
  <td colspan="3" height="5"></td>
 </tr>
 <tr>
   <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
 </tr>
 <tr>
  <td colspan="3" height="1">
<!--
   <a href="/staticfile/web/2008Pictures 029.jpg" rel="lightbox">It is a testing</a>
   <p></p>
  <p><a href="#mydiv" rel="facebox">View DIV with id="mydiv" on the page</a></p>
  <div id="mydiv" style="display:none">
  This is the contents of a hidden DIV on the page, with ID="mydiv" and style set to "display:none"<br /><br />
  <a href="http://www.dynamicdrive.com/dynamicindex4/facebox/index.htm">Facebox image and content viewer (v 1.1)</a>
   <img src="/staticfile/web/2008Pictures 029.jpg" width="500" height="400">
  </div>
-->
  </td>
 </tr>
 <tr>
   <td colspan="3" align="center">
     <input type="submit" name="submit" style='width:120px' value="<%=mcBean.getLabel("cm-update")%>">
   </td>
 </tr>
 <tr>
  <td colspan="3" height="5"></td>
 </tr>
</TABLE>
</FORM>
<!--SCRIPT>onPhotoFormLoad(document.form_photo);</SCRIPT-->
<iframe id='target_upload' name='target_upload' src='' style='display: none'></iframe>

<!--
<table>
<tr>
<td>
 <img src="/staticfile/web/css/media/jcrop/flowers.jpg" id="cropbox" />
 <img src="/staticfile/web/good-letter.gif" id="cropbox1" />
 <form onsubmit="return false;">
    <label>X1 <input type="text" size="4" id="x" name="x" /></label>
    <label>Y1 <input type="text" size="4" id="y" name="y" /></label>
    <label>X2 <input type="text" size="4" id="x2" name="x2" /></label>
    <label>Y2 <input type="text" size="4" id="y2" name="y2" /></label>
    <label>W <input type="text" size="4" id="w" name="w" /></label>
    <label>H <input type="text" size="4" id="h" name="h" /></label>
</form>
</td>
<td>
<div style="width:100px;height:100px;overflow:hidden;">
  <img src="/staticfile/web/css/media/jcrop/flowers.jpg" id="preview" />
</div>
</td>
</tr>
</table>
<SCRIPT src="/staticfile/web/scripts/jquery.pack.js" type=text/javascript></SCRIPT>
<SCRIPT src="/staticfile/web/scripts/jquery.jcrop.pack.js" type=text/javascript></SCRIPT>
<script language="Javascript">
jQuery(window).load(function(){

    jQuery('#cropbox').Jcrop({
        onChange: showPreview,
        onSelect: showPreview,
        aspectRatio: 1
 /*
        trueSize: [2048,1536],
        setSelect: [100,100,50,50],
        boxWidth: 720,
        boxHeight: 650
  */
    });

});
function showPreview(coords)
{
    jQuery('#x').val(c.x);
    jQuery('#y').val(c.y);
    jQuery('#x2').val(c.x2);
    jQuery('#y2').val(c.y2);
    jQuery('#w').val(c.w);
    jQuery('#h').val(c.h);

    var rx = 100 / coords.w;
    var ry = 100 / coords.h;

    jQuery('#preview').css({
        width: Math.round(rx * 500) + 'px',
        height: Math.round(ry * 370) + 'px',
        marginLeft: '-' + Math.round(rx * coords.x) + 'px',
        marginTop: '-' + Math.round(ry * coords.y) + 'px'
    });
}
</script>
-->
<% } %>