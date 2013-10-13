package com.newco.grand.baccarat.classic.service
{
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.model.GameDataModel;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.utils.GameUtils;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class StatsSummaryService
	{
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function StatsSummaryService()
		{

		}
		public function load(onComplete:Function=null):void
		{
			service.loadURL(urls.statsSummary,setStatsSummary,showError);
		}
		
		private function setStatsSummary(signal:LoaderSignal, xml:XML):void {
			signalBus.dispatch(StatisticsEvent.SUMMARYLOADED,{xml:xml});
		}
		private function showError(signal:ErrorSignal):void {
			debug("Error:" +signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}