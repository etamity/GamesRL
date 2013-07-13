package com.newco.grand.baccarat.classic.view.mediators
{
	import caurina.transitions.Tweener;
	
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.service.AnimationService;
	import com.newco.grand.baccarat.classic.view.ScoreCardView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ScoreCardMediator extends Mediator
	{
		[Inject]
		public var view:ScoreCardView;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var animationService:AnimationService;
		
		
		private var extended:Boolean=true;
		public function ScoreCardMediator()
		{
			super();
		}
		override public function initialize():void {
		
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(BaccaratEvent.SCORDCARD, processScoreCard);
			signalBus.add(StatisticsEvent.SHOWHIDE,doShowHideEvent);
			
			
			view.closeBtn.addEventListener(MouseEvent.CLICK,doShowHide);
		}
		private function doShowHide(evt:MouseEvent):void{
			doShowHideEvent();
		}
		private function doShowHideEvent(signal:BaseSignal=null):void{
			if (extended==true){
			
				Tweener.addTween(view,{x:view.stage.stageWidth-180,time:0.5,onComplete:function ():void{}});
			}else{
				Tweener.addTween(view,{x:570,time:0.5,onComplete:function ():void{}});	
			}
			extended=!extended;
		}
		private function setupModel(signal:BaseSignal):void {
			view.init(245, 90, true, false, flashvars.table_id);
			view.align();
		}
		public function processScoreCard(signal:BaseSignal):void{
			var data:XMLList= signal.params.node.result;

			view.update(data);

		}
	}
}