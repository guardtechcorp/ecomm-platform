<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.MemberProductBean"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%
{
    MemberProductBean bean = MemberProductBean.getObject(session, 20);

    if (sRealAction.startsWith("Update Rows"))
    {
        bean.changeMaxRowsPerPage(request);
    }
    else if (sRealAction.startsWith("Delete"))
    {
        ret = bean.delete(request);
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            nDisplay = 0;
            sDisplayMessage = errObj.getError();
        }
    }

    List ltArray = bean.getAll(request, bean.encodedUrl("index.jsp?action=Switch Page_ProductList"), mbInfo.MemberID);

//bean.showAllParameters(request, out);
//Utilities.dumpObject(info);
//    sPageTitle = "Product List";
%>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
  <TD>
<TABLE border=0 cellspacing=0 cellpadding=0 width="100%">
 <TR>
<% if (ltArray!=null && ltArray.size()>16) { %>
  <TD width="20%">
   &nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_Product&pt=Add New Product")%>'>Add New Product</a>
  </TD>
<% } %>
  <TD align="right">Max Rows Per Page:
  <select name="maxrowsperpage" onChange="updateMaxRows2(this, '<%=bean.encodedUrl("index.jsp?action=Update Rows_ProductList")%>');">
  <%=bean.getRowsPerPageList(-1)%>
  </select>
  </TD>
 </TR>
</TABLE>
</TD>
</TR>
<TR>
<TD>
<TABLE class="table-1" width="100%" align="right" border=0 cellspacing=1 cellpadding=1>
<TR vAlign="middle" bgColor="#4959A7">
    <td width="6%" align="center" height="22"><FONT color="#ffffff">No.</FONT></td>
    <td width="35%" align="center"><%=bean.getSortNameLink("Name", bean.encodedUrl("index.jsp?action=Sort_ProductList"), "Product Name", true)%></td>
    <td width="8%" align="center"><%=bean.getSortNameLink("Price", bean.encodedUrl("index.jsp?action=Sort_ProductList"), "Price", true)%></td>
    <td width="8%" align="center"><%=bean.getSortNameLink("VisitTime", bean.encodedUrl("index.jsp?action=Sort_ProductList"), "Visits", true)%></td>
    <td width="8%" align="center"><%=bean.getSortNameLink("Active", bean.encodedUrl("index.jsp?action=Sort_ProductList"), "Active", true)%></td>
    <td width="15%" align="center"><%=bean.getSortNameLink("CreateDate", bean.encodedUrl("index.jsp?action=Sort_ProductList"), "Added Date", true)%></td>
    <td width="12%" align="center"><FONT color="#ffffff">Actions</FONT></td>
</TR>
<% if (ltArray==null||ltArray.size()==0){ %>
      <tr class="normal_row">
        <td colspan=9>There is no any product available.</td>
      </tr>
<% } else {%>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     ProductInfo info = (ProductInfo)ltArray.get(i);
%>
 <tr class="normal_row" onmouseup="selrow(this, 2)" onmouseover="selrow(this, 0)" onmouseout="selrow(this, 1)">
    <td width="6%" align="center" height="20"><%=(nStartNo+i)%></td>
    <td width="35%"><b><%=info.Name%></b></td>
    <td width="8%" align="right"><%=Utilities.getNumberFormat(info.Price,'$',2)%>&nbsp;&nbsp;</td>
    <td width="8%" align="center"><%=Utilities.getNumberFormat(info.VisitTime,'n',0)%></td>
    <td width="15%" align="left"><%=bean.getAccessName(info.Active)%></td>
    <td width="15%" align="center"><%=Utilities.getDateValue(info.CreateDate, 16)%></td>
    <td width="12%" align="center">
      <a href='<%=bean.encodedUrl("index.jsp?action=Edit_Product&productid="+info.ProductID+"&pt=Product Information")%>'>Edit</a> |
      <a href='<%=bean.encodedUrl("index.jsp?action=Delete_ProductList&productid="+info.ProductID)%>' onClick="return confirm('Are you sure you want to delete this product.');">Delete</a>        
    </td>
  </tr>
<%}%>
<%}%>
  <tr class="normal_row2">      
    <td colspan=7>
     <table width="100%">
      <tr>
        <td width="20%">&nbsp;<a href='<%=bean.encodedUrl("index.jsp?action=New_Product&pt=Add New Product")%>'>Add New Product</a></td>
        <td width="80%" align="right"><%=bean.encodedHrefLink(bean.getCacheData(bean.KEY_PAGELINKS))%></td>
        <!--td width="80%" align="right"><%=bean.getCacheData(bean.KEY_PAGELINKS)%></td-->
      </tr>
     </table>
    </td>
  </tr>
 </table>
 </TD>
</TR>
</TABLE>        
<% } %>