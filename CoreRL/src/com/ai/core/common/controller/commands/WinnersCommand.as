package com.ai.core.common.controller.commands {
	
	import com.ai.core.common.controller.signals.MessageEvent;
	import com.ai.core.common.controller.signals.WinnersEvent;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class WinnersCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
	
		
		[Inject]
		public var flashvars:FlashVars;

		[Inject]
		public var signalBus:SignalBus;
		
		override public function execute():void {
			loadPlayers();			
		}
		
		private function loadPlayers():void {
			if(!service.hasLoader(Constants.SERVER_WINNERS)) {
				service.addLoader(new XMLLoader(new URLRequest(urls.winners + "?mode=top"), Constants.SERVER_WINNERS));
				service.getLoader(Constants.SERVER_WINNERS).onError.add(showError);
				service.getLoader(Constants.SERVER_WINNERS).onComplete.add(setPlayers);			
				service.start();
				debug(urls.winners);
			}
		}
		
		private function setPlayers(signal:LoaderSignal, xml:XML):void {
			//debug(xml);			
			service.remove(Constants.SERVER_WINNERS);
			signalBus.dispatch(WinnersEvent.LOADED,{node:xml});
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
			signalBus.dispatch(MessageEvent.ERROR,{error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}