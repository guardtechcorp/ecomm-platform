<%@ page import="com.zyzit.weboffice.util.Utilities" %>
<%@ page import="com.zyzit.weboffice.web.SessionWeb" %>
<%!
private static int[] m_arRow = new int[] {
  1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,25,30,35,40,45,50,60,70,80,90,100
};

public static String getRowsPerPageList(int nRows, int nTotal)
{
  if (nRows<=0)
     nRows = 40;

  if (nTotal<0)
  {
     nTotal = Math.abs(nTotal);  
  }
  else if (nTotal<40)
     nTotal = 40;

  boolean bSelected = false;
  StringBuffer sbMenu = new StringBuffer();
  for (int i=0; i<m_arRow.length; i++)
  {
    if (nTotal>0 && m_arRow[i]>nTotal)
    {
      break;
    }

    sbMenu.append("<option value=\"" + m_arRow[i] + "\"");
    if (m_arRow[i]==nRows || (!bSelected && m_arRow[i]>nTotal))
    {
       bSelected = true;
       sbMenu.append(" selected");
    }      
    sbMenu.append(">" + m_arRow[i] + "</option>\n");
  }

  return sbMenu.toString();
}

private static int MAX_PAGES = 10;

public static String getWFont(String strSource){return getFont(strSource,"#FFFFFF","2","arial");}
public static String getBFont(String strSource){return getFont(strSource,"#000000","2","arial");}
public static String getFont(String strSource){return getFont(strSource,null,"2","arial");}
public static String getFont(String strSource, String strColor){return getFont(strSource,strColor,"2","arial");}
public static String getFont(String strSource, String strColor, String strSize){return getFont(strSource,strColor,strSize,"arial");}
public static String getFont(String strSource, String strColor, String strSize, String strFace)
{
    String temp = "<FONT";
    if (strColor!=null)
        temp += " color="+strColor;
    if (strSize!=null)
        temp += " size="+strSize;
    if (strFace!=null)
        temp += " face="+strFace;
    return temp+">"+strSource+"</FONT>";
}

public static String getSortFieldName(String sFormName, int nTotalRecords, String sSortName, String sShowKey, String sSort, String sOrder)//, SessionBean web)
{
     if (nTotalRecords>1)
     {
       String sSymbol = sSort.equalsIgnoreCase(sSortName)?(sOrder.equalsIgnoreCase("asc")?"&#9650;":"&#9660;"):"";
       return "<a class='button' href=\"javascript:submitSort(document." + sFormName + ",'" + sSortName + "','" + (sOrder.equalsIgnoreCase("asc")?"desc":"asc") + "')\">" + sShowKey + "</a>" +
               "<span style='font-size:100%;color:white'>" + sSymbol + "</span>";
     }
     else
     {
        return "<b>" + sShowKey + "<b>";
     }
}

public static String getSortFieldName(String sFormName, String sPage, int nTotalRecords, String sSortName, String sShowKey, String sSort, String sOrder)//, SessionBean web)
{
     if (nTotalRecords>1)
     {
       String sSymbol = sSort.equalsIgnoreCase(sSortName)?(sOrder.equalsIgnoreCase("asc")?"&#9650;":"&#9660;"):"";
       return "<a class='button' href=\"javascript:submitSort(document." + sFormName +  ",'" + sPage + "','" + sSortName + "','" + (sOrder.equalsIgnoreCase("asc")?"desc":"asc") + "')\">" + sShowKey + "</a>" +
               "<span style='font-size:100%;color:white'>" + sSymbol + "</span>";
     }
     else
     {
        return "<b>" + sShowKey + "<b>";
     }
}

public static String getAjaxSortFieldName(String sFormName, int nTotalRecords, String sSortName, String sShowKey, String sSort, String sOrder)//, SessionBean web)
{
     if (nTotalRecords>1 && Utilities.getValueLength(sSortName)>0)
     {
       String sSymbol = sSort.equalsIgnoreCase(sSortName)?(sOrder.equalsIgnoreCase("asc")?"&#9650;":"&#9660;"):"";
       return "<a class='button' href=\"javascript:submitAjaxSort(document." + sFormName + ",'" + sSortName + "','" + (sOrder.equalsIgnoreCase("asc")?"desc":"asc") + "')\">" + sShowKey + "</a>" +
               "<span style='font-size:100%;color:white'>" + sSymbol + "</span>";
     }
     else
     {
        return "<b>" + sShowKey + "<b>";
     }
}

public static String getLinkAjaxSortFieldName(String sUrl, int nTotalRecords, String sSortName, String sShowKey, String sSort, String sOrder, String sIdHtml)// SessionBean web)
{
     if (nTotalRecords>1)
     {
       String sSymbol = sSort.equalsIgnoreCase(sSortName)?(sOrder.equalsIgnoreCase("asc")?"&#9650;":"&#9660;"):"";
       return "<a class='button' href=\"javascript:linkAjaxSort('" + sUrl + "','" + sSortName + "','" + (sOrder.equalsIgnoreCase("asc")?"desc":"asc") + "','" + sIdHtml + "')\">" + sShowKey + "</a>" +
               "<span style='font-size:100%;color:white'>" + sSymbol + "</span>";
     }
     else
     {
        return "<b>" + sShowKey + "<b>";
     }
}

public static String getFontName(String sNo)
{
    if ("0".equals(sNo))
       return "Default Font";
    if ("1".equals(sNo))
       return "Arial, Helvetica, San";
    else if ("2".equals(sNo))
       return "Times New Roman";
    else if ("3".equals(sNo))
       return "Courier New, Mono";
    else if ("4".equals(sNo))
       return "Georgia, Times, Serif";
    else if ("5".equals(sNo))
       return "Verdana, Arial, Helvetica";
    else if ("6".equals(sNo))
       return "Geneva, Arial, Helvetica";
    else
       return "";    
}

public static String getStyledText(String sText, String sStyle)
{
    if (Utilities.getValueLength(sText)==0||Utilities.getValueLength(sStyle)==0)
       return Utilities.getUnicode(Utilities.getValue(sText));
    sText = Utilities.replaceContent(sText, "\n", "<br>");

    String[] arStyle = sStyle.split(",");
    if (arStyle.length<7)
       return Utilities.getUnicode(Utilities.getValue(sText));

    StringBuffer sbSlogan = new StringBuffer();
    sbSlogan.append("<font face='"  + getFontName(arStyle[0]) + "'");
    sbSlogan.append(" size='" + arStyle[1] + "'");
    sbSlogan.append(" color='" + arStyle[4] + "'>");
    if ("2".equals(arStyle[2])||"6".equals(arStyle[2]))
       sbSlogan.append("<b>");
    if ("4".equals(arStyle[2])||"6".equals(arStyle[2]))
       sbSlogan.append("<i>");

    if ("2".equals(arStyle[3]))
       sbSlogan.append("<u>");
    else if ("3".equals(arStyle[3]))
       sbSlogan.append("<strike>");

    sbSlogan.append(Utilities.getUnicode(sText));

    if ("2".equals(arStyle[3]))
       sbSlogan.append("</u>");
    else if ("3".equals(arStyle[3]))
       sbSlogan.append("</strike>");

    if ("4".equals(arStyle[2])||"8".equals(arStyle[2]))
       sbSlogan.append("</i>");
    if ("2".equals(arStyle[2])||"8".equals(arStyle[2]))
       sbSlogan.append("</b>");
    sbSlogan.append("</font>");

    return sbSlogan.toString();
}

public static String convertQuot(String sText)
{
   if (Utilities.getValueLength(sText)>0)
      return sText.replaceAll("\'", "").replaceAll("\"", ""); //&#34;, &#39;
   else
      return sText;
}

public static String getMaxLengthText(String sText, int nMaxLen)
{
   if (Utilities.getValueLength(sText)>0)
   {
     int nLen = 0;
     for (int i=0; i<sText.length(); i++)
     {
        nLen++;
        if (sText.charAt(i)>256 || (sText.charAt(i)>=65&&sText.charAt(i)<=90) || sText.charAt(i)=='%' || sText.charAt(i)=='@')
           nLen++;

        if (nLen>=nMaxLen)
        {
           return  sText.substring(0, i-4) + " ...";
        }
     }
   }

   return sText;
}

public static String[] getTipText(String sText, int nMaxLen, String sTipId)
{
   String[] arText = new String[2];
   if (Utilities.getValueLength(sText)>0)
   {
     int nLen = 0;
     for (int i=0; i<sText.length(); i++)
     {
        nLen++;
        if (sText.charAt(i)>256 || (sText.charAt(i)>=65&&sText.charAt(i)<=90) || sText.charAt(i)=='%' || sText.charAt(i)=='@')
           nLen++;

        if (nLen>=nMaxLen)
        {
           arText[1] = "id='" + sTipId + "' onmouseover=\"onSectionMouseOver('" + sTipId + "','" + Utilities.getEncodeQuots2(sText) + "','#FFFFCC')\"";
           arText[0] = sText.substring(0, i-4) + " ...";
           break;
        }
     }
   }

   if (arText[0]==null)
      arText[0] = sText;

   return arText;
}

public static String getNumberChar(int numbering, int index)
{
   if (numbering>6)
      return "";
   else if (numbering==0)
      return ""+index;
   else if (numbering==1)
      return index + ")";
   else if (numbering==2)
      return new String( new char[]{(char)(64+index), '.'} );
   else if (numbering==3)
      return new String( new char[]{(char)(96+index), ')', '.'});
   else if (numbering==4)
      return new String( new char[]{(char)(96+index), '.'} );
   else
   {
      int mode = index%10;
      String syb = "i";
      if (mode==2)
         syb = "ii";
      else if (mode==3)
         syb = "iii";
      else if (mode==4)
         syb = "iv";
      else if (mode==5)
         syb = "v";
      else if (mode==6)
         syb = "vi";
      else if (mode==7)
         syb = "vii";
      else if (mode==8)
         syb = "viii";
      else if (mode==9)
         syb = "ix";
      else if (mode==0)
         syb = "x";

      if (index>10 && index<=20)
         syb = "x" + syb;
      else if (index>20 && index<=30)
          syb = "xx" + syb;
      else if (index>30 && index<39)
          syb = "xxx" + syb;
      else if (index==40)
          syb = "xl";
      else if (index>40)
          syb = "xl" + syb;

      if (numbering==5)
         return syb.toUpperCase() + ".";
      else
         return syb + ".";
   }
}

public static boolean isImageFileType(String sFileName)
{
   String sFile = sFileName.toLowerCase();
   return sFile.indexOf(".gif")!=-1||sFile.indexOf(".jpg")!=-1||sFile.indexOf(".jpeg")!=-1||sFile.indexOf(".png")!=-1||sFile.indexOf(".bmp")!=-1;
}

public static String getFileTypeIcon(String sFileName)
{
   if (isImageFileType(sFileName))
     return "photo-file.png";
   else
     return "text-file.png";

}

public static String isChecked(int value, int bit)
{
    if ((value&bit)!=0)
        return "checked";
    else
        return "";
}

public static String getSelected(String sSelection, String sIt)
{
   if (isIncludeIt(sSelection, sIt))
      return "selected";
   else
      return "";
}

public static String getChecked(String sSelection, String sIt)
{
   if (isIncludeIt(sSelection, sIt))
      return "checked";
   else
      return "";
}

public static boolean isIncludeIt(String sSelection, String sIt)
{
   return isIncludeIt(sSelection, sIt, ",");
}

public static boolean isIncludeIt(String sSelection, String sIt, String sSeparater)
{
   if (Utilities.getValueLength(sSelection)>0)
   {
       if (sSelection.equals(sIt))
          return true;

       if (sSelection.startsWith(sIt + sSeparater))
          return true;

       if (sSelection.endsWith(sSeparater+sIt))
          return true;

       if (sSelection.indexOf(sSeparater+sIt+sSeparater)!=-1)
          return true;
   }

   return false;
}

public static String two(byte flag)
{
    return two(flag, "Yes", "No");
}

public static String two(byte flag, String v1, String v2)
{
    if (flag==0)
       return v1;
    else
       return v2;
}

public static String three(byte flag)
{
    return three(flag, "Unsure", "Yes", "No");
}

public static String three(byte flag, String v1, String v2, String v3)
{
    if (flag==0)
       return v1;
    else if (flag==1)
       return v2;
    else
       return v3;
}

public static String getDesc(List<String> ltCode, String v)
{
    for (int i=0; i<ltCode.size(); i++) {
     String sCodedesc = ltCode.get(i);
     int nDash = sCodedesc.indexOf("-");
     String sCode = sCodedesc.substring(0, nDash).trim();
     if (v.equalsIgnoreCase(sCode))
        return sCodedesc.substring(nDash+1).trim();
    }

    return "";
}

    //private static int MAX_PAGES = 10;
    public static String getNavigate(int iTotalRecord,int iRecordPerPage,String strURL,int iPageNo, SessionWeb web)
    {
        return getNavigate(iTotalRecord, iRecordPerPage, strURL, iPageNo, "", web, true, false);
    }

    public static String getNavigate2(int iTotalRecord,int iRecordPerPage,String strURL,int iPageNo, SessionWeb web)
    {
        return getNavigate(iTotalRecord, iRecordPerPage, strURL, iPageNo, "", web, false, false);
    }

    public static String getNavigateSquare(int iTotalRecord,int iRecordPerPage,String strURL,int iPageNo, SessionWeb web)
    {
        return getNavigate(iTotalRecord, iRecordPerPage, strURL, iPageNo, "", web, true, true);
    }

    public static String getNavigateSquare2(int iTotalRecord,int iRecordPerPage,String strURL,int iPageNo, SessionWeb web)
    {
        return getNavigate(iTotalRecord, iRecordPerPage, strURL, iPageNo, "", web, false, true);
    }

    public static String getNavigate(int iTotalRecord, int iRecordPerPage, String strURL, int iPageNo, String strURLAtt, SessionWeb web, boolean bText, boolean bSquare)
    {
      if (iTotalRecord<=0)
         return "";

      int istart=0; int iTotalPage = 0;
      if (iRecordPerPage<1)
         iRecordPerPage = MAX_PAGES;
      if (iTotalRecord % iRecordPerPage == 0)
         iTotalPage=iTotalRecord/iRecordPerPage;
      else
         iTotalPage=iTotalRecord/iRecordPerPage+1;

      if (iPageNo != (iPageNo/MAX_PAGES)*MAX_PAGES)
        istart = iPageNo/MAX_PAGES;
      else
        istart = iPageNo/MAX_PAGES -1;

      int nTo   = iPageNo*iRecordPerPage;
      if (nTo>iTotalRecord)
         nTo = iTotalRecord;
      String sRange = "";
      if (bText)
      {
         if (iRecordPerPage>1)
      //      sRange = web.getKeyValue("ds.display", "<b>"+ Utilities.getNumberFormat(iTotalRecord,'N',0)+"</b>", "<b>"+Utilities.getNumberFormat(iTotalPage,'N',0)+"</b>") + " ";
           sRange = "<b>" + Utilities.getNumberFormat(iTotalRecord,'N',0)+"</b> Records of <b>"+Utilities.getNumberFormat(iTotalPage,'N',0)+"</b>" + " Page";
         else
           //sRange = web.getKeyValue("ds.displayrecord", "<b>"+ Utilities.getNumberFormat(iTotalRecord,'N',0)+"</b>") + " ";
           sRange = "<b>"+ Utilities.getNumberFormat(iTotalRecord,'N',0)+"</b>";
      }

      if (iRecordPerPage>=iTotalRecord)
         return sRange;

      if (strURLAtt.length()>0)
         strURLAtt = "|" + strURLAtt;

      StringBuffer sbLink = new StringBuffer();
      String strPrev="", strNext="";
      String strFirst="", strLast="";

      int nMaxPage = Math.min(istart*MAX_PAGES+MAX_PAGES, iTotalPage);
      for (int i=istart*MAX_PAGES; i<nMaxPage; i++)
      {
        if (iPageNo==i+1)
        {
          if (bSquare)
            sbLink.append("<A href='#' class='currentpage' onClick='return false'>"+ Integer.toString(i+1) +"</A> ");
          else
            sbLink.append(getFont(Integer.toString(i+1), "#990000", "2")+" ");//&nbsp;");
        }
        else
        {
          String sTip = Integer.toString(i+1) + " (" + (i*iRecordPerPage+1) + "-"  + (i+1)*iRecordPerPage + ")";
          sbLink.append(getHTML(Integer.toString(i+1),"A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, i+1, iTotalRecord), web.getKeyValue("ds.gopage", sTip)) + " ");
        }
      }

      if (istart>0)
      {
         strFirst = getHTML("[<","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, 1, iTotalRecord), web.getKeyValue("ds.firstpage"))+" ";
         strPrev = getHTML("<","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, istart*MAX_PAGES, iTotalRecord), web.getKeyValue("ds.prevpages",""+MAX_PAGES))+" ";
      }

      if (nMaxPage<iTotalPage)
      {
          strLast = " " + getHTML(">]","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, iTotalPage, iTotalRecord), web.getKeyValue("ds.lastpage"));
          strNext = getHTML(">","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, nMaxPage+1, iTotalRecord), web.getKeyValue("ds.nextpages",""+MAX_PAGES));
      }

      if (bSquare)
         return sRange + ": <span class='pagination'>" + strFirst + strPrev + sbLink.toString().trim() + strNext + strLast + "</span>";
      else
         return sRange + ": " + strFirst + strPrev + sbLink.toString() + strNext + strLast;
    }

    public static String getHrefLink(String strURL, int iRecordPerPage, int nPage, int iTotalRecord)
    {
       if (!strURL.toLowerCase().startsWith("javascript:"))
         return strURL+"&rpp="+iRecordPerPage+"&pg="+nPage+"&rd="+iTotalRecord;
       else
         return strURL.replaceAll("pg", ""+nPage);
    }

    public static String getHTML(String strSource, String strTag){return getHTML(strSource,strTag,null,null);}
    public static String getHTML(String strSource, String strTag, String strHREF, String sTitle)
    {
        java.util.StringTokenizer sToken = new java.util.StringTokenizer (strTag, ",");
        while (sToken.hasMoreTokens())
        {
            strTag = sToken.nextToken();
            if (strTag.charAt(0)=='A'){
                if (strTag.indexOf("|")!=-1)
                    strSource = "<"+strTag.charAt(0)+" "+strTag.substring(2,strTag.length())+" href='"+strHREF+"'>"+strSource+"</"+strTag.charAt(0)+">";
                else
                {
                  if (sTitle==null)
                    strSource = "<"+strTag+" href='"+strHREF+"'>"+strSource+"</"+strTag+">";
                  else
                    strSource = "<"+strTag+" href='"+strHREF+"' title='" + sTitle + "'>"+strSource+"</"+strTag+">";
                }
            }
            else
            {
                if (strTag.indexOf("|")!=-1)
                   strSource = "<"+strTag.charAt(0)+" "+strTag.substring(2,strTag.length())+">"+strSource+"</"+strTag.charAt(0)+">";
                else
                {
                   if (sTitle==null)
                     strSource = "<"+strTag+">"+strSource+"</"+strTag+">";
                   else
                     strSource = "<"+strTag+"' title='" + sTitle + "'>"+strSource+"</"+strTag+">";
                }
            }
        } return strSource;
    }

public boolean hasBit(long v1, long v2)
{
    return v1>=0 && (v1&v2)>0;
}

public boolean hasBit(int v1, int v2)
{
    return v1>=0 && (v1&v2)>0;
}

public boolean hasBit(short v1, short v2)
{
    return v1>=0 && (v1&v2)>0;
}

public boolean hasBit(byte v1, byte v2)
{
    return v1>=0 && (v1&v2)>0;
}
%>