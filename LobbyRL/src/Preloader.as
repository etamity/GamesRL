package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	
	[SWF(width = "990", height = "610", frameRate = "24", backgroundColor = "#4C4C4C")]
	public class Preloader extends Sprite
	{
		private var gameSWF:String="/player/games/";
		private var loader:Loader = new Loader(); 
		private var mainMc:MovieClip=new MovieClip();
		//private var preloader:FBPreLoaderAsset=new FBPreLoaderAsset();
		
		private var gameAuthenicationApiPath:String="/cgibin/remoteUserCreation.jsp";
		
		private var user_id:String;
		private var server:String;
		private var clientkey:String;
		public function Preloader()
		{

			//preloader.versionTxt.text="VERSION 2.0";
			//if (loaderInfo.parameters.gameFile!=null)
			//gameSWF= gameSWF+ loaderInfo.parameters.gameFile;
			
			
		
			addEventListener(Event.ADDED_TO_STAGE,onAddtoStage);

		}
		
		private function onAddtoStage(evt:Event):void{

			if (loaderInfo.parameters.mid!=null)
				user_id=loaderInfo.parameters.mid;
			if (loaderInfo.parameters.server!=null)
				server=loaderInfo.parameters.server;
			if (loaderInfo.parameters.clientkey!=null)
				clientkey=loaderInfo.parameters.clientkey;
			
			gameAuthenicationApiPath=server+gameAuthenicationApiPath+"?mid="+user_id+"&bk="+String(Math.random()*99999999);
			var request:URLRequest = new URLRequest(gameAuthenicationApiPath);
			var urlLoader:URLLoader = new URLLoader();
			
			urlLoader.addEventListener(Event.COMPLETE, loadCompleteAuthenicationApiPath);
			urlLoader.load(request);
			
		}

		private function afterLogin(evt:Event):void{
			var request:URLRequest = new URLRequest(gameSWF);
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);   
			
			//addChild(preloader);
			addChild(mainMc);
			loader.load(request);
			
			
			
			mainMc.addChild(loader);
	
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
			//preloader.progressBar.percentageTxt.text=String(percentLoaded) +" %";
			//preloader.progressBar.progress.gotoAndStop(percentLoaded);
			//trace("Loading: "+percentLoaded+"%");
		}   
		
		private function loadComplete(event:Event):void {
			trace("Complete");
			//preloader.visible=false;
			
			var params:Object={};
			params.user_id=user_id;
			//loader.init(params);
			
		}   
		
		
	}
}