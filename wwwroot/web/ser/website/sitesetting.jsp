<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%@ page import="com.zyzit.weboffice.bean.SiteSettingBean"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage" %>
<%@ page import="com.zyzit.weboffice.model.MemberInfo" %>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    SiteSettingBean bean = SiteSettingBean.getObject(session);
    ConfigInfo info;

    if (sRealAction.startsWith("Remove")) {
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        } else {
            sDisplayMessage = mcBean.getLabel("ws-removemsg");
        }
        info = (ConfigInfo) ret.getUpdateInfo();
    } else if (sRealAction.startsWith("Publish")) {
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        } else {
            sDisplayMessage = mcBean.getLabel("ws-publish");
        }
        info = (ConfigInfo) ret.getUpdateInfo();
    } else if (sRealAction.startsWith("Update")) {
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        } else {
            if (sRealAction.startsWith("Update"))
                sDisplayMessage = mcBean.getLabel("ws-updatemsg");
            else
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "site setting");
        }
        info = (ConfigInfo) ret.getUpdateInfo();
//System.out.println("Info = " + info);
    } else {
        info = bean.get(request, mbInfo.MemberID);
    }

    boolean bCanHaveSelfAds = bean.canHavePaidService(info.MemberID, 7);

//Utilities.dumpObject(info);
    int nFileMaxSize = 50 * 1024; // 50 MB
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/sitesetting.js" type="text/javascript"></SCRIPT>
  <FORM name="form_sitesetting" action="<%=mcBean.encodedUrl("index.jsp?action=Update_SiteSetting&maxsize="+nFileMaxSize)%>" method="post"  enctype="multipart/form-data" onSubmit="return validateSiteSetting(this);">
  <input type="hidden" name="configid" value="<%=info.ConfigID%>">
  <input type="hidden" name="publish" value="<%=info.Publish%>">
  <input type="hidden" name="subdir" value="site">
  <input type="hidden" name="autopublish" value="1">
  <input type="hidden" name="action1" value="Update_SiteSetting">
  <table cellspacing=0 cellpadding=0 width="100%" align="center" border=0 style1="border: 1px solid #DFDFDF; padding: 5px;">
  <TR>
   <TD height="2">
    <%@ include file="../include/information.jsp"%>
   </TD>
  </TR>
  <TR>
   <TD height="5"></TD>
  </TR>
<% if (info.Publish==1000) { %>
  <TR>
   <TD align="right" valign="top">
    <table cellspacing=0 cellpadding=4 width="100%" align="center" border=0 >
     <tr>
      <td align="center" valign="top">
   <script>createLeftButton();</script>
    <a class="button" onClick="return true;" href="<%=mcBean.encodedUrl("util/previewsite.jsp?action=Preview_SiteSetting&memberid=" + mbInfo.MemberID)%>" title="<%=mcBean.getLabel("ws-previewsite")%>" target="_blank">&nbsp;&nbsp;<%=mcBean.getLabel("ws-preview")%> &nbsp;&nbsp;</a>
   <script>createRightButton();</script>
      </td>
      <td align="center" valign="top">
   <script>createLeftButton();</script>
    <a class="button" onClick="return validatePublish(document.form_sitesetting);" href="<%=mcBean.encodedUrl("index.jsp?action=Publish_SiteSetting")%>" title="<%=mcBean.getLabel("ws-publishchange")%>">&nbsp;&nbsp;<%=mcBean.getLabel("ws-publish")%> &nbsp;&nbsp;</a>
   <script>createRightButton();</script>
      </td>
     </tr>
    </table>
   </TD>
  </TR>
  <TR>
  <TR>
    <TD height="6"></TD>
  </TR>
<% } %>
  <tr>
   <td>
  <fieldset style="margin:0px"><legend><%=mcBean.getLabel("ws-generalweb")%></legend>
    <table cellspacing=0 cellpadding=4 width="100%" align="center" border=0 style1="border: 1px dashed #DFDFDF">
      <tr>
       <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-websitename")%>:</td>
       <td><input maxlength=255 size=60 value="<%=Utilities.getValue(info.SiteName)%>" name="sitename"> <%=mcBean.getLabel("ws-sitenamedesc")%>.</td>
      </tr>
      <tr>
        <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-websiteurl")%>:</td>
        <td><b><%=mcBean.getSiteUrl(info)%></b></td>
      </tr>
      <tr>
       <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-language")%>:</td>
       <td>
         <select name="language">
          <%=bean.getLanguageOption(info.Language)%>
         </select> <%=mcBean.getLabel("ws-languagedesc")%>.
       </td>
      </tr>
      <tr>
       <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("cm-backcolor")%>:</td>
       <td>
        <input type="text" name="backcolor" value="<%=Utilities.getValue(info.BackColor)%>" maxlength="7" size="7" style="color: <%=info.BackColor%>" onClick="javascript:loadSelectColor(this, 2);">
        <a href="javascript:loadSelectColor(document.form_sitesetting.backcolor, 2);"><%=mcBean.getLabel("ws-selectcolor")%></a>   
       </td>
      </tr>
      <tr>
       <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-backimage")%>:</td>
       <td>
         <input type="hidden" name="backimageid" value="<%=info.BackImageID%>">
         <input type="file" name="bkimage" size="50">
         <% if (info.BackImageID>0) { %>
         [<%=mcBean.getPreviewLink("LogoImage",  mcBean.getLabel("ws-logoimagefile"), info.BackImageID,  mcBean.getLabel("cm-preview"))%>, <a href='<%=bean.encodedUrl("index.jsp?action=Remove File_SiteSetting&filetype=BackImageID&fileid="+info.BackImageID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>.');"><%=mcBean.getLabel("cm-remove")%></a>]
           &nbsp;<!--%=bean.getFileInfo(info.BackImageID)%-->
        <% } %> 
       </td>
      </tr>
      <tr>
       <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-webtitle")%>:</td>
       <td><%=mcBean.getLabel("ws-webtitledesc")%>.<br>
        <input type="text" name="webtitle" value="<%=Utilities.getValue(info.WebTitle)%>" maxlength="255" size=92>
       </td>
      </tr>
      <tr>
        <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-medatag")%>:</td>
        <td><%=mcBean.getLabel("ws-medatagdesc")%>.<br>
           <textarea name="metadescription" rows="3" cols="70" wrap="virtual"><%=Utilities.getValue(info.MetaDescription)%></textarea>
        </td>
      </tr>
      <tr>
        <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-medatagkey")%>:</td>
        <td><%=mcBean.getLabel("ws-medatagkeydesc")%>.<br>
           <textarea name="metakeywords" rows="3" cols="70" wrap="virtual"><%=Utilities.getValue(info.MetaKeywords)%></textarea>
        </td>
       </tr>
     </table>
   </fieldset>      
    </td>
   </tr>
   <tr>
    <td colspan="1" height="5" align="center"></td>
   </tr>
   <tr>
    <td>
     <fieldset style="margin:0px"><legend><%=mcBean.getLabel("ws-topbar")%></legend>
     <table cellspacing=0 cellpadding=4 width="100%" align="center" border=0 style1="border: 1px dashed #DFDFDF">
      <tr>
       <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-showtopbar")%>:</td>
       <td>
        <select name="topbar" onChange="onSelectFlagChange(document.form_sitesetting, this, 'topbar0', 'topbar1', 'topbar2')">
          <option value=1 <%=bean.getSelected(1, info.TopBar)%>><%=mcBean.getLabel("ws-yes")%></option>
          <option value=2 <%=bean.getSelected(2, info.TopBar)%>><%=mcBean.getLabel("ws-htmlcode")%></option>
          <option value=0 <%=bean.getSelected(0, info.TopBar)%>><%=mcBean.getLabel("ws-no")%></option>
        </select> <%=mcBean.getLabel("ws-topbardesc")%>.
       </td>
      </tr>
      <tr>
       <td colspan="2">
       <span id="topbar0" style="DISPLAY: <%=info.TopBar==0?"inline":"none"%>">
       <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
         <td height="1" colspan="2"></td>
        </tr>
       </table>
       </span>
       <span id="topbar1" style="DISPLAY: <%=info.TopBar==1?"inline":"none"%>">
       <table cellspacing=0 cellpadding=0 width="100%">
        <tr>
         <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-logoimage")%>:&nbsp;</td>
         <td><input type="file" name="lgimage" size="47">
           <input type="hidden" name="logoimageid" value="<%=info.LogoImageID%>">
          <% if (info.LogoImageID>0) { %>
          [<%=mcBean.getPreviewLink("LogoImage", mcBean.getLabel("ws-logoimagefile"), info.LogoImageID, mcBean.getLabel("cm-preview"))%>, <a href='<%=bean.encodedUrl("index.jsp?action=Remove File_SiteSetting&filetype=LogoImageID&fileid="+info.LogoImageID)%>' onClick="return confirm('<%=mcBean.getLabel("cm-confirmremove")%>.');"><%=mcBean.getLabel("cm-remove")%></a>]
           <!--%=bean.getFileInfo(info.BackImageID)%-->
          <% } %> (<%=mcBean.getLabel("ws-bestsize")%>: <b>232 x 80</b>)
         </td>
        </tr>
        <tr>
          <td height="24" width="14%" align="right"><%=mcBean.getLabel("ws-slogan")%>:&nbsp;</td>
          <td><input type="text" name="slogan" value="<%=Utilities.getValue(info.Slogan)%>" size="92" maxlength="128">
          </td>
        </tr>
        <tr>
         <td height="24" width="14%" align="right">&nbsp;</td>
         <td><%=mcBean.getLabel("cm-font")%>:
          <select name="sloganfont">
           <%=bean.getFontMeun(info.SloganFont)%>
          </select>&nbsp;<%=mcBean.getLabel("cm-size")%>:
          <select name="slogansize">
           <%=bean.getSizeMenu(info.SloganSize)%>
          </select>&nbsp;<%=mcBean.getLabel("cm-forecolor")%>:
          <input type="text" name="slogancolor" value="<%=Utilities.getValue(info.SloganColor)%>" maxlength="7" size="7" style="color: <%=info.SloganColor%>" onClick="javascript:loadSelectColor(this, 2);">
          <a href="javascript:loadSelectColor(document.form_sitesetting.slogancolor, 2);"><%=mcBean.getLabel("ws-selectcolor")%></a>
         </td>
        </tr>
        <tr>
         <td height="26" width="14%" align="right" nowrap><%=mcBean.getLabel("cm-backcolor")%>:&nbsp;</td>
         <td><input type="text" name="domaincolor" value="<%=Utilities.getValue(info.DomainColor)%>" maxlength="7" size="7" style="color: <%=info.DomainColor%>" onClick="javascript:loadSelectColor(this, 2);">
        <a href="javascript:loadSelectColor(document.form_sitesetting.domaincolor, 2);"><%=mcBean.getLabel("ws-selectcolor")%></a> &nbsp;&nbsp;
        </td>
       </tr>
       </table>
       </span>
       <span id="topbar2" style="DISPLAY: <%=info.TopBar>1?"inline":"none"%>">
       <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
         <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-htmlcode")%>:&nbsp;</td>
         <td><textarea name="topbarcode" rows="4" cols="70" wrap="virtual"><%=Utilities.getValue(info.TopbarCode)%></textarea></td>
        </tr>
       </table>
       </span>
       </td>
      </tr>
     </table>
     </fieldset>
    </td>
   </tr>
   <tr>
     <td colspan="1" height="5" align="center"></td>
   </tr>
  <tr>
   <td>
    <fieldset style="margin:0px"><legend><%=mcBean.getLabel("ws-advertisebar")%></legend>
    <table cellspacing=0 cellpadding=4 width="100%" align="center" border=0 style1="border: 1px dashed #DFDFDF">
     <tr>
      <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-showads")%>:</td>
      <td>
       <input type="hidden" name="advertisebar" value="<%=info.AdvertiseBar%>">

       <select name="adsbarfly" onChange="onSelectFlagChange2(document.form_sitesetting,  this, 'adsbar0', 'adsbar1', 'adsbar2')" <%=bCanHaveSelfAds?"":"disabled"%>>
         <option value=63 <%=(info.AdvertiseBar>0 && info.AdvertiseBar<64)?"selected":""%>><%=mcBean.getLabel("ws-googleads")%></option>
         <option value=64 <%=bean.getSelected(64, info.AdvertiseBar)%>><%=mcBean.getLabel("ws-adshtmlcode")%></option>
         <option value=0 <%=bean.getSelected(0, info.AdvertiseBar)%>><%=mcBean.getLabel("ws-no")%></option>
       </select> <%=mcBean.getLabel("ws-adsdesc")%>.
      </td>
     </tr>
     <tr>
<% if (bCanHaveSelfAds) { %>
     <td colspan="2">
      <span id="adsbar0" style="DISPLAY: <%=info.AdvertiseBar==0?"inline":"none"%>">
      <table cellpadding="0" cellspacing="0" border="0" width="100%">
       <tr>
        <td height="1" colspan="2"></td>
       </tr>
      </table>
      </span>
      <span id="adsbar1" style="DISPLAY: <%=(info.AdvertiseBar>0 && info.AdvertiseBar<64)?"inline":"none"%>">
      <table cellspacing=0 cellpadding=0 width="100%">
       <tr>
        <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-adsenseid")%>:&nbsp;</td>
        <td><input type="text" size=30 name="googleadsenseid" value="<%=Utilities.getValue(info.GoogleAdSenseID)%>" maxlength="80">
         <%=mcBean.getLabel("ws-googleadsense")%>.
       </td>
       </tr>
       <tr>
        <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-whereshow")%>:&nbsp;</td>
        <td>
          <input type="checkbox" name="googleads_1" value="1" <%=bean.getChecked(info.AdvertiseBar&1, 1)%>><%=mcBean.getLabel("ws-ontop")%> &nbsp;&nbsp;&nbsp;&nbsp;
          <input type="checkbox" name="googleads_2" value="2" <%=bean.getChecked(info.AdvertiseBar&2, 2)%>><%=mcBean.getLabel("ws-onpanel")%> &nbsp;&nbsp;&nbsp;&nbsp;
          <input type="checkbox" name="googleads_3" value="4" <%=bean.getChecked(info.AdvertiseBar&4, 4)%>><%=mcBean.getLabel("ws-onbottom")%> &nbsp;&nbsp;&nbsp;&nbsp;
        </td>
       </tr>
      </table>
      </span>
      <span id="adsbar2" style="DISPLAY: <%=(info.AdvertiseBar>=64)?"inline":"none"%>">
      <table cellpadding="0" cellspacing="0" border="0" width="100%">
       <tr>
        <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-adshtmlcode")%>:&nbsp;</td>
        <td><textarea name="advertisecode" rows="4" cols="70" wrap="virtual"><%=Utilities.getValue(info.AdvertiseCode)%></textarea></td>
       </tr>
      </table>
      </span>
      <!--table cellspacing=0 cellpadding=0 width="100%">
        <tr>
         <td height="22" width="14%" align="right">How Long:&nbsp;</td>
         <td> The terms of <b>Free Ads</b> will be expired in <b> </b>. You can <a href="<%=mcBean.encodedUrl("index.jsp?action=Load_FreeAds&rl=1&pt=Buy Free Ads Feature")%>">purchase</a> more terms of the service.
        </td>
        </tr>
      </table-->
     </td>
<% } else { %>
     <td height="22" width="14%" align="right" nowrap></td>
     <td><%=mcBean.getLabel("ws-haveto")%> <a href="<%=mcBean.encodedUrl("index.jsp?action=Load_PaidService&rl=1&pt=My Advanced Services")%>"><%=mcBean.getLabel("ws-purchase")%></a> <%=mcBean.getLabel("ws-hideads")%>.</td>
<% } %>
     </tr>
    </table>
   </fieldset>
   </td>
  </tr>
  <tr>
    <td height="5" align="center"></td>
  </tr>
  <tr>
   <td colspan="1" width="100%">
    <fieldset style="margin:0px"><legend><%=mcBean.getLabel("ws-sepbarhome")%></legend>
    <table cellspacing=0 cellpadding=2 width="100%" align="center" border=0 style1="border: 1px dashed #DFDFDF">
    <tr>
     <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-separatebar")%>:</td>
     <td><%=mcBean.getLabel("ws-height")%>:&nbsp;
     <select name="domainsize">
     <option value="0" <%=info.DomainSize==0?"selected":""%>><%=mcBean.getLabel("ws-notshow")%></option>
     <option value="1" <%=info.DomainSize==1?"selected":""%>>1</option>
     <option value="2" <%=info.DomainSize==2?"selected":""%>>2</option>
     <option value="3" <%=info.DomainSize==3?"selected":""%>>3</option>
     <option value="4" <%=info.DomainSize==4?"selected":""%>>4</option>
     <option value="5" <%=info.DomainSize==5?"selected":""%>>5</option>
     <option value="6" <%=info.DomainSize==6?"selected":""%>>6</option>
     <option value="7" <%=info.DomainSize==7?"selected":""%>>7</option>
     <option value="8" <%=info.DomainSize==8?"selected":""%>>8</option>
     <option value="9" <%=info.DomainSize==9?"selected":""%>>9</option>
     <option value="10" <%=info.DomainSize==10?"selected":""%>>10</option>
     <option value="11" <%=info.DomainSize==11?"selected":""%>>11</option>
     <option value="12" <%=info.DomainSize==12?"selected":""%>>12</option>
     <option value="13" <%=info.DomainSize==13?"selected":""%>>13</option>
     <option value="14" <%=info.DomainSize==14?"selected":""%>>14</option>
     <option value="15" <%=info.DomainSize==15?"selected":""%>>15</option>
     <option value="16" <%=info.DomainSize==16?"selected":""%>>16</option>
     <option value="17" <%=info.DomainSize==17?"selected":""%>>17</option>
     <option value="18" <%=info.DomainSize==18?"selected":""%>>18</option>
     <option value="19" <%=info.DomainSize==19?"selected":""%>>19</option>
     <option value="20" <%=info.DomainSize==20?"selected":""%>>20</option>
     </select> &nbsp;<%=mcBean.getLabel("cm-forecolor")%>:
      <input type="text" name="domainfont" value="<%=Utilities.getValue(info.DomainFont)%>" maxlength="7" size="7" style="color: <%=info.DomainFont%>" onClick="javascript:loadSelectColor(this, 2);">
     </td>
    </tr>
    <!--tr>
     <td height="22" width="14%" align="right">Title:</td>
     <td><input maxlength=255 size=60 value="<%=Utilities.getValue(info.Title)%>" name="title"> It will display on title bar in the home page.</td>
    </tr-->
    <tr>
      <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-titlefont")%>:&nbsp;</td>
      <td>
        <select name="titlefont">
         <%=bean.getFontMeun(info.TitleFont)%>
        </select> &nbsp;<%=mcBean.getLabel("ws-size")%>:
        <select name="titlesize">
         <%=bean.getSizeMenu(info.TitleSize)%>
        </select> &nbsp;<%=mcBean.getLabel("ws-forecolor")%>:
        <input type="text" name="titlecolor" value="<%=Utilities.getValue(info.TitleColor)%>" maxlength="7" size="7" style="color: <%=info.TitleColor%>" onClick="javascript:loadSelectColor(this, 2);">
        &nbsp;<%=mcBean.getLabel("cm-backcolor")%>:
        <input type="text" name="title" value="<%=Utilities.getValue(info.Title)%>" maxlength="7" size="7" style="color: <%=info.Title%>" onClick="javascript:loadSelectColor(this, 2);">
      </td>
     </tr>
     <tr>
      <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-homepage")%>:</td>
      <td><!--a href='<%=mcBean.encodedUrl("index.jsp?action=Load_HtmlEditor&pt=Edit Home Page Content&contentid="+info.HomePageID+"&name=HomePageID&title1=Home Page Content")%>'>Edit</a-->
       <select name="homepageid">
        <%=mcBean.getHomePageSelections(info.MemberID, info.HomePageID)%>
       </select> <%=mcBean.getLabel("ws-homepagedesc")%>. 
      </td>
     </tr>
    </table>
    </fieldset>
    </td>
    </tr>
    <tr>
      <td colspan="1" height="5" align="center"></td>
    </tr>
    <tr>
     <td colspan="1">
     <fieldset style="margin:0px"><legend><%=mcBean.getLabel("ws-vertpanel")%></legend>
     <table cellspacing=0 cellpadding=2 width="100%" align="center" border=0 style1="border: 1px dashed #DFDFDF">
      <tr>
       <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-vertpanel")%>:</td>
       <td>
        <select name="verticalbarside" onChange1="onSelectFlagChange(this, 'vericalbar')">
         <option value=1 <%=bean.getSelected(1, info.VerticalBarSide)%>><%=mcBean.getLabel("ws-leftside")%></option>
         <option value=2 <%=bean.getSelected(2, info.VerticalBarSide)%>><%=mcBean.getLabel("ws-rightside")%></option>
         <option value=0 <%=bean.getSelected(0, info.VerticalBarSide)%>><%=mcBean.getLabel("ws-novertpanel")%></option>
        </select> <%=mcBean.getLabel("ws-vertpaneldesc")%>.
       </td>
      </tr>
      <tr>
       <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-showlogin")%>:</td>
       <td>
         <select name="membership">
           <option value=0 <%=bean.getSelected(0, info.Membership)%>><%=mcBean.getLabel("cm-no")%></option>
           <option value=1 <%=bean.getSelected(1, info.Membership)%>><%=mcBean.getLabel("ws-vertpanel")%></option>
           <!--option value=2 <%=bean.getSelected(2, info.Membership)%>><%=mcBean.getLabel("ws-ontopbar")%></option-->
         </select> <%=mcBean.getLabel("ws-showlogindesc")%>.<!--input type="text" name="memberareaname" value="<%=Utilities.getValue(info.MemberAreaName)%>" maxlength="20"-->
       </td>
     </tr>
     <!--tr>
       <td height="22" width="14%" align="right" nowrap>Show Categories:</td>
       <td>
         <select name="categoryshow">
          <option value=0 <%=bean.getSelected(0, info.CategoryShow)%>>No</option>
          <option value=1 <%=bean.getSelected(1, info.CategoryShow)%>>Yes</option>
         </select> If yes, you can choose one of the layouts:
         <select name="categorymenuid">
           <%=bean.getLayoutList(info.CategoryMenuID, "CategoryMenu")%>
         </select> <a href="javascript:viewSampleImage('CategoryMenu', document.form_sitesetting.categorymenuid.value)">View</a> sample layout.
       </td>
      </tr-->
      <tr>
        <td height="22" width="14%" align="right" nowrap><%=mcBean.getLabel("ws-sitenews")%>:<br></td>
        <td>
         <select name="newsarea">
          <option value=0 <%=bean.getSelected(0, info.NewsArea)%>><%=mcBean.getLabel("cm-no")%></option>
          <option value=1 <%=bean.getSelected(1, info.NewsArea)%>><%=mcBean.getLabel("ws-vertpanel")%></option>
          <option value=2 <%=bean.getSelected(2, info.NewsArea)%>><%=mcBean.getLabel("ws-floatwin")%></option>
         </select>&nbsp;&nbsp;<%=mcBean.getLabel("ws-newspage")%>:
         <select name="newsareaid">
            <%=mcBean.getHomePageSelections(info.MemberID, info.NewsAreaID)%>
         </select>&nbsp;&nbsp;<%=mcBean.getLabel("ws-autoscroll")%>:
         <select name="newsareascroll">
          <option value=1 <%=bean.getSelected(1, info.NewsAreaScroll)%>><%=mcBean.getLabel("cm-yes")%></option>
          <option value=0 <%=bean.getSelected(0, info.NewsAreaScroll)%>><%=mcBean.getLabel("cm-no")%></option>
         </select>
<!--
          &nbsp;&nbsp;The news title:
          <input type="text" name="newstitle" value="<%=Utilities.getValue(info.NewsTitle)%>" maxlength="80">
          &nbsp;&nbsp;<a href='<%=mcBean.encodedUrl("index.jsp?action=Load_WebPage&pt=Edit Site News&pid="+info.NewsAreaID+"&return=Edit_SiteSetting&fieldname=NewAreaID")%>'>Edit</a> ]
 -->

        </td>
      </tr>
     <tr>
     <td height="22" width="14%" align="right" nowrap1><%=mcBean.getLabel("ws-showmenulink")%>:</td>
     <td>
       <select name="linkpage">
        <option value=1 <%=bean.getSelected(1, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 1</option>
        <option value=2 <%=bean.getSelected(2, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 2</option>
        <option value=3 <%=bean.getSelected(3, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 3</option>
        <option value=4 <%=bean.getSelected(4, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 4</option>
        <option value=5 <%=bean.getSelected(5, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 5</option>
        <option value=6 <%=bean.getSelected(6, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 6</option>
        <option value=7 <%=bean.getSelected(7, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 7</option>
        <option value=8 <%=bean.getSelected(8, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 8</option>
        <option value=9 <%=bean.getSelected(9, info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 9</option>
        <option value=10 <%=bean.getSelected(10,info.LinkPage)%>><%=mcBean.getLabel("ws-menulayout")%> 10</option>
        <!--option value=11 <%=bean.getSelected(11,info.LinkPage)%>>Yes, by Menu Layout 11</option-->
        <option value=0 <%=bean.getSelected(0, info.LinkPage)%>><%=mcBean.getLabel("ws-nomenu")%></option>
       </select> [ <a href="javascript:viewMenuLayout(document.form_sitesetting.linkpage.value)"><%=mcBean.getLabel("ws-samplelayout")%></a> ]. <%=mcBean.getLabel("ws-entername")%>: <input type="text" name="linkpagetitle" value="<%=Utilities.getValue(info.LinkPageTitle)%>" maxlength="20">
       <br>
     </td>
     </tr>                     
     <tr>
       <td height="22" width="14%" align="right"><%=mcBean.getLabel("ws-showcal")%>:</td>
       <td>
         <select name="security">
           <option value=1 <%=bean.getSelected(1, info.Security)%>><%=mcBean.getLabel("cm-yes")%></option>
           <option value=0 <%=bean.getSelected(0, info.Security)%>><%=mcBean.getLabel("cm-no")%></option>
         </select> <%=mcBean.getLabel("ws-showcaldesc")%>.</td>
     </tr>
     </table>
     </fieldset>
     </td>
     </tr>
     <tr>
       <td height="5" align="center"></td>
     </tr>
     <!--tr>
       <td >
        <table cellspacing=0 cellpadding=2 width="100%" align="center" border=0 style="border: 1px dashed #DFDFDF">
        <tr>
          <td height="22" width="14%" align="right">Counter Display:</td>
          <td>
            <select name="showcounter">
              <option value=1 <%=bean.getSelected(1, info.ShowCounter)%>>Yes</option>
              <option value=0 <%=bean.getSelected(0, info.ShowCounter)%>>No</option>
            </select> Show a visiting counter to your website at left-bottom of each page.
          </td>
        </tr>
      </table>
     </td>
    </tr-->
    <tr>
      <td height=5></td>
    </tr>
    <!--tr>
    <td >
     <table cellspacing=0 cellpadding=2 width="100%" align="center" border=0>
      <tr>
       <td height="22" width="14%" align="right">Publish:</td>
       <td>
       <select name="autopublish">
         <option value=1 <%=info.AutoPublish==1?"SELECTED":""%>>Yes</option>
         <option value=2 <%=info.AutoPublish!=1?"SELECTED":""%>>No</option>
       </select> If you select 'Yes', your website will be changed when you update. Or your changes are not published in this time. You can publish them later.
       </td>
      </tr>
     </table>
    </td>
    </tr-->
    <tr>
     <td><HR align="center" width="100%" color="#D6D6D6" noShade SIZE=1></td>
    </tr>
    <tr>
     <td>
      <table cellspacing=2 cellpadding=2 width="100%" align="center" border=0 style1="border-top: 1px solid #DFDFDF">
       <tr>
        <td align="center" valign="bottom">
        <input type="submit" name="submit" style='width:120px' value="<%=mcBean.getLabel("cm-update")%>" onClick="setAction(document.form_sitesetting, 'Update_SiteSetting');">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <!--input type="submit" name="submit" style='width:120px' value="Default Setting" onClick="setAction(document.form_sitesetting, 'Default_SiteSetting');"-->
        </td>
       </tr>
      </table>
     </td>
    </tr>
   </table>
  </FORM>
  <SCRIPT>onSiteSettingFormLoad(document.form_sitesetting);</SCRIPT>
<% } %>