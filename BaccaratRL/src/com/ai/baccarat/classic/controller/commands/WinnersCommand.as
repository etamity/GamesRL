package com.ai.baccarat.classic.controller.commands {
	
	import com.ai.baccarat.classic.controller.signals.WinnersEvent;
	import com.ai.baccarat.classic.model.GameDataModel;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class WinnersCommand extends Command {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		override public function execute():void {
			loadPlayers();			
		}
		
		private function loadPlayers():void {
			if(!service.hasLoader(Constants.SERVER_WINNERS)) {
				//service.addLoader(new XMLLoader(new URLRequest(urls.winners + "?mode=top"), Constants.SERVER_WINNERS));
				service.getLoader(Constants.SERVER_WINNERS).onError.add(showError);
				service.getLoader(Constants.SERVER_WINNERS).onComplete.add(setPlayers);			
				service.start();
				//debug(urls.winners);
			}
		}
		
		private function setPlayers(signal:LoaderSignal, xml:XML):void {
			//debug(xml);			
			service.remove(Constants.SERVER_WINNERS);
			//eventDispatcher.dispatchEvent(new WinnersEvent(WinnersEvent.LOADED, xml));
			
			signalBus.dispatch(WinnersEvent.LOADED,{xml:xml});
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}