package com.newco.grand.baccarat.classic.view.mediators {
	
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.model.BaccaratConstants;
	import com.newco.grand.baccarat.classic.model.GameDataModel;
	import com.newco.grand.baccarat.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.GameState;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.BetSpot;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class BetSpotsMediator extends Mediator {
		
		[Inject]
		public var view:IBetSpotsView;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var player:Player;
	
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var contextView:ContextView;	
		
		[Inject]
		public var signalBus:SignalBus;
		
		override public function initialize():void {
			
			signalBus.add(ModelReadyEvent.READY, setupModel);
			//signalBus.add(SocketDataEvent.HANDLE_BET, handleBet);
			signalBus.add(SocketDataEvent.HANDLE_TIMER, checkBettingState);
			signalBus.add(SocketDataEvent.HANDLE_CANCEL, clearBets);
			signalBus.add(SocketDataEvent.HANDLE_RESULT, processResult);
			
			signalBus.add(StateTableConfigEvent.LOADED, setLimits);
			signalBus.add(BalanceEvent.LOADED, setBalance);
			signalBus.add(TaskbarActionEvent.CHIP_CLICKED, setChipSelected);
			signalBus.add(BetEvent.CLOSE_BETS, closeBetting);
			signalBus.add(BetEvent.BETS_REJECTED, clearBets);
			signalBus.add(BetEvent.CLEAR, clearBets);
			signalBus.add(BetEvent.UNDO, clearLastBet);
			signalBus.add(BetEvent.REPEAT, repeat);
			signalBus.add(BetEvent.DOUBLE, double);
			signalBus.add(BetEvent.CONFRIM, confirm);
			//signalBus.add(BaccaratEvent.MAKEBETSPOT, makeBets);
		}
		private function updateLanguage(signal:BaseSignal):void{
			view.updateLanguage();
		}
		private function confirm(signal:BaseSignal):void{
			player.betString= view.betString;
		}
		
		private function setupModel(signal:BaseSignal):void {
			initializeView();
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
			if (flashVars.gametype==BaccaratConstants.TYPE_PAIRS)
				signalBus.add(BaccaratEvent.PAIRRESULT, processPairsResult);

		}
		
		private function makeBets(signal:BaseSignal):void{
			var side:String=signal.params.side;
			var index:int= game.getBespotIndex(side);
			view.createBet(view.chipSelecedValue, index);
		}
		
		private function initializeView():void {
			view.setMode(flashVars.gametype);
			view.registerPoints(game.layoutPoints);
			view.init();
			view.disableBetting();
			view.chipSelecedValue = game.chipSelected;
			
			/*view.updateBetSignal.add(updateTotalBet);
			view.messageSignal.add(showTooltip);
			view.makeBetsignal.add(makePanelBets);*/
			
			view.signalBus.add(BetEvent.UPDATE_BET,updateTotalBet);
			view.signalBus.add(MessageEvent.SHOW_MAX_SPOT,showTooltip);
			view.signalBus.add(MessageEvent.SHOW_MAX_TABLE,showTooltip);
			view.signalBus.add(MessageEvent.SHOW_MIN_SPOT,showTooltip);
			view.signalBus.add(MessageEvent.SHOW_NOT_ENOUGH_MONEY,showTooltip);
			view.signalBus.add(MessageEvent.SHOW_WINNINGS,showTooltip);
			//view.signalBus.add(BetEvent.MAKEBET,makePanelBets);
			
		}
		private function makePanelBets(signal:BaseSignal):void{
			var side:String =signal.params.side;
			var amount:Number= view.getBetspotAmount(side);
			signalBus.dispatch(BaccaratEvent.MAKEBETPANEL ,{side:side,amount:amount});
		}
		private function showTooltip(signal:BaseSignal):void {
			var target:BetSpot=signal.params.target;
			signalBus.dispatch(signal.type, {target:target});
			
		}
		
		private function setBalance(signal:BaseSignal):void {
			view.balance = player.balance;
		}
		
		private function updateTotalBet(signal:BaseSignal = null):void {
			player.bet = view.getTotalBet();
			player.bettingBalance = player.balance - player.bet;
			signalBus.dispatch(BetEvent.TOTAL_BET);
		}

		
		private function setChipSelected(signal:BaseSignal):void {
			view.chipSelecedValue = game.chipSelected;
		}
		
		private function checkBettingState(signal:BaseSignal = null):void {
			if(GameState.state == GameState.WAITING_FOR_BETS) {
				view.clearBets();
				view.enableBetting();
			}
			else if(GameState.state == GameState.NO_GAME) {
				clearBets();
			}
		}
		
		private function clearBets(event:* = null):void {
			view.clearBets();
			updateTotalBet();
		}
		
		private function clearLastBet(signal:BaseSignal):void {
			view.undo();
			updateTotalBet();
		}
		
		private function repeat(signal:BaseSignal):void {
			view.repeat();
		}
		
		private function double(signal:BaseSignal):void {
			view.double();
		}
		
		private function handleBet(signal:BaseSignal):void {
			var node:XML =signal.params.node;
			var bet:Number  = Number(node);
			var seat:Number = Number(node.@seat);
			view.createBet(bet, seat);
		}
		
		private function processResult(signal:BaseSignal):void {
			var code:String= signal.params.node.@code;
			player.winnings=view.getWinnings(code);
			if(player.bet > 0) {
				player.lastBet = view.lastBet;		
			}
			if(player.winnings > 0) {
				signalBus.dispatch(MessageEvent.SHOW_WINNINGS);
			}
		}
		private function processPairsResult(signal:BaseSignal):void{		
			var node:XML = signal.params.node;
			var code:String;
			var totalWinning:Number;
			if (node.children().length() == 1) {
				code=(node.children()[0].@code);
				totalWinning=view.getWinnings(code);
			}
			else if (node.children().length() == 2) {
				code=node.children()[0].@code;
				totalWinning=view.getPairsWinnings(code);
				code=node.children()[1].@code;
				totalWinning +=view.getPairsWinnings(code);
			}
			
			player.winnings=totalWinning;
			if(player.winnings > 0) {
				signalBus.dispatch(MessageEvent.SHOW_WINNINGS);
			}
		}
		
		private function closeBetting(signal:BaseSignal):void {
			if(player.bet > 0) {
				player.betString = view.betString;
				countBets();
				signalBus.dispatch(BetEvent.SEND_BETS);
			}
			view.disableBetting();
		}
		
		private function countBets():void {
			player.betCount= view.getTotalBet();
		}
		
		private function setLimits(signal:BaseSignal):void {
			
			view.setLimits(0, game.player_min_bet, game.player_max_bet);
			view.setLimits(1, game.banker_min_bet, game.banker_max_bet);
			view.setLimits(2, game.tie_min_bet, game.tie_max_bet);
			view.setLimits(3, game.pairs_player_min_bet, game.pairs_player_max_bet);
			view.setLimits(4, game._pairsbanker_min_bet, game.pairs_banker_max_bet);
			
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}


