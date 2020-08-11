<%@ include file="../share/header.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/customer.js"></SCRIPT>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.bean.CustomerBean"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo"%>

<h3>E-mail to customers</h3>
<p>Here you can email a message to either all of your users or all users of a
  specific group. To do this, an email will be sent out to the administrative
  email address supplied, with a blind carbon copy sent to all recipients. If
  you are emailing a large group of people please be patient after submitting
  and do not stop the page halfway through. It is normal for a mass emailing to
  take a long time and you will be notified when the script has completed</p>
<form method="post" action="admin_mass_email.php?sid=028a662de1d2764fae8dfd369f11fa92">
  <table cellspacing="1" cellpadding="4" border="0" align="center" class="forumline">
    <tr>
      <th class="thHead" colspan="2">Compose</th>
    </tr>
    <tr>
      <td class="row1" align="right"><b>Recipients</b></td>
      <td class="row2" align="left">
        <select name = "g">
          <option value = "-1">All Users</option>
          <option value = "5">New Group 1</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" align="right"><b>Subject</b></td>
      <td class="row2"><span class="gen">
        <input class="post" type="text" name="subject" size="45" maxlength="100" tabindex="2" value="" />
        </span></td>
    </tr>
    <tr>
      <td class="row1" align="right" valign="top"> <span class="gen"><b>Message</b></span>
      <td class="row2"><span class="gen">
        <textarea name="message" rows="15" cols="35" wrap="virtual" style="width:450px" tabindex="3" class="post"></textarea>
        </span>
    </tr>
    <tr>
      <td class="catBottom" align="center" colspan="2">
        <input type="submit" value="E-mail" name="submit" class="mainoption" />
      </td>
    </tr>
  </table>
</form>
<%@ include file="../share/footer.jsp"%>
