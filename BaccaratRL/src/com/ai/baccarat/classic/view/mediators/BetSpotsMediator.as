package com.ai.baccarat.classic.view.mediators {
	
	import com.ai.baccarat.classic.controller.signals.BaccaratEvent;
	import com.ai.baccarat.classic.model.BaccaratConstants;
	import com.ai.baccarat.classic.model.GameDataModel;
	import com.ai.baccarat.classic.view.BetSpotsView;
	import com.ai.core.controller.signals.BalanceEvent;
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.SocketDataEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.controller.signals.TaskbarActionEvent;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.GameState;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.BetSpot;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class BetSpotsMediator extends Mediator {
		
		[Inject]
		public var view:BetSpotsView;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var player:Player;
	
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		override public function initialize():void {
			
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(SocketDataEvent.HANDLE_TIMER, checkBettingState);
			//signalBus.add(SocketDataEvent.HANDLE_BET, handleBet);
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
		}
		
		private function confirm(signal:BaseSignal):void{
			player.betString= view.betString;
		}
		
		private function setupModel(signal:BaseSignal):void {
			initializeView();
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			if (flashVars.gametype==BaccaratConstants.TYPE_PAIRS)
				signalBus.add(BaccaratEvent.PAIRRESULT, processPairsResult);

		}
		
		private function initializeView():void {
			
			view.setMode(flashVars.gametype);
			view.registerPoints(game.layoutPoints);
			view.init();
			view.disableBetting();
			view.chipSelected = game.chipSelected;
			
			view.updateBetSignal.add(updateTotalBet);
			view.messageSignal.add(showTooltip)
		}
		
		private function showTooltip(type:String,target:BetSpot):void {
			signalBus.dispatch(type, {target:target});
			
		}
		
		private function setBalance(signal:BaseSignal):void {
			view.balance = player.balance;
		}
		
		private function updateTotalBet(target:BetSpot = null):void {
			player.bet = view.getTotalBet();
			player.bettingBalance = player.balance - player.bet;
			signalBus.dispatch(BetEvent.TOTAL_BET);
		}

		
		private function setChipSelected(signal:BaseSignal):void {
			view.chipSelected = game.chipSelected;
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
			
			view.setLimits(0, game.player_bet_min, game.player_bet_max);
			view.setLimits(1, game.banker_bet_min, game.banker_bet_max);
			view.setLimits(2, game.tie_bet_min, game.tie_bet_max);
			view.setLimits(3, game.player_pairs_bet_min, game.player_pairs_bet_max);
			view.setLimits(3, game.banker_pairs_bet_min, game.banker_pairs_bet_max);
			
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}


