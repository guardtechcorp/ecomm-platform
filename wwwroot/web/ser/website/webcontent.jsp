<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.bean.MemberAccountBean" %>
<%@ page import="com.zyzit.weboffice.model.WebPageInfo" %>
<%
{
    MemberAccountBean bean = MemberAccountBean.getObject(session);
    SiteFileWeb fileWeb1 = SiteFileWeb.getObject(session);
    int nPageId = 0;
    int nMaxPage = 1;

    if (sRealAction.endsWith("_WebContent"))
    {
        if (sRealAction.startsWith("prev")||sRealAction.startsWith("next")||sRealAction.startsWith("goto"))
        {
           String sFileName = fileWeb1.goTo(request, sRealAction);
           ret = bean.getWebContentByRequest(request, cfInfo.MemberID, sFileName);
           nPageId = Utilities.getInt(request.getParameter("pid"), 0);
           nMaxPage = Utilities.getInt(fileWeb1.getCacheData(SiteFileWeb.KEY_TOTALROWS), 1);
        }
        else
          ret = bean.getWebContentByRequest(request, cfInfo.MemberID);
    }
    else
    {//. It is the home page content
        ret = mcBean.getWebContentByPageId(cfInfo.MemberID, cfInfo.HomePageID, null);
    }

    WebPageInfo wpInfo1 = fileWeb1.getWebPage();

//MemberAccountBean.dumpAllParameters(request);
//<img src='http://www.webcenternode.com/ctr/web/fileload/webpage-253/MotherDay/P1030828.JPG' width='756' height='567' border='0'>
%>
<% if (ret.m_nStatus==0) { %>
<% if (nMaxPage>1) {
%>
<table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
  <tr>
    <td>&nbsp;</td>
    <td align="right">
     <form name="jumppageform" action='<%=bean.encodedUrl("index.jsp")%>' method="post" onSubmit="return validateJumpPage(this, 1, <%=nMaxPage%>);">
     <input type="hidden" name="action1" value="goto_WebContent">
     <input type="hidden" name="pid"  value="<%=nPageId%>">
     <%=fileWeb1.getPrevNextLinks("index.jsp?accessby=" +wpInfo1.AccessMode +"&pid="+nPageId+'&', "_WebContent", true)%>&nbsp;Jump to:
     <input type="text" name="page" value="" maxlength="6" size="1" style="height:20px" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
     <input type='submit' value='Go' name='submit' title='Jump to a specific page.' style="WIDTH:28px; height:22px">&nbsp;
     </form>
    </td>
  </tr>
</table>
<% } %>
<table width="100%">
<% if (nPageId>0) {
//   WebPageInfo wpInfo1 = fileWeb1.getWebPage();
   File file = fileWeb1.getFileByRecord(request);
%>
 <tr>
   <td align="center"><font size=3><b><%=fileWeb1.getFileTitle(wpInfo1, file)%></b></font></td>
 </tr>
 <tr>
  <td>
    <%=Utilities.getValue((String)ret.getUpdateInfo())%>
  </td>
 </tr>
<tr>
  <td align="center"><hr class="line" width="%98"></td>
</tr>
 <tr>
   <td>
   <table>
    <tr>
      <td width="15%">Description:</td>
      <td colspan="3"><b><%=fileWeb1.getFileDescription(file)%></b></td>
    </tr>
    <tr>
     <td width="15%">File Name:</td>
     <td width="45%"><b><%=file.getName()%></b></td>
     <td width="18%" nowrap>Uploaded By:</td>
     <td><b><%=fileWeb1.getSenderName()%></b></td>
   </tr>
   <tr>
    <td width="15%">File Size:</td>
    <td width="45%"><b><%=MemberFileBean.getFileAttribute2(file, 2, mcBean)%></b></td>
    <td width="18%" nowrap>Uploaded Date:</td>
    <td><b><%=MemberFileBean.getFileAttribute2(file, 4, mcBean)%></b></td>
   </tr>
   </table>
   </td>
 </tr>
<% } else { %>
  <tr>
     <td style1="padding:5 5 5 5px">
       <%=Utilities.getValue((String)ret.getUpdateInfo())%>
     </td>
   </tr>
<% } %>
</table>
<% } else { %>
   <%@ include file="filelayouts.jsp" %>
<% } %>
<% } %>