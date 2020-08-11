<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.bean.BookItemBean"%>
<%@ page import="com.zyzit.weboffice.internet.Base64Decoder"%>
<%
  BookItemBean bean = new BookItemBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EXPORT))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  if ("Export Now".equalsIgnoreCase(sAction))
  {
    boolean bRet = bean.export(request, response);
    return;
  }

  String sReturn = Base64Decoder.decode(request.getParameter("return"));
  String sDisplay = request.getParameter("display");

  String sHelpTag = "bookitemexport";
  String sTitleLinks = "<a href=\"booklist.jsp?action=Books\">Books</a> > <a href=\"" + sReturn +"\">" + sDisplay + "</a> > ";
  sTitleLinks += "<b>Export Book Items</b>";
%>
<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/export.js"></SCRIPT>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<form name="itemexport" action="itemexport.jsp" method="post" onSubmit="return validateExport(this, '<%=Utilities.getInt(bean.getCacheData(bean.KEY_TOTALROWS), 0)%>');">
<table width="90%" cellpadding="1" cellspacing="0" border="0" class="forumline" align="center">
    <tr>
      <th colspan="2" class="thHead">Export Book Item Records</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="failed"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr class="normal_row">
      <td colspan="2" height="10"></td>
    </tr>
    <tr class="normal_row">
      <td colspan="2">&nbsp;&nbsp;&nbsp;<font size="2" color="#0066FF"><b><font color="#000066">Select Format:</font></b></font></td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">
        <input type="radio" name="format" value="records" checked>
      </td>
      <td>Records (.csv file which MS-Excel can open, showing all the information of book item records.)</td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">&nbsp;</td>
      <td><input type="checkbox" name="headrow" value="yes" checked>Include field names in header row</td>
    </tr>
    <tr class="normal_row">
      <td colspan="2" align="right" height=10><!--hr--></td>
    </tr>
    <tr class="normal_row">
      <td colspan="2">&nbsp;&nbsp;&nbsp;<font color="#0066FF"><b><font size="2" color="#000066">Select Record Range:</font></b></font></td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">
        <input type="radio" name="record" value="all" checked onClick="onRecordSelect(document.orderexport);">
      </td>
      <td>All Records (<b><%=Utilities.getInt(bean.getCacheData(bean.KEY_TOTALROWS), 0)%></b> Records(s) are available to export.)</td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">
        <input type="radio" name="record" value="range" onClick="onRecordSelect(document.orderexport);">
      </td>
      <td> Range: From
        <input maxlength=10 name="rangefrom" size="10" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
        To <input maxlength=10 name="rangeto" size="10" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
    </tr>

    <tr class="normal_row">
      <td colspan="2" align="right" height=10><!--hr--></td>
    </tr>
    <tr class="normal_row">
      <td colspan="2">&nbsp;&nbsp;&nbsp;<font color="#0066FF"><b><font size="2" color="#000066">Select case conversion:</font></b></font></td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right"><input type="radio" name="casetype" value="no" checked></td>
      <td>All capital letters</td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right"><input type="radio" name="casetype" value="yes"></td>
      <td>Upper and Lower case</td>
    </tr>

    <tr class="normal_row">
      <td colspan="2" height="10"></td>
    </tr>
    <tr class="normal_row">
      <td colspan="2" class="catBottom" align="center">
        <table width="100%" border="0">
          <tr>
            <td align="center"><input type="submit" name="action" value="Export Now"></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<SCRIPT>onExportLoad(document.itemexport);</SCRIPT>
<%@ include file="../share/footer.jsp"%>