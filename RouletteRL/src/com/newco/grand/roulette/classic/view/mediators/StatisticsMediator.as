package com.newco.grand.roulette.classic.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.view.StatisticsView;
	
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
			signalBus.add(StatisticsEvent.LOADED, showStats);
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