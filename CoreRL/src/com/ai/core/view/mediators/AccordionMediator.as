package com.ai.core.view.mediators {
	
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.StartupDataEvent;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.AccordionView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class AccordionMediator extends Mediator{
		
		[Inject]
		public var view:AccordionView;
		
		[Inject]
		public var signalBus:SignalBus;
		
		override public function initialize():void {
			//eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setupModel);
			//eventMap.mapListener(eventDispatcher, StartupDataEvent.LOADED, addViews);
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(StartupDataEvent.LOADED, addViews);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
		}
		
		public function addViews(signal:BaseSignal):void {
		
			/*view.add(new StatisticsView(), Language.STATISTICS);
			view.add(new PlayersView(), Language.PLAYERS);
			view.add(new WinnersView(), Language.WINNERLIST);
			//view.add(new PlayersBetsView(), Language.PLAYERSBETS);
			view.add(new FavouritesBetsView(), Language.FAVOURITES);*/
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}