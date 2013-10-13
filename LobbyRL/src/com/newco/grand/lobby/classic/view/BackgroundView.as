package com.newco.grand.lobby.classic.view
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	public class BackgroundView extends Sprite
	{
		private var loader:Loader = new Loader();  
		public function BackgroundView()
		{
			super();
		}
		private function loadProgress(event:ProgressEvent):void {
			var percentLoaded:Number = event.bytesLoaded/event.bytesTotal;
			percentLoaded = Math.round(percentLoaded * 100);
			
			
			/*preloader.label.text=String(percentLoaded) +" %";
			preloader.gotoAndStop(percentLoaded);*/
			//trace("Loading: "+percentLoaded+"%");
		}   
		public function loadBackground(url:String):void {
			var request:URLRequest = new URLRequest(url);
			//loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			/*loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (evt:Event):void{
					lobbyMC.removeChild(preloader);
					var closeBtn:SMButton=new SMButton(new CloseButtonAsset());
					closeBtn.skin.x=1150;
					closeBtn.skin.y=5;
					lobbyMC.addChild(closeBtn.skin);
					closeBtn.skin.addEventListener(MouseEvent.CLICK,function (evt:MouseEvent):void{
						lobbyMC.visible=false;
					})
				});   */
			loader.load(request);
			addChild(loader);
				
			/*preloader =new MainPreloaderAsset();
			preloader.x=(contextView.view.stage.stageWidth-preloader.width) /2;
			preloader.y=(contextView.view.stage.stageHeight-preloader.height) /2;
			lobbyMC.addChild(preloader);*/
				
		}
		
	}
}