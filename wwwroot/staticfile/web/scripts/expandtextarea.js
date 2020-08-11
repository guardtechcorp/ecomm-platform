var textareafuc=function(){
  var type;

return {
    init:function(classname, modetype)
	{
		type = modetype;
		var alltextareas=document.getElementsByTagName("textarea")
		for (var i=0; i<alltextareas.length; i++)
		{
			if (alltextareas[i].className==classname)
			{
			   var curtextarea=alltextareas[i]
               if (type==1)
			      curtextarea.style.overflowY="hidden"
			   var helperbar=document.createElement("div")
			   if (type==0)
   			      helperbar.innerHTML='<div class="selectcode" align="right"><a href="#selectcode" class="tabs">Select Code</a> <a href="#expandcode" class="tabs">Expand</a></div>'
			   else
			      helperbar.innerHTML='<div width="500"><a href="#" class="textarea_imgnav" id="textarea_selectimg" title="Click to select all of its content."></a> <a href="#"class="textarea_imgnav" id="textarea_expandimg" title="Click to expand its height."></a></div>'
			   var helperbarlinks=helperbar.getElementsByTagName("a")
			   if (curtextarea.offsetHeight>=curtextarea.scrollHeight)
			   {
				  helperbarlinks[1].style.display="none"
				  curtextarea.style.overflowY="hidden"
			   }

			   helperbarlinks[0].setAttribute("rel", i)
			   helperbarlinks[0].onclick=function(){
				 var targettextarea=document.getElementsByTagName("textarea")[parseInt(this.rel)]
				 targettextarea.select()
				 return false
			   }

			   helperbarlinks[1].setAttribute("rel", i)
			   helperbarlinks[1].setAttribute("rev", curtextarea.offsetHeight+" defaultHeight")
			   helperbarlinks[1].onclick=function(){
				 var targettextarea=document.getElementsByTagName("textarea")[parseInt(this.rel)]
				 if (this.getAttribute("rev").indexOf("defaultHeight")!=-1){// if textarea is default height
					targettextarea.style.height=targettextarea.scrollHeight+"px"
					if (type==0)
					   this.innerHTML="Contract"
					targettextarea.style.overflowY="hidden"
					targettextarea.style.borderStyle="solid"
					this.setAttribute("rev", this.getAttribute("rev").replace("defaultHeight", "scrollHeight"))
					if (this.scrollIntoView)
					   this.scrollIntoView()
					return false
				} 
				else
				{
					targettextarea.style.height=parseInt(this.getAttribute("rev"))+"px"
					if (type==0) {
					   this.innerHTML="Expand"
					   targettextarea.style.overflowY="scroll"
					}
					targettextarea.style.borderStyle="dashed"
					this.setAttribute("rev", this.getAttribute("rev").replace("scrollHeight", "defaultHeight"))
				}
				return false
			 }

			 curtextarea.style.marginTop=0
			 curtextarea.parentNode.insertBefore(helperbar, alltextareas[i])
		   }
		}	
	}
  };
}();