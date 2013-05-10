package com.ai.core.controller.commands {
	
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.SignalConstants;
	import com.ai.core.service.ConfigService;
	import com.ai.core.service.URLSService;
	
	public class StartupCommand extends BaseCommand {
		
		[Inject]
		public var urlsService:URLSService;
		[Inject]
		public var configService:ConfigService;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		override public function execute():void {	
			if(flashVars.localhost) {
				configService.loadConfig(function ():void{
					urlsService.loadConfig(function ():void{
						signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);
					});
				});
				
			}
			else
			signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);
		}
	}
}