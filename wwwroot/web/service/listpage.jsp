<%@ page import="com.zyzit.weboffice.web.BasicWeb" %>
<%@ page import="java.util.List" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.GeneralInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.*" %>
<%
//bean.dumpAllParameters(request);
    String sSubAction = request.getParameter("wt");
    String sGroup = Utilities.getValue(request.getParameter("gp"), "");
    int nPage = Utilities.getInt(request.getParameter("page"), 1);
    if (nPage<=0) nPage = 1;
    int nMaxRowPerPage = Utilities.getInt(request.getParameter("maxrows"), 20);
    int nTotalRecords = Utilities.getInt(request.getParameter("rd"), -1);
    String sSort = Utilities.getValue(request.getParameter("sort"), "ModifyDate");
    String sOrder = Utilities.getValue(request.getParameter("asc"), "Desc");
    int nIndex = Utilities.getInt(request.getParameter("ix"), -1);


    if ("updaterows".equalsIgnoreCase(sSubAction))
    {
       web.changeMaxRowsPerPage(request);
    }
    else if ("Delete".equalsIgnoreCase(sSubAction))
    {
       int nId = Utilities.getInt(request.getParameter("id"), -1);
       BasicBean.Result ret = web.delete(nId);
       if (ret.isSuccess())
          nTotalRecords--;
    }

    List ltGeneral = web.getAll(request, loginInfo);
    nTotalRecords = web.getTotalRows();

%>
<div class="panel panel-primary">
<div class="panel-heading" align="center"><font size="3"><%="Requisition Order List"%></font></div>
<div class="panel-body">
From this page, you can view all saved/submitted Requisition Form and export, edit, sort or delete them.
<p>
<FORM style="margin: 0px; padding: 0px;" name='listform' method='post' action="/Clinician">
<INPUT type="hidden" name="action1" value="ListPage">
<INPUT type="hidden" name="gp" value="<%=sGroup%>">
<INPUT type="hidden" name="page" value="<%=nPage%>">
<INPUT type="hidden" name="rd" value="<%=nTotalRecords%>">
<INPUT type="hidden" name="sort" value="<%=sSort%>">
<INPUT type="hidden" name="asc" value="<%=sOrder%>">
<INPUT type="hidden" name="ix" value="<%=nIndex%>">
<INPUT type="hidden" name="wt" value="">
<INPUT type="hidden" name="id" value="">
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
 <tr>
  <td>
<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
  <tr>
    <td align="right">Max Rows Per Page:
    <select name="maxrows" onChange="submitAjaxMaxRow(document.listform)">
      <%=web.getRowsPerPageList(nMaxRowPerPage)%>
    </select>
    </td>
  </tr>
  <tr><td height="2"></td></tr>
</table>
<table width="100%" cellpadding="2" cellspacing="1" border1="1" align="center" class="table table-bordered table-hover">
<tr bgcolor="#eeeeee">
  <td width="3%" align="center" height="30">No.</td>
  <td width="10%" align="center" nowrap><%=getAjaxSortFieldName("listform", nTotalRecords, "FirstName", "First Name", sSort, sOrder)%></td>
  <td width="10%" align="center" nowrap><%=getAjaxSortFieldName("listform", nTotalRecords, "LastName", "Last Name", sSort, sOrder)%></td>
  <td width="10%" align="center" nowrap><%=getAjaxSortFieldName("listform", nTotalRecords, "Phy_name", "Physician", sSort, sOrder)%></td>
  <td width="12%" align="center" nowrap><%=getAjaxSortFieldName("listform", nTotalRecords, "CreateDate", "Applied Date", sSort, sOrder)%></td>
  <td width="11%" align="center" nowrap><%=getAjaxSortFieldName("listform", nTotalRecords, "ModifyDate", "Latest Update", sSort, sOrder)%></td>
  <td width="11%" align="center" nowrap><%=getAjaxSortFieldName("listform", nTotalRecords, "Status", "Status", sSort, sOrder)%></td>
  <td width="10%" align="center" nowrap>Actions</td>
</tr>
<tbody>
<%
    int nStartNo = web.getStartRowNo();//Utilities.getInt((String)session.getAttribute(web.KEY_STARTROWNO), 1);
    for (int i=0; ltGeneral!=null && i<ltGeneral.size(); i++) {
        GeneralInfo glInfo = (GeneralInfo)ltGeneral.get(i);

//        String TestName = NavigationInfo.Navigation.GetNameByValue(glInfo.TestType);//.split("\\s");
        String sCategory = "";
        for (int k=0;   k<GeneralInfo.ATestType.GetTotal(); k++)
        {
            if (hasBit(glInfo.TestType, GeneralInfo.ATestType.GetValueByIndex(k)))
            {
                if (sCategory.length()>0)
                   sCategory += ", ";
                sCategory += GeneralInfo.ATestType.GetNameByIndex(k);
            }
        }

        String sEdit = "";
        String sView = "";
        String sDelete = "";
        String sExport = "";
        if (glInfo.Status<RequisitionInfo.AStatus.SUBMITTED.GetValue())
        {
           sEdit = "<a href='#' onclick=\"javascript:loadTestForm(" + glInfo.ID + ",'edit')\">Edit</a>";
           sDelete = " | <a hreh='#' onclick=\"javascript:submitAjaxAction(document.listform,'Delete'," + glInfo.ID + ")\">Delete</a>";
        }
        else
        {
           sView = "<a href='#' onclick=\"javascript:loadTestForm(" + glInfo.ID + ",'view')\">View</a>";
          // sExport = " | <a href='/Clinician?action=Export&id=" + glInfo.ID + "&output=pdf'>Export</a>";
        }
%>
<tr>
  <td align="center" height="26"><%=(nStartNo+i)%></td>
  <td align="center"><%=Utilities.getValue(glInfo.FirstName)%></td>
  <td align="center"><%=Utilities.getValue(glInfo.LastName)%></td>
  <td align="center"><%=Utilities.getValue(glInfo.Phy_Name)%></td>
  <td align="center"><%=glInfo.ModifyDate.substring(2, 16)%></td>
  <td align="center"><%=glInfo.CreateDate.substring(2, 16)%></td>
  <td align="center"><%=Utilities.getValue(RequisitionInfo.AStatus.GetNameByValue(glInfo.Status))%></td>
  <td align="center"><%=sView%><%=sEdit%><%=sDelete%><%=sExport%></td>
</tr>
<% } %>
</tbody>
    
    <tr>
      <td colspan=11 align="right" height="30">
      <%=getNavigate(nTotalRecords, nMaxRowPerPage, "javascript:submitAjaxPage(document.listform,pg)", nPage, web)%>&nbsp;&nbsp;
      </td>
    </tr>
</table>
  </td>
 </tr>
</table>
</FORM>
</div>
</div>