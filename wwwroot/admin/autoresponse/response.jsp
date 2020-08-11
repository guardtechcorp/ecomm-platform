<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/autoresponse.js"></SCRIPT>
<SCRIPT language="JavaScript" src="/staticfile/admin/scripts/calendardateinput.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.AutoResponseBean"%>
<%@ page import="com.zyzit.weboffice.model.AutoResponseInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.session.UserSession"%>
<%
//bean.showAllParameters(request, out);
  AutoResponseBean bean = new AutoResponseBean(session, 0);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_EMAILCAMPAIGN))
     return;

//bean.showAllParameters(request, out);

  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  AutoResponseInfo info = null;
  if ("Add Autoresponder".equalsIgnoreCase(sAction))
  {
    AutoResponseBean.Result ret = bean.update(request, true);
    if (!ret.isSuccess())
    {
      info = (AutoResponseInfo)ret.getUpdateInfo();
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "Autoresponder");
      response.sendRedirect("responselist.jsp?action=Response List");
    }
  }
  else if ("Update Autoresponder".equalsIgnoreCase(sAction))
  {
//bean.showAllParameters(request, out);
    AutoResponseBean.Result ret = bean.update(request, false);
    info = (AutoResponseInfo)ret.getUpdateInfo();
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Autoresponder");
    }
  }
  else if ("Edit".equalsIgnoreCase(sAction))
  {
    info =  bean.get(request);
    sAction = "Update Autoresponder";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Autoresponder";
  }

  if (info==null)
  {
    DomainInfo dmInfo = bean.getDomainInfo();
    info = AutoResponseInfo.getInstance(true);
    info.FromEmail = "customerservice" + '@' + dmInfo.EmailDomain;
    info.TypeFlag = UserSession.USAGETYPE_SUBSCRIBER;
    info.StartDate = Utilities.getTodayDateTime();
    info.Active = 0;

    info.Start = 0;
    info.MaxSend = 0;
    info.SuccessSend = 0;
    info.FailureSend = 0;
    info.Status = 0;
    info.IntervalHour = Utilities.getInt(bean.getConfigValue("Interval-AutoResponder"), 24);

    sAction = "Add Autoresponder";
  }

  String sReturn = request.getParameter("return");
  String sDisplay = request.getParameter("display");

  String sHelpTag = "autoresponse";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Autoresponder".equalsIgnoreCase(sAction))
  {
//     sTitleLinks += "<a href=\"responselist.jsp?action=Response List\">Autoresponder Group List</a> > <b>Add a New Autoresponder</b>";
     sTitleLinks = bean.getNavigation(request, "Add a New Autoresponder");
     sDescription = "The form below will allow you to add a new auto-response group.";
  }
  else
  {
//     sTitleLinks += "<a href=\"responselist.jsp?action=Response List\">Autoresponder Group List</a> > <b>Edit the Autoresponder Group</b>";
     sTitleLinks = bean.getNavigation(request, "Edit the Autoresponder Group");
     sDescription = "The form below will allow you to edit & update the auto-response information.";
  }
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<form name="responseform" action="response.jsp" method="post" onsubmit="return validateResponseForm(this);">
<input type="hidden" name="autoid" value="<%=info.AutoID%>">
<!--input type="hidden" name="startdate" value="<%=info.StartDate%>"-->
<% if (info.AutoID>=0) { %>
<table width="100%" cellpadding="2" cellspacing="0" border="0" align="center">
  <tr>
    <td width="30%"><!--a href="passagelist.jsp?action=Passage List&sectionid=<%=info.AutoID%>">Passage List</a--></td>
    <td align="right"><%=bean.getPrevNextLinks("response.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="100%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="2">Autoresponder Information</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr class="normal_row">
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="12%" align="right">Name*:</td>
      <td class="row1">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="128" style="width: 400px;"> The name of E-Mail campaign of autoresponder.
      </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Send E-Mail To:</td>
      <td class="row1">
<% if (bean.hasAccessRole(AccessRole.ROLE_CUSTOMER)) { %>
       <input type="radio" name="typeflag" value="2" <%=info.TypeFlag==2?"checked":""%> onClick="javascript:onToListChange('EMAIL_LIST', false);">Customers
       <input type="radio" name="typeflag" value="256" <%=info.TypeFlag==256?"checked":""%>>Subscribers
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_MEMBERS)) { %>
       <input type="radio" name="typeflag" value="8" <%=info.TypeFlag==8?"checked":""%>>Members
<% } %>
<% if (bean.hasAccessRole(AccessRole.ROLE_COMMUNITY)) { %>
       <input type="radio" name="typeflag" value="512" <%=info.TypeFlag==512?"checked":""%> onClick="javascript:onToListChange('NEWSLETTER_LIST', false);">Community Members
       <input type="radio" name="typeflag" value="2048" <%=info.TypeFlag==2048?"checked":""%> onClick="javascript:onToListChange('NEWSLETTER_LIST', false);">Community Club
       <input type="radio" name="typeflag" value="256" <%=info.TypeFlag==256?"checked":""%> onClick="javascript:onToListChange('NEWSLETTER_LIST', true);">Mail List
<% } %>
<% if ("www.omniserve.com".equalsIgnoreCase(bean.getDomainName())) { %>
       <input type="radio" name="typeflag" value="1024" <%=info.TypeFlag==1024?"checked":""%> onClick="javascript:onToListChange('NEWSLETTER_LIST', false);">Promotion Users
<% } %>
      </td>
    </tr>
   <tr>
     <td colspan=2 class="row1">
      <DIV id="NEWSLETTER_LIST" style="DISPLAY: <%=info.TypeFlag==256?"inline":"none"%>">
       <table width="100%" cellpadding="1" cellspacing="1" border="0">
        <tr>
         <td class="row1" width="12%" align="right">Mail List Group:</td>
         <td class="row1" valign="top">
           <select name="maillistid">
             <option value="-1">[Select One of Groups]</option>
             <%=bean.getGroupList(info.MailListID)%>
           </select>
         </td>
        </tr>
      </table>
     </DIV>
     <DIV id="EMAIL_LIST" <%if(info.TypeFlag!=4096){%>style="DISPLAY: none"><%}%>>
      <table width="100%" cellpadding="1" cellspacing="1" border="0">
       <tr>
        <td class="row1" width="12%" align="right">Mail List:</td>
        <td class="row1" valign="top">
         <textarea rows="3" cols="50" wrap="virtual" name="emaillist"><%=Utilities.getValue(info.EmailList)%></textarea>The email address list separated by comma.
        </td>
       </tr>
     </table>
    </DIV>
    </td>
   </tr>
   <tr>
      <td class="row1" width="12%" align="right">Email From:</td>
      <td class="row1">
        <input type="text" name="fromemail" value="<%=Utilities.getValue(info.FromEmail)%>" maxlength="60" style="width: 400px;"> The from E-Mail address of email message.
      </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Email also To:</td>
      <td class="row1">
        <input type="text" name="toemail" value="<%=Utilities.getValue(info.ToEmail)%>" maxlength="60" style="width: 400px;"> A test E-Mail address to which the autoresponder will send in each time with other recipients. It is optional.
      </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Max Number:</td>
      <td class="row1">
        <input type="text" name="maxsend" value="<%=Utilities.getValue(info.MaxSend)%>" maxlength="10" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'> The max mails that will send to each time. If it is less than 1, no limit is apply.
      </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Interval Hours</td>
      <td class="row1">
        <input type="text" name="intervalhour" value="<%=Utilities.getValue(info.IntervalHour)%>" maxlength="10" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'> The interval hours of repeat/loop to send mails. It must be greater than 0.
      </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Send Type:</td>
      <td class="row1">
        <select name="jobtype">
          <option value=0 <%=bean.getSelected(0, info.JobType)%>>Send Once</option>
          <option value=1 <%=bean.getSelected(1, info.JobType)%>>Repeat Send</option>
          <option value=2 <%=bean.getSelected(2, info.JobType)%>>Send Multiple letters</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Start Date:</td>
      <td class="row1">
       <table>
         <tr>
          <td><script>DateInput('startdate', true, 'YYYY-MM-DD', '<%=Utilities.getDateValue(info.StartDate, 10)%>')</script></td>
          <td><input type="text" name="hour" value="<%=bean.getHour(info.StartDate)%>" size=2 maxlength="2" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>:
              <input type="text" name="minute" value="<%=bean.getMinute(info.StartDate)%>" size=2 maxlength="2" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'> (HH:MM)
              The start date and time of Autoresponder.</td>
         </tr>
      </table>
     </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right">Started:</td>
      <td class="row1">
        <select name="active">
          <option value=1 <%=bean.getSelected(1, info.Active)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
        </select> If selects 'No', the autoresponder will stop sending this email campaign messages.
      </td>
    </tr>
    <tr>
      <td class="row1" width="12%" align="right"></td>
      <td class="row1"><input type="checkbox" name="resetit" value="yes"> Reset it and clear all the old records.</td>
    </tr>    
    <tr>
      <td class="row1" width="10%" align="right" height=20>Send Status:</td>
      <td class="row1"> <b><%=info.Status==0?"Send in progress":"Finished"%></b> (<b><%=info.SuccessSend+info.FailureSend%></b> were sent so far and <b><%=info.SuccessSend%></b> were successful and <b><%=info.FailureSend%></b> were failed).
      </td>
    </tr>
    <TR class="normal_row">
      <TD colSpan=2 height=5></TD>
    </TR>
  <tr>
    <td class="catBottom" colspan="2" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
  </tr>
  </table>
</form>
<SCRIPT>onResponseFormLoad(document.responseform);</SCRIPT>
<%@ include file="../share/footer.jsp"%>