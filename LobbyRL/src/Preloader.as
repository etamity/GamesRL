package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	
	
	[SWF(width = "1186", height = "667", frameRate = "30", backgroundColor = "#4C4C4C" ,wmode="direct")]
	public class Preloader extends Sprite
	{
		private var gameSWF:String="LobbyRL.swf";
		
		private var gamePath:String="/player/games/";
		private var loader:Loader = new Loader(); 
		private var preloader:MainPreloaderAsset=new MainPreloaderAsset();
		
		private var gameAuthenicationApiPath:String="/cgibin/remoteUserCreation.jsp";
		
		private var user_id:String;
		private var server:String;
		private var clientkey:String;
		public function Preloader()
		{

			//preloader.versionTxt.text="VERSION 2.0";
			//if (loaderInfo.parameters.gameFile!=null)
			//gameSWF= gameSWF+ loaderInfo.parameters.gameFile;
			
			Security.allowDomain("*");
			preloader.stop();
			addEventListener(Event.ADDED_TO_STAGE,onAddtoStage);

		}
		
		private function onAddtoStage(evt:Event):void{

			/*if (loaderInfo.parameters.mid!=null)
				user_id=loaderInfo.parameters.mid;
			if (loaderInfo.parameters.server!=null)
				server=loaderInfo.parameters.server;
			if (loaderInfo.parameters.clientkey!=null)
				clientkey=loaderInfo.parameters.clientkey;
			
			gameAuthenicationApiPath=server+gameAuthenicationApiPath+"?mid="+user_id+"&bk="+String(Math.random()*99999999);
			var request:URLRequest = new URLRequest(gameAuthenicationApiPath);
			var urlLoader:URLLoader = new URLLoader();
			
			urlLoader.addEventListener(Event.COMPLETE, loadCompleteAuthenicationApiPath);
			urlLoader.load(request);*/
			if (loaderInfo.parameters.gameSWF!=null)
				gameSWF=loaderInfo.parameters.gameSWF;	
			
			afterLogin(null);
		}
		public function get localhost():Boolean {
			var result:Boolean=false;
			if (stage.loaderInfo.url!=null)
				if( stage.loaderInfo.url.indexOf("file:///") != -1) { 
					result= true;
				}else
					result=false;
			return result;
		}
		private function afterLogin(evt:Event):void{
			var params:String=getParams();
			var fullUrl:String=(localhost==true)?gameSWF+"?"+params:gamePath+gameSWF+"?"+params;
			var request:URLRequest = new URLRequest(fullUrl);
			trace("fullUrl:",fullUrl);
			//loader.loaderInfo.applicationDomain=new ApplicationDomain();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);   
			preloader.x=(stage.stageWidth -preloader.width) / 2;
			preloader.y=(stage.stageHeight -preloader.height) / 2;
	

			loader.load(request);
			
			
			
			addChild(loader);
			addChild(preloader);
	
		}
		private function loadCompleteAuthenicationApiPath(event:Event):void{
			var xmlData:XML=new XML(event.target.data);
			gameSWF=server+xmlData.flashurl+"?server="+server+"&user_id="+user_id+"&bk="+String(Math.random()*99999999);
			trace(xmlData);
			afterLogin(null);
		}
		private function loadProgress(event:ProgressEvent):void {
			var percentLoaded:Number = event.bytesLoaded/event.bytesTotal;
			percentLoaded = Math.round(percentLoaded * 100);
			preloader.label.text=String(percentLoaded) +" %";
			preloader.gotoAndStop(percentLoaded);
			//trace("Loading: "+percentLoaded+"%");
		}   
		
		private function getParams():String{
			var param:String="";
			for(var key:String in stage.loaderInfo.parameters) {
				var value:String = stage.loaderInfo.parameters[key];
				if (key !="null" && value !="null")
				param=param+ key + "=" + value + "&";
			}
			
			return param;//+"&bk="+String(new Date().toTimeString());
		}
		
		
		private function loadComplete(event:Event):void {
			trace("Complete");
			preloader.visible=false;
			
			var params:Object={};
			params.user_id=user_id;
			//loader.init(params);
			
		}   
		
		
	}
}