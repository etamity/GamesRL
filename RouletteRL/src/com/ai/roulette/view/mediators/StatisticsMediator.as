package com.ai.roulette.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.controller.signals.StatisticsEvent;
	import com.ai.roulette.model.GameDataModel;
	import com.ai.roulette.view.StatisticsView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StatisticsMediator extends Mediator {
		
		[Inject]
		public var view:StatisticsView;
		
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
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			eventMap.mapListener(eventDispatcher, StatisticsEvent.LOADED, showStats);
		}
		
		private function showStats(signal:BaseSignal):void {
			view.stats =signal.params.node;
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}