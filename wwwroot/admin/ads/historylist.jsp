<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<link rel="stylesheet" href="/staticfile/admin/css/tooltip.css" type="text/css">
<title>Administration Console - </title>
</head>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/tooltip.js"></SCRIPT>
<body>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.AdsHistoryBean" %>
<%@ page import="com.zyzit.weboffice.model.AdsProcessInfo" %>
<%@ page import="com.zyzit.weboffice.model.UserInfo" %>
<%@ include file="../share/titlelink.jsp"%>
<%
  AdsHistoryBean bean = new AdsHistoryBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_ADS_STATISTICS))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  int nUserId = Utilities.getInt(request.getParameter("userid"), 0);
  if (nUserId==0)
  {
     UserInfo urInfo = bean.getLoggedUserInfo();
     if (urInfo!=null)
        nUserId = urInfo.UserID;
  }
  else if (nUserId==-10)
  {
     nUserId = 0;
  }

  if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request, nUserId, true);

  String sHelpTag = "adshistorylist";
  String sTitleLinks = "<b>Ads History List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can see all the live chat history list. You can view any of them.
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'historylist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("C.Title", "historylist.jsp", "Ads Title")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("B.UserName", "historylist.jsp", "Username")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("Client", "historylist.jsp", "Device")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("FromIP", "historylist.jsp", "From ID")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Type", "historylist.jsp", "Type")%></th>
    <th width="8%" align="center" class="thCornerL"><%=bean.getSortNameLink("Status", "historylist.jsp", "Status")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("CreateDate", "historylist.jsp", "Date and Time")%></th>
  </tr>
  <%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     AdsProcessInfo info = (AdsProcessInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td align="center"><a href="#" onMouseover="ddrivetip('<%=bean.getDetailText(info)%>')" onMouseout="hideddrivetip()"><%=(nStartNo+i)%></a></td>
    <td align="center"><%=Utilities.getValue(info.m_Title)%></td>
    <td><%=Utilities.getValue(info.m_Username)%></td>
    <td><%=Utilities.getValue(info.Client)%></td>
    <td><%=Utilities.getValue(info.FromIP)%></td>
    <td align="center"><%=info.Type<2?"View":"Click"%></td>
    <td align="center"><%=info.Status==0?"Success":"Failed"%></td>
    <td align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
  </tr>
  <%}%>
  <tr>
    <td colspan="10" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
<% if (ltArray==null||ltArray.size()==0){ %>
         <td width="30%">There is no any Ads delivery history records.</td>
<% }else{ %>
         <td width="30%"></td>
<% } %>
         <td width="70%" align="right"><b><%=bean.getCacheData(bean.KEY_PAGELINKS)%></b></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<%@ include file="../share/footer.jsp"%>