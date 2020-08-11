<%@ page import="com.zyzit.weboffice.model.UserInfo" %>
<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.util.AccessRole" %>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo" %>
<%@ page import="com.zyzit.weboffice.database.Apollogen.model.RequisitionInfo" %>
<%@ page import="com.zyzit.weboffice.bean.Apollogen.RequisitionWeb" %>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb" %>
<% {
   RequisitionInfo trInfo = web.getRequistionInfo();
   if (trInfo==null || trInfo.glInfo==null)
   {
      trInfo =  web.get(request);
   }

   String sError = null;
   if (trInfo==null)
   {
       int nId = Utilities.getInt(request.getParameter("id"), 0);
       if (nId>0)
       {
           trInfo = web.load(nId, null);
       }

       if (trInfo!=null)
       {
           UserInfo urInfo = web.getLoggedUserInfo();
           if (urInfo!=null)
           {
           }
           else
           {
               CustomerInfo loginInfo = webCustomer.getCustomerInfo();
               if (loginInfo==null || trInfo.glInfo.CustomerID!=loginInfo.CustomerID)
               {
                 sError = "You do not have right to access this page.";
               }
           }
       }
       else
       {
           sError = "Requistion form cannot be found.";
       }
   }

   if (sError==null)
   {
       if (sActionProp.endsWith("GetImage"))
       {
           String sUploadFolder = webCustomer.getMemberAreaPath(trInfo.glInfo.CustomerID, "in"); //bean.getProductImagePath();
           String sType = Utilities.getValue(request.getParameter("type"));
           if (!"Vector".equalsIgnoreCase(sType))
           {
               String sFilename = request.getParameter("filename");
               if (Utilities.getValueLength(sFilename)==0)
               {
                  int nIndex = Utilities.getInt(request.getParameter("index"), 1);
                  String sCard = request.getParameter("card");
                  String sCardFile;
                  if ("medicare".equalsIgnoreCase(sCard))
                     sCardFile = trInfo.glInfo.MedicareCard;
                  else if ("insurance".equalsIgnoreCase(sCard))
                     sCardFile = trInfo.glInfo.InsuranceCard;
                  else
                     sCardFile = trInfo.glInfo.Phy_Sign;

                  String[] arFilename = Utilities.getValue(sCardFile).split(",");
                  sFilename = arFilename[nIndex-1];
               }

               String sFilePathName = sUploadFolder + '/' + sFilename;
               webCustomer.getImageFile2(request, sFilePathName, response);
           }
           else
           {
               String sVectorData = request.getParameter("data");
               if (trInfo!=null && trInfo.glInfo!=null)
               {
                  if ("Physician".equalsIgnoreCase(sVectorData))
                     sVectorData = trInfo.glInfo.Phy_Sign;
                  else if ("Patient".equalsIgnoreCase(sVectorData))
                     sVectorData = trInfo.glInfo.PatientSign;
                  else if ("Patient2".equalsIgnoreCase(sVectorData))
                     sVectorData = trInfo.glInfo.PatientSign2;
               }

//System.out.println("VectorData=" + sVectorData);
               response.reset();
               String mimeType = "image/png";
               response.setContentType(mimeType);
               ESignature.generateSignature(sVectorData, response.getOutputStream());
           }

           return;
      }
      else  if (sActionProp.equalsIgnoreCase("Download"))
      {
          int nIndex = Utilities.getInt(request.getParameter("index"), -1);
          String sType = request.getParameter("type");
          String sWhere = "out";
          String[] arFile = null;
          if ("docfile".equalsIgnoreCase(sType))
          {
             arFile = Utilities.getValue(trInfo.glInfo.DocFiles).split(",");
             sWhere = "in";
          }
          else
             arFile = Utilities.getValue(trInfo.glInfo.ReportFiles).split(",");

          if (nIndex<0 || nIndex>=arFile.length)
          {
             sError = "The file does not exist any more.";
          }
          else
          {
              String sUploadFolder = web.getMemberAreaPath(trInfo.glInfo.CustomerID, sWhere);
              String sFilePathName = sUploadFolder + "/" + arFile[nIndex];
              int nStartIndex = arFile[nIndex].indexOf("-");
              String sRealFilename = arFile[nIndex].substring(nStartIndex+1);
              boolean bRet = RequisitionWeb.downloadFile(request, response, sFilePathName, sRealFilename, null);
              return;
          }
      }
      else
      {
          String sFilename = RequisitionWeb.getReportName(request.getParameter("type"), trInfo);
          String sUrl = RequisitionWeb.getDownloadUrl(request.getParameter("type"), ss.getId(), trInfo);
          String sFileType = Utilities.getValue(request.getParameter("output"), "pdf");
          boolean bRet = RequisitionWeb.outputContent(sFilename, sFileType, sUrl, response);
          return;
      }
   }
%>
<%=sError%>
<% } %>