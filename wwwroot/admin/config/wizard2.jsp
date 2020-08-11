<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/config.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ConfigBean"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
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
    int nError = 0;
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      nError = errObj.getErrorNo();
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

    if (nError==0 || nError==DisplayMessage.DM_NOANYCHANGE_ERROR)
    {
      if (ret.m_sAction.indexOf("Back")!=-1)
        response.sendRedirect("wizard1.jsp?action=Step 1");
      else
        response.sendRedirect("wizard3.jsp?action=Step 3");
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

    sDisplayMessage = "You have to click <b>Next</b> or <b>Back</b> button to remove it permanently.";
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

  String sHelpTag = "setupwizard";
  String sTitleLinks = "<b>Setup Wizard -- Step Two</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
This step is to setup the titlebar of the website.
<form name="config" action="multipartform.jsp?return=wizard2.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateStep2(this);">
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th colspan=2 class="thHead" height="2">Setup Titlebar</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan=2 height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>

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
        &nbsp;&nbsp;<a href="../util/displayimage.jsp?filename=<%=bean.getImageFileName(info.TitleImage)%>" target="imageview">Preview Image</a>&nbsp;&nbsp;<a href="wizard2.jsp?action=removeimage&name=title">Remove</a>
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
        </select> <a href="../product/category.jsp?action=editspecialcategory&reference=-13&return=../config/wizard2.jsp&display=Go back to Step two">Edit</a> the attribute of this category.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right"><br>New Products Display:</td>
      <td class="row1" colspan="2">Show new arrival products link on the navigation area of the titlebar<br>
        <select name="newarrivals" onChange="OnSelectNewProducts(document.config)">
          <option value=1 <%=bean.getSelected(1, info.NewArrivals)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.NewArrivals)%>>No</option>
        </select> If yes, enter display name: <input type="text" name="newname" value="<%=Utilities.getValue(info.NewName)%>" maxlength="20">
        <a href="../product/category.jsp?action=editspecialcategory&reference=-10&return=../config/wizard2.jsp&display=Go back to Step two">Edit</a> the attribute of this category.
     </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right"><br>Hot Products Display:</td>
      <td class="row1" colspan="2">Show the most visited Products on the navigation area of the titlbar, next to 'New Product'<br>
        <select name="hotproducts" onChange="OnSelectHotProducts(document.config)">
          <option value=1 <%=bean.getSelected(1, info.HotProducts)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.HotProducts)%>>No</option>
        </select> If yes, enter display name: <input type="text" name="hotname" value="<%=Utilities.getValue(info.HotName)%>" maxlength="20">
          <a href="../product/category.jsp?action=editspecialcategory&reference=-11&return=../config/wizard2.jsp&display=Go back to Step two">Edit</a> the attribute of this category.
      </td>
    </tr>
    <tr>
      <td class="row1" width="20%" align="right"><br>Best Sale Products Display:</td>
      <td class="row1" colspan="2" height="2">Show the best sold products on the navigation area of the titlebar, next to 'Hot Product'<br>
        <select name="bestsellers" onChange="OnSelectBestProducts(document.config)">
          <option value=1 <%=bean.getSelected(1, info.BestSellers)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.BestSellers)%>>No</option>
        </select> If yes, enter display name: <input type="text" name="bestname" value="<%=Utilities.getValue(info.BestName)%>" maxlength="20">
        <a href="../product/category.jsp?action=editspecialcategory&reference=-12&return=../config/wizard2.jsp&display=Go back to Step two">Edit</a> the attribute of this category.
     </td>
    </tr>
  </table>
 </td>
</tr>
</table>
</td>
</tr>

<tr>
  <td colspan=2 align="center" class="catBottom">
   <table width="100%" height="10" cellspacing="1" border="0">
    <tr>
     <td width="70%"></td>
     <td width="15%" align="right"><input type="submit" name="action" value="< Back" style="WIDTH:70px"></td>
     <td width="15%" align="center"><input type="submit" name="action" value="Next >" style="WIDTH:70px"></td>
    </tr>
   </table>
  </td>
</tr>
</table>
</form>
<!--SCRIPT>onConfigLoad(document.config);</SCRIPT-->
<%@ include file="../share/footer.jsp"%>