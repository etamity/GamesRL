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
				SkinLoader.loadSkinFile("skins/skin.swf",onStart,onError,null,null);
			else
				onStart();
		}
		private function onStart():void{
			signalBus.dispatch(UIEvent.SETUP_VIEWS);
			var localhost:String=(flashVars.localhost==true)?"localhost:true":"localhost=false";
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:localhost+": tableid: "+
				flashVars.table_id + " server:"+flashVars.server});
			if(flashVars.localhost) {
				configService.load(function ():void{
					urlsService.load(function ():void{
						signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);
					});
				});
				
			}
			else{
				urlsService.load(function ():void{
					signalBus.dispatch(SignalConstants.STARTUP_COMPLETE);	
				});
			}
			
		}
		private function onError(evt:IOErrorEvent):void{
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:evt.text});
		}
	}
}