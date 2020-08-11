function initEditor(AreaId)
{
//  var editor = new HTMLArea(AreaId);
//  editor.generate();
 var config = new HTMLArea.Config();
 config.toolbar = [
 [//  "fontname", "space", "fontsize", "space", "formatblock",
  "fontname", "fontsize", "formatblock",
  "bold", "italic", "underline",  "forecolor", "hilitecolor", "separator",
  "strikethrough", "subscript", "superscript", "separator",
  "copy", "cut", "paste", "space", "undo", "redo"],// "separator",

 ["justifyleft", "justifycenter", "justifyright", "justifyfull", "separator",
  "insertorderedlist", "insertunorderedlist", "outdent", "indent", "separator",
//  "forecolor", "hilitecolor", "textindicator", "separator",
  "inserthorizontalrule", "createlink", "insertimage", "inserttable", "htmlmode"]
 ];

 config.statusBar = false;

 if (HTMLArea.is_ie)
 {
  var textarea = HTMLArea.getElementById("textarea", AreaId);
  config.width  = textarea.style.width;
  config.height = textarea.style.height;
 }

 HTMLArea.replace(AreaId, config);
}

function mySubmit(form)
{
// document.edit.save.value = "yes";
  form.onsubmit(); // workaround browser bugs.
  form.submit();
};