<%
    int nFileMaxSize = 100*1024; //(MB) Total submit size
//OnlineMessageBean.dumpAllParameters(request);
%>
<DIV id="id_onlinemessagespan" style="display:none; position:absolute; z-index: 200; width: 740px; border:2px solid #E8E8E8; padding:0px; background-color: #ffffff; margin: 5px">
<script>createTableOpen();</script>
<FORM name="form_message" method="post" action="<%=mcBean.encodedUrl("index.jsp?maxsize="+nFileMaxSize+"&sl=1")%>" enctype="multipart/form-data" onSubmit="return validateOnlineMessage(this);">
<INPUT type="hidden" name="subdir" value="message">
<input type="hidden" name="action1" value="<%=sPostAction%>">
<input type="hidden" name="accessby" value="<%=wpInfo.AccessMode%>">
<input type="hidden" name="memberid" value="<%=onInfo.MemberID%>">
<input type="hidden" name="senderid" value="<%=(mbInfo!=null?mbInfo.MemberID:0)%>">
<input type="hidden" name="type" value="1">
<input type="hidden" name="pid" value="<%=wpInfo.PageID%>">
<input type="hidden" name="messageid" value="">
 <table cellpadding=1 cellspacing=0 border=0 width=720 bgcolor1="#F1F1FD">
  <TR>
   <TD align="center" valign="top" width="100%">
  <table cellpadding=2 cellspacing=0 border=0 align="center" width="100%">
   <tr>
     <td colspan=2 align="center" id="action_title"><h3><%=mcBean.getLabel("om-addmsg")%></h3></td>
   </tr>            
  <tr>
    <td width="12%" align="right">* <%=mcBean.getLabel("cm-title")%>:&nbsp;</td>
    <td><input type="text" name="title" maxlength=256 value="" style="width: 620px"></td>
  </tr>
  <tr>
    <td width="12%" align="right"><%=mcBean.getLabel("cm-url")%>:&nbsp;</td>
    <td><input type="text" name="url" maxlength=256 value="" style="width: 620px"></td>
  </tr>
  <tr>
    <td width="12%" align="right"><%=mcBean.getLabel("cm-tag")%>:&nbsp;</td>
    <td><input type="text" name="tags" maxlength=256 value="" style="width: 350px">&nbsp;&nbsp;(<%=mcBean.getLabel("cm-sepbycomma")%>)</td>
  </tr>
  <tr>
    <td width="12%" align="right"><%=mcBean.getLabel("cm-public")%>:&nbsp;</td>
     <td>
      <select name="active">
       <option value=1 selected><%=mcBean.getLabel("cm-yes")%></option>
       <option value=0><%=mcBean.getLabel("cm-no")%></option>
        </select> <%=mcBean.getLabel("om-activedes")%> 
     </td>
  </tr>
  <tr>
     <td colspan=2 height="20" id="id_description"><%=mcBean.getLabel("cm-desc")%>:</td>
  </tr>
  <tr>
     <td colspan=2 align="center">
       <textarea id="content" name="content" rows=18 cols=80 wrap="soft" style="width: 700px"></textarea>
       <script language="javascript1.2">createToolbar('content', 710, 180, ",7,15,16,17,32,");</script>
     </td>
  </tr>
  <tr>
     <td colspan=2 height="5"></td>
  </tr>
  <tr>
   <td colspan=2 width="100%">
   <table>
   <tr>
     <td width="95%" id="id_existtitle">
      <table width="100%" cellpadding=1 cellspacing=0 border=0>
       <tr>
         <td width="5%" align="left" style="border-bottom:1px solid #DFDFDF"><b><%=mcBean.getLabel("cm-number")%></b></td>
         <td width="85%" style="border-bottom:1px solid #DFDFDF"><b><%=mcBean.getLabel("cm-filename")%></b></td>
         <td align="center" style="border-bottom:1px solid #DFDFDF"><b><%=mcBean.getLabel("cm-delete")%></b></td>
       </tr>
      </table>
     </td>
     <td></td>
    </tr>
    <tr>
     <td width="95%" id="id_existfiles">
      <table width="100%">
       <tr>
         <td width="5%" align="center"><b><%=mcBean.getLabel("cm-number")%></b></td>
         <td width="85%"><b><%=mcBean.getLabel("cm-filename")%></b></td>
         <td align="center"><b><%=mcBean.getLabel("cm-delete")%></b></td>
       </tr>
       <tr>
         <td width="5%" align="center">1</td>
         <td width="90%"><%=mcBean.getLabel("cm-file")%> 1</td>
         <td align="center"><input type="checkbox" name="deletefile_1" value="1" /></td>
       </tr>
      </table>
     </td>
     <td align="right" valign="bottom" style1="border-bottom:1px solid #DFDFDF" nowrap>
      <div id="attachments">&nbsp;&nbsp;
        <!--script>createLeftButton();</script-->
        <a id="addupload" class1="button" href="javascript:;" onClick="javascript:addUpload(5, 'file')"><%=mcBean.getLabel("om-attachfile")%></a>
        <!--script>createRightButton();</script-->
      </div>
     </td>
    </tr>
    </table>
    <hr class="line" width="100%">       
   </td>
  </tr>
  <tr>
     <td colspan=2>
       <span id="attachparent"><span id="attachmentmarker"></span></span>
       <div id="attachment" style="display:none">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="dropcap" class="dropcap" style="text-align: center">1</span>.&nbsp;&nbsp;&nbsp;
       <input id="file" name="file" style="background-color1: #ddeeee;" type="file" size="80" />&nbsp;&nbsp;&nbsp;&nbsp;
       <a href="#" onclick="javascript:removeFile(this.parentNode.parentNode,this.parentNode);"><%=mcBean.getLabel("cm-remove")%></a>
       <!-- <br/> <input id="desc" name="desc" type="text" maxlength="55" size="55"/> -->
       </div>
   </td>
  </tr>                
  <tr>
   <td colspan=2><!--hr class="line" width="99%"--></td>
  </tr>
  <tr>
   <td colspan=2>
   <table>
    <tr>
     <td width="12%" align="right"><%=mcBean.getLabel("cm-yourname")%>:&nbsp;</td>
     <td width="38%"><input type="text" name="authorname" maxlength=40 value="<%=(mbInfo!=null?mbInfo.getFullName():"")%>" style="width: 260px"></td>
     <td width="12%" align="right"><%=mcBean.getLabel("cm-email")%>:&nbsp;</td>
     <td><input type="text" name="email" maxlength=60 value="<%=(mbInfo!=null?mbInfo.EMail:"")%>" style="width: 262px"></td>
    </tr>
   </table>
   </td>
  </tr>
  <tr>
    <td id="id_commenturl" colspan="2">
     <table cellpadding=0 cellspacing=0 border=0>
      <tr>
        <td width="12%" align="right"><%=mcBean.getLabel("om-siteurl")%>:&nbsp;</td>
        <td><input type="text" name="senderweburl" maxlength=256 value="" style="width: 615px"></td>
      </tr>
     </table>
    </td>
  </tr>
  <tr>
   <td colspan=2 height="15"><hr class="line" width="99%"></td>
  </tr>
  <tr>
   <td colspan=2>
   <table width="100%">
    <tr>
     <td width="50%" align="center"><input type="submit" name="submit" value="<%=mcBean.getLabel("cm-add")%>" onClick1="setAction(document.form_message, this.value+'<%=sPostAction%>');" style='width:100px'></td>
     <td align="center"><input type="button" name="cancel" value="<%=mcBean.getLabel("cm-cancel")%>" style="width: 100px" onclick="javascript:hideMessageBox('id_onlinemessagespan');"></td>
    </tr>
   </table>
   </td>
  </tr>
</table>
  </TD>
 <TR>
</table>
</FORM>
<script>createTableClose();</script>
</DIV>