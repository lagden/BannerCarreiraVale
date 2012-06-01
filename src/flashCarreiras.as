package
{
	import app.events.Application;
	import app.events.Dispatcher;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Security;
	import flash.system.System;
	
	import lagden.ui.Nav;
	import lagden.utils.TxtBox;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.time.Interval;
	import org.casalib.util.AlignUtil;
	import org.casalib.util.NavigateUtil;
	import org.casalib.util.StageReference;
	
	[SWF(width="499", height="158", backgroundColor="#FFFFFF", frameRate="31")]
	
	public class flashCarreiras extends CasaSprite
	{
		protected var _app:Application;
		protected var _dispatcher:Dispatcher;
		
		protected var _interval:Interval;
		
		protected var lista:Array;
		protected var lnk:Array;
		protected var navi:Array;
		
		private var masterContent:CasaSprite;
		
		public function flashCarreiras()
		{
			Security.allowDomain('*');
			
			StageReference.setStage(this.stage);
			this.stage.scaleMode=StageScaleMode.NO_SCALE;
			this.stage.align=StageAlign.TOP_LEFT;
			
			
			this._app = Application.getInstance();
			this._dispatcher = new Dispatcher();
			
			this._app['vars']={};
			this._app['vars']['w'] = stage.stageWidth;
			this._app['vars']['h'] = stage.stageHeight;
			// Lingua que será renderizada (pt || en)
			this._app['vars']['language'] = 'en';
			// Tempo de troca
			this._app['vars']['tempoTroca'] = 10;
			// Font
			this._app['vars']['fontSize'] = 10;
			this._app['vars']['font'] = new Arial();
			this._app['vars']['branco'] = '0xFFFFFF';
			this._app['vars']['verde'] = '0x008F83';
			this._app['vars']['laranja'] = '0xE8A605';
			
			// Master
			masterContent = new CasaSprite();
			
			if(this._app['vars']['language'] == 'en')
			{
				// EN
				lista=[
					new En1(),
					new En2(),
					new En3(),
					//new En4(),
					new En5()
				];
				
				lnk = [
					"/en-us/carreiras/depoimentos/Pages/bojan-blasevic.aspx",
					"/en-us/carreiras/depoimentos/Pages/lindsay-moreau-verlaan-.aspx",
					"/en-us/carreiras/depoimentos/Pages/kristina-fransiska-muntu.aspx",
					//"/en-us/carreiras/depoimentos/Pages/elisa-raquel-vieira-pinto-.aspx",
					"/en-us/carreiras/depoimentos/Pages/jorge-eduardo-plaza-jofre.aspx"
				];
			}
			else
			{
				// PT
				lista=[
					//new Pt1(),
					new Pt2(),
					new Pt3(),
					new Pt4(),
					new Pt5()
				];
				
				lnk = [
					//"/pt-br/carreiras/depoimentos/Paginas/elisa-raquel-vieira-pinto-.aspx",
					"/pt-br/carreiras/depoimentos/Paginas/bojan-blasevic.aspx",
					"/pt-br/carreiras/depoimentos/Paginas/kristina-fransiska-muntu.aspx",
					"/pt-br/carreiras/depoimentos/Paginas/lindsay-moreau-verlaan-.aspx",
					"/pt-br/carreiras/depoimentos/Paginas/jorge-eduardo-plaza-jofre.aspx"
				];
			}
			
			// Imagens e Nav
			navi=[];
			for( var i:String in lista)
			{
				navi.push(new Nav(_dispatcher,{txt:(uint(i)+1),pos:uint(i)}));
				lista[uint(i)].alpha = 0;
				lista[uint(i)].visible = false;
				// Fix size
				/*
				lista[uint(i)].width = this._app['vars']['w'];
				lista[uint(i)].height = this._app['vars']['h'];
				//*/
				//
				masterContent.addChild(lista[uint(i)]);
			}
			
			// Link
			var lnkBt:CasaSprite = new CasaSprite();
			lnkBt.graphics.beginFill(0x990000,0);
			lnkBt.graphics.drawRect(0,0,_app['vars']['w'],_app['vars']['h']);
			lnkBt.graphics.endFill();
			lnkBt.buttonMode = true;
			lnkBt.useHandCursor = true;
			masterContent.addChild(lnkBt);
			lnkBt.addEventListener(MouseEvent.CLICK,goToUrl);
			
			// Bg Nav
			var navBg:MovieClip = new NavBg();
			AlignUtil.alignBottomRight(navBg,new Rectangle(0,0,_app['vars']['w'],_app['vars']['h']));
			masterContent.addChild(navBg);
			
			// Nav
			var navGroup:CasaSprite = new CasaSprite
			for( var ii:String in navi)
			{
				navi[uint(ii)].x = ((navi[uint(ii)].width + 7) * uint(ii));
				navGroup.addChild(navi[uint(ii)]);
			}
			AlignUtil.alignBottomRight(navGroup,new Rectangle(0,0,_app['vars']['w'],_app['vars']['h']));
			navGroup.x -= 15;
			navGroup.y -= 5;
			masterContent.addChild(navGroup);
			
			this.addChild(masterContent);
			
			_app['vars']['old']=null;
			_app['vars']['position']=0;
			_app['vars']['clica']=true;
			
			_app['vars']['interval'] = Interval.setInterval(repeating, _app['vars']['tempoTroca'] * 1000);
			_app['vars']['interval'].start();
			
			_dispatcher.addEventListener(_dispatcher.ON_SWAP_BANNER,this.onSwapBanner);
			_dispatcher.navSelect();
			_dispatcher.swapBanner();
		}
		
		// Abre o link
		private function goToUrl(e:MouseEvent):void
		{
			NavigateUtil.openUrl(lnk[_app['vars']['position']],NavigateUtil.WINDOW_SELF);
		}
		
		protected function repeating():void
		{
			_app['vars']['old'] = _app['vars']['position'];
			if(_app['vars']['position']==(lista.length -1))
			{
				_app['vars']['position']=0;
			}
			else
			{
				_app['vars']['position'] = _app['vars']['position'] + 1;
			}
			_dispatcher.navSelect();
			_dispatcher.swapBanner();
		}
		
		protected function onSwapBanner(e:Event):void
		{
			_app['vars']['clica']=false;
			lista[_app['vars']['position']].visible=true;
			lista[_app['vars']['position']].alpha=0;
			
			if(_app['vars']['old'] != null)
			{
				if(masterContent.getChildIndex(lista[_app['vars']['old']]) > masterContent.getChildIndex(lista[_app['vars']['position']]))
				{
					masterContent.swapChildren(lista[_app['vars']['old']],lista[_app['vars']['position']]);
				}
			}
			TweenMax.to(lista[_app['vars']['position']], 1,{alpha:1, ease:Cubic.easeInOut, onComplete:onFinishTween});
		}
		
		public function onFinishTween():void
		{
			if(_app['vars']['old'] != null)
			{
				lista[_app['vars']['old']].visible=false;
				lista[_app['vars']['old']].alpha=0;
			}
			_app['vars']['old'] = _app['vars']['position'];
			_app['vars']['clica']=true;
		}
	}
}