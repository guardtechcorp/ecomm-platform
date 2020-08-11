<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.bean.MemberProductBean" %>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage" %>
<%
{
    MemberProductBean bean = MemberProductBean.getObject(session, 20);

    ProductInfo info = null;
    if (sRealAction.startsWith("Edit"))
    {
       info = bean.get(request);
//Utilities.dumpObject(info);
    }
    else if (sRealAction.startsWith("prev") || sRealAction.startsWith("next"))
    {
       info = bean.getPrevOrNext(sRealAction);
//System.out.println("cgInfo = "+ cgInfo);
    }
    else if (sRealAction.startsWith("Remove"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            nDisplay = 0;
        }
        else
        {
            sDisplayMessage = "The image file was removed successfully.";
        }
        info = (ProductInfo) ret.getUpdateInfo();
    }
    else  if (sRealAction.startsWith("Add")||sRealAction.startsWith("Update"))
    {
        if (!ret.isSuccess())
        {
            Errors errObj = (Errors) ret.getInfoObject();
            sDisplayMessage = errObj.getError();
            info = (ProductInfo) ret.getUpdateInfo();
            nDisplay = 0;
        }
        else
        {
            info = (ProductInfo) ret.getUpdateInfo();
            if (sRealAction.startsWith("Update"))
               sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "product information");
            else
            {
               sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "product");
               info = null;
            }
        }
    }

    if (info==null)
    {
        info = ProductInfo.getInstance(true);
        info.Active = Definition.ACCESSMODE_PUBLIC;
        info.Orderable = 0;
        info.Taxable = 0;
        info.VisitTime = 0;
        info.SoldCount = 0;
        info.OnlineDelivery = 0;
        sRealAction = "Add";
    }
    else
        sRealAction = "Update";

    int nFileMaxSize = 50*1024; // 50 MB
//    sPageTitle = "Product Information";
%>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/uploadstatus.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/product.js" type="text/javascript"></SCRIPT>
<SCRIPT Language="JavaScript" src="/staticfile/web/scripts/customer.js" type="text/javascript"></SCRIPT>
<script language="JavaScript" src="/staticfile/admin/scripts/editor/wysiwyg.js"></script>
<form name="form_product" action="<%=mcBean.encodedUrl("index.jsp?maxsize="+nFileMaxSize)%>" method="post" enctype="multipart/form-data" onsubmit="return validateProduct(this);" target1="target_upload">
<input type="hidden" name="productid" value="<%=info.ProductID%>">
<input type="hidden" name="subdir" value="product">
<input type="hidden" name="category" value="">
<input type="hidden" name="refinedregion" value="<%=Utilities.getValue(info.RefinedRegion)%>">
<input type="hidden" name="action1" value="">
<TABLE cellpadding="0" cellspacing="0" border="0">
<TR>
 <TD colspan="1" height="1">
  <%@ include file="../include/information.jsp"%>
 </TD>
</TR>
  <TR>
   <TD>
    <table width="100%" cellpadding="0" cellspacing="1" border="0" align="center">
      <tr>
        <td>&nbsp;Fields marked with an asterisk * are required &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="submit" value="<%=sRealAction%>" onClick="setAction(document.form_product, this.value+'_Product');" style="width:100px">
        </td>
        <td align="right">
<% if (info.ProductID>0) { %>
         <%=bean.getPrevNextLinks("index.jsp?", "_Product", true)%>&nbsp;
<% } %>            
        </td>
      </tr>
    </table>
   </TD>
  </TR>
  <TR>
   <TD>
    <TABLE class="table-outline" width="100%" align="center">
     <tr>
      <td width="11%" align="right">* Name:</td>
      <td>
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" size="60" maxlength="255">
        Name of this item, used wherever it is referred to.</td>
     </tr>
     <tr>
      <td width="11%" align="right">Code:</td>
       <td >
        <input type="text" name="code" value="<%=Utilities.getValue(info.Code)%>" size="60" maxlength="128">
        Code you use to identify the item (SKU, ISBN, etc). </td>
      </tr>
      <tr>
       <td width="11%" align="right">Price:</td>
       <td>
          <input type="text" name="price" value="<%=Utilities.getValue(info.Price)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");' size="60">
          If price is entered and Orderable is select "Yes". The item is treated as product for sale.
        </td>
      </tr>
      <tr>
       <td width="11%" align="right">Orderable:</td>
       <td>
         <select name="orderable">
           <option value=1 <%=bean.getSelected(1, info.Orderable)%>>Yes</option>
           <option value=0 <%=bean.getSelected(0, info.Orderable)%>>No</option>
         </select>Select "No" to not display an order button even when item has price.
       </td>
      </tr>
      <tr>
       <td width="11%" align="right" valign="top">* Description:</td>
       <td >
        <textarea rows="5" cols="75" wrap="virtual" id="description" name="description"><%=Utilities.getValue(info.Description)%></textarea>
        <!--script language="javascript1.2">
          createToolbar('description', 600, 100, ",7,10,11,12,13,14,15,16,17,26,32,");
        </script-->
       </td>
      </tr>
      <tr>
        <td width="11%" align="right" valign="top"><br>Images:</td>
        <td >
          <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <input type="hidden" name="largeimageid" value="<%=info.LargeImageID%>">
          <input type="hidden" name="mediumimageid" value="<%=info.MediumImageID%>">
          <input type="hidden" name="smallimageid" value="<%=info.SmallImageID%>">
          <tr>
            <td>
              <b>Large Size:</b> It will display in a single page (with <b>best image quality</b>). <br>
             <input type="file" name="large" size="60">
              <% if (info.LargeImageID>0) { %>
              [<%=mcBean.getPreviewLink("Large", "Large Size Image File", info.LargeImageID, "Preview")%>,
               <a href='<%=bean.encodedUrl("index.jsp?action=Remove File_Product&filetype=LargeImageID&fileid="+info.LargeImageID)%>' onClick="return confirm('Are you sure you want to remove it.');">Remove</a>]
              &nbsp;<%=bean.getFileInfo(info.LargeImageID)%>
              <% } %><br>&nbsp;
            </td>
          </tr>
          <tr>
            <td>
              <b>Medium Size:</b> It will display in the detail page (best size: <b>200 x 200</b> pixels). <br>
              <input type="file" name="medium" size="60">
              <% if (info.MediumImageID>0) { %>
              [<%=mcBean.getPreviewLink("Medium", "Medium Size Image File", info.MediumImageID, "Preview")%>,
               <a href='<%=bean.encodedUrl("index.jsp?action=Remove File_Product&filetype=MediumImageID&fileid="+info.MediumImageID)%>' onClick="return confirm('Are you sure you want to remove it.');">Remove</a>]
              &nbsp;<%=bean.getFileInfo(info.MediumImageID)%>
              <% } %>
             <br>If it is empty, the online system will auto create a medium-size file from the large-size file.<br>&nbsp;
            </td>
          </tr>
          <tr>
            <td valign="top"><b>Small Size:</b> It will be used when an image is needed as a link to this item (best size: <b>80 x 80</b> pixels).<br>
              <input type="file" name="small" size="60">
            <% if (info.SmallImageID>0) { %>
              [<%=mcBean.getPreviewLink("Small", "Small Size File", info.SmallImageID, "Preview")%>,
               <a href='<%=bean.encodedUrl("index.jsp?action=Remove File_Product&filetype=SmallImageID&fileid="+info.SmallImageID)%>' onClick="return confirm('Are you sure you want to remove it.');">Remove</a>]
              &nbsp;<%=bean.getFileInfo(info.SmallImageID)%>
              <% } %>
             <br>If it is empty, the online system will auto create a small-size file from the medium-size/large-size file.<br>&nbsp;
            </td>
          </tr>
          </table>
          </td>
        </tr>
        <!--tr>
         <td class="normal_row" width="11%" align="right" valign="top">Categories:*</td>
         <td class="normal_row">
         <table cellpadding="0" cellspacing="0" border="0">
          <tr>
            <td width="62%" valign="top">
             <select name="categoryoptions" size="6" multiple style="WIDTH: 383px">
              <%=bean.getCategoryList(info, mbInfo.MemberID)%>
             </select>
            </td>
            <td valign="top">The product is belogs to the highlighting category(s).<p>Hold down the Shift or Ctrl key and click on the items you want to select/deselect.</td>
           </tr>
         </table>
         </td>
        </tr-->
     <tr>
      <td width="11%" align="right" valign="top">Category:</td>
      <td >
      <table cellpadding="0" cellspacing="0" border="0">
       <tr>
         <td valign="top">
          <div id="scroll_list" style="width:384px;height:116px;background-color:white;overflow:auto;BORDER: #4279bd 1px solid; ">
            <%=bean.getCategoryList(info, mbInfo.MemberID)%>
          </div>
         </td>
         <td width="1%"></td>
         <td valign="top">The product is belogs to the selected category(s).<p>You check or uncheck them to change the categories to which product belogs.</td>
        </tr>
      </table>
      </td>
     </tr>

     <tr>
      <td width="11%" align="right" valign="top">Refine by region:</td>
      <td >
       <table cellpadding="0" cellspacing="0" border="0">
        <tr>
         <td valign="top">
         <div id="scroll_list1" style="width:384px;height:116px;background-color:white;overflow:auto;BORDER: #4279bd 1px solid; ">
         <Script language = "JavaScript">setCountryCheckboxList();</Script>
         </div>
         </td>
        </tr>
       </table>
      </td>
     </tr>
    <!--tr>
       <td class="normal_row" width="11%" align="right">External Url:<br>&nbsp;</td>
       <td class="normal_row">
         <input type="text" name="externalurl" value="<%=Utilities.getValue(info.ExternalUrl)%>" maxlength="255" size="60">
         A Url, which will display on the detailed page, to link to other website to introduce this product. If it is empty, no link will display.</td>
     </tr-->
      <tr>
         <td width="11%" align="right">Accessed By:</td>
         <td colspan="2">
          <select name="active">
           <%=bean.getAccessOption(info.Active)%>
          </select> If selects 'Nobody', it can not be searchable and show on the website.
         </td>
      </tr>
      <tr>
        <td colspan="2" height="5" ></td>
      </tr>
      <tr>
        <td colspan="2" height="10"><HR align="center" width="99%" color="#D6D6D6" noShade SIZE=1></td>
      </tr>
      <tr>
        <td colspan="2" align="center"><input type="submit" name="submit" value="<%=sRealAction%>" onClick="setAction(document.form_product, this.value+'_Product');" style="width:100px"></td>
      </tr>
    </table>
    </form>
   </TD>
  </TR>
</TABLE>
<SCRIPT Language="JavaScript">onProductLoad(document.form_product);</SCRIPT>
<iframe id='target_upload' name='target_upload' src='' style='display: none'></iframe>
<% } %>