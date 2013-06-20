package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.view.interfaces.ICardsPanelView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class CardsPanelMediator extends Mediator
	{
		[Inject]
		public var view:ICardsPanelView;
		[Inject]
		public var signalBus:SignalBus;
		public function CardsPanelMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(BaccaratEvent.CARD, issueCard);
			signalBus.add(SocketDataEvent.HANDLE_GAME, cleanCardPanel);
			signalBus.add(SocketDataEvent.HANDLE_CANCEL, cleanCardPanel);

		}
		private function setupModel(signal:BaseSignal):void {
			view.init();
		}
		private function cleanCardPanel(signal:BaseSignal):void{
			view.cleanPanel();
		}
		private function issueCard(signal:BaseSignal):void{
			var card:XML= signal.params.node;
			var side:String=card.@place;
			view.issueCard(side,card);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}