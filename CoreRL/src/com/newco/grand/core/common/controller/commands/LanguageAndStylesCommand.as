package com.newco.grand.core.common.controller.commands
{
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.service.impl.LanguageService;
	import com.newco.grand.core.common.service.impl.StyleService;
	import com.newco.grand.core.utils.GameUtils;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class LanguageAndStylesCommand extends Command
	{
		[Inject]
		public var langService:LanguageService;
		[Inject]
		public var styleService:StyleService;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		public function LanguageAndStylesCommand()
		{
			super();
		}
		override public function execute():void {
			langService.load();
			styleService.load(function ():void{
				signalBus.dispatch(LanguageAndStylesEvent.LOADED);
				debug("flashVars.user_id",flashVars.user_id);
				if (flashVars.user_id!="" || FlashVars.PLATFORM==FlashVars.WEB_PLATFORM)
				{

					signalBus.dispatch(LoginEvent.LOGIN_SUCCESS);
					signalBus.dispatch(StartupDataEvent.SEAT);
					signalBus.dispatch(StartupDataEvent.LOAD);
				}
				 else if(flashVars.localhost==true  || FlashVars.PLATFORM==FlashVars.AIR_PLATFORM 
					 || FlashVars.PLATFORM==FlashVars.DESKTOP_PLATFORM
					 || FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM) {
					 signalBus.dispatch(LoginEvent.INITIALIZE);
				 }
	
			});
			
		
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}