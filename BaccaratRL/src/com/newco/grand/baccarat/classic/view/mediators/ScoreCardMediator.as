package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.service.AnimationService;
	import com.newco.grand.baccarat.classic.view.interfaces.IScoreCardView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class ScoreCardMediator extends Mediator
	{
		[Inject]
		public var view:IScoreCardView;
		
		[Inject]
		public var flashvars:FlashVars;	
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var animationService:AnimationService;
		
		[Inject]
		public var contextView:ContextView;	
		private var _extended:Boolean=false;
		public function ScoreCardMediator()
		{
			super();
		}
		public function get extended():Boolean{
			return _extended;
		}
		public function set extended(val:Boolean):void{
			if (_extended==false){
				
				Tweener.addTween(view,{x:contextView.view.stage.stageWidth-180,time:0.5,onComplete:function ():void{}});
			}else{
				Tweener.addTween(view,{x:530,time:0.5,onComplete:function ():void{}});	
			}
			_extended=val;
		}
		override public function initialize():void {
		
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(BaccaratEvent.SCORDCARD, processScoreCard);
			signalBus.add(StatisticsEvent.SHOWHIDE,doShowHideEvent);
			
			
			//view.closeBtn.addEventListener(MouseEvent.CLICK,doShowHide);
			extended=true;
		}
		private function doShowHide(evt:MouseEvent):void{
			extended=!extended;
		}
		private function doShowHideEvent(signal:BaseSignal=null):void{
			extended=!extended;
		
		}
		private function setupModel(signal:BaseSignal):void {
			view.initView(377, 187, true, false, flashvars.table_id);
			view.init();
			
		}
		public function processScoreCard(signal:BaseSignal):void{
			var data:XMLList= signal.params.node.result;

			view.update(data);

		}
	}
}