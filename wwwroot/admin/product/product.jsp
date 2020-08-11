<link rel="stylesheet" type="text/css" href="/staticfile/admin/css/jquery-ui.css">
<script language=JavaScript type="text/javascript" src="/staticfile/admin/scripts/jquery_pack.js"></script>
<script language=JavaScript type="text/javascript" src="/staticfile/admin/scripts/jquery-ui-min.js"></script>
<%@ include file="../share/uparea.jsp"%>
<%@ page import="com.zyzit.weboffice.util.*"%>
<%@ page import="com.zyzit.weboffice.message.DisplayMessage"%>
<%@ page import="com.zyzit.weboffice.bean.ProductBean"%>
<%@ page import="com.zyzit.weboffice.model.ProductInfo"%>
<%@ page import="com.zyzit.weboffice.web.ProductWeb" %>
<%
  ProductBean bean = new ProductBean(session);
  if (!bean.canAccessPage(request, response, AccessRole.ROLE_PRODUCT))
     return;

//bean.showAllParameters(request, out);
  String sAction = request.getParameter("action");
  String sDisplayMessage = null;
  String sClass = "successful";
  ProductInfo info = null;

  if ("Download".equalsIgnoreCase(sAction))
  {
     bean.getFileContent(request, response);
     return;
  }
  else if ("GetStatus".equalsIgnoreCase(sAction))
  {
//     bean.updateStatus(response);
     return;
  }
  else  if ("Update Product".equalsIgnoreCase(sAction))
  {
    ProductBean.Result ret = (ProductBean.Result)session.getAttribute(ProductBean.KEY_UPLOADRESULT);

    sAction = ret.m_sAction;
    if (!ret.isSuccess())
    {
      Errors errObj = (Errors)ret.getInfoObject();
      sDisplayMessage = errObj.getError();
      info = (ProductInfo)ret.getUpdateInfo();
      sClass = "failed";
    }
    else
    {
      if ("Update Product".equalsIgnoreCase(sAction))
      {
         info = (ProductInfo)ret.getUpdateInfo();
         sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_UPDATEINFO_SUCCESS, null).replaceAll("%s", "product");
      }
      else
         sDisplayMessage = DisplayMessage.getMessage(DisplayMessage.DM_ADDINFO_SUCCESS, null).replaceAll("%s", "product");
    }
  }
//  else if ("removeimage".equalsIgnoreCase(sAction))
//  {
////    int nPdId = Utilities.getInt(request.getParameter("pdid"), 0);
//    info = (ProductInfo)bean.getCacheMap().get(bean.KEY_TEMPINFO);
//    String sImageSize = request.getParameter("imagesize");
//    if ("small".equalsIgnoreCase(sImageSize))
//       info.SmallImage = "";
//    else if ("medium".equalsIgnoreCase(sImageSize))
//       info.MediumImage = "";
//    else if ("large".equalsIgnoreCase(sImageSize))
//       info.LargeImage = "";
//    else if ("download".equalsIgnoreCase(sImageSize))
//       info.DownloadFile = "";
//
//    sDisplayMessage = "You have to click <b>Update Product</b> button to remove it permanently.";
//    sAction = "Update Product";//request.getParameter("actionstatus");
//  }
  else if ("copy".equalsIgnoreCase(sAction))
  {
    info = (ProductInfo)bean.getLastInfo();
    info.ProductID = -1;
    info.Name = "Copy of " + info.Name;
    info.SmallImage = null;
    info.MediumImage = null;
    info.LargeImage = null;
    info.DownloadFile = null;

    sAction = "Add Product";
  }
  else if ("Edit Product".equalsIgnoreCase(sAction))
  {
      info =  bean.get(request);
      sAction = "Update Product";
  }
  else if ("prev".equalsIgnoreCase(sAction)||"next".equalsIgnoreCase(sAction))
  {
     info =  bean.getPrevOrNext(sAction);
     sAction = "Update Product";
//System.out.println("cgInfo = "+ cgInfo);
  }

  if (info==null)
  {
    info = ProductInfo.getInstance(true);
    info.Active = 1;
    info.Orderable = 1;
    info.Taxable = 1;
    info.VisitTime = 0;
    info.SoldCount = 0;
    info.OnlineDelivery = 0;
info.Auction = 0;
    info.Instruction = "You can download product by click [$download$].";
    sAction = "Add Product";
  }

  String sHelpTag = "product";
  String sTitleLinks = "";
  String sDescription;
  if ("Add Product".equalsIgnoreCase(sAction))
  {
     sTitleLinks = "<a href=\"productlist.jsp?action=list\">Product List</a> > <b>Add a New Product</b>";
     sDescription = "The form below allows you to create a new product.";
  }
  else
  {
     sTitleLinks += "<a href=\"productlist.jsp?action=list\">Product List</a> > <b>Edit the Product</b>";
     sDescription = "The form below allows you to edit and update the product information.";
  }
%>
<script type="text/javascript">
$(document).ready(function() {
    var dates = $( "#datefrom, #dateto" ).datetimepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 1,
        dateFormat: "yy-mm-dd",
        constrainInput: true,
        showSecond: true,
        timeFormat: 'hh:mm:ss'

//        onSelect: function( selectedDate ) {
//            var option = this.id == "datefrom" ? "minDate" : "maxDate",
//                instance = $( this ).data( "datepicker" ),
//                date = $.datepicker.parseDate(
//                    instance.settings.dateFormat ||
//                    $.datepicker._defaults.dateFormat,
//                    selectedDate, instance.settings );
//            dates.not( this ).datepicker( "option", option, date );
//        }
    });
});
</script>
<SCRIPT Language="JavaScript" src="/staticfile/admin/scripts/product.js"></SCRIPT>
<SCRIPT Language="JavaScript">setUpArea('<%=sHelpTag%>', '<%=sTitleLinks%>');</SCRIPT>
<%=sDescription%>
<%@ include file="../share/waitprocess.jsp"%>
<SPAN id="ProductInfomation">
<form name="product" style="margin: 0px; padding: 0px" action="productmixform.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateProduct2(this)">
<input type="hidden" name="productid" value="<%=info.ProductID%>">
<input type="hidden" name="sequence" value="<%=info.Sequence%>">
<input type="hidden" name="starttime" value="<%=info.StartTime%>">
<input type="hidden" name="endtime" value="<%=info.EndTime%>">
<% if (!"Add Product".equalsIgnoreCase(sAction)) { %>
<table width="99%" cellpadding="0" cellspacing="1" border="0" align="center">
  <tr>
    <td align="right"><%=bean.getPrevNextLinks("product.jsp?")%></td>
  </tr>
</table>
<% } %>
<table width="99%" cellpadding="2" cellspacing="1" border="0" class="forumline" align="center">
  <tr>
    <th class="thHead" colspan="2">Product Settings</th>
    <th class="thHead" width="28%" align="center"><input type="submit" name="action" value="<%=sAction%>"></th>
  </tr>
<% if (sDisplayMessage!=null) { %>
    <tr>
      <td class="row1" colspan="2" align="center"><span class="<%=sClass%>"><%=sDisplayMessage%></span></td>
      <td class="row1" width="28%" align="right"><%=bean.getCopyPreviousLink(sAction)%></td>
    </tr>
<% } %>
    <!--tr>
      <td class="row1" colspan="2" height="12"><span class="gensmall">Items marked with a * are required unless stated otherwise.</span></td>
      <td class="row1" width="28%" height="12" align="right"><%=bean.getCopyPreviousLink(sAction)%></td>
    </tr-->
    <tr>
      <td class="row1" width="14%" align="right">Name:*</td>
      <td class="row1" colspan="2">
        <input type="text" name="name" value="<%=Utilities.getValue(info.Name)%>" maxlength="255">
        Name of this item, used wherever it is referred to.</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Code:</td>
      <td class="row1" colspan="2">
        <input type="text" name="code" value="<%=Utilities.getValue(info.Code)%>" maxlength="128">
        Code you use to identify the item (SKU, Item number, ISBN, etc). </td>
    </tr>
    <tr>
     <td class="row1" width="14%" align="right">Author:</td>
     <td class="row1" colspan="2">
      <input type="text" name="author" value="<%=Utilities.getValue(info.Author)%>" maxlength="512">
      Who made this product (It may be a person or a company or etc.). </td>
    </tr>
  <tr>
      <td class="row1" width="14%" align="right">Auction:</td>
      <td class="row1" colspan="2">
          <select name="auction" onchange="onAuctionChange(this)" disabled>
              <option value=1 <%=bean.getSelected(1, info.Auction)%>>Yes</option>
              <option value=0 <%=bean.getSelected(0, info.Auction)%>>No</option>
          </select>
          Select &#147;No&#148; to be a reqular product, otherwise &#147;Yes&#148; it is a auctionalble product.
      </td>
  </tr>
  <tr>
     <td colspan="3">
      <div id="id_regular" style="display:<%=info.Auction==0?"block":"none"%>">
      <table width="100%" cellpadding2="0" cellspacing2="0">
          <tr>
              <td class="row1" width="14%" align="right">Price:</td>
              <td class="row1" colspan="2">
                  <input type="text" name="price" value="<%=Utilities.getValue2(info.Price)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
                  If price is entered, item is treated as product for sale. </td>
          </tr>
          <tr>
              <td class="row1" align="right">Sale Price:</td>
              <td class="row1" colspan="2">
                  <input type="text" name="saleprice" value="<%=Utilities.getValue2(info.SalePrice)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
                  Price entered here overrides the regular price. Same format. </td>
          </tr>
          <tr>
              <td class="row1" align="right">Member Price:</td>
              <td class="row1" colspan="2">
                  <input type="text" name="memberprice" value="<%=Utilities.getValue2(info.MemberPrice)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
                  Price entered here is the member price. Only the membership after login can enjoy this price.</td>
          </tr>
       </table>
      </div>

     <div id="id_auction" style="display:<%=info.Auction!=0?"block":"none"%>">
     <table width="100%" cellpadding2="0" cellspacing2="0">
         <tr>
             <td class="row1" width="14%" align="right">* Start Price:</td>
             <td class="row1" colspan="2">
               <input type="text" name="price2" value="<%=Utilities.getValue2(info.Price)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
                 It is the starting lowest price. </td>
         </tr>
         <tr>
             <td class="row1" align="right">* Incremental Price:</td>
             <td class="row1" colspan="2">
                 <input type="text" name="memberprice2" value="<%=Utilities.getValue2(info.MemberPrice)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");'>
                 It is an incremental price for each auction bidding.</td>
         </tr>
<%
    String StartTime = "";
    if (info.StartTime>0)
       StartTime = Utilities.getDateTime(info.StartTime);
    String EndTime = "";
    if (info.EndTime>0)
       EndTime = Utilities.getDateTime(info.EndTime);
%>
         <tr>
             <td class="row1" align="right">Start Date: </td>
             <td class="row1"><input type="text" name="datefrom" id="datefrom" value="<%=Utilities.getMaxLengthValue(StartTime, 19)%>" class2="post" maxlength="255" style2="width:200px">
              Auction start date and time. If it is empty, auction will start immediately.</td>
         </tr>
         <tr>
             <td class="row1" align="right">* End Date: </td>
             <td class="row1"><input type="text" name="datto" id="dateto" value="<%=Utilities.getMaxLengthValue(EndTime, 19)%>" class2="post" maxlength="255" style2="width:200px">
             Auction end date and time. This date will end the auction and  this product will be sold to the customer who did the latest bidding and offer the highest price.
             </td>
         </tr>
      </table>
     </div>
     </td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Orderable:</td>
      <td class="row1" colspan="2">
        <select name="orderable">
          <option value=1 <%=bean.getSelected(1, info.Orderable)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Orderable)%>>No</option>
        </select>
        Select &#147;No&#148; to not display an order button even when item has
        price. Setting to &#147;No&#148; useful when an item is out of stock and
        you do not wish to accept back orders.</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Taxable:</td>
      <td class="row1" colspan="2">
        <select name=taxable>
          <option value=1 <%=bean.getSelected(1, info.Taxable)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.Taxable)%>>No</option>
        </select>
        If yes, sales tax will be applied as you have specified.</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right" valign="top">Main Photo:</td>
      <td class="row1" valign="top">
        <table width2="100%" border="0">
          <input type="hidden" name="smallimage" value="<%=Utilities.getValue(info.SmallImage)%>">
          <input type="hidden" name="mediumimage" value="<%=Utilities.getValue(info.MediumImage)%>">
          <input type="hidden" name="largeimage" value="<%=Utilities.getValue(info.LargeImage)%>">
            <tr>
             <td valign="top">Large-Size:
                 <% if (info.LargeImage!=null&&info.LargeImage.length()>0) { %>
                 &nbsp; &nbsp;<a href="../util/displayimage.jsp?filename=<%=bean.getImageFileName(info.LargeImage)%>" target="imageview">Preview</a>
                 &nbsp; &nbsp;<a href="../util/downloadfile.jsp?filename=<%=bean.getImageFileName(info.LargeImage)%>">Download</a>
                 &nbsp; &nbsp;Delete: <input type="checkbox" value="<%=info.ProductID%>" name="delimage_large">
                 <% } %><br>
                <input type="file" name="large" size="60">
             </td>
            </tr>
            <tr>
              <td>Medium-Size:  <% if (info.MediumImage!=null&&info.MediumImage.length()>0) { %>
                &nbsp; &nbsp;<a href="../util/displayimage.jsp?filename=<%=bean.getImageFileName(info.MediumImage)%>" target="imageview">Preview</a>
                &nbsp; &nbsp;<a href="../util/downloadfile.jsp?filename=<%=bean.getImageFileName(info.MediumImage)%>">Download</a>
                &nbsp; &nbsp;Delete: <input type="checkbox" value="<%=info.ProductID%>" name="delimage_medium">
                <% } %><br>
                <input type="file" name="medium" size="60">

              </td>
           </tr>
          <tr>
            <td>Small-Size:<% if (info.SmallImage!=null&&info.SmallImage.length()>0) { %>
              &nbsp; &nbsp;<a href="../util/displayimage.jsp?filename=<%=bean.getImageFileName(info.SmallImage)%>" target="imageview">Preview</a>
              &nbsp; &nbsp;<a href="../util/downloadfile.jsp?filename=<%=bean.getImageFileName(info.SmallImage)%>">Download</a>
              &nbsp; &nbsp;Delete: <input type="checkbox" value="<%=info.ProductID%>" name="delimage_small">
              <% } %><br>
              <input type="file" name="small" size="60">              
            </td>
          </tr>
        </table>
      </td>
      <td valign="top"><b>Large-Size:</b> if supplied, the item's page will also containthis image. With best image quality but less than 1 MB for better performance.
          <br><b>Medium-Size:</b> if supplied, It will be used when an image is needed as a link to this item. Its best image size: 200 x 268 pixels.
          <br><b>Small-Size:</b> if supplied, the item's page will also contain a thumbnail-sized version of this image. Its image size: 80 x 100 pixels.
          <p>if a medium or small size image do not provide, the system will generated it or them with Large-Size photo. 
      </td>
    </tr>
  <%
      String[] arMoreFile = null;
      if (info.ProductID>0)
         arMoreFile = bean.getMoreFileList(info, ProductWeb.MOREFILE_LARGE);
      if (arMoreFile!=null) {
  %>
    <tr>
     <td class="row1" width="14%" align="right" valign="top">More Photos: </td>
     <td class="row1" colspan="2">
       <table width="100%" style2="border-bottom:1px solid #DFDFDF">
<% for (int i=0; i<arMoreFile.length; i++) { %>
          <tr>
           <td valign="top">
           <%=(i+1)%>. <a href="../util/displayimage.jsp?filename=<%=arMoreFile[i]%>" target="imageview">Preview</a>
           &nbsp;<a href="../util/downloadfile.jsp?filename=<%=arMoreFile[i]%>">Download</a>
           &nbsp; &nbsp;Delete:<input type="checkbox" value="<%=arMoreFile[i]%>" name="delimage_<%=(i+1)%>">
           </td>
          </tr>
  <% } %>
      </table>
     </td>
   </tr>
<% } %>
    <tr>
     <td class="row1" width="14%" align="right" valign="top">
       <a id="addupload" class1="button" href="javascript:;" onClick="return addUpload('file', 'desc')">Add Photo Input</a>&nbsp;
     </td>
     <td class="row1" colspan="2">
      <table width="100%" style2="border-bottom:1px solid #DFDFDF">
          <tr>
           <td>
           <span id="attachparent"><span id="attachmentmarker"></span></span>
           <div id="attachment" style="display:none;height:22px">
           <span id="dropcap" class="dropcap" style="text-align: center">1</span>.&nbsp;
           <input id="file" name="file" style="background-color1: #ddeeee;" type="file" size="56" multiple2 />&nbsp;&nbsp;
           <input id="desc" name="desc" type="hidden"/>
           <a href="#" onclick="return removeFile(this.parentNode.parentNode,this.parentNode);">Remove</a>
           </div>
           </td>
          </tr>
       </table>
      </td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right" valign="middle">Description:*</td>
      <td class="row1" width="58%">
        <textarea rows="5" cols="60" wrap="virtual" name="description"><%=Utilities.getValue(info.Description)%></textarea>
      </td>
      <td class="row1" width="28%">Text for this item. Appears on the item's page or on the containing page if the item doesn't have its own.</td>
    </tr>
    <!--tr>
      <td class="row1" width="14%" align="right">External Url:<br>&nbsp;</td>
      <td class="row1" colspan="2">
        <input type="text" name="externalurl" value="<%=Utilities.getValue(info.ExternalUrl)%>" maxlength="255" size="60">
        A Url, which will display on the detailed page, to link to other website to introduce this product. If it is empty, no link will display.</td>
    </tr-->
    <tr>
      <td class="row1" width="13%" height="78" align="right">Options:</td>
      <td class="row1" height="78" width="59%">
        <textarea name=options rows=4 cols=60><%=Utilities.getValue(info.Options)%></textarea>
      </td>
      <td class="row1" height="78" width="28%">For items with multiple sizes,
        colors, etc. In each set of options, the first word is the title and the
        rest are the choices. Use a blank line to separate sets of options, and
        double-quotes to make several words be treated as one. Example: <br>
        Size S M L XL<br>
        Color Black White "Sea Green"</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Ship-Weight:</td>
      <td class="row1" colspan="2">
        <input type="text" name="weight" value="<%=Utilities.getValue2(info.Weight)%>" onBlur='autoFormat(this,"F");' onKeyUp='autoFormat(this,"F");' />
        Shipping weight of this item. Only needed if your shipping charges go
        by weight.</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Stock:</td>
      <td class="row1" colspan="2" >
        <input type="text" name="stock" value="<%=Utilities.getValue(info.Stock)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
        How many qualities in your stock.</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Online-Product:</td>
      <td class="row1" colspan="2">
        <select name="onlinedelivery" onChange="onDeliveryChange(document.product.onlinedelivery, 'ONLINE_PRODUCT')" disabled>
          <option value=1 <%=bean.getSelected(1, info.OnlineDelivery)%>>Yes</option>
          <option value=0 <%=bean.getSelected(0, info.OnlineDelivery)%>>No</option>
        </select> If selects 'Yes', the product is a electronic product and need to download online.
     </td>
    </tr>
<tr>
  <td height="0" valign="top" colspan="3">
   <DIV id="ONLINE_PRODUCT" <%if(info.OnlineDelivery==0){%>style="DISPLAY: none"<%}%>>
   <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="row1" width="14%" align="right" valign="middle">Downlaod File:</td>
      <td class="row1" colspan="2">
        <table width="100%" border="0">
          <input type="hidden" name="downloadfile" value="<%=Utilities.getValue(info.DownloadFile)%>">
          <tr>
            <td height="25" valign="top">
              <input type="file" name="localfile">
              <% if (info.DownloadFile!=null&&info.DownloadFile.length()>0) { %>
              &nbsp;&nbsp;<a href="product.jsp?action=Download&filename=<%=info.DownloadFile%>" target="_self">Download it</a>&nbsp;&nbsp;<a href="product.jsp?action=removeimage&imagesize=download">Remove</a>
              <% } %>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right" valign="middle">Instruction:</td>
      <td class="row1" width="58%">
        <textarea rows="5" cols="60" wrap="virtual" name="instruction"><%=Utilities.getValue(info.Instruction)%></textarea>
      </td>
      <td class="row1" width="28%">The brief instruction to explain how to download, install and launch this product. This should be in HTML, not plain text. In this content, a
      tag of [$download$] should be inside any place to dynamically create a link for file downloading.</td>
    </tr>
    <tr>
      <td class="row1" width="14%" align="right">Expired Days:</td>
      <td class="row1" colspan="2">
        <input type="text" name="expireddays" value="<%=Utilities.getValue2(info.ExpiredDays)%>" onBlur='autoFormat(this,"N");' onKeyUp='autoFormat(this,"N");'>
        How many days will be expired for downloading. If it is empty, no expired date is applied.</td>
    </tr>
   </table>
   </DIV>
  </td>
</tr>
    <tr>
      <td class="row1" width="14%" align="right">Active:</td>
      <td class="row1" colspan="2">
        <select name="active">
            <option value=0 <%=bean.getSelected(0, info.Active)%>>No</option>
            <option value=1 <%=bean.getSelected(1, info.Active)%>>Show for Visitors</option>
            <option value=2 <%=bean.getSelected(2, info.Active)%>>Show only for Logged Customers</option>
            <option value=3 <%=bean.getSelected(3, info.Active)%>>Show only for Logged Members</option>
        </select> If selects 'No', the product is not show on the category(s) to which it belongs.</td>
    </tr>
    <tr>
      <td colspan="3" height="2" class="spaceRow"><img src="/staticfile/admin/images/spacer.gif" alt="" width="1" height="1" /></td>
    </tr>
    <tr>
      <td class="catBottom" colspan="3" align="center"><input type="submit" name="action" value="<%=sAction%>"></td>
    </tr>
</table>
</form>
</SPAN>
<%@ include file="../share/footer.jsp"%>