package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.view.interfaces.ITableGraphicView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.SignalBus;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class TableGraphicMediator extends Mediator
	{
		[Inject]
		public var contextView:ContextView;	
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var view:ITableGraphicView;	
		public function TableGraphicMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
		}
		private function setupModel(signal:BaseSignal):void {
			
			view.init();
			
		}
	}
}