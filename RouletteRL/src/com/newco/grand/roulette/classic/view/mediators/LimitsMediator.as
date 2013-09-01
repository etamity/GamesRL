package com.newco.grand.roulette.classic.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.view.LimitsView;
	import com.newco.grand.core.common.model.LanguageModel;
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
			view.minLabel = LanguageModel.MIN;
			view.maxLabel = LanguageModel.MAX;
			view.titleLabel = game.table;
			view.betLabel = LanguageModel.BETLABEL;
			view.payoutLabel = LanguageModel.PAYOUT;
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
		}		
		
		private function setLimits(signal:BaseSignal):void {
			view.minLimit = player.currencyCode + " " + game.min;
			view.maxLimit = player.currencyCode + " " + game.max;
			
			for (var i:int = 0; i < ALL_LIMITS.length; i++) {
				view.addLimits(LanguageModel[ALL_LIMITS[i].toUpperCase()], game[ALL_LIMITS[i] + "Min"], game[ALL_LIMITS[i] + "Max"], ALL_PAYOUTS[i], i);
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