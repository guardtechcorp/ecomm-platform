<tr>
 <td height="4"></td>
</tr>
<tr>
 <td align="center">
 <script type="text/javascript" src="/staticfile/web/scripts/basiccalendar.js"></script>
 <script type="text/javascript">
 var todaydate=new Date()
 var curmonth=todaydate.getMonth()+1 //get current month (1-12)
 var curyear=todaydate.getFullYear() //get current year
 document.write(buildCal(curmonth ,curyear, "calendarmain", "calendarmonth", "calendardaysofweek", "calendardays", 1));
 </script>
 </td>
</tr>