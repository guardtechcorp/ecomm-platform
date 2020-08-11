 <form id="form_advancemessagesearch" name="form_advancemessagesearch" action="<%=omBean.encodedUrl("index.jsp")%>" method="post" onsubmit="return validateAdvanceMessageSearch(this, document.common_search);">
 <input type="hidden" name="action1" value="Search_OnlineMessageList">
 <input type="hidden" name="accessby" value="<%=wpInfo.AccessMode%>">
 <input type="hidden" name="memberid" value="<%=onInfo.MemberID%>">
 <input type="hidden" name="pid" value="<%=wpInfo.PageID%>">
 <input type="hidden" name="sortedby" value="">
 <table class="table-outline" width="100%" align="center">
   <tr>
     <td colspan="2" align="center"><font size="3"><b><%=mcBean.getLabel("cm-advancesearch")%></b></font></td>
   </tr>
   <tr>
    <td align="right" width="18%"></td>
    <td align="right">(<%=mcBean.getLabel("cm-sepbycomma")%>)</td>
   </tr>
   <tr>
    <td align="right" height="24" width="18%"><%=mcBean.getLabel("as-ontitle")%>:</td>
    <td><input name="titlewords" maxlength=255 size=70 value=""> <%=mcBean.getLabel("cm-or")%></td>
   </tr>
   <tr>
    <td align="right" height="24" width="18%"><%=mcBean.getLabel("as-onurl")%>:</td>
    <td><input name="urlwords" maxlength=255 size=70 value=""> <%=mcBean.getLabel("cm-or")%></td>
   </tr>
   <tr>
    <td align="right" height="24" width="18%"><%=mcBean.getLabel("as-ondesc")%>:</td>
    <td><input name="descriptionwords" maxlength=255 size=70 value=""> <%=mcBean.getLabel("cm-or")%></td>
   </tr>
   <!--tr>
   <input name="titlekeywords" maxlength=255 size=70 value="Enter key word(s) (separated by comma)" onfocus="clearInput(this, 'Enter key word(s) (separated by comma)')" onblur="resetInput(this, 'Enter key word(s) (separated by comma)')">
    <td align="right" height=24 width="18%">Match Option</td>
    <td valign="top">
     <input type="radio" value="1" name="matchoption">An exact phrase match
     <input type="radio" value="2" name="matchoption">Matches on all words (AND)
     <input type="radio" value="3" name="matchoption" checked> (OR)
    </td>
   </tr-->
   <tr>
    <td align="right" height="24" width="18%"><%=mcBean.getLabel("cm-tag")%>:</td>
    <td><input name="tagwords" maxlength=255 size=70 value=""> <%=mcBean.getLabel("cm-or")%></td>
   </tr>
   <!--tr>
    <td align="right" height="24" width="18%">Words on Filename:</td>
    <td><input name="filenamewords" maxlength=255 size=70 value=""> AND</td>
   </tr-->
   <tr>
     <td align="right" width="18%" height=24 ><%=mcBean.getLabel("cm-adddate")%>:</td>
     <td><input name="createdate_from" maxlength=20 size=20 onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' value="">
         -- <input name="createdate_to" maxlength=20 size=20 onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");' value=""> (<%=mcBean.getLabel("as-mdy")%>)
     </td>
   </tr>     
   <!--tr>
       <td align="right" width="18%" height=24 >Create Date:</td>
       <SCRIPT language="JavaScript" src="/staticfile/admin/scripts/calendardateinput.js"></SCRIPT>
       <td><script>DateInput('createdate', true, 'YYYY-MM-DD');</script>
       </td>
   </tr-->
    <tr>
    <td colspan="2" style="border-bottom: 1px solid #DFDFDF;">&nbsp;</td>
   </tr>
   <tr>
    <td colspan="2" height="2"></td>
   </tr>
<!--
   <tr>
    <td align="right" height=24 width="18%">Sorting Field:</td>
    <td >
     <input type="radio" value="Name" name="sortfield">Product name
     <input type="radio" value="CreateDate" name="sortfield" >Product added date
     <input type="radio" value="VisitTime" name="sortfield" >Product visited times
     <input type="radio" value="Price" name="sortfield">Product price
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
-->   
   <tr>
    <td colspan="2">
     <table width="100%">
      <tr>
       <td align="center"><input type="submit" value="<%=mcBean.getLabel("cm-search")%>" name="submit" style='width:110px'></td>
       <td align="center"><input type="button" value="<%=mcBean.getLabel("cm-close")%>" name="close" style='width:110px' onclick="hideAdvancedSearcbBox();"></td>
      </tr>
     </table>
    </td>
   </tr>
   <tr>
     <td colspan="2" height="0"></td>
   </tr>     
  </table>
 </form>