package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.view.interfaces.ITableGraphicView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.SignalBus;

	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	
	import caurina.transitions.Tweener;
	import com.newco.grand.core.common.model.FlashVars;
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
			signalBus.add(UIEvent.VIDEO_STOP, showGraphics);
			signalBus.add(UIEvent.VIDEO_LOADED, hideGraphics);
			
		}
		private function showGraphics(signal:BaseSignal):void {
			view.view.alpha=1;
			view.view.visible=true;
		}
		private function hideGraphics(signal:BaseSignal):void {
			Tweener.addTween(view.view, {alpha:0, time:3, transition:"easeInOutQuart",onComplete:function ():void{
				view.view.visible=false;
			}});

		}
		
		private function setupModel(signal:BaseSignal):void {
			
			view.init();
			
		}
	}
}