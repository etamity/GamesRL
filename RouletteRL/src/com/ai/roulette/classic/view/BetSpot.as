package com.ai.roulette.classic.view {

	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class BetSpot extends BetspotAsset {

		private var _chip:MovieClip;
		private var _min:Number = 0;
		private var _max:Number = 0;
		private var _chipValue:Number = 0;
		private var _lastBet:Number = 0;
		private var _hand0Bet:Number = 0;
		private var _hand1Bet:Number = 0;
		private var _chipSelected:Number = 0;
		private var _chipsPlaced:Array;
		
		public var updateBetSignal:Signal=new Signal();
		public var messageSignal:Signal=new Signal();
		public var hightLightSignal:Signal=new Signal();
		public var removeLightSignal:Signal=new Signal();
		public function BetSpot() {
			chipsPlaced = [];
			chipValue = 0;
			lastBet = 0;
			buttonMode = true;
			mouseChildren = false;
			baseMC.alpha = 0;
			_chip= new MovieClip();
			addChild(_chip);
		}

		public function get chipSelected():Number {
			var betspotView:BetSpotsView= this.parent as BetSpotsView;
			return betspotView.chipSelecedValue;
		}
		public function get balance():Number {
			var betspotView:BetSpotsView= this.parent as BetSpotsView;
			return betspotView.balance;
		}

		private function rollOver(evt:MouseEvent):void {
			hightLightSignal.dispatch(this.name);
			visible = true;
			if (chipValue > 0 && chipValue < min) {

				messageSignal.dispatch(MessageEvent.SHOW_MIN_SPOT,this);
			}
		}

		private function rollOut(evt:MouseEvent):void {

			removeLightSignal.dispatch(this.name);

		}

		public function highlight():void {
			baseMC.alpha = 0.5;
		}

		public function removeHighlight():void {
			baseMC.alpha = 0;
		}

		public function placeChip(evt:MouseEvent):void {
			placeBetOnTable(chipSelected);
		}

		public function placeBetOnTable(value:Number):void {
			var newValue:Number = chipValue + value;
			var totalBetPlaced:Number = (parent as BetSpotsView).getTotalBet() + value;
			if(totalBetPlaced <= balance && balance > 0) {
				if(newValue <= max) {
					updateBet(value);
					updateBetSignal.dispatch(BetEvent.UPDATE_BET,this);
				}
				else {
					messageSignal.dispatch(MessageEvent.SHOW_MAX_SPOT,this)
				}				
			}
			else {
				messageSignal.dispatch(MessageEvent.SHOW_MAX_SPOT,this);
			}
		}
		
		public function updateBet(value:Number):void {
			chipValue += value;
			chipsPlaced.push(value);
		}

		public function clean():void {
			chipsPlaced = [];
			chipValue = 0;
			_chip.removeChildren();
		}

		public function repeat():void {
			clean();
			placeBetOnTable(lastBet);
		}

		public function double():void {
			clean();
			placeBetOnTable(lastBet * 2);
		}

		public function undo():void {
			if (chipsPlaced.length > 0) {
				chipValue = chipValue - chipsPlaced[chipsPlaced.length - 1];
				chipsPlaced.pop();
			}
			else {
				clean();
			}
		}

		public function set chipValue(value:Number):void {
			_chipValue = value;
		}

		public function get chipValue():Number {
			return _chipValue;
		}

		public function set min(value:Number):void {
			_min = value;
		}

		public function get min():Number {
			return _min;
		}

		public function set max(value:Number):void {
			_max = value;
		}

		public function get max():Number {
			return _max;
		}

		public function set chipsPlaced(value:Array):void {
			_chipsPlaced = value;
		}

		public function get chipsPlaced():Array {
			return _chipsPlaced;
		}
		
		public function get lastChipPlaced():Number {
			return chipsPlaced[chipsPlaced.length - 1];
		}

		public function set lastBet(value:Number):void {
			_lastBet = value;
		}

		public function get lastBet():Number {
			return _lastBet;
		}
		
		public function disable():void {
			removeHighlight();
			baseMC.visible = false;
			mouseEnabled = false;
			buttonMode = false;
			removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, placeChip);
		}

		public function enable():void {
			baseMC.visible = true;
			mouseEnabled = true;
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER, rollOver);
			addEventListener(MouseEvent.ROLL_OUT, rollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, placeChip);			
		}

		public function calculateBJWin(result0:String, result1:String = ""):void {
			hand0Bet = 0;
			hand1Bet = 0;

			if (result1 != "") {
				hand0Bet = _chipValue / 2;
				hand1Bet = _chipValue / 2;
				if (result1 == "win") {
					hand1Bet *= 2;
				}
				else if (result1 == "blackjack") {
					hand1Bet *= 2.5;
				}
				else if (result1 == "lose") {
					hand1Bet = 0;
				}
				else if (result1 == "bust") {
					hand1Bet = 0;
				}
				if (result0 == "win") {
					hand0Bet *= 2;
				}
				else if (result0 == "blackjack") {
					hand0Bet *= 2.5;
				}
				else if (result0 == "lose") {
					hand0Bet = 0;
				}
				else if (result0 == "bust") {
					hand0Bet = 0;
				}
			}
			else {
				if (result0 == "win") {
					hand0Bet = _chipValue * 2;
				}
				else if (result0 == "blackjack") {
					hand0Bet = _chipValue * 2.5;
				}
				else if (result0 == "push") {
					hand0Bet = _chipValue;
				}
				else if (result0 == "lose") {
					hand0Bet = 0;
				}
			}
			//winnings = hand0Bet + hand1Bet;
		}

		public function set hand0Bet(value:Number):void {
			_hand0Bet = value;
		}

		public function get hand0Bet():Number {
			return _hand0Bet;
		}

		public function set hand1Bet(value:Number):void {
			_hand1Bet = value;
		}

		public function get hand1Bet():Number {
			return _hand1Bet;
		}

		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}