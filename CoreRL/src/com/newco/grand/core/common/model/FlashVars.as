package com.newco.grand.core.common.model {
	import com.demonsters.debugger.MonsterDebugger;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;


	public dynamic class FlashVars extends Actor {
		
		public var port:int 			= 5654;
		
		// For testing Roulette
		public var server:String 		= "http://live.extremelivegaming.com/";	
		public var socketServer:String	= "live.extremelivegaming.com";		
		public var table_id:String 		= "7nyiaws9tgqrzaz3";
		public var vt_id:String 		= "";
		public var user_id:String 		= "";
		public var room:String 			= "game-o3d9tx3u8kd0yawc-i6t6y1jcdxih0wex";
		public var client:String		= "xlc";		
		public var lang:String 			= "en";
		
		public var site:String			= "";
		public var sessionId:String		= "";
		public var game_url:String;
		
		public var game:String         = "";
		public var gametype:String     = "classic";
		
		public var videoplayer:String  ="";
		public var streamUrl:String  ="";
		public var parameters:Object;
		private var _urls:String = "cgibin/appconfig/xml/configs/urls.xml";
		public static var SKIN_ENABLE:Boolean=false;
		public static var DEBUG_MODE:Boolean=true;
		
		
		public static const AIR_PLATFORM:String="AIR";
		public static const WEB_PLATFORM:String="WEB";
		public static const DESKTOP_PLATFORM:String="DESKTOP";
		public static const TESTING_PLATFORM:String="TESTING";
		
		
		public static var PLATFORM:String="";
		public static var GAMECLIENT:String="baccarat";
		
		
		
		private var root:DisplayObjectContainer;
		
		public var debugIP:String=	"";	
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
			parse(root.loaderInfo.parameters);
			parameters=root.loaderInfo.parameters;
			game_url = root.loaderInfo.url;
			if(FlashVars.PLATFORM==""){
				if (localhost==true)
				FlashVars.PLATFORM=FlashVars.DESKTOP_PLATFORM;
				else
				FlashVars.PLATFORM = FlashVars.WEB_PLATFORM;
			}
			debug("PLATFORM:",FlashVars.PLATFORM);
		}
		
		public function get urls():String{
			return server+_urls;
		}
		public function set urls(val:String):void{
			_urls=val;
		}
		private function onAddToStage(evt:Event):void{
			params=root.loaderInfo.parameters;
			game_url = root.loaderInfo.url;
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
				if (game_url!=null)
				if( game_url.indexOf("file:///") != -1) { 
					result= true;
				}else
					result=false;
			return result;
		}

		protected function onParseError(key:String, value:String, error:Error) : void {
			GameUtils.log(FlashVars, key,value,error);
		}

		public function parseXML(xml:XML):void{
			var obj:Object=new Object();
			var value:String;
			for each(var node:XML in xml.attributes()) {
				if (obj[node.localName()]=="" || obj[node.localName()]==null)
				obj[node.localName()]=String(node);
			}	
			parse(obj);
		}

		
		protected function parse(params:Object):void {
			if (params.debugIP!=null && params.debugIP!="")
			MonsterDebugger.initialize(root,params.debugIP);
				
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
				debug("Key:"+key,"vaule:"+this[key]);
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
		private function debug(...args):void {
			GameUtils.log(FlashVars, args);
		}
	}
}