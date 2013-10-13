package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.view.interfaces.ITableGraphicView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.SignalBus;
	
	import caurina.transitions.Tweener;
	
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
			signalBus.add(UIEvent.BACKGROUND_GRAPHIC, showHideGraphics);

			
		}
		private function showHideGraphics(signal:BaseSignal):void {
			var show:Boolean=signal.params.show;
			if (show)
			{
				view.view.alpha=1;
				view.view.visible=true;
			}else
			{
				view.view.alpha=1;
				Tweener.addTween(view.view, {alpha:0, time:1, transition:"easeInOutQuart",onComplete:function ():void{
					view.view.visible=false;
				}});
			}

		}
		
		private function setupModel(signal:BaseSignal):void {
			
			view.init();
			
		}
	}
}