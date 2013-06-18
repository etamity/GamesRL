package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.common.view.uicomps.PlayersUIView;
	
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
			signalBus.add(UIEvent.RESIZE, resize);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			addContextListener(Event.RESIZE, onStageResize);

		}
		
		private function showPlayers(signal:BaseSignal):void {
			view.players = signal.params.node;
		
		}
		public function resize(signal:BaseSignal):void{
			var ww:int= signal.params.width;
			var hh:int= signal.params.height;
			view.resize(ww,hh);
		}
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}