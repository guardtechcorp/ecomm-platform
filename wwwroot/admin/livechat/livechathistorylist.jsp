<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<link rel="stylesheet" href="/staticfile/admin/css/main.css" type="text/css">
<link rel="stylesheet" href="/staticfile/admin/css/tooltip.css" type="text/css">
<title>Administration Console - </title>
</head>
<!--SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/sarissa.js"></SCRIPT-->
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/tooltip.js"></SCRIPT>
<body>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.LiveChatHistoryBean"%>
<%@ page import="com.zyzit.weboffice.model.LiveChatInfo"%>
<%@ include file="../share/titlelink.jsp"%>
<%
/*
  <link rel="stylesheet" href="tooltip.css" type="text/css">
  <SCRIPT Language="JavaScript" src="tooltip.js"></SCRIPT>
  </HEAD>
  <body>

  <a href="http://www.yahoo.com" onMouseover="ddrivetip('We have received your good <br>feedback and <b>we will response</b> you as soon as we can')";
   onMouseout="hideddrivetip()">Search Engine</a>
  <p>
  <p>
  <div onMouseover="ddrivetip('Yahoo\'s Site', 250)"; onMouseout="hideddrivetip()">This is a DIV. This is a DIV.</div>
*/

  LiveChatHistoryBean bean = new LiveChatHistoryBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_LIVECHAT_USER))
     return;

//ctBean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Delete".equalsIgnoreCase(sAction))
  {
     LiveChatHistoryBean.Result ret = bean.delete(request);
     if (!ret.isSuccess())
     {
        Errors errObj = (Errors)ret.getInfoObject();
        sDisplayMessage = errObj.getError();
        sClass = "failed";
     }
  }
  else if ("updaterows".equalsIgnoreCase(sAction))
  {
    bean.changeMaxRowsPerPage(request);
  }

  List ltArray = bean.getAll(request);

  String sHelpTag = "livechathistorylist";
  String sTitleLinks = "<b>Live Chat History List</b>";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
From this page, you can see all the live chat history list. You can view any of them.
<!--table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="20" valign="top"><font size="2"><b>Live Chat History List</b></font></td>
    <td width="5%"  height="20" valign="top" onmouseover="showTipHelp('livechathistorylist');" onmouseout="showHideSpan('close','tiphelp');" >
     <a href="javascript:;" class="helplink"><IMG src="/staticfile/admin/images/quickhelp.gif" width=14 height=16 align="CENTER" border="0">Help</a>
    </td>
  </tr>
  <tr>
    <td height="1" valign="top" colspan="2">
     <DIV id="tiphelp" style="DISPLAY: none">
     <table width="100%" cellpadding="4" cellspacing="0" class="infobox">
      <tr>
       <td bgcolor="#FFFFCC"><DIV id="tipcontent"></DIV></td>
      </tr>
     </table>
     </DIV>
    </td>
  </tr>
  <tr>
    <td height="20" valign="top">From this page, you can see all the live chat history list. You can view any of them.</td>
  </tr>
</table-->
<table width="99%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrowsperpage" onChange="updateMaxRows(this, 'livechathistorylist.jsp');">
      <%=bean.getRowsPerPageList(-1)%>
    </select>
    </td>
  </tr>
</table>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th width="5%" align="center" class="thCornerL">No.</th>
    <th width="10%" align="center" class="thCornerL"><%=bean.getSortNameLink("CaseNo", "livechathistorylist.jsp", "Case No.")%></th>
    <th width="20%" align="center" class="thCornerL"><%=bean.getSortNameLink("FirstName", "livechathistorylist.jsp", "Customer Name")%></th>
    <th width="24%" align="center" class="thCornerL"><%=bean.getSortNameLink("EMail", "livechathistorylist.jsp", "E-Mail")%></th>
    <th width="15%" align="center" class="thCornerL"><%=bean.getSortNameLink("StartDate", "livechathistorylist.jsp", "Start Date")%></th>
    <th width="16%" align="center" class="thCornerL"><%=bean.getSortNameLink("FinishDate", "livechathistorylist.jsp", "Finish Date")%></th>
    <th width="10%" align="center" class="thCornerL">Action</th>
  </tr>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td class="row1" colspan="6" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
  <%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     LiveChatInfo info = (LiveChatInfo)ltArray.get(i);
%>
  <tr class="normal_row">
    <td width="5%" align="center"><a href="#" onMouseover="ddrivetip('<%=bean.getDetailText(info)%>')" onMouseout="hideddrivetip()"><%=(nStartNo+i)%></a></td>
    <td width="10%" align="center"><%=Utilities.getValue(info.CaseNo)%></td>
    <td width="20%"><%=Utilities.getValue(info.FirstName)%> <%=Utilities.getValue(info.LastName)%></td>
    <td width="24%">
      <a href="../util/email.jsp?action=person&toemail=<%=info.EMail%>&name=<%=info.FirstName%>&group=recipients&return=../livechat/livechathistorylist.jsp&display=Live Chat History List" title="Email to <%=info.EMail%>"><%=info.EMail%></a>
    </td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.StartDate, 16)%></td>
    <td width="16%" align="center"><%=Utilities.getDateValue(info.FinishDate, 16)%></td>
    <td width="10%" align="center"><%=bean.getAction(info)%></td>
  </tr>
  <%}%>
  <tr>
    <td colspan="7" class="catBottom" height="2">
      <table width="100%" border="0">
        <tr>
<% if (ltArray==null||ltArray.size()==0){ %>
         <td width="30%">There is no any live chat history records.</td>
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