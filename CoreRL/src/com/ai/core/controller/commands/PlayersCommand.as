package com.ai.core.controller.commands {
	
	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.controller.signals.PlayersEvent;
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
	
	public class PlayersCommand extends BaseCommand {
		
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
			if(!service.hasLoader(Constants.SERVER_PLAYERS)) {
				service.addLoader(new XMLLoader(new URLRequest(urls.players + "?table_id=" + flashvars.table_id), Constants.SERVER_PLAYERS));
				service.getLoader(Constants.SERVER_PLAYERS).onError.add(showError);
				service.getLoader(Constants.SERVER_PLAYERS).onComplete.add(setPlayers);			
				service.start();
				debug(urls.players);
			}
		}
		
		private function setPlayers(signal:LoaderSignal, xml:XML):void {
			//debug(xml);		
			signalBus.dispatch(PlayersEvent.LOADED,{node:xml});
			service.remove(Constants.SERVER_PLAYERS);
			
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