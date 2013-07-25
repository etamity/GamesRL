package FBTools
{
	import com.slc.utilities.WebUtils;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	public class Preloader extends Sprite
	{
		private var gameSWF:String="/player/games/";
		private var loader:Loader = new Loader(); 
		private var mainMc:MovieClip=new MovieClip();
		private var preloader:FBPreLoaderAsset=new FBPreLoaderAsset();
		
		private var user_id:String="";
		public function Preloader()
		{

			preloader.versionTxt.text="VERSION 2.0";
			if (loaderInfo.parameters.gameFile!=null)
			gameSWF= gameSWF+ loaderInfo.parameters.gameFile;
	
			
			afterLogin(null);

		}

		private function afterLogin(evt:Event):void{
			var request:URLRequest = new URLRequest(gameSWF);
			
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);   
			
			addChild(preloader);
			addChild(mainMc);
			loader.load(request);
			
			
			
			mainMc.addChild(loader);
	
		}
		
		private function loadProgress(event:ProgressEvent):void {
			var percentLoaded:Number = event.bytesLoaded/event.bytesTotal;
			percentLoaded = Math.round(percentLoaded * 100);
			preloader.progressBar.percentageTxt.text=String(percentLoaded) +" %";
			preloader.progressBar.progress.gotoAndStop(percentLoaded);
			//trace("Loading: "+percentLoaded+"%");
		}   
		
		private function loadComplete(event:Event):void {
			trace("Complete");
			preloader.visible=false;
			
			var params:Object=loaderInfo.parameters;
			params.user_id=user_id;
		}   
		
		
	}
}