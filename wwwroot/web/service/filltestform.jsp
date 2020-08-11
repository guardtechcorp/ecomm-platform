<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionWeb" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.RequisitionInfo" %>
<%@ page import="com.zyzit.weboffice.model.NavigationInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.TestResult" %>
<%@ page import="com.zyzit.weboffice.bean.BasicBean" %>
<%
    String sAction = sActionProp;
    RequisitionInfo trInfo = web.getRequistionInfo();

    currentPage = NavigationInfo.Navigation.Dashbord;
    byte saveFlag = NavigationInfo.Navigation.All.GetValue();
    if (sAction.equalsIgnoreCase("FillTestForm"))
    {
        trInfo = RequisitionInfo.getInstance(true);
        trInfo.CreateDate = Utilities.getTodayDateTime();
        web.setRequistionInfo(trInfo);
        currentPage = NavigationInfo.Navigation.General;
    }
    else if (sAction.equalsIgnoreCase("FillTestForm-Edit")||sAction.equalsIgnoreCase("FillTestForm-View"))
    {
        int nId = Utilities.getInt(request.getParameter("id"), -1);
        trInfo = web.load(nId, null);
        if (trInfo!=null && trInfo.glInfo!=null)
           trInfo.ID = trInfo.glInfo.ID;
        web.setRequistionInfo(trInfo);

        currentPage = NavigationInfo.Navigation.General;
    }
    else if (sAction.equalsIgnoreCase("FillTestForm-Search")||sAction.equalsIgnoreCase("GetRequisition"))
    {
        String sRequestCode = request.getParameter("requestcode");
        String sWhat = request.getParameter("what");
        if ("Tranfer".equalsIgnoreCase(sWhat))
           sRequestCode = request.getParameter("id");

        RequisitionInfo findInfo = web.findByRequestCode(sRequestCode);
        if (findInfo==null)
        {
            sErrorMessage = "It could not find a requisition form with the requested code -- " + sRequestCode;
            sErrorClass = "danger";
            currentPage = NavigationInfo.Navigation.Dashbord;
        }
        else
        {
            if (findInfo.glInfo.CustomerID==loginInfo.CustomerID)
            {//. Your claim requested form
                trInfo = findInfo;
                web.setRequistionInfo(trInfo);

                if (trInfo.glInfo.Status<RequisitionInfo.AStatus.PATIENTSUBMIT.GetValue())
                   currentPage = NavigationInfo.Navigation.General;
                else
                   currentPage = NavigationInfo.Navigation.Status;
            }
            else if ("Tranfer".equalsIgnoreCase(sWhat))
            {//. Your claim requested form
                web.transferOrder(findInfo.glInfo.ID, loginInfo.CustomerID);
                findInfo.glInfo.CustomerID = loginInfo.CustomerID;
                findInfo.glInfo.Status = RequisitionInfo.AStatus.TRANSFER.GetValue();
                findInfo.glInfo.ModifyDate = Utilities.getTodayDateTime();

                trInfo = findInfo;
                web.setRequistionInfo(trInfo);

                currentPage = NavigationInfo.Navigation.General;
            }
            else if (findInfo.glInfo.CustomerID==0)
            { //. Patient new requested form
                trInfo = findInfo;
                web.setRequistionInfo(trInfo);

                currentPage = NavigationInfo.Navigation.Transfer;
            }
            else
            {
                sErrorMessage = "This requested order is not yours and you cannot access to it";
                sErrorClass = "*";
                currentPage = NavigationInfo.Navigation.Dashbord;
            }
        }
    }
    else if (sAction.startsWith("FillTestForm-Tranfer"))
    {
       Utilities.fillObjectInfo2(trInfo.glInfo, request);
       trInfo.glInfo.TestType = GeneralInfo.ATestType.Cancer.GetValue();
       trInfo.glInfo.CustomerID = loginInfo.CustomerID;
       if (trInfo.glInfo.BillType>=GeneralInfo.ABillType.CreditCardPayment.GetValue())
       {
          currentPage = NavigationInfo.Navigation.Summary;
          trInfo.glInfo.Status = RequisitionInfo.AStatus.SUBMITTED.GetValue();
       }
       else
       {
          currentPage = NavigationInfo.Navigation.Clinical;
          trInfo.glInfo.Status = RequisitionInfo.AStatus.TRANSFER.GetValue();
       }
    }
    else if (sAction.equals("PaypalPay"))
    {
        if (trInfo.glInfo.TotalPay<=0)
           currentPage = NavigationInfo.Navigation.Summary;
        else
           currentPage = NavigationInfo.Navigation.Status;
    }
    else {
        if (sAction.startsWith("FillTestForm-General")) {
            Utilities.fillObjectInfo2(trInfo.glInfo, request);
            if (trInfo.glInfo.RequestType != RequisitionWeb.REQUEST_PATIENT)
                currentPage = NavigationInfo.Navigation.Ordering;
            else
                currentPage = NavigationInfo.Navigation.Clinical;

            saveFlag = NavigationInfo.Navigation.General.GetValue();
        } else if (sAction.startsWith("FillTestForm-Ordering")) {
            //. Get input information
            trInfo.glInfo.TestType = Utilities.getByte(request.getParameter("testtype"), (byte) 0);
            trInfo.glInfo.Comprehensive = Utilities.getInt(request.getParameter("comprehensive"), 0);
            trInfo.glInfo.Specialty = Utilities.getInt(request.getParameter("specialty"), 0);
            trInfo.glInfo.Cardiovascular = Utilities.getInt(request.getParameter("cardiovascular"), 0);
            trInfo.glInfo.Cardiomyopathy = Utilities.getInt(request.getParameter("cardiomyopathy"), 0);
            trInfo.glInfo.Arrhythmia = Utilities.getInt(request.getParameter("arrhythmia"), 0);
            trInfo.glInfo.Aortopathy = Utilities.getInt(request.getParameter("aortopathy"), 0);
            trInfo.glInfo.OtherOption = Utilities.getInt(request.getParameter("otheroption"), 0);
            trInfo.glInfo.Pharmacogenomics = Utilities.getInt(request.getParameter("pharmacogenomics"), 0);
            trInfo.glInfo.Ophthalmology = Utilities.getInt(request.getParameter("ophthalmology"), 0);
            trInfo.glInfo.Other = Utilities.getInt(request.getParameter("other"), 0);

            if (sAction.endsWith("-next"))
                currentPage = NavigationInfo.Navigation.Clinical;
            else if (sAction.endsWith("-prev"))
                currentPage = NavigationInfo.Navigation.General;

            saveFlag = NavigationInfo.Navigation.General.GetValue();
        } else if (sAction.startsWith("FillTestForm-Clinical")) {
            Utilities.fillObjectInfo(trInfo.ccInfo, request, true);

            //. for Test result
            trInfo.ltTestResult = Utilities.fillObjectList(TestResultInfo.class, request, 50);
            for (int nIndex = 0; nIndex < trInfo.ltTestResult.size(); nIndex++) {
                TestResultInfo ttInfo = (TestResultInfo) trInfo.ltTestResult.get(nIndex);
                ttInfo.Type = TestResult.TYPE_TESTRESULT;
            }
            //. For Finding
            List ltFinding = Utilities.fillObjectList(TestResultInfo.class, request, 200, 250);
            for (int nIndex = 0; nIndex < ltFinding.size(); nIndex++) {
                TestResultInfo ttInfo = (TestResultInfo) ltFinding.get(nIndex);
                ttInfo.Type = TestResult.TYPE_SPECIALFIND;

                trInfo.ltTestResult.add(ttInfo);
            }

            trInfo.ltHistory = Utilities.fillObjectList(HistoryInfo.class, request, 10);

            if (sAction.endsWith("-prev"))
            {
                if (trInfo.glInfo.RequestType != RequisitionWeb.REQUEST_PATIENT)
                    currentPage = NavigationInfo.Navigation.Ordering;
                else
                    currentPage = NavigationInfo.Navigation.General;
            } else if (sAction.endsWith("-next")) {
                if (RequisitionWeb.tryEligibility(trInfo))
                    currentPage = NavigationInfo.Navigation.Eligibility;
                else {
                    if (trInfo.glInfo.RequestType != RequisitionWeb.REQUEST_PATIENT)
                        currentPage = NavigationInfo.Navigation.Consent;
                    else
                        currentPage = NavigationInfo.Navigation.Summary;
                }
            }

            saveFlag = NavigationInfo.Navigation.Clinical.GetValue();
        } else if (sAction.startsWith("FillTestForm-Eligiblity")) {
            if (sAction.endsWith("-prev"))
                currentPage = NavigationInfo.Navigation.Clinical;
            else if (sAction.endsWith("-next")) {
                if (trInfo.glInfo.RequestType != RequisitionWeb.REQUEST_PATIENT)
                    currentPage = NavigationInfo.Navigation.Consent;
                else
                    currentPage = NavigationInfo.Navigation.Summary;
            }
        } else if (sAction.startsWith("FillTestForm-Consent")) {
            Utilities.fillObjectInfo2(trInfo.ctInfo, request);
            Utilities.fillObjectInfo2(trInfo.glInfo, request);

            if (sAction.endsWith("-prev")) {
                if (RequisitionWeb.tryEligibility(trInfo))
                    currentPage = NavigationInfo.Navigation.Eligibility;
                else
                    currentPage = NavigationInfo.Navigation.Clinical;
            } else if (sAction.endsWith("-next")) { //. Write to Database here
                currentPage = NavigationInfo.Navigation.Summary;
            }

            saveFlag = NavigationInfo.Navigation.Consent.GetValue();

        } else if (sAction.startsWith("FillTestForm-Summary")) {
            if (sAction.endsWith("-prev")) {
                if (trInfo.glInfo.RequestType != RequisitionWeb.REQUEST_PATIENT)
                    currentPage = NavigationInfo.Navigation.Consent;
                else
                    currentPage = NavigationInfo.Navigation.Clinical;
            } else if (sAction.endsWith("-next")) { //. Write to Database here
                currentPage = NavigationInfo.Navigation.Summary;
                if (trInfo.glInfo.Status <= RequisitionInfo.AStatus.TRANSFER.GetValue()) {
                    trInfo.glInfo.Status = RequisitionInfo.AStatus.SUBMITTED.GetValue();
                } else if (trInfo.glInfo.Status <= RequisitionInfo.AStatus.SUBMITTED.GetValue())
                    trInfo.glInfo.Status = RequisitionInfo.AStatus.RESUBMITTED.GetValue();
                else
                    trInfo.glInfo.Status = -1; //Not update it

                trInfo.glInfo.CustomerID = loginInfo.CustomerID;
                if (trInfo.ID > 0 && trInfo.ID != trInfo.glInfo.ID)
                    trInfo.glInfo.ID = trInfo.ID;

                BasicBean.Result ret = web.update(trInfo, NavigationInfo.Navigation.All.GetValue());
                if (!ret.isSuccess()) {
                    Errors errObj = (Errors) ret.getInfoObject();
                    sErrorMessage = errObj.getError();
                    sErrorClass = "failed";
                } else {
                    sErrorMessage = "Your Test-Requisition is submitted and waiting for process.";
                }

                currentPage = NavigationInfo.Navigation.Status;
            } else {
                currentPage = NavigationInfo.Navigation.Summary;
            }
        } else {
            if (trInfo == null) {
                trInfo = RequisitionInfo.getInstance(true);
                trInfo.CreateDate = Utilities.getTodayDateTime();

                web.setRequistionInfo(trInfo);
            }
        }
    }

    if (sAction.endsWith("-prev") || sAction.endsWith("-next")||sAction.endsWith("-save"))
    {
        if (!sAction.startsWith("FillTestForm-Eligiblity") && !sAction.startsWith("FillTestForm-Summary"))
        {
            if (trInfo.ID>0 && trInfo.ID!=trInfo.glInfo.ID)
               trInfo.glInfo.ID = trInfo.ID;

            if (trInfo.glInfo.Status<=RequisitionInfo.AStatus.STARTED.GetValue())
               trInfo.glInfo.Status = RequisitionInfo.AStatus.SAVED.GetValue();
            else if (trInfo.glInfo.Status==RequisitionInfo.AStatus.SUBMITTED.GetValue())
               trInfo.glInfo.Status = RequisitionInfo.AStatus.RESUBMITTED.GetValue();
            else if (trInfo.glInfo.Status==RequisitionInfo.AStatus.TRANSFER.GetValue())
            {
                if (!sAction.startsWith("FillTestForm-Tranfer"))
                   trInfo.glInfo.Status = RequisitionInfo.AStatus.SAVED.GetValue();
            }

            BasicBean.Result ret = web.update(trInfo, saveFlag);

            if (sAction.endsWith("-save"))
            {
                if (!ret.isSuccess())
                {
                  Errors errObj = (Errors)ret.getInfoObject();
                  sErrorMessage = "<font color='red'>" + errObj.getError() + "</font>";
                  sErrorClass = "failed";
                }
                else
                {
                   sErrorMessage = "<font color='green'>Successfully saved!</font>";
                }

                StringBuffer sbContent = new StringBuffer("{");
                sbContent.append("\"ret\":" + ret.isSuccess() + ",\n");
                sbContent.append("\"message\":\"" + sErrorMessage +  "\"");
                sbContent.append("}");

                RequisitionWeb.outputAjaxContent(sbContent.toString(), response);
                return;
            }
        }
    }
    else if (sAction.startsWith(("FillTestForm-")) && !"FillTestForm-General".equalsIgnoreCase(sAction))
    {
        if (!(sAction.endsWith("-next")||sAction.endsWith("-prev")||sAction.endsWith("-edit")
            ||sAction.endsWith("-input")||sAction.endsWith("-letter")||sAction.endsWith("-Search")
            ||sAction.endsWith("-Tranfer")
        ))
        {
           int nIndex = sAction.lastIndexOf("-");
           String name =  sAction.substring(nIndex+1);
           if (nIndex>0)
              currentPage = NavigationInfo.Navigation.GetObjectByName(name);
           if (currentPage==null)
              currentPage = NavigationInfo.Navigation.Dashbord;
        }
    }
%>
<% if (currentPage==NavigationInfo.Navigation.General) { %>
 <%@ include file="general.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Ordering) { %>
<%@ include file="ordering.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Clinical) { %>
<%@ include file="clinical.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Eligibility) { %>
<%@ include file="eligiblity.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Consent) { %>
<%@ include file="consent.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Summary) { %>
<%@ include file="finalpage.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Status) {
  boolean bFront = true;
%>
<%@ include file="statusinfo.jsp"%>
<% } else if (currentPage==NavigationInfo.Navigation.Transfer) { %>
<%@ include file="transfer.jsp"%>
<% } else { %>
<%@ include file="dashboard.jsp"%>
<% } %>