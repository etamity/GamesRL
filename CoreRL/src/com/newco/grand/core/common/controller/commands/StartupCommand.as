package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.ConfigService;
	import com.newco.grand.core.common.service.URLSService;
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
						if (FlashVars.AIR_MODE==false)
						SkinLoader.loadSkinFile("skins/skin.swf",onStart,onError,null,null);
						else
						signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);	
					});
				});
				
			}
			else{
				urlsService.loadConfig(function ():void{
					if (FlashVars.AIR_MODE==false)
					SkinLoader.loadSkinFile(urls.skin,onStart,onError,null,null);
					else
					signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);	
				});
			}

		}
		private function onStart():void{
			signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);
		}
		private function onError(evt:IOErrorEvent):void{
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:evt.text});
		}
	}
}