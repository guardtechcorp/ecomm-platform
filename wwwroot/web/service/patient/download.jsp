<%@ page import="com.zyzit.weboffice.model.UserInfo" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.util.AccessRole" %>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.RequisitionInfo" %>
<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionWeb" %>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb" %>
<% {
   RequisitionInfo trInfo = web.getRequistionInfo();

   String sError = null;
   int nCustomerId = 0;
   if (trInfo==null)
   {
       int nId = Utilities.getInt(request.getParameter("id"), 0);

       trInfo = web.load(nId, null, false);
       CustomerInfo loginInfo = null;//webCustomer.getCustomerInfo();
//       if (loginInfo!=null)
//          nCustomerId = loginInfo.CustomerID;

       if (trInfo==null|| trInfo.glInfo==null)
       {
           sError = "This summary page does not exist.";
       }
       else if (loginInfo==null)
       {//.
           UserInfo urInfo = web.getLoggedUserInfo();
           if (urInfo==null || !web.hasAccessRole(AccessRole.ROLE_PORTAL_VIEW| AccessRole.ROLE_PORTAL_UPDATE))
           {
               sError = "You do not have right to access this page.";
           }
       }
       else if ( trInfo.glInfo.CustomerID!=loginInfo.CustomerID)
       {
         sError = "You do not have right to access this page.";
       }
   }

//System.out.println("sActionProp2=" + sActionProp);    
   if (sError==null)
   {
       if (sActionProp.endsWith("GetImage"))
       {
//           String sUploadFolder = webCustomer.getMemberAreaPath(nCustomerId, "in"); //bean.getProductImagePath();
////System.out.println("sFilename = " + sFilename);
//           webCustomer.getImageFile(request, sUploadFolder, response);
           String sUploadFolder = web.getMemberAreaPath(nCustomerId, "in"); //bean.getProductImagePath();
           String sFilename = request.getParameter("filename");
           if (Utilities.getValueLength(sFilename)==0)
           {
              int nIndex = Utilities.getInt(request.getParameter("index"), 1);
              String sCard = request.getParameter("card");
              String sCardFile;
              if ("medicare".equalsIgnoreCase(sCard))
                 sCardFile = trInfo.glInfo.MedicareCard;
              else
                 sCardFile = trInfo.glInfo.InsuranceCard;
              String[] arFilename = Utilities.getValue(sCardFile).split(",");
              sFilename = arFilename[nIndex-1];
           }

           String sFilePathName = sUploadFolder + '/' + sFilename;
//System.out.println("sFilename = " + sFilename);
           web.getImageFile2(request, sFilePathName, response);

           return;
      }
      else  if (sActionProp.equalsIgnoreCase("Download"))
      {
          int nIndex = Utilities.getInt(request.getParameter("index"), -1);
          String[] arFile = Utilities.getValue(trInfo.glInfo.ReportFiles).split(",");
          if (nIndex<0 || nIndex>=arFile.length)
          {
             sError = "The file does not exist any more.";
          }
          else
          {
              String sUploadFolder = web.getMemberAreaPath(trInfo.glInfo.CustomerID, "out");
              String sFilePathName = sUploadFolder + "/" + arFile[nIndex];
              int nStartIndex = arFile[nIndex].indexOf("-");
              String sRealFilename = arFile[nIndex].substring(nStartIndex+1);
              boolean bRet = RequisitionWeb.downloadFile(request, response, sFilePathName, sRealFilename, null);
              return;
          }
      }
      else
      {
          String sFilename = "Requisition-Summary ";
          if ("letter".equalsIgnoreCase(request.getParameter("type")))
             sFilename = "Necessity-Letter ";
          sFilename += " for " + Utilities.getValue(trInfo.glInfo.FirstName) + " " + Utilities.getValue(trInfo.glInfo.LastName);
          sFilename += " on " + Utilities.getTodayDateTime().substring(0, 10);

          String sFileType = Utilities.getValue(request.getParameter("output"), "pdf");
          String sUrl ="http://localhost:8080";
          if (web.getHttpsUrl()!=null)
             sUrl += "/ctr";
//          sUrl += "/Clinician?action=GetSummary&id=" + trInfo.glInfo.ID + "&domainname=" + web.getDomainName() + "&tr-key=" + RequisitionWeb.cacheRequisiton(trInfo);
          sUrl += "/Patient?action=GetSummary&id=" + trInfo.glInfo.ID + "&JSID=" + ss.getId() + "&type=" + request.getParameter("type");
//System.out.println("sUrl=" + sUrl);

          boolean bRet = RequisitionWeb.outputContent(sFilename, sFileType, sUrl, response);
          return;
      }
   }
%>
<%=sError%>
<% } %>