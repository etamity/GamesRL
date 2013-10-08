package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.ConfigService;
	import com.newco.grand.core.common.service.impl.URLSService;
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
			
			
			if (FlashVars.SKIN_ENABLE==true)
				if (flashVars.localhost==true )
				SkinLoader.loadSkinFile("cgibin/appconfig/skins/skin.swf",onStart,onError,null,null);
				else
				SkinLoader.loadSkinFile("/cgibin/appconfig/skins/skin.swf",onStart,onError,null,null);	
			else
				onStart();
		}
		private function onStart():void{
			if(flashVars.localhost==true 
				|| FlashVars.PLATFORM==FlashVars.AIR_PLATFORM 
				|| FlashVars.PLATFORM==FlashVars.DESKTOP_PLATFORM
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM) {
				configService.load(function ():void{
					urlsService.load(function ():void{
						signalBus.dispatch(UIEvent.SETUP_VIEWS);
						signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);
					});
				});
				
			}
			else{
				urlsService.load(function ():void{
					signalBus.dispatch(UIEvent.SETUP_VIEWS);
					signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);	
				});
			}
			
		}
		private function onError(evt:IOErrorEvent):void{
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:evt.text});
		}
	}
}