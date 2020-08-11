<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.CategoryInfo"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.MemberCategoryBean" %>
<%
{
    MemberCategoryBean bean = new MemberCategoryBean(session, 20);

    CategoryInfo info = null;
    if (sRealAction.startsWith("Edit")) {
        info = bean.get(request);
//Utilities.dumpObject(info);
    } else if (sRealAction.startsWith("prev") || sRealAction.startsWith("next")) {
        info = bean.getPrevOrNext(sRealAction);
//System.out.println("cgInfo = "+ cgInfo);
    } else if (sRealAction.startsWith("Add") || sRealAction.startsWith("Update")) {
        if (!ret.isSuccess()) {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            info = (CategoryInfo) ret.getUpdateInfo();
            nDisplay = 0;
        } else {
            info = (CategoryInfo) ret.getUpdateInfo();
            if (sRealAction.startsWith("Update"))
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "category information");
            else {
                sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "category");
                info = null;
            }
        }
    }

    if (info == null) {
        info = CategoryInfo.getInstance(true);
        info.Active = Definition.ACCESSMODE_PUBLIC;
        info.Reference = 0;
        info.LayoutID = 1;
        info.BackColor = "#ffffff";
        info.RowsPerPage = 10;
        info.SortOrder = 0;

        sRealAction = "Add";
    } else
        sRealAction = "Update";

//Utilities.dumpObject(info);
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/product.js" type="text/javascript"></SCRIPT>
<TABLE cellpadding="0" cellspacing="0" border="0">
 <TR>
   <TD height="1">
   <%@ include file="../include/information.jsp"%>
  </TD>
 </TR>
 <TR>
  <TD>
  <table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
   <tr>
    <td>&nbsp;Fields marked with an asterisk * are required</td>
    <td align="right">
<% if (info.CategoryID>0) { %>
     <%=bean.getPrevNextLinks("index.jsp?", "_Category", true)%>&nbsp;
<% } %>
    </td>
   </tr>
  </table>
 </TD>
</TR>
<TR>
 <TD>
<FORM name="form_category" action="<%=mcBean.encodedUrl("index.jsp")%>" method="post" onSubmit="return validateCategory(this);">
<input type="hidden" name="categoryid" value="<%=info.CategoryID%>">
<input type="hidden" name="action1" value="">
<table class="table-outline" width="100%" align="center">
    <tr>
      <td class="row1" width="17%" align="right">* Name:</td>
      <td class="row1" width="48%">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" class="post" maxlength="30" size="30">
      </td>
      <td class="row1">The name of category.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right" valign="top">Description:</td>
      <td class="row1" width="48%">
        <textarea rows="4" cols="40" wrap="virtual" name="description"><%=Utilities.getValue(info.Description)%></textarea>
      </td>
      <td class="row1" valign="top">Text for this category. It will appear on the top of each page of product list.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Display Layout:</td>
      <td class="row1" width="48%" >
        <select name="layoutid">
          <%=bean.getLayoutList(info.LayoutID)%>
        </select>
        <a href="javascript:viewSampleImage('Category', document.form_category.layoutid.value)">View sample layout</a></td>
      <td class="row1">The display layout of products in this category.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Background Color:</td>
      <td class="row1" width="48%">
       <input type="text" name="backcolor" value="<%=Utilities.getValue(info.BackColor)%>" maxlength="7" size="7" style="color: <%=info.BackColor%>" onClick="javascript:loadSelectColor(this, 2);">
      </td>
      <td class="row1">The background color of products displaying in this screen.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Max Rows/Page:</td>
      <td class="row1" width="48%">
        <input type="text" name="rowsperpage" value="<%=Utilities.getValue(info.RowsPerPage)%>" maxlength="6" size="4" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
      </td>
      <td class="row1">The max products will display on each page.</td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Sort By:</td>
      <td class="row1" width="48%">
       <select name="sortfieldname">
        <option value="" <%=bean.getSelected("", info.SortFieldName)%>>Default given by system</option>
        <option value="Name" <%=bean.getSelected("Name", info.SortFieldName)%>>Name/Title</option>
        <option value="Price" <%=bean.getSelected("Price", info.SortFieldName)%>>Product Price</option>
        <option value="CreateDate" <%=bean.getSelected("CreateDate", info.SortFieldName)%>>Added Date and Time</option>
        <option value="ModifyDate" <%=bean.getSelected("ModifyDate", info.SortFieldName)%>>Modified Date and Time</option>
        <option value="VisitTime" <%=bean.getSelected("VisitTime", info.SortFieldName)%>>Visited Times</option>
       </select>&nbsp;
        <input type="radio" value="0" name="sortorder" <%=bean.getChecked(0, info.SortOrder)%>>Ascending
        <input type="radio" value="1" name="sortorder" <%=bean.getChecked(1, info.SortOrder)%>>Descending
      </td>
      <td class="row1"></td>
    </tr>
    <tr>
      <td class="row1" width="17%" align="right">Accessed By:</td>
      <td class="row1" width="48%">
       <select name="active">
        <%=bean.getAccessOption(info.Active, 0)%>
       </select>
      </td>
      <td class="row1">If selects 'Nobody', this category will not show on website.</td>
    </tr>
    <tr>
     <td colspan="3"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
    </tr>
    <tr>
     <td class="row1" width="17%" align="right">&nbsp;</td>
     <td class="row1" colspan="2">
      <input type="submit" name="submit" style='width:120px' value="<%=sRealAction%>" onClick="setAction(document.form_category, this.value+'_Category');">
      </td>
    </tr>
  </table>
</FORM>
<SCRIPT>onCategoryFormLoad(document.form_category);</SCRIPT>
  </TD>
 </TR>
</TABLE>    
<% } %>
<%

/*    
    FF1+ IE5+ Opr7+
    DOM Drag & Drop script
    Author: Aaron Boodman | Homepage

    Description: This is a superb DOM drag and drop script that be used on any relatively or absolutely positioned element on the page to make it instantly dragable. What we like most about this script is its very compact, no fuss design. The script also fires 3 custom event handlers that let your page sense and react to the dragging in some fashion. Very nice!

    Simple example:

    Drag me!

    Directions: Developer's View

    Step 1: Add the below code to the <HEAD> section of your page:

    Select All
    <script type="text/javascript" src="dom-drag.js"></script>

    Step 2: As you can see, this script references an external .js file. Download "dom-drag.js" (right click, and select "Save-As"), and upload to your web page directory. And that's it, well the installation part at least.
    Applying the script to an element
    Note: See also: author's tutorial page.

    Now here comes the fun part, making an element on the page dragable!

    The basic version

    To make an element draggable using this script simply call Drag.init(obj), with "obj" being the reference to the element in question. For example:

    <img id="example" src="lips.gif" style="position: relative" />

    <script type="text/javascript">
    Drag.init(document.getElementById("example"));
    </script>

    A couple of important points to mention here:

        *

          This script can only be used on relatively or absolutely positioned elements. Furthermore, you should define its "position" inline inside the element, for example: <img src="cake.gif" style="position: relative" />.
        *

          The method Drag.init(obj) obviously should be called following the element in question. Alternatively you can also call this method after the page has loaded (window.onload).

    Creating a draggable handle

    Sometimes you want to set only a special area within a complex object to be draggable - aka a handle. To do this, pass two references to the method Drag.init(): the handle and the root.

    <div id="root" style="left:50px; top:50px;">
    <div id="handle">Handle</div>
    Some text
    </div>

    <script type="text/javascript">
    var theHandle = document.getElementById("handle");
    var theRoot = document.getElementById("root");
    Drag.init(theHandle, theRoot);
    </script>

    See complete example

    When you view the source of the example page above, notice how while most of the CSS for the DIV is defined in the HEAD section of the page, at the very least, the "top" and "left" properties to affect initial positioning need to be defined inside the <DIV> tag itself.

    Limiting the range of the drag

    You can also set up the drag behavior in a way so the dragging is limited by range, whether vertically or horizontally. This is useful, for example, when you're creating an artificial scrollbar, and it should only be allowed to be dragged vertically or horizontally a certain distance.

    <div id="thumb" style="position: relative; left:0; top:0;"></div>

    <script language="javascript">
    var aThumb = document.getElementById("thumb");
    Drag.init(aThumb, null, 0, 300, 0, 0);
    </script>

    See another example. (absolutely positioned scrollbar instead of relative).

    Those 4 numbers at the end are the constraining rectangle of the draggable object. They go in the order: minX, maxX, minY, maxY. You can set some of them to null to tell DOM-Drag that motion in that direction should not be constrained. Note also how we have set the root object parameter to null in this case, since the thumb is not a handle for anything.

    Drag and react

    What good is dragging if it your page cant be aware of and react to this action? DOM-Drag fires three events into the environment that you can tap into:

    .onDragStart(x,y)
    .onDragEnd(x,y)
    .onDrag(x,y).

    These custom event handlers allow your page to react to the dragging in any fashion your creativity takes you. Take a look at this script to see how to use some of these event handlers:

    <script language="javascript">
    var aThumbv = document.getElementById("thumbv");
    var scrolldiv=document.getElementById("scrollcontent");
    Drag.init(aThumbv, null, 0, 0, 0, 150);
    aThumbv.onDrag = function(x, y) {// x, y contains current offset coords of drag
    scrolldiv.style.top=y * (-1) +"px";
    }
    </script>


----------------------------------------------
<body onload="ajaxLoader('basic.xml','contentLYR')">
<div id="contentLYR">
</div>
</body>
<script type="text/javascript">
   function ajaxLoader(url,id)
	{
		if (document.getElementById) {
			var x = (window.ActiveXObject) ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
			}
			if (x)
				{
			x.onreadystatechange = function()
					{
				if (x.readyState == 4 && x.status == 200)
						{
						el = document.getElementById(id);
						el.innerHTML = x.responseText;
					}
					}
				x.open("GET", url, true);
				x.send(null);
				}
	    }

</script>

------------------------------------------------------
<script>
<!--

//specify FULL path to midi
var musicsrc="http://www.yourdomain.com/allfor.mid"
if (navigator.appName=="Microsoft Internet Explorer")
document.write('<bgsound src='+'"'+musicsrc+'"'+' loop="infinite">')
else
document.write('<embed src=\"'+musicsrc+'\" hidden="true" border="0" width="20" height="20" autostart="true" loop="true">')
//-->
</script>


---------------------------------------------
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>

<script type="text/javascript" src="jquery-1.2.2.pack.js"></script>

<script type="text/javascript" src="ddaccordion.js">

</script>


<script type="text/javascript">

ddaccordion.init({
	headerclass: "expandable", //Shared CSS class name of headers group that are expandable
	contentclass: "categoryitems", //Shared CSS class name of contents group
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
	defaultexpanded: [0], //index of content(s) open by default [index1, index2, etc]. [] denotes no content
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", "openheader"], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["prefix", "", ""], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "normal" //speed of animation: "fast", "normal", or "slow"
})
</script>
*/
%>