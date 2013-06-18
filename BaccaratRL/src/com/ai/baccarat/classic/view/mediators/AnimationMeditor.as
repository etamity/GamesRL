package com.ai.baccarat.classic.view.mediators
{
	import com.ai.baccarat.classic.controller.signals.BaccaratEvent;
	import com.ai.baccarat.classic.model.BaccaratConstants;
	import com.ai.baccarat.classic.model.GameDataModel;
	import com.ai.baccarat.classic.service.AnimationService;
	import com.ai.baccarat.classic.view.AnimationPanelView;
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.ModelReadyEvent;
	import com.ai.core.common.controller.signals.SocketDataEvent;
	import com.ai.core.common.model.FlashVars;
	import com.ai.core.common.model.Player;
	import com.ai.core.common.model.SignalBus;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class AnimationMeditor extends Mediator
	{
		[Inject]
		public var animationService:AnimationService;
		[Inject]
		public var view :AnimationPanelView;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		public function AnimationMeditor()
		{
			super();
		}
		override public function initialize():void {
			//eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_RESULT, processResult);
			//eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, initialize);
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(SocketDataEvent.HANDLE_RESULT,processResult);
		}
		private function setupModel(signal:BaseSignal):void {
			if (flashVars.gametype==BaccaratConstants.TYPE_PAIRS)
				signalBus.add(BaccaratEvent.PAIRRESULT, processPairsResult);
				//eventMap.mapListener(eventDispatcher, BaccaratEvent.PAIRRESULT , processPairsResult);
		}
	
		
		private function processResult(signal:BaseSignal):void{
			var sideName:String=signal.params.node;
			animationService.fadeIn(view.showWinningCup(),game.layoutPoints[sideName]);
			if (player.winnings>0)
			animationService.fadeInCenter(view.showWinningBox(player.currencyCode+String(player.winnings),signal.params.node));
		}
		
		private function processPairsResult(signal:BaseSignal):void{
			var sideName:String;
			var node:XML = signal.params.node;
			var code:String;
			var totalWinning:Number;
			if (node.children().length() == 1) {
				code=(node.children()[0].@code);
				sideName=game.getBespotName(code);
				animationService.fadeIn(view.showWinningCup(),game.layoutPoints[sideName]);
			}
			else if (node.children().length() == 2) {
				code=node.children()[0].@code;
				sideName=game.getBespotName(code);
				animationService.fadeIn(view.showWinningCup(),game.layoutPoints[sideName]);
				code=node.children()[1].@code;
				sideName=game.getBespotName(code);
				animationService.fadeIn(view.showWinningCup(),game.layoutPoints[sideName]);
			}
			
			if (player.winnings>0)
				animationService.fadeInCenter(view.showWinningBox(player.currencyCode+String(player.winnings),signal.params.node));

		}
	}
}