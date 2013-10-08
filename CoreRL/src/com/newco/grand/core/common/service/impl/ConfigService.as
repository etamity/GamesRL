package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class ConfigService implements IService
	{
		[Inject]
		public var urls:URLSModel;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var service:XMLService;
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var signalBus:SignalBus;
		
		private var _onComplete:Function;
		public function ConfigService()
		{
			super();

		}
		private function setConfig(signal:LoaderSignal,xml:XML):void {
			debug("Config:",xml);
			var casino:XMLList=xml.casino.(@game==FlashVars.GAMECLIENT.toLowerCase());
			debug("game:",FlashVars.GAMECLIENT.toLowerCase(),casino.toXMLString());
			/*var parameters:Object ={};
			parameters.server=casino.@server;
			parameters.game = casino.@game;
			parameters.client=casino.@client;
			parameters.table_id=casino.@tableid;
			parameters.vt_id=casino.@vtid;
			parameters.lang=casino.@lang;
			parameters.room=casino.@room;
			parameters.user_id=casino.@userid;
			parameters.gametype=casino.@gametype;
			parameters.videoplayer=casino.@videoplayer;
			parameters.socketServer=casino.@socketServer;
			parameters.debugIP=casino.@debugIP;
			parameters.urls=casino.@urls;
			parameters.streamUrl =casino.@streamUrl;
			flashVars.params= parameters;*/
			flashVars.parseXML(new XML(casino.toXMLString()));
			urls.server=flashVars.server;
			debug("flashvars.server:",flashVars.server);
			debug("flashvars.streamUrl:",flashVars.streamUrl);
			debug("flashvars.localhost:  " + flashVars.localhost);
			debug("flashvars.game_url:  " + flashVars.game_url);
			
			
			if (_onComplete!=null)
				_onComplete();
		}
		
		public function load(onComplete:Function=null):void{
			debug("loading Config  " + urls.flashVarsConfig);
			_onComplete=onComplete;
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:urls.flashVarsConfig+"::"+flashVars.game_url});
			service.loadURL(urls.flashVarsConfig,setConfig,showError);
		}
		private function showError(signal:ErrorSignal):void {
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message + " : " + signal.type});
			debug("error " + signal.message);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}