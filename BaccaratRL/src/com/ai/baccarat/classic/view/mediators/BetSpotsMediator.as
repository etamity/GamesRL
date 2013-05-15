package com.ai.baccarat.classic.view.mediators {
	
	import com.ai.baccarat.classic.controller.signals.BaccaratEvent;
	import com.ai.baccarat.classic.model.BaccaratConstants;
	import com.ai.baccarat.classic.model.GameDataModel;
	import com.ai.baccarat.classic.view.BetSpot;
	import com.ai.baccarat.classic.view.BetSpotsView;
	import com.ai.core.controller.signals.BalanceEvent;
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.SocketDataEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.controller.signals.TaskbarActionEvent;
	import com.ai.core.controller.signals.UIEvent;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.GameState;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	
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
			/*eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, initialize);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_TIMER, checkBettingState);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_BET, handleBet);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_CANCEL, clearBets);
			eventMap.mapListener(eventDispatcher, SocketDataEvent.HANDLE_RESULT, processResult);
	
			
			eventMap.mapListener(eventDispatcher, StateTableConfigEvent.LOADED, setLimits);
			eventMap.mapListener(eventDispatcher, BalanceEvent.LOADED, setBalance);
			eventMap.mapListener(eventDispatcher, TaskbarActionEvent.CHIP_CLICKED, setChipSelected);
			eventMap.mapListener(eventDispatcher, BetEvent.CLOSE_BETS, closeBetting);
			eventMap.mapListener(eventDispatcher, BetEvent.BETS_REJECTED, clearBets);
			eventMap.mapListener(eventDispatcher, BetEvent.CLEAR, clearBets);
			eventMap.mapListener(eventDispatcher, BetEvent.UNDO, clearLastBet);
			eventMap.mapListener(eventDispatcher, BetEvent.REPEAT, repeat);
			eventMap.mapListener(eventDispatcher, BetEvent.DOUBLE, double);
			eventMap.mapListener(eventDispatcher, BetEvent.CONFRIM, confirm);*/
			
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(SocketDataEvent.HANDLE_TIMER, checkBettingState);
			signalBus.add(SocketDataEvent.HANDLE_BET, handleBet);
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
			//eventMap.mapListener(eventDispatcher, BaccaratEvent.PAIRRESULT , processPairsResult);

		}
		
		private function initializeView():void {
			
			view.setMode(flashVars.gametype);
			debug("flashVas.gametype  ",flashVars.gametype);
			view.registerPoints(game.layoutPoints);
			view.init();
			view.disableBetting();
			view.chipSelected = game.chipSelected;
			
			/*view.addEventListener(BetEvent.UPDATE_BET, updateTotalBet);
			view.addEventListener(MessageEvent.SHOW_NOT_ENOUGH_MONEY, showTooltip);
			view.addEventListener(MessageEvent.SHOW_MIN_SPOT, showTooltip);
			view.addEventListener(MessageEvent.SHOW_MAX_SPOT, showTooltip);*/
			view.updateBetSignal.add(updateTotalBet);
			view.messageSignal.add(showTooltip)
		}
		
		private function showTooltip(type:String,target:BetSpot):void {
			//eventDispatcher.dispatchEvent(event);
			signalBus.dispatch(type, {target:target.max});
			
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
					//eventDispatcher.dispatchEvent(new MessageEvent(MessageEvent.SHOW_WINNINGS));
					signalBus.dispatch(MessageEvent.SHOW_WINNINGS);
			}
		}
		private function processPairsResult(signal:BaseSignal):void{		
			var node:XML = signal.params.node;
			var code:String;
			var totalWinning:Number;
			if (node.children().length() == 1) {
				code=(node.children()[0].@code);
				totalWinning=view.getPairsWinnings(code);
			}
			else if (node.children().length() == 2) {
				code=node.children()[0].@code;
				totalWinning=view.getPairsWinnings(code);
				code=node.children()[1].@code;
				totalWinning +=view.getPairsWinnings(code);
			}
			
			player.winnings=totalWinning;
			if(player.winnings > 0) {
				//eventDispatcher.dispatchEvent(new MessageEvent(MessageEvent.SHOW_WINNINGS));
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
			/*var betCount:Object = {};
			var totalCount:int = 0;
			for (var item:String in view.betBatch) {
				if (int(item) > 39) {
					var bets:Array = BetspotData["BS" + item];
					for (var i:int = 0; i < bets.length; i++) {
						betCount[bets[i]] = (bets[i] != int(item));
					}
				}
				else {
					betCount[item] = true;
				}
			}
			
			for (item in betCount) {
				totalCount++;
			}
			player.betCount = totalCount;*/
			player.betCount= view.getTotalBet();
		}
		
		private function setLimits(signal:BaseSignal):void {
			
			view.setLimits(game.min,game.max);
			/*for (var i:int = 0; i < STRAIGHTS.length; i++) {
				view.setLimits(STRAIGHTS[i], game.straightMin, game.straightMax);
			}
			
			for (i = 0; i < SPLITS.length; i++) {
				view.setLimits(SPLITS[i], game.splitMin, game.splitMax);
			}
			
			for (i = 0; i < TRIOS.length; i++) {
				view.setLimits(TRIOS[i], game.trioMin, game.trioMax);
			}
			
			for (i = 0; i < CORNERS.length; i++) {
				view.setLimits(CORNERS[i], game.cornerMin, game.cornerMax);
			}
			
			for (i = 0; i < SIXES.length; i++) {
				view.setLimits(SIXES[i], game.sixMin, game.sixMax);
			}
			
			for (i = 0; i < DOZENS.length; i++) {
				view.setLimits(DOZENS[i], game.dozenMin, game.dozenMax);
			}
			
			for (i = 0; i < COLUMNS.length; i++) {
				view.setLimits(COLUMNS[i], game.columnMin, game.columnMax);
			}
			
			view.setLimits(ODD, game.oddMin, game.oddMax);
			view.setLimits(EVEN, game.evenMin, game.evenMax);
			view.setLimits(BLACK, game.blackMin, game.blackMax);
			view.setLimits(RED, game.redMin, game.redMax);
			view.setLimits(HIGH, game.highMin, game.highMax);
			view.setLimits(LOW, game.lowMin, game.lowMax);
			
			// For french/casino magic
			view.setLimits(163, game.oddMin, game.oddMax);
			view.setLimits(160, game.evenMin, game.evenMax);			
			view.setLimits(161, game.redMin, game.redMax);
			view.setLimits(162, game.blackMin, game.blackMax);
			view.setLimits(164, game.highMin, game.highMax);
			view.setLimits(165, game.lowMin, game.lowMax);*/
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}


