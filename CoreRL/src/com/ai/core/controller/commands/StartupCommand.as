package com.ai.core.controller.commands {
	
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.SignalConstants;
	import com.ai.core.model.URLSModel;
	import com.ai.core.service.ConfigService;
	import com.ai.core.service.URLSService;
	import com.smart.uicore.controls.managers.SkinLoader;
	
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
						SkinLoader.loadSkinFile("skins/skin.swf",start,null,null);
					});
				});
			
			}
			else{
				urlsService.loadConfig(function ():void{
					SkinLoader.loadSkinFile(urls.skin,start,null,null);
				});

	
			}
		}
		private function start():void{
			signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);
		}
	}
}