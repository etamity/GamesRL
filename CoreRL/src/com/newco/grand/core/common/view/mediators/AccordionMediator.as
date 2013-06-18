package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.ai.corcom.ai.core.common.view.interfaces.IAccordione.view.interfaces.IAccordion;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class AccordionMediator extends Mediator{
		
		[Inject]
		public var view:IAccordion;
		
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var signalBus:SignalBus;
		
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(StartupDataEvent.LOADED, addViews);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
		}
		
		public function addViews(signal:BaseSignal):void {
		
		}
		public function resize():void{
			signalBus.dispatch(UIEvent.RESIZE,{width:164,height:view.contentHeight-10})
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}