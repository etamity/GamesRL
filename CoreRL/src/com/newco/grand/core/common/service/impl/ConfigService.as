package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class ConfigService
	{
		private var _xmlurl:String="xml/configs.xml";
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var signalBus:SignalBus;
		
		private var _onComplete:Function;
		public function ConfigService()
		{
			super();

		}
		private function setConfig(signal:LoaderSignal,xml:XML):void {
			debug(xml);
			var parameters:Object ={};
			parameters.server=xml.casino.@server;
			parameters.game = xml.casino.@game;
			parameters.client=xml.casino.@client;
			parameters.table_id=xml.casino.@tableid;
			parameters.vt_id=xml.casino.@vtid;
			parameters.lang=xml.casino.@lang;
			parameters.room=xml.casino.@room;
			parameters.user_id=xml.casino.@userid;
			parameters.gametype=xml.casino.@gametype;
			parameters.videoplayer=xml.casino.@videoplayer;
			var streamUrl:String=xml.casino.@streamUrl;
			parameters.streamUrl =streamUrl;
			flashVars.params= parameters;
			
			debug("[flashvars.streamUrl]",flashVars.streamUrl);

			
			if (_onComplete!=null)
				_onComplete();
		}
		
		public function load(onComplete:Function=null):void{
			debug("loading Config  " + _xmlurl);
			_onComplete=onComplete;
			service.loadURL(_xmlurl,setConfig);
		}
		private function showError(signal:ErrorSignal):void {
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
			debug("error " + signal.message);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}