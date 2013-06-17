package com.ai.core.controller.commands {
	
	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.SignalConstants;
	import com.ai.core.model.URLSModel;
	import com.ai.core.service.ConfigService;
	import com.ai.core.service.URLSService;
	import com.smart.uicore.controls.managers.SkinLoader;
	
	import flash.events.IOErrorEvent;
	
	public class StartupCommand extends BaseCommand {
		
		[Inject]
		public var urlsService:URLSService;
		[Inject]
		public var configService:ConfigService;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var urls:URLSModel;
		
		override public function execute():void {	
			if(flashVars.localhost) {
				configService.loadConfig(function ():void{
					urlsService.loadConfig(function ():void{
						SkinLoader.loadSkinFile("skins/skin.swf",onStart,onError,null,null);
					});
				});
			
			}
			else{
				urlsService.loadConfig(function ():void{
					SkinLoader.loadSkinFile(urls.skin,onStart,null,null);
				});

	
			}
		}
		private function onStart():void{
			signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);
		}
		private function onError(evt:IOErrorEvent):void{
			signalBus.dispatch(MessageEvent.ERROR,{error:evt.text});
		}
	}
}