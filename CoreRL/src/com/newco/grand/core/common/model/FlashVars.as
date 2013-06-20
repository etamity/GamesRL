package com.newco.grand.core.common.model {
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;

	public dynamic class FlashVars extends Actor {
		
		public var port:int 			= 5654;
		
		// For testing Roulette
		public var server:String 		= "livecasino.smartliveaffiliates.com";		
		public var table_id:String 		= "7nyiaws9tgqrzaz3";
		public var vt_id:String 		= "";
		public var user_id:String 		= "";
		public var room:String 			= "game-7nyiaws9tgqrzaz3-rvu4z17kx9010qv2";
		public var client:String		= "generic";		
		public var lang:String 			= "en";
		
		public var site:String			= "";
		public var sessionId:String		= "";
		public var game_url:String;
		
		public var game:String         = "";
		public var gametype:String     = "";
		
		public var videoplayer:String  ="";
		public var streamUrl:String  ="";
		public var parameters:Object;
		
		public static var AIR_MODE:Boolean=false;
		public static var DEBUG_MODE:Boolean=true;
		private var root:DisplayObjectContainer;
		
		//blackjack
		/*public var server:String = "singlewallet.smartlivegaming.com";
		public var port:int = 5654;
		public var table_id:String = "l5aug44hhzr3qvxs"; // test - uwd2bl2khwcikjlz //live - l5aug44hhzr3qvxs
		public var user_id:String = "kiw3w6ltl4i05c9q";
		public var room:String = "game-l5aug44hhzr3qvxs-nl5pe00j2t6klsn5";*/		
		/*[Inject]
		public var contextView:ContextView;*/
		
		public function FlashVars(contextView:ContextView) {
			root=contextView.view;
			contextView.view.addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			parse(root.stage.loaderInfo.parameters);
			game_url = root.stage.loaderInfo.url;
		}
		private function onAddToStage(evt:Event):void{

			params=root.stage.loaderInfo.parameters;
			game_url = root.stage.loaderInfo.url;
		}
		public function set params(param:Object):void{
			parse(param);
			parameters=param;
		}
		public function get params():Object{
			return parameters;
		}
		public function get localhost():Boolean {
			var result:Boolean=false;
			if (AIR_MODE==false)
			{
				if (game_url!=null)
				if( game_url.indexOf("file:///") != -1) { 
					result= true;
				}else
					result=false;
			}else
				result=true;
			return result;
		}

		protected function onParseError(key:String, value:String, error:Error) : void {
		
		}

		protected function parse(params:Object):void {
			var types : Array = new Array("array", "boolean", "int", "number", "string", "xml");
			
			for(var key:String in params) {
				var value:String = params[key];
				var keySplit:Array = key.split("_");
				var type:String = keySplit[0].toLowerCase();
				var typeIndex:int = types.indexOf(type);
				
				if(typeIndex == -1) {
					type = "string";
				}
				else {
					key = keySplit.splice(1).join("_");
				}
				
				try {
					switch (type) {
						case "array" :
							this[key] = value.split(",");
							break;
						case "boolean" :
							this[key] = toBoolean(value);
							break;
						case "int" :
							this[key] = int(value);
							break;
						case "number" :
							this[key] = Number(value);
							break;
						case "string" :
							this[key] = value;
							break;
						case "xml" :
							this[key] = new XML(value);
							break;
					}
				}
				catch(error:Error) {
					onParseError(key, value, error);
				}
			}
		}

		protected function toBoolean(str:String):Boolean {
			str = str.toLowerCase();
			if(str == "1" || str == "true") {
				return true;
			}
			return false;
		}
		
	    public function toString():String{
			var str:String;
			for(var key:String in this) {
				str +=  key + ":" + this[key]+" ";
			}
			return str;
			
			
		}
	}
}