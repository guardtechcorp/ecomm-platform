<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb"%>
<%@ page import="com.zyzit.weboffice.web.CategoryWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
//bean.showAllParameters(request, out);
//  String sAction = request.getParameter("action");
  String sAction = ProductWeb.getRealAction(request);
  String sDisplayMessage = null;
  String sClass = "failed";

  if ("Quick Search".equalsIgnoreCase(sAction)) //Search Now
  {
      sDisplayMessage = "Your qurey did not find any product. Please try another search.";
/*Neil00
    ProductWeb product = new ProductWeb(session, request, 10);
    List ltArray = product.quickSearch(request);
    if (ltArray==null || ltArray.size()==0)
      sDisplayMessage = "Your qurey did not find any product. Please try another search.";
    else
    {
//      response.sendRedirect("index.jsp?action=searchproduct&categoryid=-13");
       response.sendRedirect(product.encodedUrl("index.jsp?action=showproducts&categoryid=-13"));
    }
*/
  }
  else if ("Advance Search".equalsIgnoreCase(sAction)) //Search Now
  {
     sDisplayMessage = "Your qurey did not find any product. Please try another search.";
/*Neil00
     ProductWeb product = new ProductWeb(session, request, 10);
     List ltArray = product.advancedSearch(request);
     if (ltArray==null || ltArray.size()==0)
       sDisplayMessage = "Your qurey did not find any product. Please try another search.";
     else
     {
//       response.sendRedirect("index.jsp?action=searchproduct&categoryid=-13");
       response.sendRedirect(product.encodedUrl("index.jsp?action=showproducts&categoryid=-13"));
     }
*/
  }

  CategoryWeb web = new CategoryWeb(session, request, 10);
  ConfigInfo cfInfo = web.getConfigInfo();
%>
<script language = "JavaScript">
<%=web.getAllSubCategories()%>
function OnCategoryChange(form)
{
    form.subcategory.length = 0;
    form.subcategory.options[form.subcategory.length] = new Option("Select sub-category", "-1");

    var Reference = form.category.options[form.category.selectedIndex].value;
    var i;
    for (i=0; i<subcat.length; i++)
    {
      if (subcat[i][0] == Reference)
         form.subcategory.options[form.subcategory.length] = new Option(subcat[i][1], subcat[i][2]);
    }
}
</script>
<table cellspacing=0 cellpadding=5 width="100%" align="center" valign="top"  bgcolor="<%=cfInfo.BackColor%>" height="100%">
<form name="advancesearch" action="<%=web.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateAdvancedSearch(this);">
<input type="hidden" name="categoryid" value="-13">
<input type="hidden" name="action1" value="">
    <TR>
      <TD height=5></TD>
    </TR>
    <TR>
      <TD align="center"><b><font size="4" Color="#4279bd" face="Verdana, Arial, Helvetica, sans-serif"><%=web.getLabelText(cfInfo, "advsearch-tit")%></font></b></TD>
    </TR>
<% if (sDisplayMessage!=null) { %>
    <TR>
      <TD height=20 align="center"><b><span class="failed"><%=sDisplayMessage%></span></b></TD>
    </TR>
<% } %>
    <TR>
      <TD valign="top">
        <table style="BORDER-COLLAPSE: collapse" bordercolor="#cccccc" cellspacing=0 cellpadding=5 align="center" border=1>
          <tr valign="middle">
            <td align="right" width=20% height=30><%=web.getLabelText(cfInfo, "productcat-lab")%></td>
            <td width=80% height=30><%=web.getLabelText(cfInfo, "category-lab")%>
              <select size=1 name="category" onChange="OnCategoryChange(document.advancesearch);">
                <option value="-1" selected><%=web.getLabelText(cfInfo, "selectcat-lab")%></option>
                <%=web.getCategoryOptions()%>
              </select>
              <br>Sub-Category:
              <select name="subcategory">
                <option value="-1" selected><%=web.getLabelText(cfInfo, "selectsub-lab")%></option>
              </select>
            </td>
          </tr>
          <tr valign="middle">
            <td align="right" height=28 width="20%"><%=web.getLabelText(cfInfo, "pricerange-lab")%></td>
            <td height=28 width="80%"><%=web.getLabelText(cfInfo, "from-lab")%>
            <input name="price_from" maxlength=20 size=7 onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>&nbsp;&nbsp;&nbsp;<%=web.getLabelText(cfInfo, "to-lab")%>
            <input name="price_to" maxlength=20 size=7 onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
            </td>
          </tr>
          <tr valign="middle">
            <td align="right" height=10 width="20%"><%=web.getLabelText(cfInfo, "productname-lab")%></td>
            <td height=10 width="80%"><input name="productname" maxlength=30 size=30 value='<%=Utilities.getUnicode(Utilities.getValue(request.getParameter("productname")))%>'></td>
          </tr>
          <tr valign="middle">
           <td align="right" height=10 width="20%"><%="Product Code"%>: </td>
           <td height=10 width="80%"><input name="productcode" maxlength=30 size=30 value='<%=Utilities.getUnicode(Utilities.getValue(request.getParameter("productcode")))%>'></td>
          </tr>
          <tr valign="middle">
           <td align="right" height=10 width="20%"><%="Author"%>: </td>
           <td height=10 width="80%"><input name="authorname" maxlength=30 size=30 value='<%=Utilities.getValue(request.getParameter("authorname"))%>'></td>
          </tr>
          <tr valign="middle"> <td align="right" height=35 width="20%"><%=web.getLabelText(cfInfo, "sortfield-lab")%></td>
            <td height=35 width="80%">
              <input type="radio" value="CreateDate" name="sortfield" CHECKED><%=web.getLabelText(cfInfo, "adddatesort-lab")%>
              <input type="radio" value="VisitTime" name="sortfield"><%=web.getLabelText(cfInfo, "visittime-lab")%>
              <input type="radio" value="Price" name="sortfield"><%=web.getLabelText(cfInfo, "productprice-lab")%>
            </td>
          </tr>
          <tr valign="middle">
            <td align="right" height=30 width="20%"><%=web.getLabelText(cfInfo, "sort-lab")%></td>
            <td height=30 width="80%">
              <input type="radio" value="desc" name="sortorder" CHECKED><%=web.getLabelText(cfInfo, "descend-lab")%>
              <input type="radio" value="asc" name="sortorder"><%=web.getLabelText(cfInfo, "ascend-lab")%>
            </td>
          </tr>
          <tr valign="middle">
            <td align="center" colspan=2 height=30><br><input type="submit" value="<%=web.getLabelText(cfInfo, "searchnow-lab")%>" name="submit" onClick="setAction(document.advancesearch, 'Advance Search');"><br>&nbsp;</td>
          </tr>
          <tr valign="middle">
            <td bgcolor="#fff8e1" align="center" colspan=2><br>
                <p align="center"><font size="4"><%=web.getLabelText(cfInfo, "instruction-lab")%></font></p>
                <div align="left">
                <p><img height=17 src="/staticfile/web/images/tp06.gif" width=17 align="CENTER"> <u><b><%=web.getLabelText(cfInfo, "productsearch-lab")%></b></u><br>
                  <%=web.getLabelText(cfInfo, "productsearch-des")%></p>
                <p><img height=17 src="/staticfile/web/images/tp06.gif" width=17 align=CENTER> <u><b><%=web.getLabelText(cfInfo, "advsearch-lab")%></b></u><br>
                  <%=web.getLabelText(cfInfo, "advsearch-des")%></p>
                </div>
            </td>
          </tr>
        </table>
      </TD>
    </TR>
 </form>
</TABLE>
<% } %>