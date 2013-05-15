package com.ai.baccarat.classic.view {

	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.Betchip;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class BetSpot extends BetSpotAsset {

		private var _chips:MovieClip;
		private var _balance:Number = 0;
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
		
		public function BetSpot() {
			chipsPlaced = [];
			chipValue = 0;
			lastBet = 0;
			buttonMode = true;
			mouseChildren = false;
			highlight.alpha = 0;
			_chips=new MovieClip();
			addChild(_chips);
		}

		public function get chipHolder():MovieClip{
			return _chips;
		}
		public function get chipSelected():Number {
			return _chipSelected;
		}

		public function set chipSelected(value:Number):void {
			_chipSelected = value;
		}

		public function get mainChip():Betchip{
			var chip:Betchip =null;
			if (chipHolder.numChildren>0)
				chip=chipHolder.getChildAt(chipHolder.numChildren-1) as Betchip;
			
			return chip;
		}
		private function rollOver(evt:MouseEvent):void {
			//dispatchEvent(new HighlightEvent(HighlightEvent.HIGHLIGHT, name));
			highlightSpot();
			visible = true;
			if (chipValue > 0 && chipValue < min) {
				//dispatchEvent(new MessageEvent(MessageEvent.SHOW_MIN_SPOT, this));
				messageSignal.dispatch(MessageEvent.SHOW_MIN_SPOT,this);
			}
		}

		private function rollOut(evt:MouseEvent):void {
			//dispatchEvent(new HighlightEvent(HighlightEvent.REMOVE_HIGHLIGHT, name));
			removeHighlight();
		}

		public function highlightSpot():void {
			highlight.alpha = 0.5;
		}

		public function removeHighlight():void {
			highlight.alpha = 0;
		}

		public function addChip(chip:Betchip):void{
			chipHolder.addChild(chip);
			chipHolder.setChildIndex(chip,chipHolder.numChildren-1);

		}
		public function placeChip(evt:MouseEvent):void {
			placeBetOnTable(chipSelected);
		}
		
		public function updateBet(value:Number):void {
			chipValue += value;
			chipsPlaced.push(value);
		}

		public function clean():void {
			chipsPlaced = [];
			chipValue = 0;
			_chips.removeChildren();
		}
		public function placeBetOnTable(value:Number):void {
			var newValue:Number = chipValue + value;
			var totalBetPlaced:Number = (parent as BetSpotsView).getTotalBet() + value;
			debug(newValue,totalBetPlaced,balance);
			
			if(totalBetPlaced <= balance && balance > 0) {
				if(newValue <= max) {
					updateBet(value);
					//dispatchEvent(new BetEvent(BetEvent.UPDATE_BET, name));
					updateBetSignal.dispatch(this);
				}
				else {
					//dispatchEvent(new MessageEvent(MessageEvent.SHOW_MAX_SPOT, this));
					messageSignal.dispatch(MessageEvent.SHOW_MAX_SPOT,this)
				}				
			}
			else {
				//dispatchEvent(new MessageEvent(MessageEvent.SHOW_NOT_ENOUGH_MONEY, this));
				messageSignal.dispatch(MessageEvent.SHOW_MAX_SPOT,this);
			}
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
				chipHolder.removeChildAt(chipHolder.numChildren-1);
				
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
		
		public function get balance():Number {
			return _balance;
		}
		
		public function set balance(value:Number):void {
			_balance = value;
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
			mouseEnabled = false;
			buttonMode = false;
			removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, placeChip);
			blinkMc.visible=false;
		}

		public function enable():void {
			mouseEnabled = true;
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER, rollOver);
			addEventListener(MouseEvent.ROLL_OUT, rollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, placeChip);		
			blinkMc.visible=true;
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