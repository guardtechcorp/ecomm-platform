<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/product.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.ProductMemberPriceBean"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%
  ProductMemberPriceBean bean = new ProductMemberPriceBean(session, 20);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_CUSTOMER))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  CustomerInfo ctInfo = bean.getCustomer(request);
  String sClass = "successful";

  List ltProduct;
  if ("Update".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    ProductMemberPriceBean.Result ret = bean.update(request);
    ltProduct = (List)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      int nSampleMemberId = Utilities.getInt(request.getParameter("samplemember"), -1);
      if (nSampleMemberId<=0)
        sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "member price");
      else
        sDisplayMessage = "It is successfully to copy member prices";
    }
  }
  else
    ltProduct = bean.getProductList(request);

  sAction = "Update";

  String sHelpTag = "MemberPrice";
  String sTitleLinks = bean.getNavigation(request, "Edit Member Price");
  String sDescription = "The form below will allow you to edit and update the member price for customer of <b>" + ctInfo.Yourname + "</b> (<b>" + ctInfo.EMail + "</b>).";
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="memberprice" action="memberprice.jsp"  method="post" onsubmit="return validateMemberPrice(this);">
<table width="95%" cellpadding="0" cellspacing="0" border="0" align="center">
  <!--tr>
    <td>&nbsp;<a href='moneypocketlist.jsp?action=Get List&customerid=<%=ctInfo.CustomerID%>&yourname=<%=ctInfo.Yourname%>'>Credit List</a></td>
  </tr-->
</table>
<br>
<input type="hidden" name="customerid" value="<%=ctInfo.CustomerID%>">
<table border="0" cellpadding="2" cellspacing="1" width="95%" class="forumline" align="center">
  <tr>
    <th class="thHead" colspan="5" height="25" align="center" valign="middle">Member Price Information</th>
  </tr>
<% if (sDisplayMessage!=null) {%>
  <tr>
    <td class="row1" colspan="5" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
  </tr>
<% } %>
  <tr bgcolor="#9AAEDA">
    <td align="center" width="5%" height="25"><font color="#ffffff"><b>No</b></font></td>
    <td align="center" width="51%" height="25"><font color="#ffffff"><b>Product Name</b></font></td>
    <td align="center" width="20%" height="25"><font color="#ffffff"><b>Member Price</b></font></td>
    <td align="center" width="12%" height="25"><font color="#ffffff"><b>Regular Price</b></font></td>
    <td align="center" width="12%" height="25"><font color="#ffffff"><b>Sale Price</b></font></td>
  </tr>

<% if ("www.test101.wlmg.net".equalsIgnoreCase(bean.getDomainName())
      ||"www.hepahealth.com".equalsIgnoreCase(bean.getDomainName())
      ||"store.hepahealth.com".equalsIgnoreCase(bean.getDomainName())) {
   String sLastName = "Zhao";
   if (!"www.test101.wlmg.net".equalsIgnoreCase(bean.getDomainName()))
      sLastName = "Kang";
%>
    <tr >
      <td class="row1" width="5%" align="center"><input type="checkbox" name="copymember" value="1"></td>
      <td class="row1" width="51%" align="left">Copy the member prices from the listing member&nbsp;&nbsp;</td>
      <td class="row1" colspan="3">
       <select size=1 name="samplemember">
          <option value="-1" selected>None of them</option>
          <%=bean.getSampleMembers(sLastName)%>
       </select>
      </td>
    </tr>
<% } %>    
<%
  for (int i=0; ltProduct!=null && i<ltProduct.size(); i++) {
      ProductInfo pdInfo = (ProductInfo)ltProduct.get(i);
%>
    <tr>
      <td class="row1" width="5%" align="center"><%=(i+1)%></td>
      <td class="row1" width="51%"><%=pdInfo.Name%></td>
      <td class="row1" width="20%"> $ <input type="text" name="pd_<%=pdInfo.ProductID%>" size="10" maxlength="40" value="<%=bean.getMemberPrice(pdInfo)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'></td>
      <td class="row1" width="12%">&nbsp;&nbsp;<%=Utilities.getNumberFormat(pdInfo.Price, '$', 2)%></td>
      <td class="row1" width="12%">&nbsp;&nbsp;<%=Utilities.getNumberFormat(pdInfo.SalePrice, '$', 2)%></td>
    </tr>
<% } %>
    <tr>
      <td class="catBottom" colspan="5" align="center" height="28"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
</table>
</form>
<SCRIPT>onMemberPriceLoad(document.memberprice);</SCRIPT>
<%@ include file="../share/footer.jsp"%>