package com.ai.roulette.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.model.Language;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.controller.signals.WinnersEvent;
	import com.ai.roulette.model.GameDataModel;
	import com.ai.roulette.view.WinnersView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class WinnersMediator extends Mediator {
		
		[Inject]
		public var view:WinnersView;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var signalBus:SignalBus;
		override public function initialize():void {
			//eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, initialize);
			signalBus.add(ModelReadyEvent.READY, setupModel);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			view.listView.columns[0].headerText = Language.PLAYERNAME;
			view.listView.columns[1].headerText = Language.PLAYERWINS;
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			//eventMap.mapListener(eventDispatcher, WinnersEvent.LOADED, showPlayers);
			signalBus.add( WinnersEvent.LOADED, showPlayers);
		}
		
		private function showPlayers(signal:BaseSignal):void {
			view.players =signal.params.node;
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}