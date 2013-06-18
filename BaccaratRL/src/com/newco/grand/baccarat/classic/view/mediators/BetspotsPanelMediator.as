package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.view.BetspotsPanelView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.GameState;
	import com.newco.grand.core.common.model.SignalBus;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class BetspotsPanelMediator extends Mediator
	{
		[Inject]
		public var view:BetspotsPanelView;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;	
		
		[Inject]
		public var flashVars:FlashVars;
		public function BetspotsPanelMediator()
		{
			super();

		}
		override public function initialize():void {
			signalBus.add(UIEvent.RESIZE, resize);
			signalBus.add(ModelReadyEvent.READY, setupModel);
		}
		private function setupModel(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
			signalBus.add(BaccaratEvent.MAKEBETPANEL, makePanelBet);
			signalBus.add(BetEvent.CLOSE_BETS, closeBetting);
			signalBus.add(SocketDataEvent.HANDLE_TIMER, checkBettingState);
			signalBus.add(SocketDataEvent.HANDLE_CANCEL, clearBets);
			
			view.makeBetSignal.add(makeBet);
			view.setMode(flashVars.gametype);
		}
		
		private function closeBetting(signal:BaseSignal):void{
			view.enabledBetting(false);
		}
		private function checkBettingState(signal:BaseSignal):void{
			if(GameState.state == GameState.WAITING_FOR_BETS) {
				view.clearBets();
				view.enabledBetting(true);
			}
			else if(GameState.state == GameState.NO_GAME) {
				view.clearBets();
			}
		}
		private function clearBets(signal:BaseSignal):void{
			view.clearBets();
		}
		private function makePanelBet(signal:BaseSignal):void{
			var side:String= signal.params.side;
			var amount:Number= signal.params.amount;
			view.makeBet(amount,side);
		}
		private function makeBet(side:String):void{
			signalBus.dispatch(BaccaratEvent.MAKEBETSPOT ,{side:side});
		}
		private function onStageResize(event:Event):void {
			view.align();
		}
		public function resize(signal:BaseSignal):void{
			var ww:int= signal.params.width;
			var hh:int= signal.params.height;
			view.resize(ww,hh);
		}
	}
}