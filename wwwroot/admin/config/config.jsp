<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/config.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ConfigBean"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<!--%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=iso-8859-1" %-->
<!--%@ page language="java" pageEncoding="utf-8" contentType="text/html;charset=utf-8" %-->
<%
//    AdSense for Content: ca-pub-5861999013505756 
//    AdSense for Search: partner-pub-5861999013505756
  ConfigBean bean = new ConfigBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CONFIG))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  ConfigInfo info = null;
  String sClass = "successful";
  if ("Update Settings".equalsIgnoreCase(sAction))
  {
    ConfigBean.Result ret = (ConfigBean.Result)session.getAttribute(ConfigBean.KEY_UPLOADRESULT);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
      info = (ConfigInfo)ret.getUpdateInfo();
    }
    else
    {
      Map hmParameter = (Map)ret.m_InfoObject;
      info = (ConfigInfo)ret.getUpdateInfo();
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "configuration");
    }
  }
  else if ("removeimage".equalsIgnoreCase(sAction))
  {
    info = (ConfigInfo)bean.getCacheMap().get(bean.KEY_TEMPINFO);
    String sImageName = request.getParameter("name");
    if ("backtile".equalsIgnoreCase(sImageName))
       info.BackImage = "";
    else if ("title".equalsIgnoreCase(sImageName))
       info.TitleImage = "";
    else if ("advertise".equalsIgnoreCase(sImageName))
       info.AdvertiseImage = "";
    else if ("bottom".equalsIgnoreCase(sImageName))
       info.BottomImage = "";

    sDisplayMessage = "You have to click <b>Update Configuration</b> button to remove it permanently.";
//System.out.println("after=" + info.TitleImage + ";" + info.AdvertiseImage);
  }
  else if ("finisheditcontent".equalsIgnoreCase(sAction))
  {
    String sSet = request.getParameter("name")+"="+request.getParameter("contentid");
    info = bean.updateContentID(request, sSet);
  }
  else
  {
    info =  bean.get(request);
  }
  sAction = "Update Configuration";

  String sHelpTag = "config";
//  String sTitleLinks = "<b>Web Site Settings</b>";
  String sTitleLinks = bean.getNavigation(request, "Web Site Settings");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this form, you can change and update any of settings of your website. After you press '<b>Update Configuration</b>' button,
the modifications will immediately reflect the front of your website. If You want to setup <b>ContactUs page</b>, click <a href="contactus.jsp">here</a>.
<form name="config" action="multipartform.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateConfig(this);">
<table width="100%" cellpadding="2" cellspacing="0" border="0" class="forumline" align="center">
  <tr>
    <th class="thHead">Configuration Settings</th>
    <th class="thHead" width="28%" align="center"><input type="submit" name="action" value="<%=sAction%>" style="HEIGHT:24px"></th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan=2 height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
 <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Language:</td>
      <td class="row1" colspan="2">
        <select name="language">
          <%=bean.getLanguageList(info.Language)%>
        </select> The Language of the website.&nbsp; &nbsp; &nbsp; &nbsp;
        Width:
        <select name="width">
         <option value="800" <%=info.Width==800?"selected":""%>>800</option>
         <option value="1280" <%=info.Width==1280?"selected":""%>>1280</option>
         <option value="1480" <%=info.Width==1480?"selected":""%>>1480</option>
         <option value="1680" <%=info.Width==1680?"selected":""%>>1680</option>
         <option value="0" <%=info.Width<=0?"selected":""%>>100%</option>
       </select> The Website Width.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Background Color:</td>
      <td class="row1" colspan="2"><input type="text" name="backcolor" value="<%=Utilities.getValue(info.BackColor)%>" maxlength="7" size="7" style="color: <%=info.BackColor%>" onClick="javascript:loadSelectColor(this, 2);">
        <a href="javascript:loadSelectColor(document.config.backcolor, 2);">Select Color</a> The background color of the website.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Background Image:</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="backimage" value="<%=Utilities.getValue(info.BackImage)%>">
        <input type="file" name="backtile" size="40">
        <% if (info.BackImage!=null&&info.BackImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.BackImage%>" target="imageview">Preview
        Image</a>&nbsp;&nbsp;<a href="config.jsp?action=removeimage&name=backtile">Remove</a>
        <% } %>
        The backgroud image of the website.
      </td>
    </tr>
  </table>
  </td>
 </tr>

 <tr>
  <td colspan=2 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
   <tr>
    <td class="row1" width="20%" align="right">Titlebar Display:</td>
    <td class="row1" colspan="2">
      <select name="topbar" onChange="onSelectFlagChange(this, 'titlebar')">
        <option value=1 <%=bean.getSelected(1, info.TopBar)%>>Yes</option>
        <option value=0 <%=bean.getSelected(0, info.TopBar)%>>No</option>
      </select>Show the titlebar or not show it.
     </td>
   </tr>
<tr id="titlebar" style="DISPLAY: <%=info.TopBar==1?"show":"none"%>">
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
   <tr>
      <td class="row1" width="20%" align="right">Titlebar Layout:</td>
      <td class="row1" colspan="2">
        <select name="layoutid">
          <%=bean.getLayoutList(info.LayoutID, "Titlebar")%>
        </select> The layout of title bar. You can <a href="javascript:viewSampleTitle(document.config, 'Titlebar')">view</a> sample layout.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Title Name:</td>
      <td class="row1" colspan="2">
        <input type="text" name="title" value="<%=info.Title%>" maxlength="30" <%=bean.getDisableFlag(info.TitleImage)%>> Font:
        <select name="titlefont" <%=bean.getDisableFlag(info.TitleImage)%>>
          <%=bean.getFontMeun(info.TitleFont)%>
        </select> Size:
        <select name="titlesize" <%=bean.getDisableFlag(info.TitleImage)%>>
          <%=bean.getSizeMenu(info.TitleSize)%>
        </select> Color:
        <input type="text" name="titlecolor" value="<%=Utilities.getValue(info.TitleColor)%>" maxlength="7" size="7" style="color: <%=info.TitleColor%>" onClick="javascript:loadSelectColor(this, 2);">
        <a href="javascript:loadSelectColor(document.config.titlecolor, 2);">Select Color</a>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Slogan:</td>
      <td class="row1" colspan="2">
        <input type="text" name="slogan" value="<%=info.Slogan%>" maxlength="128"<%=bean.getDisableFlag(info.TitleImage)%>> Font:
        <select name="sloganfont" <%=bean.getDisableFlag(info.TitleImage)%>>
          <%=bean.getFontMeun(info.SloganFont)%>
        </select> Size:
        <select name="slogansize" <%=bean.getDisableFlag(info.TitleImage)%>>
          <%=bean.getSizeMenu(info.SloganSize)%>
        </select> Color:
       <input type="text" name="slogancolor" value="<%=Utilities.getValue(info.SloganColor)%>" maxlength="7" size="7" style="color: <%=info.SloganColor%>" onClick="javascript:loadSelectColor(this, 2);">
        <a href="javascript:loadSelectColor(document.config.slogancolor, 2);">Select Color</a>
     </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Or Logo Image:<br>&nbsp;</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="titleimage" value="<%=Utilities.getValue(info.TitleImage)%>">
        <input type="file" name="title" size="40">
        <% if (info.TitleImage!=null&&info.TitleImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=bean.getImageFileName(info.TitleImage)%>" target="imageview">Preview
        Image</a>&nbsp;&nbsp;<a href="config.jsp?action=removeimage&name=title">Remove</a>
        <% } %><br>Your own logo image to replace both of title name and slogan.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Welcome Content:</td>
      <td class="row1" colspan="2"><input type="text" name="domaincontent" value="<%=Utilities.getValue(info.DomainContent)%>" maxlength="128"> Font:
        <select name="domainfont">
          <%=bean.getFontMeun(info.DomainFont)%>
        </select> Size:
        <select name="domainsize">
          <%=bean.getSizeMenu(info.DomainSize)%>
        </select> Color:
        <input type="text" name="domaincolor" value="<%=Utilities.getValue(info.DomainColor)%>" maxlength="7" size="7" style="color: <%=info.DomainColor%>" onClick="javascript:loadSelectColor(this, 2);">
        <a href="javascript:loadSelectColor(document.config.domaincolor, 2);">Select Color</a>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right"><br>Product Search Display:</td>
      <td class="row1" colspan="2">Show Advanced and General Product Search on top titlebar area.<br>
        <select name="productsearch">
          <option value=1 <%=bean.getSelected(1, info.ProductSearch)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.ProductSearch)%>>No</option>
        </select> <a href="../product/category.jsp?action=editspecialcategory&reference=-13&return=../config/config.jsp&display=Go back to Site Settings">Edit</a> the attribute of this category.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right"><br>New Products Display:</td>
      <td class="row1" colspan="2">Show new arrival products link on the navigation area of the titlebar<br>
        <select name="newarrivals" onChange="OnSelectNewProducts(document.config)">
          <option value=1 <%=bean.getSelected(1, info.NewArrivals)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.NewArrivals)%>>No</option>
        </select> If yes, enter display name: <input type="text" name="newname" value="<%=Utilities.getValue(info.NewName)%>" maxlength="20">
        <a href="../product/category.jsp?action=editspecialcategory&reference=-10&return=../config/config.jsp&display=Go back to Site Settings">Edit</a> the attribute of this category.
     </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right"><br>Hot Products Display:</td>
      <td class="row1" colspan="2">Show the most visited Products on the navigation area of the titlbar, next to 'New Product'<br>
        <select name="hotproducts" onChange="OnSelectHotProducts(document.config)">
          <option value=1 <%=bean.getSelected(1, info.HotProducts)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.HotProducts)%>>No</option>
        </select> If yes, enter display name: <input type="text" name="hotname" value="<%=Utilities.getValue(info.HotName)%>" maxlength="20">
          <a href="../product/category.jsp?action=editspecialcategory&reference=-11&return=../config/config.jsp&display=Go back to Site Settings">Edit</a> the attribute of this category.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right"><br>Best Sale Products Display:</td>
      <td class="row1" colspan="2" height="2">Show the best sold products on the navigation area of the titlebar, next to 'Hot Product'<br>
        <select name="bestsellers" onChange="OnSelectBestProducts(document.config)">
          <option value=1 <%=bean.getSelected(1, info.BestSellers)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.BestSellers)%>>No</option>
        </select> If yes, enter display name: <input type="text" name="bestname" value="<%=Utilities.getValue(info.BestName)%>" maxlength="20">
        <a href="../product/category.jsp?action=editspecialcategory&reference=-12&return=../config/config.jsp&display=Go back to Site Settings">Edit</a> the attribute of this category.
     </td>
    </tr>
  </table>
 </td>
 </tr>
</table>
  </td>
 </tr>

  <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Advertisement Display:</td>
      <td class="row1" colspan="2">
        <select name="advertisebar" onChange="onSelectFlagChange(this, 'advertise')">
          <option value=1 <%=bean.getSelected(1, info.AdvertiseBar)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.AdvertiseBar)%>>No</option>
        </select>Show Advertisement Bar below the titlebar (Width should be 778 pixel or less.)
      </td>
    </tr>
<tr  id="advertise" style="DISPLAY: <%=info.AdvertiseBar==1?"show":"none"%>">
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Advertise Image:</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="advertiseimage" value="<%=Utilities.getValue(info.AdvertiseImage)%>">
        <input type="file" name="advertise" size="40">
        <% if (info.AdvertiseImage!=null&&info.AdvertiseImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.AdvertiseImage%>" target="imageview">Preview
        Image</a>&nbsp;&nbsp;<a href="config.jsp?action=removeimage&name=advertise">Remove</a>
        <% } %>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Or Html Code:</td>
      <td class="row1" colspan="2">The html code allows to display more complex advertisement.<br>
        <textarea name="advertisecode" rows="4" cols="70" wrap="virtual" <%=bean.getDisableFlag(info.AdvertiseImage)%>><%=Utilities.getValue(info.AdvertiseCode)%></textarea>
      </td>
    </tr>
  </table>
 </td>
 </tr>
  </table>
  </td>
 </tr>
 <tr>
  <td colspan=2 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right" valign="top">Home Page Gategory:</td>
      <td class="row1" colspan="2">
        <select name="homecategoryid">
        <%=bean.getAllCategoryList(info.HomeCategoryID)%>
        </select> Select 'My Content', or one of categories. If select the category, its products will show on your home page.
         If select 'My Content', the home page will show your own content and you can <a href="../util/content.jsp?contentid=<%=info.HomePageID%>&name=HomePageID&title=Home Page Content&return=../config/config.jsp">Edit</a> it.
        </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right" valign="middle"><br>Home Link:</td>
      <td class="row1" colspan="2" height="2">If you want the Home button of online store to link to your main website, please enter the URL:<br>
        <input type="text" name="homeurl" value="<%=Utilities.getValue(info.HomeURL)%>" maxlength="255" size="80"> (for example, http://www.yourdomainame.com)
     </td>
    </tr>
   </table>
  </td>
 </tr>

<tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right" valign="top">Vertical Panel:</td>
      <td class="row1" width="80%">
        <select name="verticalbarside" onChange="onSelectFlagChange(this, 'vericalbar', config.vertbarwidth)">
          <option value=0 <%=bean.getSelected(0, info.VerticalBarSide)%>>On Left Side</option>
          <option value=1 <%=bean.getSelected(1, info.VerticalBarSide)%>>On Right Side</option>
          <option value=2 <%=bean.getSelected(2, info.VerticalBarSide)%>>No Vertical Panel</option>
        </select> The vertical panel can either be on the left or right side or hide.&nbsp; &nbsp;
        Width:
         <select name="vertbarwidth">
          <option value="150" <%=info.VertBarWidth==150?"selected":""%>>150</option>
          <option value="180" <%=info.VertBarWidth==180?"selected":""%>>180</option>
          <option value="220" <%=info.VertBarWidth==220?"selected":""%>>220</option>
          <option value="260" <%=info.VertBarWidth==260?"selected":""%>>260</option>
          <option value="300" <%=info.VertBarWidth==300?"selected":""%>>300</option>
          <option value="360" <%=info.VertBarWidth==360?"selected":""%>>360</option>
          <option value="400" <%=info.VertBarWidth==400?"selected":""%>>400</option>
          <option value="450" <%=info.VertBarWidth==450?"selected":""%>>450</option>
          <option value="500" <%=info.VertBarWidth==500?"selected":""%>>500</option>   
         </select>
     </td>
    </tr>
<tr>
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2" id="vericalbar" style="DISPLAY: <%=info.VerticalBarSide<2?"show":"none"%>">
    <tr>
      <td class="row1" width="20%" align="right">Product Category Display:</td>
      <td class="row1" colspan="2">
        <select name="categoryshow">
          <option value=1 <%=bean.getSelected(1, info.CategoryShow)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.CategoryShow)%>>No</option>
        </select> If yes, you can choose one of the layouts:
        <select name="categorymenuid">
          <%=bean.getLayoutList(info.CategoryMenuID, "CategoryMenu")%>
        </select> <a href="javascript:viewSampleMenu(document.config, 'CategoryMenu')">View</a> sample layout.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Support Membership:</td>
      <td class="row1" width="80%">
        <select name="membership">
          <option value=1 <%=bean.getSelected(1, info.Membership)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Membership)%>>No</option>
        </select>If yes, enter display name of title: <input type="text" name="memberareaname" value="<%=Utilities.getValue(info.MemberAreaName)%>" maxlength="20">
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Site News Display:<br><br>The content auto scrolling:</td>
      <td class="row1" width="80%">
        <select name="newsarea">
          <option value=0 <%=bean.getSelected(0, info.NewsArea)%>>No</option>
          <option value=1 <%=bean.getSelected(1, info.NewsArea)%>>On Vertical Panel</option>
          <option value=2 <%=bean.getSelected(2, info.NewsArea)%>>Floating in Center</option>
        </select>If not No, enter name of news title: <input type="text" name="newstitle" value="<%=Utilities.getValue(info.NewsTitle)%>" maxlength="80">
You can <a href="../util/content.jsp?contentid=<%=info.NewsAreaID%>&name=NewsAreaID&title=Site News&return=../config/config.jsp">Edit</a> the content.
        <br><select name="newsareascroll">
          <option value=1 <%=bean.getSelected(1, info.NewsAreaScroll)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.NewsAreaScroll)%>>No</option>
        </select> The new content can automatically move up or not move.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Newsletter Display:</td>
      <td class="row1" width="80%">
        <select name="newsletter">
          <option value=1 <%=bean.getSelected(1, info.NewsLetter)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.NewsLetter)%>>No</option>
        </select> Show newsletter function on vertical panel.</td>
    </tr>
    <tr>
    <td class="row1" width="20%" align="right" valign="top">Link Page Display:</td>
    <td class="row1" width="80%">
      <select name="linkpage">
        <option value=1 <%=bean.getSelected(1, info.LinkPage)%>>Yes</option>
        <option value=0 <%=bean.getSelected(0, info.LinkPage)%>>No</option>
      </select> If yes, enter display name of title: <input type="text" name="linkpagetitle" value="<%=Utilities.getValue(info.LinkPageTitle)%>" maxlength="20">
      <br> <a href='../config/linkpagelist.jsp?action=Get List&returnflag=2' target='main'>Enter Link Page List</a> to edit its items or make either one to be active or not active.
    </td>
    </tr>            
    <tr>
     <td class="row1" width="20%" align="right" valign="top">Google AdSense ID:</td>
     <td class="row1" width="80%">
     <input type="text" name="googleadsenseid" value="<%=Utilities.getValue(info.GoogleAdSenseID)%>" maxlength="80">
     If you enter it, the content of Ads will show on the bottom of vertical Panel.
     </td>
    </tr>
<% if (bean.hasAccessRole(AccessRole.ROLE_LIVECHAT_SETTING)) {%>
    <!--tr>
      <td class="row1" width="20%" align="right">Live Chat Display:</td>
      <td class="row1" width="78%">
        <select name="livechat">
          <option value=1 <%=bean.getSelected(1, info.LiveChat)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.LiveChat)%>>No</option>
        </select> Show Live Chat Link to allow the customers to launch live chat session.
      </td>
    </tr-->
<% } %>
  </table>
</td>
 </tr>
 </table>
  </td>
 </tr>
  <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Counter Display:</td>
      <td class="row1" colspan="2">
        <select name="showcounter">
          <option value=1 <%=bean.getSelected(1, info.ShowCounter)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.ShowCounter)%>>No</option>
        </select> Show a visiting counter to your website at left-bottom of each page.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Bottom Bar Display:</td>
      <td class="row1" colspan="2">
        <select name="bottombar" onChange="onSelectFlagChange2(this, 'bottomimage', 'bottombar')">
          <option value=1 <%=bean.getSelected(1, info.BottomBar)%>>Use default</option>
          <option value=2 <%=bean.getSelected(2, info.BottomBar)%>>Use your own</option>
          <option value=0 <%=bean.getSelected(0, info.BottomBar)%>>No bar</option>
        </select> Show the default bottom bar, display your own or not display it at all.
      </td>
    </tr>
<tr id="bottomimage" style="DISPLAY: <%=info.BottomBar==2?"show":"none"%>">
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Bottom Bar Image:</td>
      <td class="row1" colspan="2">
        <input type="hidden" name="bottombarimage" value="<%=Utilities.getValue(info.BottomImage)%>">
        <input type="file" name="bottom" size="40">
        <% if (info.BottomImage!=null&&info.BottomImage.length()>0) { %>
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=info.BottomImage%>" target="imageview">Preview
        Image</a>&nbsp;&nbsp;<a href="config.jsp?action=removeimage&name=bottom">Remove</a>
        <% } %>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Or Html Code:</td>
      <td class="row1" colspan="2">The html code allows to display more complex bottom bar.<br>
        <textarea name="bottomcode" rows="4" cols="70" wrap="virtual" <%=bean.getDisableFlag(info.BottomImage)%>><%=Utilities.getValue(info.BottomCode)%></textarea>
      </td>
    </tr>
  </table>
 </td>
</tr>
<tr id="bottombar" style="DISPLAY: <%=info.BottomBar==1?"show":"none"%>">
 <td colspan=3 class="row1">
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2" >
    <tr>
      <td class="row1" width="20%" align="right">Security Policy Display:</td>
      <td class="row1" width="80%">
        <select name="security">
          <option value=1 <%=bean.getSelected(1, info.Security)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Security)%>>No</option>
        </select> Show Security Policy Link on the bottom. You can <a href="../util/content.jsp?contentid=<%=info.SecurityID%>&name=SecurityID&title=Security Policy&return=../config/config.jsp">Edit</a> the content.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Privacy Note Display:</td>
      <td class="row1" width="80%">
        <select name="privacy">
          <option value=1 <%=bean.getSelected(1, info.Privacy)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Privacy)%>>No</option>
        </select> Show Privacy Note Link on the bottom. You can <a href="../util/content.jsp?contentid=<%=info.PrivacyID%>&name=PrivacyID&title=Privacy Note&return=../config/config.jsp">Edit</a> the content.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Legal Statement Display:</td>
      <td class="row1" width="80%">
        <select name="return">
          <option value=1 <%=bean.getSelected(1, info.Legal)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Legal)%>>No</option>
        </select> Show Legal Statement Link on the bottom. You can <a href="../util/content.jsp?contentid=<%=info.LegalID%>&name=LegalID&title=Legal Statement&return=../config/config.jsp">Edit</a> the content.
      </td>
    </tr>
  </table>
</td>
</tr>
  </table>
  </td>
 </tr>

 <tr>
  <td class="row1" colspan=2>
  <table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline2">
    <tr>
      <td class="row1" width="20%" align="right">Web Title:</td>
      <td class="row1" colspan="2">Web title is display at the top of a browser.<br>
      <input type="text" name="webtitle" value="<%=Utilities.getValue(info.WebTitle)%>" maxlength="255" size=92>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Meda Tag Description:</td>
      <td class="row1" colspan="2">The tag would allow search engines to better index your site.<br>
        <textarea name="metadescription" rows="3" cols="70" wrap="virtual"><%=Utilities.getValue(info.MetaDescription)%></textarea>
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right">Meda Tag Keywords:</td>
      <td class="row1" colspan="2">The tag would allow search engines to easily find your site.<br>
        <textarea name="metakeywords" rows="3" cols="70" wrap="virtual"><%=Utilities.getValue(info.MetaKeywords)%></textarea>
      </td>
    </tr>
  </table>
  </td>
 </tr>
  <tr>
    <td class="catBottom" colspan=2 align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
</table>
</form>
<!--SCRIPT>onConfigLoad(document.config);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>