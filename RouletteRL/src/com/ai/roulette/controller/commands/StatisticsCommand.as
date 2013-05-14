package com.ai.roulette.controller.commands {
	
	import com.ai.core.controller.commands.BaseCommand;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.controller.signals.StatisticsEvent;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class StatisticsCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		override public function execute():void {
			loadStatistics();			
		}
		
		private function loadStatistics():void {
			if(!service.hasLoader(Constants.SERVER_STATISTICS)) {
				debug(urls.statistics + "?count=100&table_id=" + flashvars.table_id);
				service.addLoader(new XMLLoader(new URLRequest(urls.statistics + "?count=100&table_id=" + flashvars.table_id), Constants.SERVER_STATISTICS));
				service.getLoader(Constants.SERVER_STATISTICS).onError.add(showError);
				service.getLoader(Constants.SERVER_STATISTICS).onComplete.add(setStatistics);			
				service.start();
			}
		}
		
		private function setStatistics(signal:LoaderSignal, xml:XML):void {
			//debug(xml);			
			service.remove(Constants.SERVER_STATISTICS);
			//eventDispatcher.dispatchEvent(new StatisticsEvent(StatisticsEvent.LOADED, xml));
			signalBus.dispatch(StatisticsEvent.LOADED,{node:xml});
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}