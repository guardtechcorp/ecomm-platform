<!--Copyright Info-->
<!--The contents of this file are copyrighted by Zyz International Technology -->
<!--All Rights Reserved.  You are not permitted to copy or use this script in any circumstances -->

var g_Proccess;
var g_nIterval;
var jg;// = new jsGraphics("processCanvas");

function startProcess(nWidth, nHeight, nMaxValue, nIntervalSeconds)
{
  g_Proccess = new Proccess(nWidth, nHeight, nMaxValue);
  g_nIterval = nIntervalSeconds*1000;
  repeatShow();
}

function repeatShow()
{
  var sRequest = m_ServerProgram + "?action=Get UsedMemory" + "&time="+new Date().getTime();
  var sResponse = getUrlContent(sRequest);
//alert("sResponse=" + sResponse +"!");
  g_Proccess.add(parseInt(sResponse, 10));
  g_Proccess.render("proccessCanvas");
  setTimeout('repeatShow()', g_nIterval);
}

function Proccess(nWidth, nHeight, nMaxValue)
{
  this.width = nWidth;
  this.height = nHeight;
  this.maxvalue = nMaxValue;
  this.space = 12;
  this.delta  = 0;
  this.maxstep = nWidth/this.space;
  this.arData = new Array();

  this.add = function(nValue)
  {
    this.arData.push(nValue);
  }

  this.getPixel = function(nValue)
  {
    return this.height - this.height*(nValue/this.maxvalue);
  }

  this.render = function(canvas)
  {
//   var jg = new jsGraphics(canvas);
   if (!jg)
      jg = new jsGraphics(canvas);
   else
      jg.clear();

   //. Fill background color
   jg.setColor("black");
   jg.fillRect(0, 0, this.width, this.height);

   jg.setColor("#008040");
   var nStep;

   //. Draw horizontal rule lines
   for (nStep=this.space; nStep<this.height; nStep+=this.space)
   {
      jg.drawLine(0, nStep, this.width-1, nStep);
   }

   //. Draw vertical rule lines
   for (nStep=this.width-this.delta-1; nStep>0; nStep-=this.space)
   {
      jg.drawLine(nStep, 0, nStep, this.height-1);
   }

   jg.setColor("#FFFF00");

   //. Write the min and max value on left side.
   jg.drawString("0", 2, this.height-15, 50, "left");
   jg.drawString(""+this.maxvalue, 2, 2, 50, "left");

	//. Draw curve of proccess line
   if (this.arData.length>1)
   {
     var nLast = this.arData.length-1;
     if (this.delta>0)
     {//. Draw the first segemnt curve
       jg.drawLine(this.width-1, this.getPixel(this.arData[nLast]), this.width-this.delta-1, this.getPixel(this.arData[nLast-1]));
       nLast--;
     }

     var i;
     nStep = this.width-this.delta-1;
     for (i=nLast; i>0; i--)
     {
       jg.drawLine(nStep, this.getPixel(this.arData[i]), nStep-this.space, this.getPixel(this.arData[i-1]));
       nStep -= this.space;
     }

//    jg.setFont("Verdana", fnt,  Font.BOLD);
     jg.drawStringRect(""+this.arData[nLast], this.width-110, this.getPixel(this.arData[nLast])-22, 100, "right");
   }

   //. Adjust delta for show moving
   this.delta += this.space/3;
   if (this.delta>this.space)
   {
	  this.delta = 0;
   }

   jg.paint();
  }

}
