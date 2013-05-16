package com.ai.core.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.WinnersEvent;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.uicomps.WinnersUIView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class WinnersMediator extends Mediator {
		
		[Inject]
		public var view:WinnersUIView;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;	
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add( WinnersEvent.LOADED, showPlayers);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);

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