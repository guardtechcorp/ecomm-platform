<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.bean.InvoiceBean"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceInfo"%>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.InvoiceItemInfo"%>
<%
   InvoiceBean bean = new InvoiceBean(session, 20);
   Object[] arObj = bean.getInvoice(request);
   InvoiceInfo ivInfo = (InvoiceInfo)arObj[0];
   List ltItemArray = (List)arObj[1];
   CompanyInfo cpInfo = (CompanyInfo)arObj[2];
%>
Hi, <%=cpInfo.Yourname%>:

This email confirms that you have paid KZ Company <%=bean.getChargeBy()%><%=Utilities.getNumberFormat(bean.getTotalAmount(ltItemArray),'$',2)%> to use <%=bean.getConfigValue("productname", "Web Online Management")%>
Service of <%=ivInfo.Description%>.

Invoice Number: <%=Utilities.getValue(ivInfo.InvoiceNo)%>
Date and Time:  <%=Utilities.getDateValue(ivInfo.CreateDate, 16)%>

<%=cpInfo.CompanyName%>
<%=cpInfo.Address%>
<%=cpInfo.City%>, <%=cpInfo.State%> <%=cpInfo.ZipCode%>
Email: <%=cpInfo.EMail%>
Phone: <%=cpInfo.Phone%>  Fax: <%=Utilities.getValue(cpInfo.Fax)%>

Credit Card Type: <%=cpInfo.CreditType%>
Credit Card No.: <%=bean.getCreditNo(cpInfo.CreditNo, false)%>
Expiration Date: <%=cpInfo.ExpiredMonth%>/<%=cpInfo.ExpiredYear%>

 No.       Description                      Quantity  Unit Price  Total Price
------------------------------------------------------------------------------
<% for (int i=0; ltItemArray!=null&&i<ltItemArray.size(); i++) { InvoiceItemInfo iiInfo = (InvoiceItemInfo)ltItemArray.get(i);%>
 <%=Utilities.getFixedLengthValue(""+(i+1), 6, 1)%> <%=Utilities.getFixedLengthValue(iiInfo.Name,30,1)%>         <%=Utilities.getFixedLengthValue("1", 4, 0)%>      <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(iiInfo.Amount,'$',2), 8, -1)%>    <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(iiInfo.Amount*1,'$',2), 8, -1)%>
<% } %>
------------------------------------------------------------------------------
                                                          Subtotal: <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(bean.getTotalAmount(ltItemArray),'$',2), 8, -1)%>
                                                               Tax: <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(0,'$',2), 8, -1)%>
                                                             Total: <%=Utilities.getFixedLengthValue(Utilities.getNumberFormat(bean.getTotalAmount(ltItemArray),'$',2), 8, -1)%>


Thank you for using <%=bean.getConfigValue("productname", "Web Online Management")%> Service.

Customer Service Team of <%=bean.getConfigValue("company", "KZ Company")%>