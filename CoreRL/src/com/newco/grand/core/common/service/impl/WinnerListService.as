package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.WinnersEvent;
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
	
	public class WinnerListService implements IService
	{
		
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		public function WinnerListService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			loadPlayers();
		}
		
		private function loadPlayers():void {
		/*	if(!service.hasLoader(Constants.SERVER_WINNERS)) {
				service.addLoader(new XMLLoader(new URLRequest(urls.winners + "?mode=top"), Constants.SERVER_WINNERS));
				service.getLoader(Constants.SERVER_WINNERS).onError.add(showError);
				service.getLoader(Constants.SERVER_WINNERS).onComplete.add(setPlayers);			
				service.start();
				debug(urls.winners);
			}*/
			debug(urls.winners);
			service.loadURL(urls.winners,setPlayers,showError);
		}
		
		private function setPlayers(signal:LoaderSignal, xml:XML):void {
			//debug(xml);			
			//service.remove(Constants.SERVER_WINNERS);
			signalBus.dispatch(WinnersEvent.LOADED,{node:xml});
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
			signalBus.dispatch(MessageEvent.SHOWERROR,{error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}