<%@ include file="../share/uparea.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AdsBean"%>
<%@ page import="com.zyzit.weboffice.model.AdsInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.service.AdsDelivery" %>
<%
  AdsBean bean = new AdsBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ADS_UPDATE))
     return;

  //DomainInfo dmInfo = bean.getDomainInfo();
//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  if ("delete".equalsIgnoreCase(sAction))
  {
    AdsBean.Result ret = bean.delete(request);
    if (!ret.isSuccess())
    {
       Errors errObj = (Errors)ret.getInfoObject();
       session.setAttribute(Definition.KEY_DISPLAYMESSAGE, errObj.getError());
       session.setAttribute(Definition.KEY_DISPLAYLINK, "Click <a href=\"javascript:history.go(-1);\">Here</a> to return to the Ads list page.");
       response.sendRedirect("../share/information.jsp");
     }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

//  List ltUser = bean.getAll(request, "adslist.jsp");
  int nUserId = bean.getLoggedUsrId();
  List ltArray = bean.getAll(request, nUserId);

  String sHelpTag = "adslist";
  String sTitleLinks = "<b>Ads List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can view all Ads and sort them. You can delete any of them or enter the Ads page to add a new Ads or edit it.
<p>
<table width="98%" cellpadding="0" cellspacing="0" border="0" align="center">
 <tr>
  <td>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'adslist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="4%" class="thCornerL">No.</th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("Title", "adslist.jsp")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Category", "adslist.jsp")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Available", "adslist.jsp", "Available")%></th>
    <th width="6%" align="center" class="thCornerL"><%=bean.getSortNameLink("StartTime", "adslist.jsp", "Start")%></th>
    <th width="6%" align="center" class="thCornerL"><%=bean.getSortNameLink("EndTime", "adslist.jsp", "End")%></th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("ModifyDate", "adslist.jsp", "Latest Modify")%></th>
    <th width="6%" align="center" class="thCornerL"><%=bean.getSortNameLink("ViewCount", "adslist.jsp", "View")%></th>
    <th width="6%" align="center" class="thCornerL"><%=bean.getSortNameLink("ClickCount", "adslist.jsp", "Click")%></th>
    <th width="5%" align="center" class="thCornerL"><%=bean.getSortNameLink("Active", "adslist.jsp")%></th>
    <th width="3%" align="center" class="thCornerL">Edit</th>
    <th width="4%" align="center" class="thCornerL">Delete</th>
  </tr>

<% if (ltArray==null||ltArray.size()==0){ %>
  <tr class="normal_row">
    <td colspan=12>There is no any ads available.</td>
  </tr>
<% } else {%>
<%
  int nStartNo = Utilities.getInt((String)session.getAttribute(bean.KEY_STARTROWNO), 1);
  for (int i=0; i<ltArray.size(); i++) {
      AdsInfo adInfo = (AdsInfo)ltArray.get(i);
      AdsDelivery.getLatestActionInfo(bean.getDomainName(), adInfo);      
%>
  <tr>
    <td class="row1" align="center"> <%=(nStartNo+i)%></td>
    <td class="row1"><%=Utilities.getValue(adInfo.Title)%></td>
    <td class="row1"><%=Utilities.getValue(adInfo.Category)%></td>
    <td class="row1" align="center"><%=Utilities.getValue(AdsInfo.AOption.GetNameByIndex(adInfo.Available))%></td>
    <td class="row1" align="center"><%=Utilities.getValue(adInfo.StartTime)%></td>
    <td class="row1" align="center"><%=Utilities.getValue(adInfo.EndTime)%></td>
    <td class="row1" align="center"><%=Utilities.getDateValue(adInfo.ModifyDate, 16)%></td>
    <td class="row1" align="center"><%=Utilities.getNumberFormat(adInfo.ViewCount, 'N', 0)%></td>
    <td class="row1" align="center"><%=Utilities.getNumberFormat(adInfo.ClickCount, 'N', 0)%></td>
    <td class="row1" align="center"><%=adInfo.Active>0?"Yes":"No"%></td>
    <td class="row1" align="center"><a href="ads.jsp?action=Edit&adsid=<%=adInfo.AdsID%>">Edit</a></td>
    <td class="row1" align="center"><a onClick="return confirm('Are you sure you want to delete it?')" href="adslist.jsp?action=delete&adsid=<%=adInfo.AdsID%>">Delete</a></td>
  </tr>
<%}%>
<% } %>
  <tr>
    <td colspan="12" class="catBottom">
      <table width="100%" border="0">
        <tr>
          <td width="30%"><a href="ads.jsp?action=addads">Add New Ads</a></td>
          <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>      
  </td>
 </tr>
</table>
<%@ include file="../share/footer.jsp"%>
