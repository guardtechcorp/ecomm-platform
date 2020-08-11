<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function onSecontLoad(form)
{
  setFocus(form.name);
}

function validateSection(form)
{
  //. check the last name
  if (checkFieldEmpty(form.name))
  {
     alert("You missed to input section name.");
     setFocus(form.name);
     return false;
  }

  return true;
}

function onPageLoad(form)
{
  setFocus(form.name);
}

function validatePage(form)
{
  //. check the last name
  if (checkFieldEmpty(form.name))
  {
     alert("You missed to input page name.");
     setFocus(form.name);
     return false;
  }

//updateTextArea('text');
//alert(form.text.value);
  return true;
}

function onPassageLoad(form)
{
  setFocus(form.name);
}

function validatePassage(form)
{
  //. check the last name
  if (checkFieldEmpty(form.name))
  {
     alert("You missed to input Passage name.");
     setFocus(form.name);
     return false;
  }

//   var sTemp= form.content.value.replace(/<PRE>/,"");
//   form.content.value = sTemp.replace(/<\/PRE>/,"")
   return true;
}

function onQuestionLoad(form)
{
//  setFocus(form.name);
  setEditorFocus('content');
}

function validateQuestion(form)
{
  updateTextArea('content');

//alert("name=" + form.action.value+"!"+form.name.value);
  //. check the last name
  if (checkFieldEmpty(form.content))
  {
     alert("You missed to input Question.");
     setEditorFocus('content');
     return false;
  }

/*
//alert("form.content.value1=" + form.content.value);
  var sTemp= form.content.value.replace(/<PRE>/,"");
  form.content.value = sTemp.replace(/<\/PRE>/,"");
  sTemp= form.content.guide.replace(/<PRE>/,"");
  form.guide.value = sTemp.replace(/<\/PRE>/,"");
  sTemp= form.answer.value.replace(/<PRE>/,"");
  form.answer.value = sTemp.replace(/<\/PRE>/,"");
*/

  return true;
}

function showSolution(sName, bShow)
{
  toggleShow('TS_'+sName);
  if (bShow)
  {
    openAndClose('hide_'+sName, 'show_'+sName);
  }
  else
  {
    openAndClose('show_'+sName, 'hide_'+sName);
  }
}

function goSearch(form)
{
  //. check the last name
  if (checkFieldEmpty(form.keyword))
  {
     alert("You missed to input the search keyword.");
     setFocus(form.keyword);
     return false;
  }

  search(form.keyword.value, parent.frames["examarea"].frames["leftpassage"]);
}

function submitGlobalSearch(form)
{
  //. check the last name
  if (checkFieldEmpty(form.keyword))
  {
     alert("You missed to input the search keyword.");
     setFocus(form.keyword);
     return false;
  }

   var sRequest = "/web/exam/start-frame.jsp?action=Search";
   sRequest += "&domainname=" + form.domainname.value;
   sRequest += "&keyword=" + form.keyword.value;
   sRequest += "&sectionid=" + form.sectionid.value;
   sRequest += "&sessionid=" + form.sessionid.value;
   sRequest += "&time="+new Date().getTime();

//alert(sRequest);
    var sResponse = getUrlContent(sRequest);
//alert("sResponse=!" + sResponse+"!");
    if (sResponse=="-1")
    {
       alert("The keyword you entered was not find any match in any passage page. Please try an another keyword.");
       setFocus(form.keyword);
       return false;
    }
    else
    {
//       form.reset();
      parent.frames["examarea"].location = "exam-frame.jsp?action=Go To Question&sessionid="+form.sessionid.value+"&sectionid="+form.sectionid.value+"&passageno="+sResponse+"&keyword="+form.keyword.value;
//      search(form.keyword.value, "examarea");

      return false;
    }
}