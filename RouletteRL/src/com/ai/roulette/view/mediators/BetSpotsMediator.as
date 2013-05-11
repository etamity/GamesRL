package com.ai.roulette.view.mediators {
	
	import com.ai.core.controller.signals.BalanceEvent;
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.HighlightEvent;
	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.SocketDataEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.controller.signals.TaskbarActionEvent;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.controller.signals.DataGirdEvent;
	import com.ai.roulette.model.BetspotData;
	import com.ai.roulette.model.GameDataModel;
	import com.ai.roulette.model.GameState;
	import com.ai.roulette.view.BetSpot;
	import com.ai.roulette.view.BetSpotsView;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class BetSpotsMediator extends Mediator{
		
		[Inject]
		public var view:BetSpotsView;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var signalBus:SignalBus;
		
		private const STRAIGHTS:Array        = new Array(2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39);
		private const SPLITS:Array           = new Array(52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 154, 155, 156);
		private const TRIOS:Array            = new Array(131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 157, 158);
		private const CORNERS:Array          = new Array(109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 159);
		private const SIXES:Array            = new Array(143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153);
		private const DOZENS:Array           = new Array(43, 44, 45);
		private const COLUMNS:Array          = new Array(40, 41, 42);
		private const ODD:Number             = 50;
		private const EVEN:Number            = 47;
		private const RED:Number             = 48;
		private const BLACK:Number           = 49;
		private const LOW:Number             = 46;
		private const HIGH:Number            = 51;
		
		override public function initialize():void {
			/*eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setupModel);
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
			eventMap.mapListener(eventDispatcher, BetEvent.CONFRIM, confirm);
			eventMap.mapListener(eventDispatcher, DataGirdEvent.FAVOURITESAPPLY, applyFavourites);*/
			
			
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
			signalBus.add(DataGirdEvent.FAVOURITESAPPLY, applyFavourites);
		}
		
		private function confirm(signal:BaseSignal):void{
			player.betString= view.betString;
		}
		
		private function applyFavourites(signal:BaseSignal):void{
			view.clearBets();
			var betString:String=String(signal.params.betString);
		
			view.placeFavouritesBets(betString);
			
		}
		private function setupModel(signal:BaseSignal):void {
			initializeView();
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
		}
		
		private function initializeView():void {
			view.init();
			view.chipSelected = game.chipSelected;
			/*view.addEventListener(BetEvent.UPDATE_BET, updateTotalBet);
			view.addEventListener(BetEvent.NEIGHBOUR_BETS, placeNeighbourBets);
			view.addEventListener(HighlightEvent.HIGHLIGHT, highlight);
			view.addEventListener(HighlightEvent.REMOVE_HIGHLIGHT, removeHighlight);
			view.addEventListener(MessageEvent.SHOW_NOT_ENOUGH_MONEY, showTooltip);
			view.addEventListener(MessageEvent.SHOW_MIN_SPOT, showTooltip);
			view.addEventListener(MessageEvent.SHOW_MAX_SPOT, showTooltip);*/
			view.updateBetSignal.add(updateTotalBet);
			view.messageSignal.add(showTooltip)
			view.neighbourBetsSignal.add(placeNeighbourBets);
			view.hightLightSignal.add(highlight);
			view.removeLightSignal.add(removeHighlight);
		}
		
		private function showTooltip(type:String,target:BetSpot):void {
			signalBus.dispatch(type, target);		
		}
		
		private function setBalance(signal:BaseSignal):void {
			view.balance = player.balance;
		}
		
		private function updateTotalBet(target:String = null):void {
			player.bet = view.getTotalBet();
			player.bettingBalance = player.balance - player.bet;
			//eventDispatcher.dispatchEvent(new BetEvent(BetEvent.TOTAL_BET));
			signalBus.dispatch(BetEvent.TOTAL_BET);
		}
		
		private function placeNeighbourBets(target:BetSpot):void {
			var highlights:Array = BetspotData[target.name.toUpperCase()];
			if (highlights != null && highlights.length > 0) {
				for (var i:uint = 0; i < highlights.length; i++) {
					view.createBet(game.chipSelected, highlights[i]);
				}
			}
		}
		
		private function highlight(target:String):void {
			var highlights:Array = BetspotData[target.toUpperCase()];
			if (highlights != null && highlights.length > 0) {
				for (var i:uint = 0; i < highlights.length; i++) {
					view.highlightSpot("bs" + highlights[i]);
				}
			}
			else {
				view.highlightSpot(target);
			}
		}
		
		private function removeHighlight(target:String):void {
			var highlights:Array = BetspotData[target.toUpperCase()];
			if (highlights != null && highlights.length > 0) {
				for (var i:uint = 0; i < highlights.length; i++) {
					view.removeHighlightSpot("bs" + highlights[i]);
				}
			}
			else {
				view.removeHighlightSpot(target);
			}
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
		
		private function clearBets(signal:BaseSignal = null):void {
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
			var node:XML = signal.params.node;
			var bet:Number  = Number(node);
			var seat:Number = Number(node.@seat);
			view.createBet(bet, seat);
		}
		
		private function processResult(signal:BaseSignal):void {
			var result:int = game.result;
			result = (result != 0) ? result + 3 : 2;
			view.showWinningNumber(result);

			if(player.bet > 0) {
				player.lastBet = view.lastBet;
				var winners:XMLList = BetspotData.DATA.betcode.(@winners.indexOf("," + game.result + ",") > -1);
				for each (var node:XML in winners) {
					player.winnings += view.getWinnings(node.@id, node.@payout);
				}

				if(player.winnings > 0) {
					//eventDispatcher.dispatchEvent(new MessageEvent(MessageEvent.SHOW_WINNINGS));
					signalBus.dispatch(MessageEvent.SHOW_WINNINGS);
				}
			}
		}
		
		private function closeBetting(signal:BaseSignal):void {
			if(player.bet > 0) {
				player.betString = view.betString;
				countBets();
				//eventDispatcher.dispatchEvent(new BetEvent(BetEvent.SEND_BETS));
				signalBus.dispatch(BetEvent.SEND_BETS);
			}
			view.disableBetting();
		}
		
		private function countBets():void {
			var betCount:Object = {};
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
			player.betCount = totalCount;
		}
		
		private function setLimits(signal:BaseSignal):void {
			for (var i:int = 0; i < STRAIGHTS.length; i++) {
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
			view.setLimits(165, game.lowMin, game.lowMax);
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}