var slideShow=function(){
	var bxs,bxe,fxs,fxe,ys,ye,ta,ia,ie,st,ss,ft,fs,xp,yp,ci,t,tar,tarl,mwidth,twidth;
	ta=document.getElementById(slidethumbid); ia=document.getElementById(slideimgid);
	t=ta.getElementsByTagName('li'); ie=document.all?true:false;
	st=3; ss=3; ft=10; fs=5; xp,yp=0; cid=0;
	twidth=(ta.parentNode.offsetWidth-10);
	return{
		init:function(){
			document.onmousemove=this.pos; window.onresize=function(){setTimeout("slideShow.lim()",500)};
			ys=this.toppos(ta); ye=ys+ta.offsetHeight;
			len=t.length;tar=[];mwidth=0;
			for(i=0;i<len;i++){
				var id=t[i].value; tar[i]=id;
				t[i].onclick=new Function("slideShow.getimg('"+id+"')");
				if(i==0){this.getimg(id)}
			    mwidth += t[i].offsetWidth + 5;
			}
			tarl=tar.length;

			ta.style.left=fs+'px';
			if (document.getElementById('slidetotalid')!=null)
			   document.getElementById('slidetotalid').innerHTML = tar.length;
			this.shstatus();
		},
		scrl:function(d){
			clearInterval(ta.timer);
			var l=(d==-1)?0:(t[tarl-1].offsetLeft-(ta.parentNode.offsetWidth-t[tarl-1].offsetWidth)+10)
			ta.timer=setInterval(function(){slideShow.mv(d,l)},st);
		},
		mv:function(d,l){
			ta.style.left=ta.style.left||'0px';
			var left=ta.style.left.replace('px','');
			if(d==1){
				if(l-Math.abs(left)<=(ss+fs)){
					this.cncl(ta.id); ta.style.left='-'+(l-fs)+'px';
				}else{ta.style.left=left-ss+'px'}
			}else{
				if(Math.abs(left)-l<=(ss+fs)){
					this.cncl(ta.id); ta.style.left=l+fs+'px';
				}else{ta.style.left=parseInt(left)+ss+'px'}
			}

            this.shstatus();
		},
		cncl:function(){clearTimeout(ta.timer)},
		getimg:function(id){
			if(slideauto){clearTimeout(ia.timer)}
			if(ci!=null){
				var ts,tsl,x;
				ts=ia.getElementsByTagName('img'); tsl=ts.length;x=0;
				for(x;x<tsl;x++){
					if(ci.id!=id){var o=ts[x]; clearInterval(o.timer); o.timer=setInterval(function(){slideShow.fdout(o)},fs)}
				}
			}
			if(!document.getElementById(id)){
				var i=document.createElement('img');
				ia.appendChild(i);
				i.id=id; i.av=0; i.style.opacity=0;
   			    if (document.all)
				   i.style.filter='alpha(opacity=0)';
				else
				   i.style.filter='opacity:.0';

				i.src=getImageById(id);//imgdir+'/'+id+imgext;

				i.onclick=new Function("slideShow.clickimg('"+id+"')");
                i.alt="To click it to show its full-size picture.";

				var j = 0;
				for (var k=0; k<tar.length; k++)
				{
				   if (tar[k]==id)
				   {
					  j = k;
					  break;
				   }
				}
				var timg = t[j].getElementsByTagName('img');
                i.style.height = slideimgheight + 'px';
                if ((slideimgheight*timg[0].width/timg[0].height)<695)
                   i.style.width = slideimgheight*timg[0].width/timg[0].height + 'px';
                else
                   i.style.width = '700px';
//alert("i.style.width=" + i.style.width);
                if (document.getElementById('slideimageid'))
			      document.getElementById('slideimageid').innerHTML = (j+1);
//alert ("img=" + timg + "," + timg[0].src + "-->"+ timg[0].width+"x"+timg[0].height + "--" + tar.length);
			}else{
				i=document.getElementById(id); clearInterval(i.timer);
			}
			i.timer=setInterval(function(){slideShow.fdin(i)},fs);

			cid=id;
		},
		nav:function(d){
			var c=0;
			for(key in tar){if(tar[key]==ci.id){c=key}}
			if(tar[parseInt(c)+d]){
				this.getimg(tar[parseInt(c)+d]);
			}else{
				if(d==1){
					this.getimg(tar[0]);
				}else{this.getimg(tar[tarl-1])}
			}
		},
		auto:function(){ia.timer=setInterval(function(){slideShow.nav(1)},slideautodelay*1000)},
		fdin:function(i){
			if(i.complete){
			i.av=i.av+fs; i.style.opacity=i.av/100;
			if (document.all)
			   i.style.filter='alpha(opacity='+i.av+')';
			else
			   i.style.filter='opacity:'+i.av;
			}
			if(i.av>=100){if(slideauto){this.auto()}; clearInterval(i.timer); ci=i}
		},
		fdout:function(i){
			i.av=i.av-fs; i.style.opacity=i.av/100;
			if(document.all)
			   i.style.filter='alpha(opacity='+i.av+')';
			else
			   i.style.filter='opacity:'+i.av;

			if(i.av<=0){clearInterval(i.timer); if(i.parentNode){i.parentNode.removeChild(i)}}
		},
		lim:function(){
			var taw,taa,len; taw=ta.parentNode.offsetWidth; taa=taw/4;
//alert("taw=" + taw + "," + ta.style.left);
			bxs=slideShow.leftpos(ta); bxe=bxs+taa; fxe=bxs+taw; fxs=fxe-taa;
 		},
		pos:function(e){
			xp=ie?event.clientX+document.documentElement.scrollLeft:e.pageX;
			yp=ie?event.clientY+document.documentElement.scrollTop:e.pageY;
			if(xp>bxs&&xp<bxe&&yp>ys&&yp<ye){
				slideShow.scrl(-1);
			}else if(xp>fxs&&xp<fxe&&yp>ys&&yp<ye){
				slideShow.scrl(1);
			}else{slideShow.cncl()}
		},
		leftpos:function(t){
			var l=0;
			if(t.offsetParent){
				while(1){l+=t.offsetLeft; if(!t.offsetParent){break}; t=t.offsetParent}
			}else if(t.x){l+=t.x}
			return l;
		},
		toppos:function(t){
			var p=0;
			if(t.offsetParent){
				while(1){p+=t.offsetTop; if(!t.offsetParent){break}; t=t.offsetParent}
			}else if(t.y){p+=t.y}
			return p;
		},

		navend:function(d){
		   if(d<0){
			this.getimg(tar[0]);
		   }else{this.getimg(tar[tarl-1])}
		},
		mvend:function(d){
			if (d<0)
			{
			  ta.style.left=fs+'px';
			}
		    else
			{
			  ta.style.left=-(mwidth-twidth-10)  +'px';
		    }
			this.shstatus();
		},
		mvpage:function(d,p){
			this.cncl(ta.id);
			if (d<0)
			{
              var left = parseInt(ta.style.left.replace('px','')||0) + (twidth*p);
			  if (left>5)
				 this.mvend(d);
			  else
			  {
			    ta.style.left = left + 'px';
                this.shstatus();
	          }
			}
			else
			{
  			  var left = parseInt(ta.style.left.replace('px','')||0)-twidth*p;
			  if (Math.abs(left)>(mwidth-twidth-10))
			     this.mvend(d);
			  else
			  {
			     ta.style.left=left +'px';
                 this.shstatus();
			  }
			}
		},
		shstatus:function(){
			if (document.getElementById('slidderangeid')==null)
			   return;

			var left = parseInt(ta.style.left.replace('px','')||0);
            var nFirst = -1; nLast = -1;
			var nR=0;

			for (i=0; i<t.length; i++) {
               nR+=t[i].offsetWidth;
               if (nFirst<0 && (nR+left)>0)
				  nFirst = i;

			   if ((nR+left)>twidth)
			   {
				  nLast = i;
				  break;
			   }

			   nR+=fs;
			}

			nFirst++;
			if (nLast<0)
			   nLast = t.length;
			else
			   nLast++;
			document.getElementById('slidderangeid').innerHTML = '' + nFirst + ' - ' + nLast;

		   if (document.getElementById('slideprevid')!=null)
		      document.getElementById('slideprevid').disabled=(nFirst==1?true:false);
		   if (document.getElementById('slidefirstid')!=null)
              document.getElementById('slidefirstid').disabled=(nFirst==1?true:false);

		   if (document.getElementById('slidenextid')!=null)
		      document.getElementById('slidenextid').disabled=(nLast==t.length?true:false);
		   if (document.getElementById('slidelastid')!=null)
              document.getElementById('slidelastid').disabled=(nLast==t.length?true:false);
		},
		tgplay:function(){
	      slideauto = !slideauto;
		  if (slideauto)
		    this.getimg(cid);
		  else
			clearTimeout(ia.timer);

		  if (document.getElementById('slideplayid')!=null)
		  {
 		      if(document.all)
		        document.getElementById('slideplayid').innerText=(slideauto?"Stop Play":"Auto Play");
              else
		        document.getElementById('slideplayid').textContent=(slideauto?"Stop Play":"Auto Play");
		  }
		},
		clickimg:function(id){
		   onClickImage(id);
		},
		dp:function(msg){
		  window.status = msg;
		}
	};
}();//window.onload=function(){slideShow.init(); slideShow.lim()};
slideShow.init(); slideShow.lim();


/*
var slideShow=function(){
	var bxs,bxe,fxs,fxe,ys,ye,ta,ia,ie,st,ss,ft,fs,xp,yp,ci,t,tar,tarl,mwidth,twidth;
	ta=document.getElementById(slidethumbid); ia=document.getElementById(slideimgid);
	t=ta.getElementsByTagName('li'); ie=document.all?true:false;
	st=3; ss=3; ft=10; fs=5; xp,yp=0;
	twidth=(ta.parentNode.offsetWidth-10);
	return{
		init:function(){
			document.onmousemove=this.pos; window.onresize=function(){setTimeout("slideShow.lim()",500)};
			ys=this.toppos(ta); ye=ys+ta.offsetHeight;
			len=t.length;tar=[];mwidth=0;
			for(i=0;i<len;i++){
				var id=t[i].value; tar[i]=id;
				t[i].onclick=new Function("slideShow.getimg('"+id+"')");
				if(i==0){this.getimg(id)}
			    mwidth += t[i].offsetWidth + 5;
			}
			tarl=tar.length;

			ta.style.left=fs+'px';
			if (document.getElementById('slidetotalid')!=null)
			   document.getElementById('slidetotalid').innerHTML = tar.length;
			this.shstatus();
		},
		scrl:function(d){
			clearInterval(ta.timer);
			var l=(d==-1)?0:(t[tarl-1].offsetLeft-(ta.parentNode.offsetWidth-t[tarl-1].offsetWidth)+10)
			ta.timer=setInterval(function(){slideShow.mv(d,l)},st);
		},
		mv:function(d,l){
			ta.style.left=ta.style.left||'0px';
			var left=ta.style.left.replace('px','');
			if(d==1){
				if(l-Math.abs(left)<=(ss+fs)){
					this.cncl(ta.id); ta.style.left='-'+(l-fs)+'px';
				}else{ta.style.left=left-ss+'px'}
			}else{
				if(Math.abs(left)-l<=(ss+fs)){
					this.cncl(ta.id); ta.style.left=l+fs+'px';
				}else{ta.style.left=parseInt(left)+ss+'px'}
			}

            this.shstatus();

		},
		cncl:function(){clearTimeout(ta.timer)},
		getimg:function(id){
			if(slideauto){clearTimeout(ia.timer)}
			if(ci!=null){
				var ts,tsl,x;
				ts=ia.getElementsByTagName('img'); tsl=ts.length;x=0;
				for(x;x<tsl;x++){
					if(ci.id!=id){var o=ts[x]; clearInterval(o.timer); o.timer=setInterval(function(){slideShow.fdout(o)},fs)}
				}
			}
			if(!document.getElementById(id)){
				var i=document.createElement('img');
				ia.appendChild(i);
				i.id=id; i.av=0; i.style.opacity=0;
				i.style.filter='alpha(opacity=0)';
				i.src=getImageById(id);//imgdir+'/'+id+imgext;

				var j = 0;
				for (var k=0; k<tar.length; k++)
				{
				   if (tar[k]==id)
				   {
					  j = k;
					  break;
				   }
				}
				var timg = t[j].getElementsByTagName('img');
                i.style.height = slideheight + 'px';
                i.style.width = 700 + 'px';//slideheight*timg[0].width/timg[0].height + 'px';
			}else{
				i=document.getElementById(id); clearInterval(i.timer);
			}
			i.timer=setInterval(function(){slideShow.fdin(i)},fs);
		},
		nav:function(d){
			var c=0;
			for(key in tar){if(tar[key]==ci.id){c=key}}
			if(tar[parseInt(c)+d]){
				this.getimg(tar[parseInt(c)+d]);
			}else{
				if(d==1){
					this.getimg(tar[0]);
				}else{this.getimg(tar[tarl-1])}
			}
		},
		auto:function(){ia.timer=setInterval(function(){slideShow.nav(1)},slideautodelay*1000)},
		fdin:function(i){
			if(i.complete){i.av=i.av+fs; i.style.opacity=i.av/100; i.style.filter='alpha(opacity='+i.av+')'}
			if(i.av>=100){if(slideauto){this.auto()}; clearInterval(i.timer); ci=i}
		},
		fdout:function(i){
			i.av=i.av-fs; i.style.opacity=i.av/100;
			i.style.filter='alpha(opacity='+i.av+')';
			if(i.av<=0){clearInterval(i.timer); if(i.parentNode){i.parentNode.removeChild(i)}}
		},
		lim:function(){
			var taw,taa,len; taw=ta.parentNode.offsetWidth; taa=taw/4;
//alert("taw=" + taw + "," + ta.style.left);
			bxs=slideShow.leftpos(ta); bxe=bxs+taa; fxe=bxs+taw; fxs=fxe-taa;
 		},
		pos:function(e){
			xp=ie?event.clientX+document.documentElement.scrollLeft:e.pageX;
			yp=ie?event.clientY+document.documentElement.scrollTop:e.pageY;
			if(xp>bxs&&xp<bxe&&yp>ys&&yp<ye){
				slideShow.scrl(-1);
			}else if(xp>fxs&&xp<fxe&&yp>ys&&yp<ye){
				slideShow.scrl(1);
			}else{slideShow.cncl()}
		},
		leftpos:function(t){
			var l=0;
			if(t.offsetParent){
				while(1){l+=t.offsetLeft; if(!t.offsetParent){break}; t=t.offsetParent}
			}else if(t.x){l+=t.x}
			return l;
		},
		toppos:function(t){
			var p=0;
			if(t.offsetParent){
				while(1){p+=t.offsetTop; if(!t.offsetParent){break}; t=t.offsetParent}
			}else if(t.y){p+=t.y}
			return p;
		},

		navend:function(d){
		   if(d<0){
			this.getimg(tar[0]);
		   }else{this.getimg(tar[tarl-1])}
		},
		mvend:function(d){
			if (d<0)
			{
			  ta.style.left=fs+'px';
			}
		    else
			{
			  ta.style.left=-(mwidth-twidth-10)  +'px';
		    }
			this.shstatus();
		},
		mvpage:function(d,p){
			this.cncl(ta.id);
			if (d<0)
			{
              var left = parseInt(ta.style.left.replace('px','')||0) + (twidth*p);
			  if (left>5)
				 this.mvend(d);
			  else
			  {
			    ta.style.left = left + 'px';
                this.shstatus();
	          }
			}
			else
			{
  			  var left = parseInt(ta.style.left.replace('px','')||0)-twidth*p;
			  if (Math.abs(left)>(mwidth-twidth-10))
			     this.mvend(d);
			  else
			  {
			     ta.style.left=left +'px';
                 this.shstatus();
			  }
			}
		},
		shstatus:function(){
			if (document.getElementById('slidderangeid')==null)
			   return;

			var left = parseInt(ta.style.left.replace('px','')||0);
            var nFirst = -1; nLast = -1;
			var nR=0;

			for (i=0; i<t.length; i++) {
               nR+=t[i].offsetWidth;
               if (nFirst<0 && (nR+left)>0)
				  nFirst = i;

			   if ((nR+left)>twidth)
			   {
				  nLast = i;
				  break;
			   }

			   nR+=fs;//5;
			}

			nFirst++;
			if (nLast<0)
			   nLast = t.length;
			else
			   nLast++;
			document.getElementById('slidderangeid').innerHTML = '' + nFirst + ' - ' + nLast;
        },
		tgplay:function(){
	      slideauto = !slideauto;
		  if (slideauto)
		    this.getimg(1);
		  else
			clearTimeout(ia.timer);
		},
		dp:function(msg){
		  window.status = msg;
		}
	};
}();
//window.onload=function(){slideShow.init(); slideShow.lim()};
slideShow.init(); slideShow.lim();
*/
