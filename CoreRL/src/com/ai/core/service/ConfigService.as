package com.ai.core.service
{
	import com.ai.core.model.Actor;
	import com.ai.core.model.FlashVars;
	import com.ai.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class ConfigService extends Actor
	{
		private var _xmlurl:String="xml/configs.xml";
		
		private const CONFIGXML:String= "CONFIGXML";
		
		[Inject]
		public var service:IAssetLoader;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var videoService:VideoService;
		
		private var _onComplete:Function;
		public function ConfigService()
		{
			super();

		}
		private function setConfig(signal:LoaderSignal, xml:XML):void {
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
			service.remove(CONFIGXML);
			if (_onComplete!=null)
				_onComplete();
		}
		
		public function loadConfig(onComplete:Function):void{
			debug("loading Config  " + _xmlurl);
			_onComplete=onComplete;
			service.addLoader(new XMLLoader(new URLRequest(_xmlurl), CONFIGXML));
			service.getLoader(CONFIGXML).onError.add(showError);
			service.getLoader(CONFIGXML).onComplete.add(setConfig);			
			service.start();
		}
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}