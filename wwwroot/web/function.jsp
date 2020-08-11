<%@ page import="java.util.regex.Pattern" %>
<%@ page import="com.zyzit.weboffice.web.SessionWeb" %>

<%!
private static int[] m_arRow = new int[] {
 // 5,10,
  10,20,30,40
};

public static String getRowsPerPageList(int nRows, int nTotal)
{
  if (nRows<=0)
     nRows = 40;

  StringBuffer sbMenu = new StringBuffer();
  for (int i=0; i<m_arRow.length; i++)
  {
    sbMenu.append("<option value=\"" + m_arRow[i] + "\"");
    if (m_arRow[i]==nRows)
       sbMenu.append(" selected");
    sbMenu.append(">" + m_arRow[i] + "</option>\n");
  }

  return sbMenu.toString();
}

public static String getNavigate(String[] arImageFile, String[] arMediumFile)
{
  if (arImageFile==null || arImageFile.length<=1)
     return "";

//  String strUrl = "javascript:switchPhoto('" + arImageFile[i] + "')";
  StringBuffer sbLink = new StringBuffer();
  for (int i=0; i<arImageFile.length; i++)
  {
//     if (arMediumFile==null || arImageFile.length!=arMediumFile.length)
     {
        sbLink.append("<A href=\"javascript:switchPhoto('" + arImageFile[i] + "')\"><font size=2>"+ Integer.toString(i+1) +"</font></A> ");
     }
  }

  return sbLink.toString();
}

private static int MAX_PAGES = 10;
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

  int nFrom = (iPageNo-1)*iRecordPerPage+1;
  int nTo   = iPageNo*iRecordPerPage;
  if (nTo>iTotalRecord)
     nTo = iTotalRecord;
//    web.getKeyValue("ds.recordof").replaceFirst("\\{0\\}", "<b>"+nFrom+"-"+nTo+"</b>").replaceFirst("\\{1\\}", "<b>"+iTotalRecord+"</b>");
  String sRange = "";
  if (bText)
     sRange = web.getKeyValue("ds.display", "<b>"+Utilities.getNumberFormat(iTotalRecord,'N',0)+"</b>"
                      , "<b>"+Utilities.getNumberFormat(iTotalPage,'N',0)+"</b>") + " ";
//                      .replaceFirst("\\{2\\}", "<b>"+nFrom+"-"+nTo+"</b>") + " ";

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
/*
if (i>0)
strPrev = getHTML("<","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, i, iTotalRecord), web.getKeyValue("ds.prevpage"))+" ";
if (iPageNo*iRecordPerPage<iTotalRecord)
strNext = getHTML(">","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, i+2, iTotalRecord), web.getKeyValue("ds.nextpage"));
*/
    }
    else
    {
      String sTip = Integer.toString(i+1) + " (" + (i*iRecordPerPage+1) + "-"  + (i+1)*iRecordPerPage + ")";
      sbLink.append(getHTML(Integer.toString(i+1),"A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, i+1, iTotalRecord), web.getKeyValue("ds.gopage").replaceFirst("\\{0\\}", sTip)) + " ");
    }
  }

  if (istart>0)
  {
     strFirst = getHTML("[<","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, 1, iTotalRecord), web.getKeyValue("ds.firstpage"))+" ";
//     strPrev = getHTML("<","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, nMaxPage-2*MAX_PAGES+1, iTotalRecord), web.getKeyValue("ds.prevpages").replaceFirst("\\{0\\}",""+MAX_PAGES))+" ";
     strPrev = getHTML("<","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, istart*MAX_PAGES, iTotalRecord), web.getKeyValue("ds.prevpages").replaceFirst("\\{0\\}",""+MAX_PAGES))+" ";
  }

  if (nMaxPage<iTotalPage)
  {
      strLast = " " + getHTML(">]","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, iTotalPage, iTotalRecord), web.getKeyValue("ds.lastpage"));

      strNext = getHTML(">","A"+strURLAtt,getHrefLink(strURL, iRecordPerPage, nMaxPage+1, iTotalRecord), web.getKeyValue("ds.nextpages").replaceFirst("\\{0\\}",""+MAX_PAGES));
  }

  if (bSquare)
     return sRange + "<span class='pagination'>" + strFirst + strPrev + sbLink.toString() + strNext + strLast + "</span>";
  else
     return sRange + strFirst + strPrev + sbLink.toString() + strNext + strLast;
}

public static String getHrefLink(String strURL, int iRecordPerPage, int nPage, int iTotalRecord)
{
   if (!strURL.toLowerCase().startsWith("javascript:"))
     return strURL+"&rpp="+iRecordPerPage+"&pg="+nPage+"&rd="+iTotalRecord;
   else
     return strURL.replace("pg", ""+nPage);
}

// --  getHTML()
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
        
%>