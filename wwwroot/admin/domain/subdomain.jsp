<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name='GENERATOR' content='Web Online Management from KZ Company'>
<title>Sub-Domain Registration Form</title>
</head>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/common.js"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/subdomain.js"></SCRIPT>
<body>
<%@ page import="com.zyzit.weboffice.model.CompanyInfo"%>
<%@ page import="com.zyzit.weboffice.model.DomainInfo"%>
<%@ page import="com.zyzit.weboffice.bean.DomainBean"%>
<%@ page import="com.zyzit.weboffice.util.Utilities"%>
<%@ page import="com.zyzit.weboffice.util.Errors"%>
<%
  DomainBean bean = new DomainBean(session, 20);
//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "failed";
  DomainInfo dmInfo = null;
  CompanyInfo cpInfo = null;
  boolean bRegister = false;
  if ("Submit Now".equalsIgnoreCase(sAction))
  {
// bean.dumpAllParameters(request);
    DomainBean.Result ret = bean.freeSignup(request, null);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
    }
    else
    {
      bRegister = true;
      sClass = "successful";
      sDisplayMessage = "It is successfully to register your domain.";

      Object[] arInfo = (Object[])ret.getUpdateInfo();
      dmInfo = (DomainInfo)arInfo[0];
      cpInfo = (CompanyInfo)arInfo[1];
    }
  }
  if (dmInfo==null)
  {
    dmInfo = DomainInfo.getInstance(true);
    cpInfo = CompanyInfo.getInstance(true);
    cpInfo.Country = "USA";
  }

  String sDomainName = request.getHeader("x-forwarded-host");
  int nIndex = sDomainName.indexOf(".");
  String sSiteName = sDomainName.substring(0, nIndex);
%>
<% if (!bRegister) { %>
<form name="subdomain" method="post" action="#" onSubmit="return validateSubdomain(this, 'omniserve.com');">
<input type="hidden" name="domainname" value="member.omniserve.com">
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
<% if (sDisplayMessage!=null) { %>
  <tr>
    <td colspan="3" align="center"><Font color="red"><%=sDisplayMessage%></Font></td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
<% } %>
  <tr>
    <td width="25%" align="right">Your Domain Name:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=22 name="sitename" value="<%=Utilities.getValue(sSiteName)%>"><b>.omniserve.com</b></td>
  </tr>
  <tr>
    <td width="25%" align="right">Your Name:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=40 size=40 name="yourname" value="<%=Utilities.getValue(request.getParameter("yourname"))%>"></td>
  </tr>
  <tr>
    <td width="25%" align="right">Phone Number:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=20 size=40 name="phone" value="<%=Utilities.getValue(request.getParameter("phone"))%>"></td>
  </tr>
  <tr>
    <td width="25%" align="right">E-Mail:</td>
    <td width="1%">&nbsp;</td>
    <td><input maxlength=60 size=40 name="email" value="<%=Utilities.getValue(request.getParameter("email"))%>"> (Current active E-Mail)</td>
  </tr>
  <tr>
    <td width="25%" align="right" valign="top">Enter the code shown below:</td>
    <td width="1%">&nbsp;</td>
    <td valign="top">
     <input maxlength=20 size=20 name="input">&nbsp;This will prevent automated registrations. <a href="javascript:ChildWin=window.open('/staticfile/web/imagecode-help.html','imagecode_help','resizable=yes,scrollbars=no,width=460,height=450');ChildWin.focus()">Help</a>
     <br><img name="captchaimg" src="../util/captcha.jsp?action=getimage" align="top" alt="Enter the characters appearing in this image" border="1"/>
    </td>
  </tr>
  <tr>
    <td height="5" colspan="3"></td>
  </tr>
  <tr>
    <td width="25%" align="right" valign="top">Terms of Service:</td>
    <td width="1%"></td>
    <td><TEXTAREA name="textarea" cols="255" rows="6" wrap="virtual" style="width:440px">OmniServe.com Terms of Use Agreement
Welcome to Omniserve.com, a personal web portal and social networking service that allows members to create personal profiles online and find and communicate with other members. The services offered by Omniserve.com ("Omniserve.com" or "we") include the Omniserve.com website (the "OmniServe Website"), the OmniServe client program, and any other features, content, or applications offered from time to time by Omniserve.com (collectively, the "OmniServe Services").
This Terms of Use Agreement ("Agreement") sets forth the legally binding terms for your use of the OmniServe Services. By using the OmniServe Services, you agree to be bound by this Agreement, whether you are a "Visitor" (which means that you simply browse the OmniServe Website) or you are a "Member" (which means that you have registered with Omniserve.com). The term "User" refers to a Visitor or a Member. You are only authorized to use the OmniServe Services (regardless of whether your access or use is intended) if you agree to abide by all applicable laws and to this Agreement. Please read this Agreement carefully and save it. If you do not agree with it, you should leave the OmniServe Website and discontinue use of the OmniServe Services immediately. If you wish to become a Member, communicate with other Members and make use of the OmniServe Services, you must read this Agreement and indicate your acceptance during the Registration process.
This Agreement includes Omniserve.com's policy for acceptable use of the OmniServe Services and Content posted on the OmniServe Website, your rights, obligations and restrictions regarding your use of the OmniServe Services and Omniserve.com's Privacy Policy. In order to participate in certain OmniServe Services, you may be notified that you are required to download software or content and/or agree to additional terms and conditions. Unless otherwise provided by the additional terms and conditions applicable to the OmniServe Services in which you choose to participate, those additional terms are hereby incorporated into this Agreement. You may receive a copy of this Agreement by emailing us at: info@omniserve.com, Subject: Terms of Use Agreement.
Omniserve.com may modify this Agreement from time to time and such modification shall be effective upon posting by Omniserve.com on the OmniServe Website. You agree to be bound to any changes to this Agreement when you use the OmniServe Services after any such modification is posted. It is therefore important that you review this Agreement regularly to ensure you are updated as to any changes.
Please choose carefully the information you post on Omniserve.com and that you provide to other Users. Your Omniserve.com profile may not include the following items: telephone numbers, street addresses, last names, and any photographs containing nudity, or obscene, lewd, excessively violent, harassing, sexually explicit or otherwise objectionable subject matter. Despite this prohibition, information provided by other Omniserve.com Members (for instance, in their Profile) may contain inaccurate, inappropriate, offensive or sexually explicit material, products or services, and Omniserve.com assumes no responsibility or liability for this material.
Omniserve.com reserves the right, in its sole discretion, to reject, refuse to post or remove any posting (including private messages) by you, or to restrict, suspend, or terminate your access to all or any part of the OmniServe Services at any time, for any or no reason, with or without prior notice, and without liability.
1. Eligibility. Use of and Membership in the OmniServe Services is void where prohibited. By using the OmniServe Services, you represent and warrant that (a) all registration information you submit is truthful and accurate; (b) you will maintain the accuracy of such information; (c) you are 16 years of age or older; and (d) your use of the OmniServe Services does not violate any applicable law or regulation. Your profile may be deleted and your Membership may be terminated without warning, if we believe that you are under 16 years of age.
2. Term. This Agreement shall remain in full force and effect while you use the OmniServe Services or are a Member. You may terminate your Membership at any time, for any reason, by following the instructions on the Member's My Account page. OmniServe.com may terminate your Membership at any time, without warning.
3. Non-commercial Use by Members. The OmniServe Services are for the personal use of Members only and may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by Omniserve.com. Illegal and/or unauthorized use of the OmniServe Services, including collecting usernames and/or email addresses of Members by electronic or other means for the purpose of sending unsolicited email or unauthorized framing of or linking to the OmniServe Website is prohibited. Commercial advertisements, affiliate links, and other forms of solicitation may be removed from Member profiles without notice and may result in termination of Membership privileges. Appropriate legal action will be taken for any illegal or unauthorized use of the OmniServe Services.
4. Proprietary Rights in Content on Omniserve.com.
a) Omniserve.com does not claim any ownership rights in the text, files, images, photos, video, sounds, musical works, works of authorship, or any other materials (collectively, "Content") that you post to the OmniServe Services. After posting your Content to the OmniServe Services, you continue to retain all ownership rights in such Content, and you continue to have the right to use your Content in any way you choose. By displaying or publishing ("posting") any Content on or through the OmniServe Services, you hereby grant to Omniserve.com a limited license to use, modify, publicly perform, publicly display, reproduce, and distribute such Content solely on and through the OmniServe Services.
b) You represent and warrant that: (i) you own the Content posted by you on or through the OmniServe Services or otherwise have the right to grant the license set forth in this section, and (ii) the posting of your Content on or through the OmniServe Services does not violate the privacy rights, publicity rights, copyrights, contract rights or any other rights of any person. You agree to pay for all royalties, fees, and any other monies owing any person by reason of any Content posted by you to or through the OmniServe Services.
5. Content Posted.
a) Omniserve.com may delete any Content that in the sole judgment of Omniserve.com violates this Agreement or which may be offensive, illegal or violate the rights, harm, or threaten the safety of any person. Omniserve.com assumes no responsibility for monitoring the OmniServe Services for inappropriate Content or conduct. If at any time Omniserve.com chooses, in its sole discretion, to monitor the OmniServe Services, Omniserve.com nonetheless assumes no responsibility for the Content, no obligation to modify or remove any inappropriate Content, and no responsibility for the conduct of the User submitting any such Content.
b) You are solely responsible for the Content that you post on or through any of the OmniServe Services, and any material or information that you transmit to other Members and for your interactions with other Users. Omniserve.com does not endorse and has no control over the Content. Content is not necessarily reviewed by Omniserve.com prior to posting and does not necessarily reflect the opinions or policies of Omniserve.com. Omniserve.com makes no warranties, express or implied, as to the Content or to the accuracy and reliability of the Content or any material or information that you transmit to other Members.
6. Content/Activity Prohibited. The following is a partial list of the kind of Content that is illegal or prohibited to post on or through the OmniServe Services. Omniserve.com reserves the right to investigate and take appropriate legal action against anyone who, in Omniserve.com's sole discretion, violates this provision, including without limitation, removing the offending communication from the OmniServe Services and terminating the Membership of such violators. Prohibited Content includes, but is not limited to Content that, in the sole discretion of Omniserve.com:
a) is patently offensive and promotes racism, bigotry, hatred or physical harm of any kind against any group or individual;
b) harasses or advocates harassment of another person;
c) exploits people in a sexual or violent manner;
d) contains nudity, violence, or offensive subject matter or contains a link to an adult website;
e) solicits personal information from anyone under 18;
f) provides any telephone numbers, street addresses, last names, URLs or email addresses;
g) promotes information that you know is false or misleading or promotes illegal activities or conduct that is abusive, threatening, obscene, defamatory or libelous;
h) promotes an illegal or unauthorized copy of another person's copyrighted work, such as providing pirated computer programs or links to them, providing information to circumvent manufacture-installed copy-protect devices, or providing pirated music or links to pirated music files;
i) involves the transmission of "junk mail," "chain letters," or unsolicited mass mailing, instant messaging, "spimming," or "spamming";
j) contains restricted or password only access pages or hidden pages or images (those not linked to or from another accessible page);
k) furthers or promotes any criminal activity or enterprise or provides instructional information about illegal activities including, but not limited to making or buying illegal weapons, violating someone's privacy, or providing or creating computer viruses;
l) solicits passwords or personal identifying information for commercial or unlawful purposes from other Users;
m) involves commercial activities and/or sales without our prior written consent such as contests, sweepstakes, barter, advertising, or pyramid schemes;
n) includes a photograph of another person that you have posted without that person's consent; or
o) for band and filmmaker profiles, uses sexually suggestive imagery or any other unfair, misleading or deceptive Content intended to draw traffic to the profile.

The following is a partial list of the kind of activity that is illegal or prohibited on the OmniServe Website and through your use of the OmniServe Services. OmniServe.com reserves the right to investigate and take appropriate legal action against anyone who, in Omniserve.com's sole discretion, violates this provision, including without limitation, reporting you to law enforcement authorities. Prohibited activity includes, but is not limited to:

p) criminal or tortious activity, including child pornography, fraud, trafficking in obscene material, drug dealing, gambling, harassment, stalking, spamming, spimming, sending of viruses or other harmful files, copyright infringement, patent infringement, or theft of trade secrets;
q) advertising to, or solicitation of, any Member to buy or sell any products or services through the OmniServe Services. You may not transmit any chain letters or junk email to other Members. It is also a violation of these rules to use any information obtained from the OmniServe Services in order to contact, advertise to, solicit, or sell to any Member without their prior explicit consent. In order to protect our Members from such advertising or solicitation, Omniserve.com reserves the right to restrict the number of emails which a Member may send to other Members in any 24-hour period to a number which Omniserve.com deems appropriate in its sole discretion. If you breach this Agreement and send unsolicited bulk email, instant messages or other unsolicited communications of any kind through the OmniServe Services, you acknowledge that you will have caused substantial harm to Omniserve.com, but that the amount of such harm would be extremely difficult to ascertain.
r) covering or obscuring the banner advertisements on your personal profile page, or any Omniserve.com page via HTML/CSS or any other means;
s) any automated use of the system, such as using scripts to add friends or send comments or messages;
t) interfering with, disrupting, or creating an undue burden on the OmniServe Services or the networks or services connected to the OmniServe Services;
u) attempting to impersonate another Member or person;
v) using the account, username, or password of another Member at any time or disclosing your password to any third party or permitting any third party to access your account;
w) selling or otherwise transferring your profile;
x) using any information obtained from the OmniServe Services in order to harass, abuse, or harm another person;

7. Copyright Policy. You may not post, modify, distribute, or reproduce in any way any copyrighted material, trademarks, or other proprietary information belonging to others without obtaining the prior written consent of the owner of such proprietary rights. It is the policy of Omniserve.com to terminate Membership privileges of any Member who repeatedly infringes the copyright rights of others upon receipt of prompt notification to Omniserve.com by the copyright owner or the copyright owner's legal agent.
8. Member Disputes. You are solely responsible for your interactions with other Omniserve.com Members. Omniserve.com reserves the right, but has no obligation, to monitor disputes between you and other Members.
9. Privacy. Use of the OmniServe Services is also governed by our Privacy Policy, which is incorporated into this Agreement by this reference.
10. Disclaimers. OmniServe.com is not responsible for any incorrect or inaccurate Content posted on the OmniServe Website or in connection with the OmniServe Services, whether caused by Users of the OmniServe Services or by any of the equipment or programming associated with or utilized in the OmniServe Services. Profiles created and posted by Members on the OmniServe Website may contain links to other websites. Omniserve.com is not responsible for the Content, accuracy or opinions expressed on such websites, and such websites are in no way investigated, monitored or checked for accuracy or completeness by Omniserve.com. Inclusion of any linked website on the OmniServe Services does not imply approval or endorsement of the linked website by Omniserve.com. When you access these third-party sites, you do so at your own risk. Omniserve.com takes no responsibility for third party advertisements which are posted on this OmniServe Website or through the OmniServe Services, nor does it take any responsibility for the goods or services provided by its advertisers. Omniserve.com is not responsible for the conduct, whether online or offline, of any User of the OmniServe Services. Omniserve.com assumes no responsibility for any error, omission, interruption, deletion, defect, delay in operation or transmission, communications line failure, theft or destruction or unauthorized access to, or alteration of, any User or Member communication. Omniserve.com is not responsible for any problems or technical malfunction of any telephone network or lines, computer online systems, servers or providers, computer equipment, software, failure of any email or players due to technical problems or traffic congestion on the Internet or on any of the OmniServe Services or combination thereof, including any injury or damage to Users or to any person's computer related to or resulting from participation or downloading materials in connection with the OmniServe Services. Under no circumstances shall Omniserve.com be responsible for any loss or damage, including personal injury or death, resulting from use of the OmniServe Services, attendance at a Omniserve.com event, from any Content posted on or through the OmniServe Services, or from the conduct of any Users of the OmniServe Services, whether online or offline. The OmniServe Services are provided "AS-IS" and as available and Omniserve.com expressly disclaims any warranty of fitness for a particular purpose or non-infringement. Omniserve.com cannot guarantee and does not promise any specific results from use of the OmniServe Services.
11. Limitation on Liability. IN NO EVENT SHALL OMNISERVE.COM BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY INDIRECT, CONSEQUENTIAL, EXEMPLARY, INCIDENTAL, SPECIAL OR PUNITIVE DAMAGES, INCLUDING LOST PROFIT DAMAGES ARISING FROM YOUR USE OF THE SERVICES, EVEN IF OMNISERVE.COM HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. NOTWITHSTANDING ANYTHING TO THE CONTRARY CONTAINED HEREIN, OMNISERVE.COM'S LIABILITY TO YOU FOR ANY CAUSE WHATSOEVER AND REGARDLESS OF THE FORM OF THE ACTION, WILL AT ALL TIMES BE LIMITED TO THE AMOUNT PAID, IF ANY, BY YOU TO OMNISERVE.COM FOR THE OMNISERVE SERVICES DURING THE TERM OF MEMBERSHIP.
12. Disputes. If there is any dispute about or involving the OmniServe Services, you agree that the dispute shall be governed by the laws of the State of California, USA, without regard to conflict of law provisions and you agree to exclusive personal jurisdiction and venue in the state and federal courts of the United States located in the State of California, City of Los Angeles. Either Omniserve.com or you may demand that any dispute between Omniserve.com and you about or involving the OmniServe Services must be settled by arbitration utilizing the dispute resolution procedures of the American Arbitration Association (AAA) in Los Angeles, California, USA, provided that the foregoing shall not prevent Omniserve.com from seeking injunctive relief in a court of competent jurisdiction.
13. Indemnity. You agree to indemnify and hold Omniserve.com, its subsidiaries, and affiliates, and their respective officers, agents, partners and employees, harmless from any loss, liability, claim, or demand, including reasonable attorneys' fees, made by any third party due to or arising out of your use of the OmniServe Services in violation of this Agreement and/or arising from a breach of this Agreement and/or any breach of your representations and warranties set forth above and/or if any Content that you post on the OmniServe Website or through the OmniServe Services causes Omniserve.com to be liable to another.
14. Other. This Agreement is accepted upon your use of the OmniServe Website or any of the OmniServe Services and is further affirmed by you becoming a Member. This Agreement constitutes the entire agreement between you and Omniserve.com regarding the use of the OmniServe Services. The failure of Omniserve.com to exercise or enforce any right or provision of this Agreement shall not operate as a waiver of such right or provision. The section titles in this Agreement are for convenience only and have no legal or contractual effect. If any provision of this Agreement is unlawful, void or unenforceable, that provision is deemed severable from this Agreement and does not affect the validity and enforceability of any remaining provisions.
Please contact us at info@omniserve.com with any questions regarding this Agreement.
I HAVE READ THIS AGREEMENT AND AGREE TO ALL OF THE PROVISIONS CONTAINED ABOVE.</TEXTAREA></td>
    <td></td>
  </tr>
  <tr>
    <td width="25%" align="right" ><input type="checkbox" name="agreeto" value="0"></td>
    <td width="1%"></td>
    <td>I agree to the terms of service.</td>
    <td></td>
  </tr>
  <tr>
    <td colspan="3" height="10"></td>
  </tr>
  <tr>
    <td width="25%">&nbsp;</td>
    <td width="1%">&nbsp;</td>
    <td ><input type="submit" name="action" value="Submit Now"></td>
  </tr>
</table>
</form>
<SCRIPT>onSubdomainLoad(document.subdomain);</SCRIPT>
<% } else { %>
<table cellspacing=0 cellpadding=0 width="100%" align="center" border=0>
  <tr>
    <td colspan="3" height="5" align="center"></td>
  </tr>
  <tr>
    <td width="5%"></td>
    <td width="90%">
Congratulations!!! You have successfully signed up a free test website and online store.<br>
Your test website and online store is open now and will be closed in 30 days.<br>
You can visit your website at: <a href="http://<%=dmInfo.DomainName%>" target="_blank">http://<%=dmInfo.DomainName%></a>.
<p>
You can login your admin account to set up and manage your web site any time from anywhere.<br>
Your administration console URL is: <a href="http://<%=dmInfo.DomainName%>/console" target="_blank">http://<%=dmInfo.DomainName%>/console</a><br>
Your username is: <b>admin</b><br>
Your password is: <b><%=cpInfo.Password%></b></p>
<p>
Your email account was also created and you can send and receive email by using a web browser.<br>
Your email box address (URL) is: <a href="http://<%=dmInfo.DomainName%>/webmail" target="_blank">http://<%=dmInfo.DomainName%>/webmail</a><br>
Your UserID is: <b>admin@<%=dmInfo.EmailDomain%></b><br>
Your Password is: <b><%=cpInfo.Password%></b> (the same as admin account of your website)</p>
<p>
The six company forwarding email addresses were also generated. They will automatically forward to
<b>admin@<%=dmInfo.EmailDomain%></b> at first. You can reassign each of them to other employees of your company
later. The six forwarding emails are:<br>
   <b>1. customerservice@<%=dmInfo.EmailDomain%></b><br>
   <b>2. sales@<%=dmInfo.EmailDomain%></b><br>
   <b>3. support@<%=dmInfo.EmailDomain%></b><br>
   <b>4. newsletter@<%=dmInfo.EmailDomain%></b><br>
   <b>5. rma@<%=dmInfo.EmailDomain%></b><br>
   <b>6. staff@<%=dmInfo.EmailDomain%></b><br>
</p>
<p>Thank you again for using <%=bean.getConfigValue("productname")%> service from <%=bean.getConfigValue("company")%>!</p>
   </td>
   <td width="5%"></td>
  </tr>
  <tr>
    <td colspan="3" height="10" align="center"></td>
  </tr>
</table>
<% } %>
<%@ include file="../share/footer.jsp"%>