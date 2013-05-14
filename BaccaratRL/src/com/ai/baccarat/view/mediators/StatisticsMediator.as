package com.ai.baccarat.view.mediators
{
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.model.SignalBus;
	
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