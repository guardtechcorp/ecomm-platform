<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

function OnCustomerLoad(form)
{
    OnSelectStateChange(form);
    OnSelectCountryChange(form);
    setFocus(form.email);
/*
    OnSelectShipStateChange(form);
    OnSelectShipCountryChange(form);
*/
}

function OnSelectCreditType(form)
{
  if (form.credittype.value=="Check" || form.credittype.value=="PayPal")
  {
    form.creditname.disabled="true";
    form.creditno.disabled="true";
    form.csid.disabled="true";
    form.expiredmonth.disabled="true";
    form.expiredyear.disabled="true";
  }
  else
  {
    form.creditname.disabled="";
    form.creditno.disabled="";
    form.csid.disabled="";
    form.expiredmonth.disabled="";
    form.expiredyear.disabled="";
  }
}

function CreditCardSelect(form, type, month, year)
{
  TypeSelect(form, type);
  MonthSelect(form, month);
  YearSelect(form, year);
}

function TypeSelect(form, type)
{
   for(i=0; i<form.credittype.length; i++)
   {
      if (form.credittype.options[i].value==type)
      {
         form.credittype.selectedIndex = i;
         break;
      }
   }
}

function MonthSelect(form, month)
{
  for(i=0; i<form.expiredmonth.length; i++)
  {
    if (form.expiredmonth.options[i].value==month)
    {
     form.expiredmonth.selectedIndex = i;
     break;
    }
  }
}

function YearSelect(form, year)
{
   for(i=0; i<form.expiredyear.length; i++)
   {
      if (form.expiredyear.options[i].value==year)
      {
         form.expiredyear.selectedIndex = i;
         break;
      }
   }
}

function StateSelect(form, state)
{
//alert("state = " + state);
    var bRet = false;
    for(i=0; i<form.state.length; i++)
    {
       if (form.state.options[i].value==state)
       {
          form.state.selectedIndex = i;
          form.province.disabled="true";
          bRet = true;
          break;
        }
    }

    if (state!="" && bRet==false)
    {//Non-USA
       form.province.disabled="";
       form.province.value = state;
       form.state.selectedIndex = form.state.length-1;
    }
}

function CountrySelect(form, country, state)
{
  var bRet = false;
  for(i=0; i<form.country.length; i++)
  {
     if (form.country.options[i].value==country)
     {
         form.province.disabled="true";
         form.country.selectedIndex = i;
         bRet = true;
         break;
      }
    }

    if (state!=null&&bRet==false)
    {//Non-USA
      form.province.disabled="";
      form.province.value = state;
      form.state.selectedIndex = form.state.length-1;
    }
}

function ShipStateSelect(form, shipstate)
{
    var bRet = false;
    for(i=0; i<form.ship_state.length; i++)
    {
      if (form.ship_state.options[i].value==shipstate)
      {
        form.ship_state.selectedIndex = i;
        form.ship_province.disabled="true";
        bRet = true;
        break;
      }
    }

    if (bRet==false)
    {//Non-USA
      form.ship_province.disabled="";
      form.ship_province.value = shipstate;
      form.ship_state.selectedIndex = form.ship_state.length-1;
    }
}

function ShipCountrySelect(form, shipcountry, shipstate)
{
    var bRet = false;
    for(i=0; i<form.ship_country.length; i++)
    {
      if (form.ship_country.options[i].value==shipcountry)
      {
        form.ship_province.disabled="true";
        form.ship_country.selectedIndex = i;
        bRet = true;
        break;
      }
    }

    if (bRet==false)
    {//Non-USA
     form.ship_province.disabled="";
     form.ship_province.value = shipstate;
     form.ship_state.selectedIndex = form.ship_state.length-1;
    }
}

function OnSelectStateChange(form)
{
  if (CheckSelectedProvince(form))
  {//Non-USA
     form.province.disabled="";
     form.province.focus();
     form.province.select();
  }
  else
  {
    form.province.value = "";
    form.province.disabled="true";
  }
}

function CheckSelectedProvince(form)
{
  if (form.state.options[form.state.selectedIndex].value=="XX")
  {
    return true;
  }
  else
  {
    return false;
  }
}

function OnSelectCountryChange(form)
{
    var nLastIndex =  form.state.length-1;
    if (form.country.options[form.country.selectedIndex].value!="USA")
    {//Non-USA
       form.state.selectedIndex = nLastIndex;
       form.province.disabled="";
       form.province.focus();
       form.province.select();
    }
    else
    {
       if (form.state.selectedIndex==nLastIndex)
       {
         form.state.selectedIndex = 0;//6;//California
//         form.province.value = "";
         form.province.disabled="true";
         form.state.focus();
       }
    }
}

function OnSelectShipStateChange(form)
{
    if (form.ship_state.options[form.ship_state.selectedIndex].value=="XX")
    {//Non-USA
       form.ship_province.disabled="";
       form.ship_province.focus();
       form.ship_province.select();
    }
    else
    {
       form.ship_province.value = "";
       form.ship_province.disabled="true";
    }
}

function OnSelectShipCountryChange(form)
{
  var nLastIndex =  form.ship_state.length-1;
  if (form.ship_country.options[form.ship_country.selectedIndex].value!="USA")
  {//Non-USA
     form.ship_state.selectedIndex = nLastIndex;
     form.ship_province.disabled="";
     form.ship_province.focus();
     form.ship_province.select();
  }
  else
  {
     if (form.ship_state.selectedIndex==nLastIndex)
     {
       form.ship_state.selectedIndex = 0;//6;//California
       form.ship_province.value = "";
       form.ship_province.disabled="true";
       form.ship_state.focus();
     }
  }
}


function validateCustomer(form, creditno)
{
  //. check the email
  if (checkFieldEmpty(form.email))
  {
     alert("You missed to input email.");
     setFocus(form.email);
     return false;
  }
  if (!validateEmail(form.email))
     return false;

  //. check the password
  if (checkFieldEmpty(form.password))
  {
     alert("You missed to input password.");
     setFocus(form.password);
     return false;
  }
  //. check the confirm password
  if (checkFieldEmpty(form.cpassword))
  {
     alert("You missed to input confirm password.");
     setFocus(form.cpassword);
     return false;
  }
  //.
  if (form.password.value!=form.cpassword.value)
  {
     alert("The password adn confir password is not the same.");
     setFocus(form.cpassword);
     return false;
  }

/*
  if (form.credittype.value!="Check" && form.credittype.value!="PayPal")
  {
    //. check the credit card
    if (checkFieldEmpty(form.creditname))
    {
      alert("You missed to input name on your credit card.");
      setFocus(form.creditname);
      return false;
    }
    //. check card no
    if (checkFieldEmpty(form.creditno))
    {
      alert("You missed to input credit card number.");
      setFocus(form.creditno);
      return false;
    }

    if (form.creditno.value.length<15)
    {
      alert("The credit card number is a invalid number.");
      setFocus(form.creditno);
      return false;
    }


    //. check Expired month
    if (form.expiredmonth.selectedIndex==0)
    {
      alert("You missed to select expiration month.");
      form.expiredmonth.focus();
      return false;
    }
    //. check Expiration year
    if (form.expiredyear.selectedIndex==0)
    {
      alert("You missed to select expiration year.");
      form.expiredyear.focus();
      return false;
    }

    //. check  security id
    if (checkFieldEmpty(form.csid))
    {
       alert("You missed to input security id.");
       setFocus(form.csid);
       return false;
    }
  }
*/

  //. check the your name
  if (checkFieldEmpty(form.yourname))
  {
     alert("You missed to input your name.");
     setFocus(form.yourname);
     return false;
  }
  //. check the street address
  if (checkFieldEmpty(form.address))
  {
     alert("You missed to input address.");
     setFocus(form.address);
     return false;
  }
  //. check the city name
  if (checkFieldEmpty(form.city))
  {
     alert("You missed to input city.");
     setFocus(form.city);
     return false;
  }

  //. check the provice
  if (form.country.options[form.country.selectedIndex].value!="USA")
  {//Non-USA
      if (checkFieldEmpty(form.province))
      {
         alert("You missed to input Other field.");
         setFocus(form.province);
         return false;
      }
  }
  //. check the zip code
  if (checkFieldEmpty(form.zipcode))
  {
     alert("You missed to input zip/postal Code.");
     setFocus(form.zipcode);
     return false;
  }
/*
  //.check the phone
  if (checkFieldEmpty(form.phone))
  {
     alert("You missed to input phone number.");
     setFocus(form.phone);
     return false;
  }
*/
  //. check the shipping
  if (!checkFieldEmpty(form.ship_address))
  {
    if (checkFieldEmpty(form.ship_yourname))
    {
       alert("You missed to input ship name.");
       setFocus(form.ship_yourname);
       return false;
    }
    //. check the city name
    if (checkFieldEmpty(form.ship_city))
    {
       alert("You missed to input ship city.");
       setFocus(form.ship_city)
       return false;
    }
    //. check the provice
    if (form.ship_country.options[form.ship_country.selectedIndex].value!="USA")
    {//Non-USA
        if (checkFieldEmpty(form.ship_province))
        {
           alert("You missed to input ship Other field.");
           setFocus(form.ship_province);
           return false;
        }
    }
    //. check the zip code
    if (checkFieldEmpty(form.ship_zipcode))
    {
       alert("You missed to input zip/postal Code.");
       setFocus(form.ship_zipcode);

       return false;
    }
  }

  FillInfomation(form, creditno);

  return true;
}

function FillInfomation(form, creditno)
{
   //Handle Credit No
   if (form.creditno.disabled=="true")
   {//. It is encryed
     form.creditno.disabled = "";
     form.creditno.value = creditno;
   }

   if (form.country.options[form.country.selectedIndex].value!="USA")
   {//Non-USA
     form.state.selectedIndex = 0;
     form.state.options[form.state.selectedIndex].value = form.province.value;
   }

//	if (form.ship_country.selectedIndex!=0)
   if (form.ship_country.options[form.ship_country.selectedIndex].value!="USA")
   {//Non-USA
     form.ship_state.selectedIndex = 0;
     form.ship_state.options[form.ship_state.selectedIndex].value = form.ship_province.value;
   }
}

//. For Customer search
function onCustomerSearchLoad(form)
{
  setFocus(form.customerid);
}

function validateSearch(form)
{
  //. check the email
  var bRet = false;
  //. check the your name
  if (!checkFieldEmpty(form.yourname))
  {
     return true;
  }
  if (!checkFieldEmpty(form.email))
  {
     bRet = true;
  }
  //. check the phone
  if (!checkFieldEmpty(form.phone))
  {
     bRet = true;
  }
  //. check the street address
  if (!checkFieldEmpty(form.address))
  {
     bRet = true;
  }
  //. check the city name
  if (!checkFieldEmpty(form.city))
  {
     bRet = true;
  }

  //. check the state
  if (!checkFieldEmpty(form.state))
  {
     bRet = true;
  }
  //. check the zip code
  if (!checkFieldEmpty(form.zipcode))
  {
     bRet = true;
  }
  //. check the country
  if (!checkFieldEmpty(form.country))
  {
     bRet = true;
  }
  //. check the create date from
  if (!checkFieldEmpty(form.createdate_from))
  {
     bRet = true;
  }
  //. check the create date to
  if (!checkFieldEmpty(form.createdate_to))
  {
     bRet = true;
  }

  if (!bRet)
  {
     alert("You at least to input one of fields.");
     setFocus(form.yourname);
     return false;
  }
  else
     return true;
}

function onMoneyPocketFormLoad(form)
{
  setFocus(form.money);
}

function validateMoneyPocketForm(form)
{
  //. check the money field
  if (checkFieldEmpty(form.money))
  {
     alert("You missed to input money.");
     setFocus(form.money);
     return false;
  }

  if (parseInt(form.money.value)<=0)
  {
    alert("The money you entered must be large than 0.");
    setFocus(form.money);
    return false;
  }

  return true;
}

var g_State = new Array();
g_State[0] = new Array("AL","Alabama");
g_State[1] = new Array("AK","Alaska");
g_State[2] = new Array("AB","Alberta");
g_State[3] = new Array("AZ","Arizona");
g_State[4] = new Array("AR","Arkansas");
g_State[5] = new Array("BC","British Columbia");
g_State[6] = new Array("CA","California");
g_State[7] = new Array("CO","Colorado");
g_State[8] = new Array("CT","Connecticut");
g_State[9] = new Array("DE","Delaware");
g_State[10] = new Array("DC","District of Columbia");
g_State[11] = new Array("FL","Florida");
g_State[12] = new Array("GA","Georgia");
g_State[13] = new Array("HI","Hawaii");
g_State[14] = new Array("ID","Idaho");
g_State[15] = new Array("IL","Illinois");
g_State[16] = new Array("IN","Indiana");
g_State[17] = new Array("IA","Iowa");
g_State[18] = new Array("KS","Kansas");
g_State[19] = new Array("KY","Kentucky");
g_State[20] = new Array("LA","Louisiana");
g_State[21] = new Array("ME","Maine");
g_State[22] = new Array("MB","Manitoba");
g_State[23] = new Array("MD","Maryland");
g_State[24] = new Array("MA","Massachusetts");
g_State[25] = new Array("MI","Michigan");
g_State[26] = new Array("MN","Minnesota");
g_State[27] = new Array("MS","Mississippi");
g_State[28] = new Array("MO","Missouri");
g_State[29] = new Array("MT","Montana");
g_State[30] = new Array("NE","Nebraska");
g_State[31] = new Array("NV","Nevada");
g_State[32] = new Array("NB","New Brunswick");
g_State[33] = new Array("NF","Newfoundland");
g_State[34] = new Array("NH","New Hampshire");
g_State[35] = new Array("NJ","New Jersey");
g_State[36] = new Array("NM","New Mexico");
g_State[37] = new Array("NY","New York");
g_State[38] = new Array("NC","North Carolina");
g_State[39] = new Array("ND","North Dakota");
g_State[40] = new Array("NT","Northwest Territories");
g_State[41] = new Array("NS","Nova Scotia");
g_State[42] = new Array("OH","Ohio");
g_State[43] = new Array("OK","Oklahoma");
g_State[44] = new Array("ON","Ontario");
g_State[45] = new Array("OR","Oregon");
g_State[46] = new Array("PA","Pennsylvania");
g_State[47] = new Array("PE","Prince Edward Island");
g_State[48] = new Array("PR","Puerto Rico");
g_State[49] = new Array("QC","Quebec");
g_State[50] = new Array("RI","Rhode Island");
g_State[51] = new Array("SK","Saskatchewan");
g_State[52] = new Array("SC","South Carolina");
g_State[53] = new Array("SD","South Dakota");
g_State[54] = new Array("TN","Tennessee");
g_State[55] = new Array("TX","Texas");
g_State[56] = new Array("UT","Utah");
g_State[57] = new Array("VT","Vermont");
g_State[58] = new Array("VA","Virginia");
g_State[59] = new Array("WA","Washington");
g_State[60] = new Array("WV","West Virginia");
g_State[61] = new Array("WI","Wisconsin");
g_State[62] = new Array("WY","Wyoming");
g_State[63] = new Array("YK","Yukon Territory");
g_State[64] = new Array("XX","Other--->>");

var g_Country = new Array();
g_Country[0] = new Array("AFG","Afghanistan");
g_Country[1] = new Array("ALB","Albania");
g_Country[2] = new Array("DZA","Algeria");
g_Country[3] = new Array("ASM","American Samoa");
g_Country[4] = new Array("AND","Andorra");
g_Country[5] = new Array("AGO","Angola");
g_Country[6] = new Array("AIA","Anguilla");
g_Country[7] = new Array("ATA","Antarctica");
g_Country[8] = new Array("ATG","Antigua and Barbuda");
g_Country[9] = new Array("ARG","Argentina");
g_Country[10] = new Array("ARM","Armenia");
g_Country[11] = new Array("ABW","Aruba");
g_Country[12] = new Array("AUS","Australia");
g_Country[13] = new Array("AUT","Austria");
g_Country[14] = new Array("AZE","Azerbaijan");
g_Country[15] = new Array("BHS","Bahamas");
g_Country[16] = new Array("BHR","Bahrain");
g_Country[17] = new Array("BGD","Bangladesh");
g_Country[18] = new Array("BRB","Barbados");
g_Country[19] = new Array("BLR","Belarus");
g_Country[20] = new Array("BEL","Belgium");
g_Country[21] = new Array("BLZ","Belize");
g_Country[22] = new Array("BEN","Benin");
g_Country[23] = new Array("BMU","Bermuda");
g_Country[24] = new Array("BTN","Bhutan");
g_Country[25] = new Array("BOL","Bolivia");
g_Country[26] = new Array("BIH","Bosnia and Herzegowina");
g_Country[27] = new Array("BWA","Botswana");
g_Country[28] = new Array("BVT","Bouvet Island");
g_Country[29] = new Array("BRA","Brazil");
g_Country[30] = new Array("IOT","British Indian Ocean Territory");
g_Country[31] = new Array("BRN","Brunei Darussalam");
g_Country[32] = new Array("BGR","Bulgaria");
g_Country[33] = new Array("BFA","Burkina Faso");
g_Country[34] = new Array("BDI","Burundi");
g_Country[35] = new Array("KHM","Cambodia");
g_Country[36] = new Array("CMR","Cameroon");
g_Country[37] = new Array("CAN","Canada");
g_Country[38] = new Array("CPV","Cape Verde");
g_Country[39] = new Array("CYM","Cayman Islands");
g_Country[40] = new Array("CAF","Central African Republic");
g_Country[41] = new Array("TCD","Chad");
g_Country[42] = new Array("CHL","Chile");
g_Country[43] = new Array("CHN","China");
g_Country[44] = new Array("CXR","Christmas Island");
g_Country[45] = new Array("CCK","Cocos (Keeling) Islands");
g_Country[46] = new Array("COL","Colombia");
g_Country[47] = new Array("COM","Comoros");
g_Country[48] = new Array("COG","Congo");
g_Country[49] = new Array("COD","Congo, the Democratic Republic of the");
g_Country[50] = new Array("COK","Cook Islands");
g_Country[51] = new Array("CRI","Costa Rica");
g_Country[52] = new Array("CIV","Cote D'Ivoire");
g_Country[53] = new Array("HRV","Croatia (Local Name: Hrvatska)");
g_Country[54] = new Array("CUB","Cuba");
g_Country[55] = new Array("CYP","Cyprus");
g_Country[56] = new Array("CZE","Czech Republic");
g_Country[57] = new Array("DNK","Denmark");
g_Country[58] = new Array("DJI","Djibouti");
g_Country[59] = new Array("DMA","Dominica");
g_Country[60] = new Array("DOM","Dominican Republic");
g_Country[61] = new Array("TMP","East Timor");
g_Country[62] = new Array("ECU","Ecuador");
g_Country[63] = new Array("EGY","Egypt");
g_Country[64] = new Array("SLV","El Salvador");
g_Country[65] = new Array("GNQ","Equatorial Guinea");
g_Country[66] = new Array("ERI","Eritrea");
g_Country[67] = new Array("EST","Estonia");
g_Country[68] = new Array("ETH","Ethiopia");
g_Country[69] = new Array("FLK","Falkland Islands (Malvinas)");
g_Country[70] = new Array("FRO","Faroe Islands");
g_Country[71] = new Array("FJI","Fiji");
g_Country[72] = new Array("FIN","Finland");
g_Country[73] = new Array("FRA","France");
g_Country[74] = new Array("FXX","France, Metropolitan");
g_Country[75] = new Array("GUF","French Guiana");
g_Country[76] = new Array("PYF","French Polynesia");
g_Country[77] = new Array("ATF","French Southern Territories");
g_Country[78] = new Array("GAB","Gabon");
g_Country[79] = new Array("GMB","Gambia");
g_Country[80] = new Array("GEO","Georgia");
g_Country[81] = new Array("DEU","Germany");
g_Country[82] = new Array("GHA","Ghana");
g_Country[83] = new Array("GIB","Gibraltar");
g_Country[84] = new Array("GRC","Greece");
g_Country[85] = new Array("GRL","Greenland");
g_Country[86] = new Array("GRD","Grenada");
g_Country[87] = new Array("GLP","Guadeloupe");
g_Country[88] = new Array("GUM","Guam");
g_Country[89] = new Array("GTM","Guatemala");
g_Country[90] = new Array("GIN","Guinea");
g_Country[91] = new Array("GNB","Guinea-Bissau");
g_Country[92] = new Array("GUY","Guyana");
g_Country[93] = new Array("HTI","Haiti");
g_Country[94] = new Array("HMD","Heard and Mc Donald Islands");
g_Country[95] = new Array("VAT","Holy See (Vatican City State)");
g_Country[96] = new Array("HND","Honduras");
g_Country[97] = new Array("HKG","Hong Kong");
g_Country[98] = new Array("HUN","Hungary");
g_Country[99] = new Array("ISL","Iceland");
g_Country[100] = new Array("IND","India");
g_Country[101] = new Array("IDN","Indonesia");
g_Country[102] = new Array("IRN","Iran (Islamic Republic of)");
g_Country[103] = new Array("IRQ","Iraq");
g_Country[104] = new Array("IRL","Ireland");
g_Country[105] = new Array("ISR","Israel");
g_Country[106] = new Array("ITA","Italy");
g_Country[107] = new Array("JAM","Jamaica");
g_Country[108] = new Array("JPN","Japan");
g_Country[109] = new Array("JOR","Jordan");
g_Country[110] = new Array("KAZ","Kazakhstan");
g_Country[111] = new Array("KEN","Kenya");
g_Country[112] = new Array("KIR","Kiribati");
g_Country[113] = new Array("PRK","Korea, Democratic People's Republic of");
g_Country[114] = new Array("KOR","Korea, Republic of");
g_Country[115] = new Array("KWT","Kuwait");
g_Country[116] = new Array("KGZ","Kyrgyzstan");
g_Country[117] = new Array("LAO","Lao People's Democratic Republic");
g_Country[118] = new Array("LVA","Latvia");
g_Country[119] = new Array("LBN","Lebanon");
g_Country[120] = new Array("LSO","Lesotho");
g_Country[121] = new Array("LBR","Liberia");
g_Country[122] = new Array("LBY","Libyan Arab Jamahiriya");
g_Country[123] = new Array("LIE","Liechtenstein");
g_Country[124] = new Array("LTU","Lithuania");
g_Country[125] = new Array("LUX","Luxembourg");
g_Country[126] = new Array("MAC","Macau");
g_Country[127] = new Array("MKD","Macedonia, the Former Yugoslav Republic of");
g_Country[128] = new Array("MDG","Madagascar");
g_Country[129] = new Array("MWI","Malawi");
g_Country[130] = new Array("MYS","Malaysia");
g_Country[131] = new Array("MDV","Maldives");
g_Country[132] = new Array("MLI","Mali");
g_Country[133] = new Array("MLT","Malta");
g_Country[134] = new Array("MHL","Marshall Islands");
g_Country[135] = new Array("MTQ","Martinique");
g_Country[136] = new Array("MRT","Mauritania");
g_Country[137] = new Array("MUS","Mauritius");
g_Country[138] = new Array("MYT","Mayotte");
g_Country[139] = new Array("MEX","Mexico");
g_Country[140] = new Array("FSM","Micronesia, Federated States of");
g_Country[141] = new Array("MDA","Moldova, Republic of");
g_Country[142] = new Array("MCO","Monaco");
g_Country[143] = new Array("MNG","Mongolia");
g_Country[144] = new Array("MSR","Montserrat");
g_Country[145] = new Array("MAR","Morocco");
g_Country[146] = new Array("MOZ","Mozambique");
g_Country[147] = new Array("MMR","Myanmar");
g_Country[148] = new Array("NAM","Namibia");
g_Country[149] = new Array("NRU","Nauru");
g_Country[150] = new Array("NPL","Nepal");
g_Country[151] = new Array("NLD","Netherlands");
g_Country[152] = new Array("ANT","Netherlands Antilles");
g_Country[153] = new Array("NCL","New Caledonia");
g_Country[154] = new Array("NZL","New Zealand");
g_Country[155] = new Array("NIC","Nicaragua");
g_Country[156] = new Array("NER","Niger");
g_Country[157] = new Array("NGA","Nigeria");
g_Country[158] = new Array("NIU","Niue");
g_Country[159] = new Array("NFK","Norfolk Island");
g_Country[160] = new Array("MNP","Northern Mariana Islands");
g_Country[161] = new Array("NOR","Norway");
g_Country[162] = new Array("OMN","Oman");
g_Country[163] = new Array("PAK","Pakistan");
g_Country[164] = new Array("PLW","Palau");
g_Country[165] = new Array("PAN","Panama");
g_Country[166] = new Array("PNG","Papua New Guinea");
g_Country[167] = new Array("PRY","Paraguay");
g_Country[168] = new Array("PER","Peru");
g_Country[169] = new Array("PHL","Philippines");
g_Country[170] = new Array("PCN","Pitcairn");
g_Country[171] = new Array("POL","Poland");
g_Country[172] = new Array("PRT","Portugal");
g_Country[173] = new Array("PRI","Puerto Rico");
g_Country[174] = new Array("QAT","Qatar");
g_Country[175] = new Array("REU","Reunion");
g_Country[176] = new Array("ROM","Romania");
g_Country[177] = new Array("RUS","Russian Federation");
g_Country[178] = new Array("RWA","Rwanda");
g_Country[179] = new Array("KNA","Saint Kitts and Nevis");
g_Country[180] = new Array("LCA","Saint Lucia");
g_Country[181] = new Array("VCT","Saint Vincent and the Grenadines");
g_Country[182] = new Array("WSM","Samoa");
g_Country[183] = new Array("SMR","San Marino");
g_Country[184] = new Array("STP","Sao Tome and Principe");
g_Country[185] = new Array("SAU","Saudi Arabia");
g_Country[186] = new Array("SEN","Senegal");
g_Country[187] = new Array("SYC","Seychelles");
g_Country[188] = new Array("SLE","Sierra Leone");
g_Country[189] = new Array("SGP","Singapore");
g_Country[190] = new Array("SVK","Slovakia (Slovak Republic)");
g_Country[191] = new Array("SVN","Slovenia");
g_Country[192] = new Array("SLB","Solomon Islands");
g_Country[193] = new Array("SOM","Somalia");
g_Country[194] = new Array("ZAF","South Africa");
g_Country[195] = new Array("SGS","South Georgia and the South Sandwich Islands");
g_Country[196] = new Array("ESP","Spain");
g_Country[197] = new Array("LKA","Sri Lanka");
g_Country[198] = new Array("SHN","St. Helena");
g_Country[199] = new Array("SPM","St. Pierre and Miquelon");
g_Country[200] = new Array("SDN","Sudan");
g_Country[201] = new Array("SUR","Suriname");
g_Country[202] = new Array("SJM","Svalbard and Jan Mayen Islands");
g_Country[203] = new Array("SWZ","Swaziland");
g_Country[204] = new Array("SWE","Sweden");
g_Country[205] = new Array("CHE","Switzerland");
g_Country[206] = new Array("SYR","Syrian Arab Republic");
g_Country[207] = new Array("TWN","Taiwan");
g_Country[208] = new Array("TJK","Tajikistan");
g_Country[209] = new Array("TZA","Tanzania, United Republic of");
g_Country[210] = new Array("THA","Thailand");
g_Country[211] = new Array("TGO","Togo");
g_Country[212] = new Array("TKL","Tokelau");
g_Country[213] = new Array("TON","Tonga");
g_Country[214] = new Array("TTO","Trinidad and Tobago");
g_Country[215] = new Array("TUN","Tunisia");
g_Country[216] = new Array("TUR","Turkey");
g_Country[217] = new Array("TKM","Turkmenistan");
g_Country[218] = new Array("TCA","Turks and Caicos Islands");
g_Country[219] = new Array("TUV","Tuvalu");
g_Country[220] = new Array("UGA","Uganda");
g_Country[221] = new Array("UKR","Ukraine");
g_Country[222] = new Array("ARE","United Arab Emirates");
g_Country[223] = new Array("GBR","United Kingdom");
g_Country[224] = new Array("USA","United States");
g_Country[225] = new Array("UMI","United States Minor Outlying Islands");
g_Country[226] = new Array("URY","Uruguay");
g_Country[227] = new Array("UZB","Uzbekistan");
g_Country[228] = new Array("VUT","Vanuatu");
g_Country[229] = new Array("VEN","Venezuela");
g_Country[230] = new Array("VNM","Viet Nam");
g_Country[231] = new Array("VGB","Virgin Islands (British)");
g_Country[232] = new Array("VIR","Virgin Islands (U.S.)");
g_Country[233] = new Array("WLF","Wallis and Futuna Islands");
g_Country[234] = new Array("ESH","Western Sahara");
g_Country[235] = new Array("YEM","Yemen");
g_Country[236] = new Array("YUG","Yugoslavia");
g_Country[237] = new Array("ZMB","Zambia");
g_Country[238] = new Array("ZWE","Zimbabwe");

function setupStateOption(form, sSelected, type)
{
    if (type==0)
       setupOption(form.state, g_State, sSelected);
    else
       setupOption(form.ship_state, g_State, sSelected);

    if (type==0)
    {
      if (form.country.value!="USA")
      {
         form.state.selectedIndex = form.state.length-1;
         form.province.value = sSelected;
      }
    }
    else
    {
       if (form.ship_country.value!="USA")
       {
          form.ship_state.selectedIndex = form.ship_state.length-1;
          form.ship_province.value = sSelected;
       }
    }
}

function setupOption2(objSelect, objArray, sSelected)
{
//  objSelect.length = 0;
  var nInitial = objSelect.length;
  for (i=0; i<objArray.length; i++)
  {
     objSelect.options[objSelect.length] = new Option(objArray[i][1], objArray[i][0]);
     if (objArray[i][0] == sSelected)
        objSelect.selectedIndex = i + nInitial;
  }
}
