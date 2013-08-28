package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.service.VideoService;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
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
					var streamUrl:String= flashvars.streamUrl;
					var lowerCaseStreamUr:String= streamUrl.toLowerCase();
					
					if (streamUrl!="" && streamUrl.search("rtmp://")!=-1)
					{
						
						if (streamUrl !=""){
							var params:Array = String(streamUrl).split("//");
							params.shift();
							
							var paramStr:String= params[0];
							params=paramStr.split("/");
							var sever:String = params[0];
							var videoName:String= params[params.length-1];
							var application:String= String(streamUrl).replace("rtmp://"+sever+"/","");
							application=application.replace("/"+videoName,"");
				
							
							game.server=sever;
							game.videoStream=videoName;
							game.videoApplication = application;
	
						}
					}
					
					if (streamUrl!="" && (lowerCaseStreamUr.search(".mp4")!=-1 || lowerCaseStreamUr.search(".flv")!=-1))
						{
						   game.server="";
						   game.videoStream=lowerCaseStreamUr;
						   game.videoStreams=new Array(lowerCaseStreamUr);
						   game.videoApplication="";
						}
						else
						{
							videoService.servers = String(game.videoSettings.videoservers).split(",");
							game.server=videoService.servers[0];
							if (game.videoSettings.application.@withGameName=="false")
								game.videoApplication = game.videoSettings.application;
							else
								game.videoApplication = StringUtils.trim(game.videoSettings.application+"/"+FlashVars.GAMECLIENT.toLowerCase());
						}
					
					/*if (game.server !="")
						videoService.servers=new Array(game.server);*/
					if (game.videoStreams !=null)
						videoService.streams= game.videoStreams;
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