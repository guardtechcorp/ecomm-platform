<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CategoryWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
/*
 // <input class="text" value="Enter keywords (e.g., nurse, sales)" onfocus="clearInput(this, 'Enter keywords (e.g., nurse, sales)')" onblur="resetInput(this, 'Enter keywords (e.g., nurse, sales)')" id="q" name="q" type="text">
 <table width="99%" style1="BORDER-COLLAPSE: collapse" bordercolor="#cccccc" cellspacing=0 cellpadding=2 align="center" border=0 style="border: 1px solid #DFDFDF; padding: 10px;">
*/
    CategoryWeb web = new CategoryWeb(session, request, 10);
    if (sRealAction.startsWith("Quick Search"))
    {
        if (!ret.isSuccess())
        {
           sDisplayMessage = (String)ret.getInfoObject();
           nDisplay = 0;
        }
    }
    else if (sRealAction.startsWith("Advance Search"))
    {
//CategoryWeb.dumpAllParameters(request);        
        if (!ret.isSuccess())
        {
           sDisplayMessage = (String)ret.getInfoObject();
           nDisplay = 0;
        }
    }

    String sSortField = request.getParameter("sortfield");
    if (sSortField==null)
       sSortField = "Name";
    String sMatchOption = request.getParameter("matchoption");
    if (sMatchOption==null)
       sMatchOption = "1";

    String sHint = "Enter keywords (e.g., material,stone)";
    String sKeywordValue = request.getParameter("keywords");
    if (sKeywordValue==null)
       sKeywordValue = sHint;

    sPageTitle = "Advanced Product Search";
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/productsearch.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/customer.js" type="text/javascript"></SCRIPT>

<TABLE cellpadding="1" cellspacing="0" border="0" width="100%">
<TR>
 <TD height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
<TR>
 <TD>
 <form name="form_advancesearch" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateAdvanceSearch(this);">
 <input type="hidden" name="cid" value="5">
 <input type="hidden" name="category" value="<%=Utilities.getValue(request.getParameter("category"))%>">
 <input type="hidden" name="refinedregion" value="<%=Utilities.getValue(request.getParameter("refinedregion"))%>">
 <input type="hidden" name="rl" value="1">
 <input type="hidden" name="pagetitle" value="Search Results">
 <input type="hidden" name="action1" value="Advance Search_Search">
 <table class="table-outline" width="100%" align="center">
   <tr>
    <td align="right" height="24" width="18%">Product Key Word:</td>
    <td><input name="keywords" maxlength=255 size=75 value='<%=sKeywordValue%>' onfocus="clearInput(this, '<%=sHint%>')" onblur="resetInput(this, '<%=sHint%>')">
        (Separated by comma)
    </td>
   </tr>
   <tr>
    <td align="right" height=24 width="18%">Match Option</td>
    <td valign="top">
     <input type="radio" value="1" name="matchoption" <%="1".equalsIgnoreCase(sMatchOption)?"CHECKED":""%>>An exact phrase match
     <input type="radio" value="2" name="matchoption" <%="2".equalsIgnoreCase(sMatchOption)?"CHECKED":""%>>Matches on all words (AND)
     <input type="radio" value="3" name="matchoption" <%="3".equalsIgnoreCase(sMatchOption)?"CHECKED":""%>>Matches on any words (OR)
    </td>
   </tr>
   <tr>
    <td align="right" height=24 width="18%" valign="top">Categories:</td>
    <td >
     <table cellpadding="0" cellspacing="0" border="0">
      <tr>
       <td valign="top">
       <div id="scroll_list" style="width:404px;height:116px;background-color:white;overflow:auto;BORDER: #4279bd 1px solid; ">
        web.getCategoryList(null)
       </div>
       </td>
      </tr>
     </table>
    </td>
   </tr>
   <tr>
    <td align="right" height=24 width="18%" valign='top'>Refine by region:</td>
    <td >
     <table cellpadding="0" cellspacing="0" border="0">
      <tr>
       <td valign="top">
       <div id="scroll_list1" style="width:404px;height:116px;background-color:white;overflow:auto;BORDER: #4279bd 1px solid; ">
       <Script language = "JavaScript">setCountryCheckboxList();</Script>
       </div>
       </td>
      </tr>
     </table>
    </td>
   </tr>
   <tr>
     <td align="right" hwidth="18%" height=24>Price Range:</td>
     <td><input name="price_from" maxlength=20 size=20 onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");' value="<%=Utilities.getValue(request.getParameter("price_from"))%>">
         -- <input name="price_to" maxlength=20 size=20 onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");' value="<%=Utilities.getValue(request.getParameter("price_to"))%>">
     </td>
   </tr>
   <tr>
     <td align="right" hwidth="18%" height=24 >Added Date:</td>
     <td><input name="createdate_from" maxlength=20 size=20 onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' value="<%=Utilities.getValue(request.getParameter("createdate_from"))%>">
         -- <input name="createdate_to" maxlength=20 size=20 onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' value="<%=Utilities.getValue(request.getParameter("createdate_to"))%>"> (MM/DD/YYYY)
     </td>
   </tr>
   <tr>
    <td colspan="2" style="border-bottom: 1px solid #DFDFDF;">&nbsp;</td>
   </tr>
   <tr>
    <td colspan="2" height="6"></td>
   </tr>     
   <tr>
    <td align="right" height=24 width="18%">Sorting Field:</td>
    <td >
     <input type="radio" value="Name" name="sortfield" <%="Name".equalsIgnoreCase(sSortField)?"CHECKED":""%>>Product name
     <input type="radio" value="CreateDate" name="sortfield" <%="CreateDate".equalsIgnoreCase(sSortField)?"CHECKED":""%>>Product added date
     <input type="radio" value="VisitTime" name="sortfield" <%="VisitTime".equalsIgnoreCase(sSortField)?"CHECKED":""%>>Product visited times
     <input type="radio" value="Price" name="sortfield" <%="Price".equalsIgnoreCase(sSortField)?"CHECKED":""%>>Product price
    </td>
   </tr>
   <tr>
    <td align="right" height="24" width="18%">Sort Order:</td>
    <td>
     <input type="radio" value="asc" name="sortorder" <%=!"desc".equalsIgnoreCase(request.getParameter("sortorder"))?"CHECKED":""%>>Ascending
     <input type="radio" value="desc" name="sortorder" <%="desc".equalsIgnoreCase(request.getParameter("sortorder"))?"CHECKED":""%>>Descending
    </td>
   </tr>
   <tr>
    <td colspan="2"><hr width1="100%" style="border: 1px solid #DFDFDF;"></td>
   </tr>
   <tr>
     <td align="right" height="24" width="18%"></td>
     <td align="left">
      <input type="submit" value="Search Now" name="submit" style='width:110px' onClick="setAction(document.form_advancesearch, 'Advance Search_Search');">&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="reset" value="Reset" name="reset" style='width:110px'>
     </td>
   </tr>
  </table>
  </form>
  <!--SCRIPT Language="JavaScript">onAdvanceSearchFormLoad(document.form_advancesearch);</SCRIPT-->     
 </td>
 </tr>
 <tr>
  <td height="10">
 </tr>
 <!--tr>
  <td>
  <table width="99%" align="center" border="0" cellpadding="2" cellspacing="0"  style="border: 1px solid #DFDFDF; background-color:#EFF7FE">
   <tr>
    <td align="center">
    <table>
     <tr>
      <td width=15 valign="top"></td>
       <td align="center"><p align="center"><font color="#FF6633" size="4">Search Instruction</font></p>
       <font size="2" face="Verdana, Arial, Helvetica, sans-serif" color='green'>
       <div align="left">
       <p><u><b>Product Search:</b></u><br>
         Please enter keyword in the product search editbox, for example, if you are looking for "jeans" you enter "jeans" in the product search editbox you will find all product name containing the keyword "jean".
      <br>You can also click Intro in product search box for product introduction search. By entering keyword in the editbox with Intro selected, you will find all the product introduction descriptions containing the keyword you entered.
       </p>
       <p><u><b>Advanced Search:</b></u><br>
       General search is typically referred to as high level search; the advanced search is more powerful search tools for sophisticated users to do more complex search. It allows you to select product class and its associated subclasses and find the products by listing date, or by popularity of the product, or by product price in ascending or descending sort order base upon the sorting preference and the product class you specified.
       </p>
       </div>
       </font>
       </td>
     </tr>
    </table>
    </td>
   </tr>
  </table>
  </td>
 </tr-->
</TABLE>
<% } %>