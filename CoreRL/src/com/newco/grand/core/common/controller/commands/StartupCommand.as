package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.ConfigService;
	import com.newco.grand.core.common.service.impl.URLSService;
	import com.newco.grand.core.utils.GameUtils;
	import com.smart.uicore.controls.managers.SkinLoader;
	
	import flash.events.IOErrorEvent;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	
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
		[Inject]
		public var contextView:ContextView;
		override public function execute():void {	
			switch (FlashVars.PLATFORM){
				case FlashVars.DESKTOP_PLATFORM:
				case FlashVars.WEB_PLATFORM:
					GameUtils.generateMask(contextView.view,"StageMask");
					break;
				case FlashVars.AIR_PLATFORM:
					GameUtils.generateMask(contextView.view,"StageMask",640,960);
					break;	
			}

			
			if (FlashVars.SKIN_ENABLE==true)
				if (flashVars.localhost==true )
				SkinLoader.loadSkinFile("cgibin/appconfig/skins/skin.swf",onStart,onError,null,null);
				else
				SkinLoader.loadSkinFile("/cgibin/appconfig/skins/skin.swf",onStart,onError,null,null);	
			else
				onStart();
		}
		private function onStart():void{
			
		
			if(FlashVars.PLATFORM==FlashVars.DESKTOP_PLATFORM
				//|| ((FlashVars.GAMECLIENT=Constants.LOBBY) && (FlashVars.PLATFORM==FlashVars.AIR_PLATFORM))
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
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
		private function onError(evt:IOErrorEvent):void{
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:evt.text});
		}
	}
}