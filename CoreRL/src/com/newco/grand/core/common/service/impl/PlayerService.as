package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class PlayerService implements IService
	{
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		public function PlayerService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			loadPlayers();
		}
		
		private function loadPlayers():void {
			/*if(!service.hasLoader(Constants.SERVER_PLAYERS)) {
				service.addLoader(new XMLLoader(new URLRequest(urls.players + "?table_id=" + flashvars.table_id), Constants.SERVER_PLAYERS));
				service.getLoader(Constants.SERVER_PLAYERS).onError.add(showError);
				service.getLoader(Constants.SERVER_PLAYERS).onComplete.add(setPlayers);			
				service.start();

			}*/
			debug(urls.players);
			service.loadURL(urls.players,setPlayers,showError);
		}
		
		private function setPlayers(signal:LoaderSignal, xml:XML):void {
			//debug(xml);		
			signalBus.dispatch(PlayersEvent.LOADED,{node:xml});
			//service.remove(Constants.SERVER_PLAYERS);
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}