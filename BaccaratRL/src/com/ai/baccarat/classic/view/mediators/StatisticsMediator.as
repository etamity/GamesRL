package com.ai.baccarat.classic.view.mediators
{
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.ModelReadyEvent;
	import com.ai.core.common.model.SignalBus;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StatisticsMediator extends Mediator
	{
		[Inject]
		public var signalBus:SignalBus;
		public function StatisticsMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
		}
		private function setupModel(signal:BaseSignal):void {

		}
	}
}