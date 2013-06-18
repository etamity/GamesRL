package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.view.ScoreCardView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ScoreCardMediator extends Mediator
	{
		[Inject]
		public var view:ScoreCardView;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function ScoreCardMediator()
		{
			super();
		}
		override public function initialize():void {
		
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(BaccaratEvent.SCORDCARD, processScoreCard);
			
		}
		private function setupModel(signal:BaseSignal):void {
			view.init(245, 90, true, false, flashvars.table_id);
			view.align();
		}
		public function processScoreCard(signal:BaseSignal):void{
			var data:XMLList= signal.params.node.result;

			view.update(data);

		}
	}
}