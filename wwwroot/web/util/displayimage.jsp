<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.CustomerInfo" %>
<%@ page import="com.zyzit.weboffice.web.CustomerWeb" %>
<%
  CustomerWeb bean = new CustomerWeb(session, request, 0);

//bean.showAllParameters(request, out);
//bean.dumpAllParameters(request);
  int nCustomerId = Utilities.getInt(request.getParameter("customerid"), 0);
  CustomerInfo loginInfo = bean.getCustomerInfo();
  if (loginInfo==null || nCustomerId!=loginInfo.CustomerID)
     return;

  String sUploadFolder = bean.getMemberAreaPath(nCustomerId, "in"); //bean.getProductImagePath();

  String sFilename = request.getParameter("filename");
//System.out.println("sFilename = " + sFilename);
  if (sFilename!=null && bean.getImageFile(request, sUploadFolder, response))
     return;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"  />
<%=bean.getHtmlTitleMeta(request, false)%>
</head>
<body leftmargin="3" topmargin="3">
<img src="<%=bean.getWebsiteUploadUrl(request)+request.getParameter("filename")%>">
<br>
<form name="dsiplayimage" method="post" action="">
<div align="center"><input type="submit" name="Submit" value="Close Window" OnClick="javascript:window.close();"></div>
</form>
</body>
</html>