package com.ai.roulette.classic.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.model.Language;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.classic.model.GameDataModel;
	import com.ai.roulette.classic.view.LimitsView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class LimitsMediator extends Mediator{
		
		[Inject]
		public var view:LimitsView;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var signalBus:SignalBus;
		private const ALL_LIMITS:Array  = new Array("straight", "split", "trio", "corner", "six", "column", "dozen", "red", "black", "even", "odd", "high", "low");
		private const ALL_PAYOUTS:Array = new Array(35, 17, 11, 8, 5, 2, 2, 1, 1, 1, 1, 1, 1);
		
		override public function initialize():void {
			/*eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setupModel);
			eventMap.mapListener(eventDispatcher, StateTableConfigEvent.LOADED, setLimits);*/
			
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(StateTableConfigEvent.LOADED, setLimits);

		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			view.minLabel = Language.MIN;
			view.maxLabel = Language.MAX;
			view.titleLabel = game.table;
			view.betLabel = Language.BETLABEL;
			view.payoutLabel = Language.PAYOUT;
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
		}		
		
		private function setLimits(signal:BaseSignal):void {
			view.minLimit = player.currencyCode + " " + game.min;
			view.maxLimit = player.currencyCode + " " + game.max;
			
			for (var i:int = 0; i < ALL_LIMITS.length; i++) {
				view.addLimits(Language[ALL_LIMITS[i].toUpperCase()], game[ALL_LIMITS[i] + "Min"], game[ALL_LIMITS[i] + "Max"], ALL_PAYOUTS[i], i);
			}
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}