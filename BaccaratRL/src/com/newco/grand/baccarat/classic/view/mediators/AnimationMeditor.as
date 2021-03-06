package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.model.BaccaratConstants;
	import com.newco.grand.baccarat.classic.model.GameDataModel;
	import com.newco.grand.baccarat.classic.service.AnimationService;
	import com.newco.grand.baccarat.classic.view.AnimationPanelView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.geom.Point;
	
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
			debug("processResult","sideName",sideName,game.layoutPoints[sideName]);
			if (FlashVars.GAMECLIENT==Constants.BACCARAT)
			animationService.fadeIn(view.showWinningCup(),game.layoutPoints[sideName]);//game.layoutPoints[sideName]);
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

		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}