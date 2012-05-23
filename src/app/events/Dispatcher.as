package app.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class Dispatcher extends EventDispatcher
	{
		public const ON_SELECTED:String = "onSelect";
		public const ON_SWAP:String = "onSwap";
		public const ON_SWAP_BANNER:String = "onSwapBanner";
		
		public function Dispatcher()
		{
			// CONSTRUCTOR
		}
		
		protected function dispacha(event:String):void
		{
			dispatchEvent(new Event(event));
		}
		
		public function swapBanner():void{dispacha(ON_SWAP_BANNER);}
		public function navSelect():void{dispacha(ON_SELECTED);}
		public function swap():void{dispacha(ON_SWAP);}
	}
}