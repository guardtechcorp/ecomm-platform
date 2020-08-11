<%@ page import="java.util.List"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ExamSectionBean"%>
<%@ page import="com.zyzit.weboffice.bean.ExamQuestionBean"%>
<%@ page import="com.zyzit.weboffice.model.ExamPassageInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamQuestionInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamSectionInfo"%>
<%@ page import="com.zyzit.weboffice.model.ExamChoiceInfo"%>
<html>
<head>
<title>Question Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--LINK href="/staticfile/web/css/common.css" type="text/css" rel="stylesheet"-->
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/index.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/bookmark.js" type="text/javascript"></SCRIPT>
</head>
<%
//bean.showAllParameters(request, out);
  ExamSectionBean bean = new ExamSectionBean(session, 0);
  ExamSectionBean.Result ret = bean.getStepInfo(request);
  ExamPassageInfo PassageInfo = (ExamPassageInfo)ret.getUpdateInfo();
  int nStartNo = ((Integer)ret.getInfoObject()).intValue();

  ExamQuestionBean question = new ExamQuestionBean(session, 0);
  List ltQuestion = question.getQuestionList(PassageInfo.PassageID);

  ExamSectionInfo info = bean.getSectionInfo(request);
%>
<script LANGUAGE="JavaScript">
function right(e)
{
    if (navigator.appName == 'Netscape' && (e.which == 3 || e.which == 2))
       return false;
    else if (navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2 || event.button == 3))
    {
       checkAction(2);
       return false;
    }

    return true;
}
document.onmouseup=right;
if (document.layers) window.captureEvents(Event.MOUSEUP);
window.onmouseup=right;
document.oncontextmenu= new Function("return false");

function getChoices()
{
  var form = document.question;
  var sCgi = "";
  for (var i=0;i<form.elements.length;i++)
  {
     var e = form.elements[i];
     if (e.type=='radio')
     {
        if (e.checked)
        {
          sCgi += '&' + e.name + '=' + e.value;
        }
     }
  }
  return sCgi;
}

function onOffSolution(sPrefix, sChoices)
{
  var arChoices = sChoices.split(",");
  for (i=0; i<arChoices.length; i++)
  {
    toggleShow(sPrefix+"_"+arChoices[i]);
  }
}

function onPageLoad()
{
  restoreAllBookmark('<%=bean.getBookmark(request, 1)%>');
}
</script>
<body bgcolor="<%=info.BackColor%>" onLoad="onPageLoad();">
<form name="question" action="right-question.jsp" method="post" onsubmit="return true;">
<table width="100%" border="0">
<%
  for (int i=0; i<ltQuestion.size(); i++) {
    ExamQuestionInfo questionInfo = (ExamQuestionInfo)ltQuestion.get(i);
    List ltChoice = question.getChoiceList(questionInfo.QuestionID);

    String sShowSolution = "";
    String sChoiceIds = null;
    String sPrefix = "TS_" + questionInfo.QuestionID;

    for (int k=0; k<ltChoice.size(); k++)
    {
      ExamChoiceInfo choiceInfo = (ExamChoiceInfo)ltChoice.get(k);
      if (choiceInfo.Solution!=null && choiceInfo.Solution.trim().length()>0)
      {
         if (sChoiceIds!=null)
            sChoiceIds +=",";
         else
            sChoiceIds ="";
         sChoiceIds += choiceInfo.ChoiceID;
      }
    }

    if (sChoiceIds!=null)
      sShowSolution = "<a href=\"javascript:onOffSolution('"+sPrefix+ "', '"+sChoiceIds+"');\">Solution<a>";

//<DIV id="off_savesearch"><A class="reportoptions" onClick="displayLayer('savesearch');" href="javascript:;"><IMG border="0" align='absmiddle' src="/images/arrow.gif">Save&nbsp;Search:</A></DIV>
//<DIV id="on_savesearch" style="display:none"><A class="reportoptions" onClick="displayLayer('savesearch');showContent('','savemgs');" href="javascript:;"><IMG border="0" align="absmiddle" src="/images/arrowdown.gif">Save&nbsp;Search:</A></DIV>
%>
<% if (i>0) { %>
      <tr>
        <td colspan=2><hr></td>
      </tr>
<% } %>
  <tr>
    <td colspan="2"><%=(nStartNo+i)%>.  <%=questionInfo.Content%></td>
  </tr>
  <tr>
    <td width="3%" valign="top"><%=sShowSolution%></td>
    <td width="97%">
      <table width="100%" border="0" cellpadding="1" cellspacing="1">
<%
  char cOrder = 'A'-1;
  for (int k=0; k<ltChoice.size(); k++) {
    ExamChoiceInfo choiceInfo = (ExamChoiceInfo)ltChoice.get(k);
    cOrder++;
    boolean bSingleSolution = choiceInfo.Solution!=null && choiceInfo.Solution.trim().length()>0;
%>
      <tr>
        <td width="5%" align="right" valign="top"><input type="radio" name="q_<%=questionInfo.QuestionID%>" value="<%=choiceInfo.ChoiceID%>" <%=bean.getChoiceChecked(questionInfo.QuestionID, choiceInfo.ChoiceID)%>><%=cOrder%>.</td>
        <td width="1%" valign="top">&nbsp;</td>
        <td width="94%" valign="top"><%=choiceInfo.Content%></td>
      </tr>
<% if (bSingleSolution) { %>
      <tr>
        <td colspan="3" width="100%" valign="top">
         <DIV id='<%=sPrefix%>_<%=choiceInfo.ChoiceID%>' style="display: none"><table cellspacing=0 cellpadding=0 width="100%" align="center" border=0 class1="infobox">
          <tr>
           <td><font size="2" face="Verdana, Arial, Helvetica, sans-serif" color="#FF6633"><%=choiceInfo.Solution%></font></td>
          </tr>
         </table></DIV>
        </td>
      </tr>
<% } %>
<% } %>
      </table>
    </td>
  </tr>
<% } %>
</table>
</form>
</body>
</html>
