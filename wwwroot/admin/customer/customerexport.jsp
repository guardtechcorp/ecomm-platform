<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.bean.CustomerBean"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%
  CustomerBean bean = new CustomerBean(session, 20);
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

//  String sReturn = request.getParameter("return");
//  String sDisplay = request.getParameter("display");

  String sHelpTag = "customerexport";
/*
  String sTitleLinks = "";
  if (sReturn!=null)
    sTitleLinks = "<a href=\"" + sReturn +"\">" + sDisplay + "</a> > ";
  sTitleLinks += "<b>Export the customers</b>";
  sTitleLinks = bean.getNavigation(request, "Export the Customers");
*/
  String sTitleLinks = bean.getNavigation(request, "Export the Customers");
%>
<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/export.js"></SCRIPT>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you to select format and range to export customer information.
<form name="customerexport" action="customerexport.jsp" method="post" onSubmit="return validateExport(this, '<%=Utilities.getInt(bean.getCacheData(bean.KEY_TOTALROWS), 0)%>');">
<table width="90%" cellpadding="1" cellspacing="0" border="0" class="forumline" align="center">
    <tr>
      <th colspan="2" class="thHead">Export</th>
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
        <input type="radio" name="format" value="label" checked onClick="onFormatSelect(document.customerexport);">
      </td>
      <td>Labels (.rtf file which MS-Word can open, only showing mailing information on each label)</td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">&nbsp;</td>
      <td >
        <input type="radio" name="label" value="5160" checked>Avery&reg; 5160 format (3 across - 1&quot; x 2 5/8&quot;) </td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">&nbsp;</td>
      <td>
        <input type="radio" name="label" value="5161">Avery&reg; 5161 fomat (2 across - 1&quot; x 4&quot;) </td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">&nbsp;</td>
      <td>
        <input type="radio" name="label" value="5162">Avery&reg; 5162 format (2 across - 1 1/3&quot; x 4&quot;)
     </td>
    </tr>
    <!--tr class="normal_row">
      <td width="20%" align="right">&nbsp;</td>
      <td colspan="2">&nbsp;</td>
    </tr-->
    <tr class="normal_row">
      <td width="6%" align="right">
        <input type="radio" name="format" value="records" onClick="onFormatSelect(document.customerexport);">
      </td>
      <td>Records (.csv file which MS-Excel can open, showing all the information of customers except password and credit no.)</td>
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
        <input type="radio" name="record" value="all" checked onClick="onRecordSelect(document.customerexport);">
      </td>
      <td>All Records (<b><%=Utilities.getInt(bean.getCacheData(bean.KEY_TOTALROWS), 0)%></b> Records(s) are available to export.)</td>
    </tr>
    <tr class="normal_row">
      <td width="6%" align="right">
        <input type="radio" name="record" value="range" onClick="onRecordSelect(document.customerexport);">
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
<SCRIPT>onExportLoad(document.customerexport);</SCRIPT>
<%@ include file="../share/footer.jsp"%>