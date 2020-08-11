<%@ include file="../share/uparea.jsp"%>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/incentiveplan.js"></SCRIPT>
<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.IncentiveBean"%>
<%@ page import="com.zyzit.weboffice.model.IncentiveInfo"%>
<%
  IncentiveBean bean = new IncentiveBean(session, 100);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_INCENTIVEPLAN))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  if ("Update Now".equalsIgnoreCase(sAction))
  {
    IncentiveBean.Result ret = bean.update(request, false);
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      sClass = "failed";
    }
    else
    {//. Continue add
      sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "Incentive Rules");
    }
  }

  List ltArray = bean.getCouponGroupList(request);

  String sHelpTag = "incentiverule";
//  String sTitleLinks = "<b>Incentive Rules</b>";
  String sTitleLinks = bean.getNavigation(request, "Incentive Rules");
%>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
The form below will allow you to design and setup incentive rules.
<script language = "JavaScript">
<%=bean.getProductsScripts()%>
</script>
<form name="incentive" action="discountrule.jsp" method="post" onsubmit="return validateIncentive(this);">
 <table width="99%" cellpadding="1" cellspacing="1" border="0" class="forumline" align="center">
    <tr>
      <th class="thHead" colspan="3">Incentive Rules</th>
    </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="3" align="center" height="20"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
    </tr>
<% } %>
    <tr>
      <td class="row1" width="16%" align="right"><b>Free Shipping:</b></td>
      <td class="row1" width="10%" align="right"><b><i>Offers:</i></b>
      <td class="row1" width="74%">
        <select name="off1">
          <option value=0.00 selected>No Free Shipping</option>
          <option value=1.00>Free Shipping</option>
        </select>
        <b><i> On:</i></b>
        <select name="limit1sel" onChange="onSelectChange(document.incentive.limit1sel, document.incentive.limit1);">
          <option value=0>All Orders
          <option value=10>Orders Over $10
          <option value=10>Orders Over $10
          <option value=20>Orders Over $20
          <option value=30>Orders Over $30
          <option value=40>Orders Over $40
          <option value=50>Orders Over $50
          <option value=75>Orders Over $75
          <option value=100>Orders Over $100
          <option value=125>Orders Over $125
          <option value=150>Orders Over $150
          <option value=200>Orders Over $200
          <option value=250>Orders Over $250
          <option value=300>Orders Over $300
          <option value=400>Orders Over $400
          <option value=500>Orders Over $500
          <option value=750>Orders Over $750
          <option value=999>Orders Over $1000
          <option value=1500>Orders Over $1500
          <option value=2000>Orders Over $2000
          <option value=3000>Orders Over $3000
          <option value=4000>Orders Over $4000
          <option value=5000>Orders Over $5000
          <option value=7500>Orders Over $7500
          <option value=10000>Orders Over $10000
          <option value="other">Use the value-->
        </select> or
        $ <input type="text" name="limit1" value="<%=Utilities.getValue(bean.getPlanValue("Free Shipping", "OverLimit"))%>" size="6" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
        <br><b><i> To:</i></b>
        <select name="applyto1">
          <option value=0 selected >All Products</option>
        </select>
      </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right" valign="top">&nbsp;</td>
      <td class="row1" width="10%" align="right"><b><i>Expired in:</i></b></td>
      <td class="row1" width="74%">
        <input maxlength=10 name="expireddate1" value="<%=Utilities.getValue(bean.getPlanValue("Free Shipping", "ExpiredDate"))%>"
        onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
        (MM/DD/YYYY) If left it to be empty, no expired date is applied.</td>
    </tr>
    <tr>
      <td class="row1" colspan="3" align="center"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right"><b>Discount Rule:</b></td>
      <td class="row1" width="10%" align="right"><b><i>Offers:</i></b></td>
      <td class="row1" width="74%">
        <select name="off2sel" onChange="onSelectChange(document.incentive.off2sel, document.incentive.off2);">
          <option value=0.00 selected>No Discount
          <option value=9.50 >$9.50 Discount
          <option value=10.00>$10 Discount
          <option value=15.00>$15 Discount
          <option value=20.00>$20 Discount
          <option value=25.00>$25 Discount
          <option value=30.00>$30 Discount
          <option value=50.00>$50 Discount
          <option value=75.00>$75 Discount
          <option value=80.00>$80 Discount
          <option value=99.00>$99 Discount
          <option value=100.00>$100 Discount
          <option value=125.00>$125 Discount
          <option value=150.00>$150 Discount
          <option value=200.00>$200 Discount
          <option value=250.00>$250 Discount
          <option value=300.00>$300 Discount
          <option value=500.00>$500 Discount
          <option value=999.00>$999 Discount
          <option value=1500.00>$1500 Discount
          <option value=2000.00>$2000 Discount
          <option value=3000.00>$3000 Discount
          <option value=4000.00>$4000 Discount
          <option value=5000.00>$5000 Discount
          <option value=6000.00>$6000 Discount
          <option value=7000.00>$7000 Discount
          <option value=8000.00>$8000 Discount
          <option value=9000.00>$9000 Discount
          <option value=10000.00>$10000 Discount
          <option value=0.01>1% Off
          <option value=0.02>2% Off
          <option value=0.03>3% Off
          <option value=0.04>4% Off
          <option value=0.05>5% Off
          <option value=0.06>6% Off
          <option value=0.07>7% Off
          <option value=0.08>8% Off
          <option value=0.09>9% Off
          <option value=0.10>10% Off
          <option value=0.11>11% Off
          <option value=0.12>12% Off
          <option value=0.13>13% Off
          <option value=0.14>14% Off
          <option value=0.15>15% Off
          <option value=0.16>16% Off
          <option value=0.17>17% Off
          <option value=0.18>18% Off
          <option value=0.19>19% Off
          <option value=0.20>20% Off
          <option value=0.25>25% Off
          <option value=0.30>30% Off
          <option value=0.35>35% Off
          <option value=0.40>40% Off
          <option value=0.45>45% Off
          <option value=0.50>50% Off
          <option value=0.55>55% Off
          <option value=0.60>60% Off
          <option value=0.65>65% Off
          <option value=0.70>70% Off
          <option value=0.75>75% Off
          <option value=0.80>80% Off
          <option value=0.85>85% Off
          <option value=0.90>90% Off
          <option value=0.95>95% Off
          <option value="other">Use the value-->
        </select> or
        $ <input type="text" name="off2" value="<%=Utilities.getValue(bean.getPlanValue("Rule1", "Off"))%>" size="6" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
        <b> <i>On:</i></b>
        <select name="limit2sel"  onChange="onSelectChange(document.incentive.limit2sel, document.incentive.limit2);">
          <option value=0 selected>All Orders
          <option value=10>Orders Over $10
          <option value=20>Orders Over $20
          <option value=30>Orders Over $30
          <option value=50>Orders Over $50
          <option value=75>Orders Over $75
          <option value=80>Orders Over $80
          <option value=100>Orders Over $100
          <option value=125>Orders Over $125
          <option value=150>Orders Over $150
          <option value=175>Orders Over $175
          <option value=195>Orders Over $195
          <option value=200>Orders Over $200
          <option value=250>Orders Over $250
          <option value=300>Orders Over $300
          <option value=400>Orders Over $400
          <option value=500>Orders Over $500
          <option value=750>Orders Over $750
          <option value=999>Orders Over $999
          <option value=1500>Orders Over $1500
          <option value=2500>Orders Over $2500
          <option value=5000>Orders Over $5000
          <option value=10000>Orders Over $10000
          <option value=20000>Orders Over $20000
          <option value=30000>Orders Over $30000
          <option value=40000>Orders Over $40000
          <option value=50000>Orders Over $50000
          <option value=75000>Orders Over $75000
          <option value=100000>Orders Over $100000
          <option value=250000>Orders Over $250000
          <option value=300000>Orders Over $300000
          <option value="other">Use the value-->
        </select> or
        $ <input type="text" name="limit2" value="<%=Utilities.getValue(bean.getPlanValue("Rule1", "OverLimit"))%>" size="6" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
        <br><b><i> To:</i></b>
        <select name="applyto2">
          <option value=0 selected >All Products</option>
        </select>
    </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right">&nbsp;</td>
      <td class="row1" width="10%" align="right"><b><i>Expired in: </i></b>
      </td>
      <td class="row1" width="74%">
        <input maxlength=10 name="expireddate2" value="<%=Utilities.getValue(bean.getPlanValue("Rule1", "ExpiredDate"))%>"
        onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
         (MM/DD/YYYY) If left it to be empty, no expired date is applied.
      </td>
    </tr>
    <tr>
      <td class="row1" colspan="3" align="center"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" colspan="3" height="20">&nbsp;&nbsp;<b>Coupon Group Rules:</b></td>
    </tr>
<%
  int nStartNo = Utilities.getInt(bean.getCacheData(bean.KEY_STARTROWNO), 1);
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     IncentiveInfo info = (IncentiveInfo)ltArray.get(i);
%>
    <tr>
      <td class="row1" width="16%" align="right"><b><%=info.Name%>:</b></td>
      <td class="row1" width="10%" align="right"><b><i>Offers:</i></b></td>
      <td class="row1" width="74%">
        <select name="off<%=(3+i)%>sel" onChange="onSelectChange(document.incentive.off<%=(3+i)%>sel, document.incentive.off<%=(3+i)%>);">
          <option value=0.00 selected>Does Not Apply
          <option value=9.50>$9.50 Discount
          <option value=10.00 >$10 Discount
          <option value=15.00>$15 Discount
          <option value=20.00>$20 Discount
          <option value=25.00>$25 Discount
          <option value=30.00>$30 Discount
          <option value=50.00>$50 Discount
          <option value=75.00>$75 Discount
          <option value=80.00>$80 Discount
          <option value=100.00>$100 Discount
          <option value=125.00>$125 Discount
          <option value=150.00>$150 Discount
          <option value=200.00>$200 Discount
          <option value=250.00>$250 Discount
          <option value=300.00>$300 Discount
          <option value=500.00>$500 Discount
          <option value=999.00>$999 Discount
          <option value=1500.00>$1500 Discount
          <option value=2000.00>$2000 Discount
          <option value=3000.00>$3000 Discount
          <option value=0.01>1% Off
          <option value=0.02>2% Off
          <option value=0.03>3% Off
          <option value=0.04>4% Off
          <option value=0.05>5% Off
          <option value=0.06>6% Off
          <option value=0.07>7% Off
          <option value=0.08>8% Off
          <option value=0.09>9% Off
          <option value=0.10>10% Off
          <option value=0.11>11% Off
          <option value=0.12>12% Off
          <option value=0.13>13% Off
          <option value=0.14>14% Off
          <option value=0.15>15% Off
          <option value=0.16>16% Off
          <option value=0.17>17% Off
          <option value=0.18>18% Off
          <option value=0.19>19% Off
          <option value=0.20>20% Off
          <option value=0.25>25% Off
          <option value=0.30>30% Off
          <option value=0.35>35% Off
          <option value=0.40>40% Off
          <option value=0.45>45% Off
          <option value=0.50>50% Off
          <option value=0.55>55% Off
          <option value=0.60>60% Off
          <option value=0.65>65% Off
          <option value=0.70>70% Off
          <option value=0.75>75% Off
          <option value=0.80>80% Off
          <option value=0.85>85% Off
          <option value=0.90>90% Off
          <option value=0.95>95% Off
          <option value="other">Use the value-->
        </select> or
        $ <input type="text" name="off<%=(3+i)%>" value="<%=Utilities.getValue(bean.getPlanValue(info.Name, "Off"))%>" size="6" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
        <b><i>On:&nbsp;</i></b>
        <select name="limit<%=(3+i)%>sel" onChange="onSelectChange(document.incentive.limit<%=(3+i)%>sel, document.incentive.limit<%=(3+i)%>);">
          <option value=0 selected>All Orders
          <option value=10>Orders Over $10
          <option value=20>Orders Over $20
          <option value=30>Orders Over $30
          <option value=50>Orders Over $50
          <option value=75>Orders Over $75
          <option value=80>Orders Over $80
          <option value=100>Orders Over $100
          <option value=125>Orders Over $125
          <option value=150>Orders Over $150
          <option value=175>Orders Over $175
          <option value=195>Orders Over $195
          <option value=200>Orders Over $200
          <option value=250>Orders Over $250
          <option value=300>Orders Over $300
          <option value=400>Orders Over $400
          <option value=500>Orders Over $500
          <option value=750>Orders Over $750
          <option value=999>Orders Over $999
          <option value=1500>Orders Over $1500
          <option value=2500>Orders Over $2500
          <option value=5000>Orders Over $5000
          <option value=10000>Orders Over $10000
          <option value=30000>Orders Over $30000
          <option value=50000>Orders Over $50000
          <option value=100000>Orders Over $100000
          <option value=250000>Orders Over $250000
          <option value="other">Use the value-->
        </select>
        $ <input type="text" name="limit<%=(3+i)%>" value="<%=Utilities.getValue(bean.getPlanValue(info.Name, "OverLimit"))%>" size="6" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
        <br><b><i> To: </i></b>
        <select name="applyto<%=(3+i)%>">
          <option value=0 selected >All Products</option>
        </select>
       </td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right"></td>
      <td class="row1" width="10%" align="right"><b><i>Expired in:</i></b></td>
      <td class="row1" width="74%">
        <input maxlength=10 name="expireddate<%=(3+i)%>" value="<%=Utilities.getValue(bean.getPlanValue(info.Name, "ExpiredDate"))%>"
        onBlur="if (this.value.length>0&amp;&amp;!checkDateFormat(this.value,'MM/DD/YYYY')){this.focus();this.select();}" onKeyUp='autoFormat(this,"D");'>
        (MM/DD/YYYY) If left it to be empty, no expired date is applied. </td>
    </tr>
<% } %>

    <tr>
      <td class="row1" colspan="3" align="center"><hr class="dotted"></td>
    </tr>
    <tr>
      <td class="row1" width="16%" align="right"><b>Member Price Rule:</b></td>
      <td class="row1" width="10%" align="right"><b><i>Offers:</i></b></td>
      <td class="row1" width="74%">
        <select name="memberoff">
          <!--option value=0>None of Memberes</option-->
          <option value=1 selected>All of Members</option>
        </select>
        <b><i> On:</i></b>
        <select name="memberbasesel"  onChange="onSelectChange(this, document.incentive.memberbaseprice);">
          <option value=0 selected>All Orders
          <option value=10>Orders Over $10
          <option value=20>Orders Over $20
          <option value=30>Orders Over $30
          <option value=50>Orders Over $50
          <option value=75>Orders Over $75
          <option value=80>Orders Over $80
          <option value=100>Orders Over $100
          <option value=125>Orders Over $125
          <option value=150>Orders Over $150
          <option value=175>Orders Over $175
          <option value=195>Orders Over $195
          <option value=200>Orders Over $200
          <option value=250>Orders Over $250
          <option value=300>Orders Over $300
          <option value=400>Orders Over $400
          <option value=500>Orders Over $500
          <option value=750>Orders Over $750
          <option value=999>Orders Over $999
          <option value=1500>Orders Over $1500
          <option value=2500>Orders Over $2500
          <option value=5000>Orders Over $5000
          <option value=10000>Orders Over $10000
          <option value=20000>Orders Over $20000
          <option value=30000>Orders Over $30000
          <option value=40000>Orders Over $40000
          <option value=50000>Orders Over $50000
          <option value=75000>Orders Over $75000
          <option value=100000>Orders Over $100000
          <option value=250000>Orders Over $250000
          <option value=300000>Orders Over $300000
          <option value="other">Use the value-->
        </select> or
        $ <input type="text" name="memberbaseprice" value="<%=Utilities.getValue(bean.getPlanValue("Member Shopping", "OverLimit"))%>" size="6" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
        <br><b><i> To:</i></b>
        <select name="memberapplyto">
          <option value=0 selected >All Products</option>
        </select>
    </td>
    </tr>

    <tr>
      <td class="row1" colspan="3" align="right" height="17">&nbsp;</td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center">
        <input type="submit" name="action" value="Update Now">
      </td>
    </tr>
  </table>
</form>
<SCRIPT>onIncentiveLoad(document.incentive);</SCRIPT>
<SCRIPT>selectDropdownMenu(document.incentive.off1, "<%=Utilities.getValue(bean.getPlanValue("Free Shipping", "Off"))%>");</SCRIPT>
<SCRIPT>selectAtLeastOne(document.incentive.limit1sel, "<%=Utilities.getValue(bean.getPlanValue("Free Shipping", "OverLimit"))%>");</SCRIPT>
<SCRIPT>setupOption(document.incentive.applyto1, g_Products, "<%=Utilities.getValue(bean.getPlanValue("Free Shipping", "ApplyTo"))%>");</SCRIPT>
<SCRIPT>selectAtLeastOne(document.incentive.off2sel, "<%=Utilities.getValue(bean.getPlanValue("Rule1", "Off"))%>");</SCRIPT>
<SCRIPT>selectAtLeastOne(document.incentive.limit2sel, "<%=Utilities.getValue(bean.getPlanValue("Rule1", "OverLimit"))%>");</SCRIPT>
<SCRIPT>setupOption(document.incentive.applyto2, g_Products, "<%=Utilities.getValue(bean.getPlanValue("Rule1", "ApplyTo"))%>");</SCRIPT>
<%
  for (int i=0; ltArray!=null&&i<ltArray.size(); i++) {
     IncentiveInfo info = (IncentiveInfo)ltArray.get(i);
%>
<SCRIPT>selectAtLeastOne(document.incentive.off<%=(3+i)%>sel, "<%=Utilities.getValue(bean.getPlanValue(info.Name, "Off"))%>");</SCRIPT>
<SCRIPT>selectAtLeastOne(document.incentive.limit<%=(3+i)%>sel, "<%=Utilities.getValue(bean.getPlanValue(info.Name, "OverLimit"))%>");</SCRIPT>
<SCRIPT>setupOption(document.incentive.applyto<%=(3+i)%>, g_Products, "<%=Utilities.getValue(bean.getPlanValue(info.Name, "ApplyTo"))%>");</SCRIPT>
<% } %>
<SCRIPT>selectAtLeastOne(document.incentive.memberbasesel, "<%=Utilities.getValue(bean.getPlanValue("Member Shopping", "OverLimit"))%>");</SCRIPT>
<%@ include file="../share/footer.jsp"%>