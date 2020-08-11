<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.web.CategoryWeb"%>
<%@ page import="com.zyzit.weboffice.model.ConfigInfo"%>
<%
{
    CategoryWeb web = new CategoryWeb(session, request, 10);
    if (sRealAction.startsWith("Submit"))
    {
CategoryWeb.dumpAllParameters(request);        
        if (!ret.isSuccess())
        {
           sDisplayMessage = (String)ret.getInfoObject();
           nDisplay = 0;
        }
    }

    sPageTitle = "Buying Leads Search";
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/productsearch.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/customer.js" type="text/javascript"></SCRIPT>
 <form name="form_buyleadsearch" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateBuyLeadSearch(this);">
 <input type="hidden" name="category" value="<%=Utilities.getValue(request.getParameter("category"))%>">
 <input type="hidden" name="rl" value="1">
 <input type="hidden" name="public" value="yes">      
 <input type="hidden" name="action1" value="Submit_BuyLeadSearch">
 <table width="99%" style1="BORDER-COLLAPSE: collapse" bordercolor="#cccccc" cellspacing=0 cellpadding=2 align="center" border=0 style="border: 1px solid #DFDFDF; padding: 10px;">
   <tr>
    <td align="right" height="24" width="18%">Key Words:</td>
    <td><input name="keywords" maxlength=255 size=75 value='<%=Utilities.getValue(request.getParameter("keywords"))%>'> (Separated by comma)
    </td>
   </tr>
   <tr>
    <td align="right" height=24 width="18%">Match Option</td>
    <td valign="top">
     <input type="radio" value="1" name="matchoption" CHECKED>An exact phrase match
     <input type="radio" value="2" name="matchoption">Matches on all words (AND)
     <input type="radio" value="3" name="matchoption">Matches on any words (OR)
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
     <td align="right" hwidth="18%" height=24 >Date Period:</td>
     <td>
     <select name="dateperiod">
      <option value=0>Show All</option>
      <option value=1>Today Only</option>
      <option value=2>Last 2 Days</option>
      <option value=3>Last 3 Days</option>
      <option value=5>Last 5 Days</option>
      <option value=7>Last 7 Days</option>
      <option value=10>Last 10 Days</option>
      <option value=20>Last 20 Days</option>
      <option value=30>Last 30 Days</option>
      <option value=60>Last 2 Months</option>
      <option value=90>Last 3 Months</option>
      <option value=180>Last 6 Months</option>
      <option value=270>Last 9 Months</option>
      <option value=365>Last 12 Months</option>
     </select>
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
     <input type="radio" value="CreateDate" name="sortfield" CHECKED>Lead added date and time
     <input type="radio" value="ViewCount" name="sortfield">Lead visited times
    </td>
   </tr>
   <tr>
    <td align="right" height="24" width="18%">Sort Order:</td>
    <td height=30>
     <input type="radio" value="desc" name="sortorder" CHECKED>Descending
     <input type="radio" value="asc" name="sortorder">Ascending
    </td>
   </tr>
   <tr>
    <td colspan="2"><hr width1="100%" style="border: 1px solid #DFDFDF;"></td>
   </tr>     
   <tr>
    <td align="center" colspan=2 height=24><br><input type="submit" style='width:110px' value="Search Now" name="submit" onClick="setAction(document.form_buyleadsearch, 'Submit_BuyLeadSearch');"><br>&nbsp;</td>
   </tr>
  </table>
  </form>
  <SCRIPT Language="JavaScript">onBuyLeadSearchFormLoad(document.form_buyleadsearch);</SCRIPT>
<% } %>