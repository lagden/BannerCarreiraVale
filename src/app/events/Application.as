package app.events
{
	public class Application{
		
		private static var _instance:Application;
		private static var _allowInstance:Boolean;
		public var vars:Object;
		
		public static function getInstance():Application
		{
			if (Application._instance == null){
				Application._allowInstance = true;
				Application._instance = new Application();
				Application._allowInstance = false;
			}
			return Application._instance;
		}
		
		public function Application()
		{
			if (!Application._allowInstance)
			{
				throw new Error("Error: Use Application.getInstance() instead of the new keyword.");
			}
		}
	}
}