package com.newco.grand.roulette.classic.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.view.ResultsClassicView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ResultsClassicMediator extends Mediator{
		
		[Inject]
		public var view:ResultsClassicView;
		
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
			//eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			addContextListener(Event.RESIZE, onStageResize);
			/*eventMap.mapListener(eventDispatcher, StateTableConfigEvent.LOADED, setResults);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_RESULT, addResult);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_CANCEL, addCancel);*/
			signalBus.add(StateTableConfigEvent.LOADED, setResults);
			signalBus.add(SocketDataEvent.HANDLE_RESULT, addResult);
			signalBus.add(SocketDataEvent.HANDLE_CANCEL, addCancel);
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