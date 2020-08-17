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
  <div class="advancedFormWrap">
      <h2 class="pageHead"><%=web.getLabelText(cfInfo, "advsearch-tit")%></h2>
<form name="advancesearch" action="<%=web.getHttpLink("index.jsp")%>" method="post" onSubmit="return validateAdvancedSearch(this);">
<input type="hidden" name="categoryid" value="-13">
<input type="hidden" name="action1" value="">


<% if (sDisplayMessage!=null) { %>
      <div class="message"><span class="failed"><%=sDisplayMessage%></span></div>

<% } %>
              <!-- <%=web.getLabelText(cfInfo, "category-lab")%> -->
              <select size=1 name="category" onChange="OnCategoryChange(document.advancesearch);">
                <option value="-1" selected><%=web.getLabelText(cfInfo, "selectcat-lab")%></option>
                <%=web.getCategoryOptions()%>
              </select>
              <br>
              <select name="subcategory">
                <option value="-1" selected><%=web.getLabelText(cfInfo, "selectsub-lab")%></option>
              </select>

            <h5>Price Range<!-- <%=web.getLabelText(cfInfo, "pricerange-lab")%> --></h5>
            <div class="leftFormWrap">
            <label>From <!-- <%=web.getLabelText(cfInfo, "from-lab")%> --></label>
            <input name="price_from" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
            </div>
              <div class="rightFormWrap">
              <label>To<!-- <%=web.getLabelText(cfInfo, "to-lab")%> --></label>
              <input name="price_to" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
              </div>

          <label>Product Name<!-- <%=web.getLabelText(cfInfo, "productname-lab")%> --></label>
          <input name="productname" value='<%=Utilities.getUnicode(Utilities.getValue(request.getParameter("productname")))%>'>


           <label>Product Code</label>
           <input name="productcode" value='<%=Utilities.getUnicode(Utilities.getValue(request.getParameter("productcode")))%>'>

          <label>Author</label>
           <input name="authorname" value='<%=Utilities.getValue(request.getParameter("authorname"))%>'>
<div class="outerRadiosWrap">
          <div class="leftFormWrap">
            <label><%=web.getLabelText(cfInfo, "sortfield-lab")%></label>
            <div class="radioWrap">
              <input type="radio" value="CreateDate" name="sortfield" checked><span><%=web.getLabelText(cfInfo, "adddatesort-lab")%></span>
            </div>
            <div class="radioWrap">
              <input type="radio" value="VisitTime" name="sortfield"><span><%=web.getLabelText(cfInfo, "visittime-lab")%></span>
            </div>
              <div class="radioWrap">
              <input type="radio" value="Price" name="sortfield"><span><%=web.getLabelText(cfInfo, "productprice-lab")%></span>
            </div>
          </div>

          <div class="rightFormWrap">
            <label><%=web.getLabelText(cfInfo, "sort-lab")%></label>
            <div class="radioWrap">
              <input type="radio" value="desc" name="sortorder" CHECKED><%=web.getLabelText(cfInfo, "descend-lab")%>
            </div>
            <div class="radioWrap">
              <input type="radio" value="asc" name="sortorder"><%=web.getLabelText(cfInfo, "ascend-lab")%>
            </div>
        </div>
      </div>
          <input type="submit" value="<%=web.getLabelText(cfInfo, "searchnow-lab")%>" name="submit" onClick="setAction(document.advancesearch, 'Advance Search');">
 </form>
</div>
          <div class="searchInstructions">
                <h4><%=web.getLabelText(cfInfo, "instruction-lab")%></h4>

                <h5><%=web.getLabelText(cfInfo, "productsearch-lab")%></h5>
                  <p><%=web.getLabelText(cfInfo, "productsearch-des")%></p>
                <h5><%=web.getLabelText(cfInfo, "advsearch-lab")%></h5>
                  <p><%=web.getLabelText(cfInfo, "advsearch-des")%></p>
        </div>

<% } %>
