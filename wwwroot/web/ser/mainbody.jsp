<%@ page import="com.zyzit.weboffice.web.TransferWeb"%>
<%
{
/*
<jsp:forward page="gotForwardedRequest.jsp"/>
<jsp: forward page="ssParameters.jsp">
  <jsp: param name="myParam" value="Amar Patel"/>
  <jsp: param name="Age" value="15"/>
</jsp: forward>

//Counter
package Mybean;

public class UsingBeanScopeSession{
  private int counter = 0;
  public void setCounter(int counter){
    this.counter = counter;
  }
  public int getCounter(){
    return counter;
  }
}

<html>
  <head>
    <title>Using Beans and Session Scope</title>
  </head>
  <body>
    <h1>Using Beans and Session Scope</h1>
    <jsp:useBean id="sessionScopeBean" class="Mybean.UsingBeanScopeSession" scope="session" />
 <jsp:useBean id="applicationScopeBean" class="Mybean.UsingBeanScopeApplication" scope="application" />

    <
    sessionScopeBean.setCounter(sessionScopeBean.getCounter() + 1);
    >
Counter value is <= sessionScopeBean.getCounter() >
  </body>
</html>
*/

/*
  String pageName = "/web/ser/pageswitch.jsp";
  RequestDispatcher requestDispatcher = request.getRequestDispatcher(pageName);
  if (requestDispatcher != null){
        requestDispatcher.forward(request, response);
  }
*/
  TransferWeb webprop = new TransferWeb(session, request);
  TransferWeb.ResponseResult ret = webprop.forwardToJsp(request, "/web/ser/pageswitch.jsp");
//System.out.println("redirect=" + ret.sContent);
  if (ret.bRedirect)
  {
//System.out.println("redirect=" + ret.sContent);
    response.sendRedirect(webprop.encodedUrl(ret.sContent));
    return;
  }
%>
<%=ret.sContent%>
<% } %>