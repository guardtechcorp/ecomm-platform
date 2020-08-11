<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->
function onAdsLoad(form, action)
{
  if ("Update"!=action)
  {
      form.title.focus();
      form.title.select();
  }
}

function validateAds(form)
{
    if (checkFieldEmpty(form.title))
    {
        alert("You have to enter Title.");
        setFocus(form.title);
        return false;
    }

//    if (checkFieldEmpty(form.linkurl))
//    {
//        alert("You have to enter Liked Url.");
//        setFocus(form.linkurl);
//        return false;
//    }

    var status = validateTimeRange(form.starttime.value, form.endtime.value);
    if (status==1)
    {
       alert("From Time is not validate format");
       setFocus(form.starttime);
       return false;
    }
    else if (status==2)
    {
       alert("To Time is not validate format");
       setFocus(form.endtime);
       return false;
    }
    else if (status==3)
    {
       alert("From Time is larger than To Time");
       setFocus(form.starttime);
       return false;
    }
        
//    var status = validateDateRange(form.startdate.value, form.enddate.value);
//    if (status==1)
//    {
//       alert("From Date is not validate format");
//       setFocus(form.startdate);
//       return false;
//    }
//    else if (status==2)
//    {
//       alert("To Date is not validate format");
//       setFocus(form.enddate);
//       return false;
//    }
//    else if (status==3)
//    {
//       alert("From Date is larger than To Date");
//       setFocus(form.startdate);
//       return false;
//    }


    return true;
}

function onAdsConfigLoad(form, action)
{
    if ("Update"!=action)
    {
        form.rotate.focus();
        form.rotate.select();
    }
}

function validateAdsConfig(form)
{
    var status = validateDateRange(form.startdate.value, form.enddate.value);
    if (status==1)
    {
       alert("From Date is not validate format");
       setFocus(form.startdate);
       return false;
    }
    else if (status==2)
    {
       alert("To Date is not validate format");
       setFocus(form.enddate);
       return false;
    }
    else if (status==3)
    {
       alert("From Date is larger than To Date");
       setFocus(form.startdate);
       return false;
    }

    return true;
}