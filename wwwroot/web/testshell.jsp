<!--%@ page pageEncoding="utf-8"%-->
<!--%@ page contentType="text/html; charset=gb2312"%-->
<!--%request.setCharacterEncoding("GB2312");%-->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.zyzit.weboffice.controller.Manager"%>
<%@ page import="com.zyzit.weboffice.convert.LanguageUnicode"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Locale"%>
<%
  //Locale.setDefault(Locale.SIMPLIFIED_CHINESE);

  request.setCharacterEncoding("utf-8");
  response.setContentType("text/html; charset=utf-8");

  Manager mg = Manager.getInstance();
  String sFilename = mg.getRootPath()+ Manager.DATAFILEPATH + '/' + "gb2312" + ".dat";
//System.out.println("sFilename=" + sFilename);

  Properties lgProperty = new Properties();
  try {
    lgProperty.load(new FileInputStream(sFilename));
  }
  catch (java.io.IOException io)
 {
   io.printStackTrace();
 }



//String utf8 = "\u4E0E\u6211\u4EEC\u8054\u7CFB"; //contact us

 String sHomeGB = (String)lgProperty.get("home-page");
 String sContactGB = (String)lgProperty.get("contact-us");
 String sShopCartGB = (String)lgProperty.get("shop-cart");


System.out.println(sHomeGB + "-->" + LanguageUnicode.getUnicode("???????? ?? ????????(??)", LanguageUnicode.UNICODE));
System.out.println("Unicode ???=" + LanguageUnicode.getUnicode("律师事务所简  介", LanguageUnicode.GB2312));
//System.out.println("GB Code=" + sContactGB + "-->" + LanguageUnicode.getHexBytes(sContactGB, "iso-8859-1"));

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Testing Shell</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!--meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"-->
</head>
<body>
<table cellspacing=0 cellpadding=0 border=0 align="left" witdth="800">
<tr>
  <td width="200">Home Page: </td>
  <td width="600"><%=sHomeGB%></td>
</tr>


 <tr>
      <td>Out of output: </td>
      <td >
      <%
          out.write("?????????");      
      %>
      </td>
</tr>


<tr>
  <td>Contact Us:(&#x6848;&#x4EF6;&#x53D7;&#x7406;) </td>
  <td ><%=sContactGB%></td>
</tr>

<tr>
  <td>Unicode (律师事务所简  介):</td>
  <td noWrap><font size=2><a href="#"><%=LanguageUnicode.getUnicode("律师事务所简  介", LanguageUnicode.GB2312)%></a></font></td>
</tr>
<tr>
  <td ></td>
  <td noWrap >&nbsp;</td>
</tr>
<tr>
  <td >Wenxuecity (?????????:????,????(??), &#x51AF;&#x5C0F;&#x521A;):<%="?????"%></td>
  <td noWrap><a href="#"><%=LanguageUnicode.getUnicode("?????????:????,????(??)", LanguageUnicode.UNICODE)%></a></td>
</tr>
<tr>
  <td></td>
  <td noWrap width="130">&nbsp;</td>
</tr>
<tr>
  <td>Big5:</td>
  <td noWrap width="130"><font size=2><a href="#"><%=LanguageUnicode.getUnicode("筿杠", LanguageUnicode.BIG5)%></a></font></td>
</tr>
<tr>
  <td ></td>
  <td noWrap width="130">&nbsp;</td>
</tr>
<tr>
  <td ></td>
  <td noWrap width="130">&nbsp;</td>
</tr>
<tr>
  <td >GB2312</td>
  <td noWrap width="130"><font size=2><a
href="http://www.libinlaw.com/GB/case.htm"
target=_self>案件受理</a></font></td>
</tr>
<tr>
  <td ></td>
  <td noWrap width="130">&nbsp;</td>
</tr>
<tr>
  <td></td>
  <td noWrap width="130"><font size=2><a
href="http://www.libinlaw.com/GB/paton.htm"
target=_self>专利检索</a></font></td>
</tr>
<tr>
  <td width="1">&nbsp;</td>
  <td noWrap colspan=2 rowspan="2">&nbsp;</td>
</tr>
<tr>
  <td width="1">&nbsp;</td>
</tr>
</table>
<%
{
/*
  JAVA_OPTS="$JAVA_OPTS -Duser.language=zh -Duser.region=CN"
  JAVA_OPTS="-server -Xms512M -Xmx1024M"
  javac -encoding gb2312 sourcefile.java


response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8; pageEncoding=UTF-8");
PrintWriter out = response.getWriter();
out.println("<html>");
out.println("<head>");
out.println("<meta http-equiv='Content-Language' content='en-us'>");
out.println("<meta http-equiv='Content-Type' content='text/html; charset=utf-8; pageEncoding=utf-8'>"); //Again not necessary line, but anyways
out.println("<title>Servlet</title>");
out.println("</head>");
out.println("<body>");
out.println("this is a test this is a test");
out.println("</body>");
out.println("</html>");
out.close();


  String sCmd = request.getParameter("cmd");
  if (sCmd==null)
     sCmd = "ls -al /home/neilzhao";
  Manager man = new Manager();
  PrintWriter pw = response.getWriter();
  man.test1(pw, sCmd);


public class GB2Utf8
{
    public static void main( String[] args )
    {
        try
        {
            FileInputStream is = new FileInputStream( args[0] );
            BufferedReader br = new BufferedReader(
                    new InputStreamReader( is, "GB2312" ) );
            BufferedWriter bw = new BufferedWriter( new OutputStreamWriter(
                    new FileOutputStream( "out_utf8.txt" ), "UTF-8" ) );
            String strLine;
            while ( (strLine = br.readLine()) != null )
            {
                bw.write( strLine);
            }
            br.close();
            bw.close();
        }
        catch ( Exception e )
        {
            e.printStackTrace();
        }
    }
}

import java.util.*;
00080
00085 public class EncodingMap
00086 {
00087     protected static Map _java2xml = new HashMap();
00088     protected static Map _xml2java = new HashMap();
00089
00090     static
00091     {
00092                 addEncoding("ISO8859_1","ISO-8859-1");
00093                 addEncoding("UTF8","UTF-8");
00094                 addEncoding("UTF16","UTF-16");
00095                 addEncoding("CP1252", "ISO-8859-1");
00096                 addEncoding("CP1250", "windows-1250");
00097         addEncoding("ISO8859_1", "ISO-8859-1");
00098         addEncoding("ISO8859_2", "ISO-8859-2");
00099         addEncoding("ISO8859_3", "ISO-8859-3");
00100         addEncoding("ISO8859_4", "ISO-8859-4");
00101         addEncoding("ISO8859_5", "ISO-8859-5");
00102         addEncoding("ISO8859_6", "ISO-8859-6");
00103         addEncoding("ISO8859_7", "ISO-8859-7");
00104         addEncoding("ISO8859_8", "ISO-8859-8");
00105         addEncoding("ISO8859_9", "ISO-8859-9");
00106                 addEncoding("JIS", "ISO-2022-JP");
00107                 addEncoding("SJIS", "Shift_JIS");
00108                 addEncoding("EUCJIS", "EUC-JP");
00109                 addEncoding("GB2312", "GB2312");
00110                 addEncoding("BIG5", "Big5");
00111                 addEncoding("KSC5601", "EUC-KR");
00112                 addEncoding("ISO2022KR", "ISO-2022-KR");
00113                 addEncoding("KOI8_R", "KOI8-R");
00114                 addEncoding("CP037", "EBCDIC-CP-US");
00115                 addEncoding("CP037", "EBCDIC-CP-CA");
00116                 addEncoding("CP037", "EBCDIC-CP-NL");
00117                 addEncoding("CP277", "EBCDIC-CP-DK");
00118                 addEncoding("CP277", "EBCDIC-CP-NO");
00119                 addEncoding("CP278", "EBCDIC-CP-FI");
00120                 addEncoding("CP278", "EBCDIC-CP-SE");
00121                 addEncoding("CP280", "EBCDIC-CP-IT");
00122                 addEncoding("CP284", "EBCDIC-CP-ES");
00123                 addEncoding("CP285", "EBCDIC-CP-GB");
00124                 addEncoding("CP297", "EBCDIC-CP-FR");
00125                 addEncoding("CP420", "EBCDIC-CP-AR1");
00126                 addEncoding("CP424", "EBCDIC-CP-HE");
00127                 addEncoding("CP500", "EBCDIC-CP-CH");
00128                 addEncoding("CP870", "EBCDIC-CP-ROECE");
00129                 addEncoding("CP870", "EBCDIC-CP-YU");
00130                 addEncoding("CP871", "EBCDIC-CP-IS");
00131                 addEncoding("CP918", "EBCDIC-CP-AR2");
00132     }
00133
00134     public static void addEncoding(String java, String xml)
00135     {
00136                 _java2xml.put(java,xml);
00137                 _xml2java.put(xml,java);
00138     }
00139
00140     public static String getJavaFromXML(String xml)
00141     {
00142         //   System.out.println("XML String = " + xml);
00143                 // Default encoding is UTF-8
00144                 if (xml == null) {
00145                     //    System.out.println("Using Default Encoding");
00146                    xml = "UTF-8";
00147                 }
00148                 xml = xml.toUpperCase();
00149                 String s = (String)_xml2java.get(xml);
00150                 if (s == null) {
00151                         s = xml;
00152                 }
00153                 return s;
00154     }
00155
00156     public static String getXMLFromJava(String java)
00157     {
00158                 java = java.toUpperCase();
00159                 String s = (String)_java2xml.get(java);
00160                 if (s == null) {
00161                         s = java;
00162                 }
00163                 return s;
00164     }
00165
00166 }

*/
}
%>
</body>
</html>
