package com.ai.core.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.PlayersEvent;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.uicomps.PlayersUIView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class PlayersMediator extends Mediator{
		
		[Inject]
		public var view:PlayersUIView;

		
		[Inject]
		public var signalBus:SignalBus;
	
		override public function initialize():void {
			//eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setupModel);
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(PlayersEvent.LOADED, showPlayers);
			debug("initialize");
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			addContextListener(Event.RESIZE, onStageResize);

			debug("setupModel");
		}
		
		private function showPlayers(signal:BaseSignal):void {
			debug(signal.params.node);
	
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