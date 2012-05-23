package lagden.ui
{
	import app.events.Application;
	import app.events.Dispatcher;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import lagden.utils.TxtBox;
	
	import org.casalib.display.CasaSprite;
	import org.casalib.util.AlignUtil;
	
	public class Nav extends CasaSprite
	{
		protected var _app:Application;
		protected var _dispatcher:Dispatcher;
		
		private var _ativo:Boolean;
		private var _txt:TxtBox;
		private var _box:CasaSprite;
		public var _pos:Number;
		
		public function Nav(dis:Dispatcher,obj:Object)
		{
			TweenPlugin.activate([TintPlugin, ColorTransformPlugin]);
			
			var padding:uint = 3;
			
			this._app = Application.getInstance();
			this._dispatcher = dis;
			this._ativo=false;
			this._pos = obj['pos'];
			
			_txt = new TxtBox(obj['txt'],"left",_app['vars']['branco'],_app['vars']['fontSize'],_app['vars']['font']);
			
			_box = new CasaSprite();
			_box.graphics.beginFill(0xFFFFFF,0);
			_box.graphics.drawRect(0,0,_txt.width + padding, _txt.height  + padding);
			_box.graphics.endFill();
			_box.alpha = 0;
			
			AlignUtil.alignMiddleCenter(_txt,new Rectangle(0,0,_box.width,_box.height));
			
			addChild(_box);
			addChild(_txt);
			
			var overlay:CasaSprite = new CasaSprite();
			overlay.graphics.beginFill(0x990000,0);
			overlay.graphics.drawRect(0,0,_box.width,_box.height);
			overlay.graphics.endFill();
			overlay.buttonMode = true;
			overlay.mouseEnabled = true;
			addChild(overlay);
			
			this.addEventListener(MouseEvent.MOUSE_OVER,handle);
			this.addEventListener(MouseEvent.MOUSE_OUT,handle);
			this.addEventListener(MouseEvent.CLICK,clica);
			
			_dispatcher.addEventListener(_dispatcher.ON_SELECTED,selecionado);
		}
		
		private function clica(e:MouseEvent):void{
			if(_app['vars']['clica'])
			{
				_app['vars']['interval'].reset();
				_app['vars']['interval'].start();
				//
				_app['vars']['position'] = _pos;
				_dispatcher.navSelect();
				_dispatcher.swapBanner();
			}
		}
		
		public function handle(e:MouseEvent):void
		{
			if(!this._ativo)
			{
				var t:Number = (e.type == MouseEvent.MOUSE_OUT)? 0 : 1;
				this.fx(t);
			}
		}
		
		private function selecionado(e:Event):void
		{
			if(_app['vars']['position'] == this._pos)
			{
				this.fx(1);
				this._ativo=true;
			}
			else
			{
				this.fx(0);
				this._ativo=false;
			}
		}
		
		private function fx(t:Number):void{
			var boxAlpha:Number = (t == 1) ? 1 : 0;
			_box.alpha = boxAlpha;
			TweenMax.to(_txt,.2,{colorTransform:{tint:_app['vars']['laranja'],tintAmount:t}});
		}
		
	}
}