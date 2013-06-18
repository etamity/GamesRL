package com.ai.core.common.controller.commands {
	
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.VideoEvent;
	import com.ai.core.common.model.FlashVars;
	import com.ai.core.common.model.IGameData;
	import com.ai.core.service.VideoService;
	import com.ai.core.utils.GameUtils;
	
	public class VideoConnectionCommand extends BaseCommand {
		[Inject]
		public var game:IGameData;
		[Inject]
		public var videoService:VideoService;
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signal:BaseSignal;
		
		override public function execute():void {
			switch (signal.type)	{				
				case VideoEvent.CONNECT: 
					
					if (flashvars.streamUrl!="")
					{
						var streamUrl:String= flashvars.streamUrl;
						if (streamUrl !=""){
							var params:Array = String(streamUrl).split("//");
							params.shift();
							
							var paramStr:String= params[0];
							params=paramStr.split("/");
							var sever:String = params[0];
							var application:String= params[1];
							var videoName:String= params[2];
							game.server=sever;
							game.videoStream=videoName;
							game.videoApplication = application;
	
						}
					}else{
						videoService.servers = String(game.videoSettings.videoservers).split(",");
						game.videoApplication = game.videoSettings.application;
					}
					
					/*if (game.server !="")
						videoService.servers=new Array(game.server);*/
					if (game.videoStream !="")
						videoService.streams= new Array(game.videoStream);
					if (game.videoApplication !="")
						videoService.application=game.videoApplication;
					
					
					debug("[game.videoStream]:"+game.videoStream);
					videoService.settings=game.videoSettings;
					
					videoService.init();
					break;
				
				case VideoEvent.PLAY:
					//dispatch(new VideoEvent(SocketDataEvent.DATA_LOADED, node));
					break;
			}
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}