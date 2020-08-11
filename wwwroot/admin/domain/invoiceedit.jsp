<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/domain.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.InvoiceBean"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceItemInfo"%>
<%
  InvoiceBean bean = new InvoiceBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_DOMAINBILL))
     return;
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  InvoiceInfo info = null;
  List ltItemArray = null;
  String sActionLink = request.getParameter("actionlink");
  if (sActionLink!=null && sActionLink.startsWith("delete"))
  {
    info =  bean.get(request);
    ltItemArray = bean.deleteItem(request);
  }
  else if ("Add New Item".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    ltItemArray = bean.addItem(request);
//System.out.println("size=" + ltItemArray.size());
  }
  else if ("Calculate".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    ltItemArray = bean.updateItem(request);
  }
  else  if ("Create Invoice".equalsIgnoreCase(sAction))
  {
    InvoiceBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (InvoiceInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Invoice");
      //. Change to update of adding its sub-category
//      info = (InvoiceInfo)ret.getUpdateInfo();
//      ltItemArray = bean.getItemList(info.InvoiceID);
    }

    ltItemArray = bean.getItemList(request);
  }
  else if ("Update Invoice".equalsIgnoreCase(sAction))
  {
    InvoiceBean.Result ret = bean.update(request, false);
    info = (InvoiceInfo)ret.getUpdateInfo();
    ltItemArray = bean.getItemList(info.InvoiceID);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Invoice");
    }

    ltItemArray = bean.getItemList(request);
  }
  else if ("edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    ltItemArray = bean.getItemList(request);
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
    info =  bean.getPrevOrNext(sAction);
    ltItemArray = bean.getItemList(info.InvoiceID);
  }

  if (info==null)
  {
/*
    info = InvoiceInfo.getInstance(true);
    info.CreateDate = Utilities.getTodayDateTime();
    info.Description = request.getParameter("description");
    if (info.Description==null)
       info.Description = "Monthly Fee for " + info.CreateDate.substring(5,7) +'/'+info.CreateDate.substring(0,4);
*/
    info = bean.getNewInfoObject(request);
    if (ltItemArray==null)
       ltItemArray = bean.getItemList(request);
  }

  if (info.InvoiceID==-1)
     sAction = "Create Invoice";
  else
     sAction = "Update Invoice";

//System.out.println("action="+sAction+","+info.InvoiceID);
  CompanyInfo cpInfo = bean.getCompany(request);
%>
<% if ("Create Invoice".equalsIgnoreCase(sAction)) { %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25" valign="top"><font size="2"><a href="billinglist.jsp?action=Billing List">Company Billing List</a> > <a href="invoiceeditlist.jsp?<%=bean.getDomainCGI(request)%>&dn=<%=request.getParameter("dn")%>">Invoice List</a> > <b>Create a Invoice</b></font></td>
  <tr>
    <td height="20" valign="top">The form below will allow you to create a new invoice.</td>
  </tr>
</table>
<% } else { %>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td height="25"><font size="2"><a href="billinglist.jsp?action=Billing List">Company Billing List</a> > <a href="invoiceeditlist.jsp?<%=bean.getDomainCGI(request)%>&dn=<%=request.getParameter("dn")%>">Invoice List</a> > <b>Edit the Invoice</b></font></td>
  <tr>
    <td height="20" valign="top">The form below will allow you to edit and update the invoice.</td>
  </tr>
</table>
<table width="95%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("invoiceedit.jsp?"+bean.getDomainCGI(request)+"&invoiceid="+info.InvoiceID+ "&dn="+request.getParameter("dn")+'&')%></td>
  </tr>
</table>
<% } %>
<table cellpadding=2 border=0 cellspacing=1 align="center" width=95% bgcolor="#666666">
  <tr bgcolor="#ffffff">
    <td class="ten">Invoice Number: <b><%=Utilities.getValue(info.InvoiceNo)%></b></td>
    <td class="ten">Date and Time: <b><%=Utilities.getDateValue(info.CreateDate, 16)%></b></td>
  </tr>
  <tr bgcolor="#4279bd">
    <td class="WB10" align="center" width=50%><b>Company Information</b></td>
    <td class="WB10" align="center" width=50%><b>Billing Information</b></td>
  </tr>
  <tr bgcolor="#ffffff">
    <td class="ten" valign="top"><b><%=cpInfo.CompanyName%><br>
      <%=cpInfo.Address%><br>
      <%=cpInfo.City%>, <%=cpInfo.State%> <%=cpInfo.ZipCode%></b><br><br>
      Email: <b><%=cpInfo.EMail%></b><br>
      Phone: <b><%=cpInfo.Phone%></b>&nbsp;&nbsp;&nbsp;Fax: <b><%=cpInfo.Fax%></b><br>
    </td>
    <td class="ten" valign="top"><b><%=cpInfo.Address_Bill%><br>
      <%=cpInfo.City_Bill%>, <%=cpInfo.State_Bill%> <%=cpInfo.ZipCode_Bill%></b>
     <br>The Name on the Card: <b><%=Utilities.getValue(cpInfo.NameOnCard)%></b><br>
     Credit Card Type: <b><%=cpInfo.CreditType%></b><br>
     Credit Card No.: <b><%=bean.getCreditNo(cpInfo.CreditNo, true)%></b><br>
     Expiration Date: <b><%=cpInfo.ExpiredMonth%>/<%=cpInfo.ExpiredYear%></b><br>
     Card Verification No.: <b><%=cpInfo.Csid%><b>
    </td>
  </tr>
</table>
<br>
<table width="95%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
   <form name="invoice" action="invoiceedit.jsp" method="post" onsubmit="return validateInvoice(this);">
   <input type="hidden" name="domainid" value="<%=request.getParameter("domainid")%>">
   <input type="hidden" name="dn" value="<%=request.getParameter("dn")%>">
   <input type="hidden" name="invoiceid" value="<%=info.InvoiceID%>">
   <input type="hidden" name="totalbytes" value="<%=Utilities.getValue(info.TotalBytes)%>">
   <input type="hidden" name="actionlink" value="">
    <tr>
      <th class="thHead" colspan="3">Invoice</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td colspan="3" height="12" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
<%
  for (int i=0; ltItemArray!=null&&i<ltItemArray.size(); i++) {
     InvoiceItemInfo iiInfo = (InvoiceItemInfo)ltItemArray.get(i);
%>
    <tr class="normal_row">
      <td width="21%" align="right">Item <%=(i+1)%>:</td>
      <td width="79%" colspan="2"><input type="text" name="name_<%=i%>" value="<%=Utilities.getValue(iiInfo.Name)%>" maxlength="1024" size="40">
      &nbsp;Amount: <input type="text" name="amount_<%=i%>" value="<%=Utilities.getValue(iiInfo.Amount)%>" size="10" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
<% if (i>0) { %>
      &nbsp;<a href="javascript:submitForm(document.invoice, 'delete_<%=i%>')">Delete</a>
<% } %>
     </td>
    </tr>
<%}%>
    <tr class="normal_row">
      <td width="21%"></td>
      <td width="41%"><input type="submit" name="action" value="Add New Item"></td>
      <td width="38%"><input type="submit" name="action" value="Calculate"></td>
    </tr>
    <tr class="normal_row">
      <td class="spaceRow" colspan="3" height="10"><hr class="dotted"></td>
    </tr>
    <tr class="normal_row">
      <td width="21%" align="right">Bytes Used:</td>
      <td width="41%" colspan="2"><%=bean.showBytesUsage(info.TotalBytes)%>
      </td>
    </tr>
    <tr class="normal_row">
      <td width="21%" align="right">Date Range:</td>
      <td width="41%" colspan="2">
       From: <input name="datefrom" size=20 maxlength=10 value="<%=Utilities.getValue(info.DateFrom)%>" onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
       To: <input name="dateto" size=20 maxlength=10 value="<%=Utilities.getValue(info.DateTo)%>" onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'> (MM/DD/YYYY)
      </td>
    </tr>
    <tr class="normal_row">
      <td width="21%" height="12" align="right">Description:</td>
      <td width="41%" height="12">
        <input type="text" name="description" value="<%=Utilities.getValue(info.Description)%>" maxlength="1024" size="40">
      </td>
      <td height="12"  width="38%"><b><%=Utilities.getNumberFormat(bean.getTotalAmount(ltItemArray), '$', 2)%></b></td>
    </tr>
    <tr class="normal_row">
      <td width="21%" height="15" align="right">
       <select name="sendmail">
        <option value=1 selected>Yes</option>
        <option value=0>No</option>
       </select>
      </td>
      <td width="79%" colspan="2">Send a confirm email to <b><%=cpInfo.EMail%></b> after the invoice is created.</td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center" height="22"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
  </form>
</table>
<SCRIPT>onInvoiceLoad(document.domain, "<%=sAction%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>