package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.view.interfaces.IStatisticsView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.SignalBus;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StatisticsMediator extends Mediator
	{
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var view:IStatisticsView;
		public function StatisticsMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
	
		}
		private function updateLanguage(signal:BaseSignal):void{
			view.updateLanguage();
		}
		private function setupModel(signal:BaseSignal):void {
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
			view.init();
		}

	}
}