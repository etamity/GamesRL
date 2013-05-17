package com.ai.roulette.classic.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.SocketDataEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.classic.model.GameDataModel;
	import com.ai.roulette.classic.view.ResultsView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ResultsMediator extends Mediator {
		
		[Inject]
		public var view:ResultsView;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var signalBus:SignalBus;
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
			//eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setupModel);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			eventMap.mapListener(eventDispatcher, StateTableConfigEvent.LOADED, setResults);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_RESULT, addResult);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_CANCEL, addCancel);
		}
		
		private function setResults(signal:BaseSignal):void {
			view.xml = game.recentResults;
		}
		
		private function addResult(signal:BaseSignal):void {
			view.addResult(game.resultXML);
		}
		
		private function addCancel(signal:BaseSignal):void {
			view.addCancel();
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}