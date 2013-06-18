package com.ai.baccarat.classic.view.mediators
{
	import com.ai.baccarat.classic.controller.signals.BaccaratEvent;
	import com.ai.baccarat.classic.view.CardsPanelView;
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.ModelReadyEvent;
	import com.ai.core.common.controller.signals.SocketDataEvent;
	import com.ai.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class CardsPanelMediator extends Mediator
	{
		[Inject]
		public var view:CardsPanelView;
		[Inject]
		public var signalBus:SignalBus;
		public function CardsPanelMediator()
		{
			super();
		}
		override public function initialize():void {
			/*eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, initialize);
			eventMap.mapListener(eventDispatcher, BaccaratEvent.CARD, issueCard);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_GAME, cleanCardPanel);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_CANCEL, cleanCardPanel);*/
			
			
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(BaccaratEvent.CARD, issueCard);
			signalBus.add(SocketDataEvent.HANDLE_GAME, cleanCardPanel);
			signalBus.add(SocketDataEvent.HANDLE_CANCEL, cleanCardPanel);

		}
		private function setupModel(signal:BaseSignal):void {
			view.visible=true;
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