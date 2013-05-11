package com.ai.roulette.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.PlayersEvent;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.model.GameDataModel;
	import com.ai.roulette.view.PlayersView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class PlayersMediator extends Mediator{
		
		[Inject]
		public var view:PlayersView;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var signalBus:SignalBus;
		override public function initialize():void {
			//eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setupModel);
			signalBus.add(ModelReadyEvent.READY, setupModel);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			//eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			addContextListener(Event.RESIZE, onStageResize);
			//eventMap.mapListener(eventDispatcher, PlayersEvent.LOADED, showPlayers);
			signalBus.add(PlayersEvent.LOADED, showPlayers);

		}
		
		private function showPlayers(signal:BaseSignal):void {
			view.players = signal.params.node;
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}