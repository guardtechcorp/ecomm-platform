<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.SiteSettingBean"%>
<%@ page import="com.zyzit.weboffice.model.MemberInfo"%>
<%@ include file="../include/pageheader.jsp"%>
<%
{
    SiteSettingBean bean = SiteSettingBean.getObject(session);

    if (sRealAction.startsWith("Update Rows"))
    {
        bean.changeMaxRowsPerPage(request);
    }

    List ltArray = bean.getAll(request, "index.jsp?action=Switch Page_SiteList", mbInfo.MemberID);
%>
<TABLE border=0 cellspacing=0 cellpadding=2 width="100%">
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>    
 <TR>
  <TD>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
  <TD width="5%"></TD>
  <TD align="right"><%=bean.getLabel("cm-maxrow")%>:
  <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_SiteList")%>');">
  <%=bean.getRowsPerPageList(-1)%>
  </select>
  </TD>
 </TR>
</TABLE>
</TD>
</TR>
<TR>
<TD>
<table class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
 <tr vAlign="middle" bgColor="#4959A7">
 <td width="4%" align="center" height="22"><FONT color="#ffffff"><b><%=bean.getLabel("cm-number")%></b></FONT></td>
 <td width="17%" align="center"><%=bean.getSortNameLink("WebTitle", bean.encodedUrl("index.jsp?action=Sort_SiteList"), bean.getLabel("ws-webtitle"), true)%></td>
 <td width="25%" align="center"><%=bean.getSortNameLink("SiteName", bean.encodedUrl("index.jsp?action=Sort_SiteList"), bean.getLabel("ws-siteurl"), true)%></td>
 <td width="8%" align="center"><%=bean.getSortNameLink("Language", bean.encodedUrl("index.jsp?action=Sort_SiteList"), bean.getLabel("cm-language"), true)%></td>
 <td width="12%" align="center"><%=bean.getSortNameLink("m_LastName", bean.encodedUrl("index.jsp?action=Sort_SiteList"), bean.getLabel("cm-ownername"), true)%></td>
 <td width="8%" align="center"><%=bean.getSortNameLink("CreateDate", bean.encodedUrl("index.jsp?action=Sort_SiteList"), bean.getLabel("cm-adddate"), true)%></td>
 </tr>
<% if (ltArray==null||ltArray.size()==0){ %>
      <tr class="normal_row">
        <td colspan=9><%=bean.getLabel("ws-norecord")%></td>
      </tr>
<% } else {%>
<%
    int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
    for (int i = 0; ltArray != null && i < ltArray.size(); i++) {
        ConfigInfo info = (ConfigInfo) ltArray.get(i);

    String sToEmail = bean.getOwnerName(info) + " [" + info.m_Email+"]";
%>
 <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
  <td width="4%" align="center" height="20" nowrap><%=(nStartNo+i)%></td>
  <td width="17%"><%=Utilities.getValue(info.WebTitle)%></td>
  <td width="25%"><%=bean.getSiteLinkUrl(info)%></td>
  <td width="8%" align="center"><%=bean.getLanguageName(info.Language)%></td>
  <td width="12%"><a href='<%=bean.encodedUrl("index.jsp?action=Load_EMail&toemail="+sToEmail+"&pt="+bean.getLabel("cm-emailtitle"))%>' title='<%=bean.getLabel("cm-emailtip")%>'><%=bean.getOwnerName(info)%></a>
  <td width="8%" align="center"><%=Utilities.getDateValue(info.CreateDate, 10)%></td>
 </tr>
<%}%>
<%}%>
  <tr class="normal_row2">      
   <td colspan=7>
    <table width="100%">
     <tr>
      <td width="5%"> </td>
      <td align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
     </tr>
    </table>
   </td>
  </tr>
 </table>
 </TD>
</TR>
</TABLE>
<% } %>