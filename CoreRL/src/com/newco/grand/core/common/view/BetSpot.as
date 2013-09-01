package com.newco.grand.core.common.view {

	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.view.interfaces.IBetSpotsViewCom;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class BetSpot{

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
		
		private var _asset:MovieClip;
		private var _name:String;
		
		private var _chipHolder:MovieClip=new MovieClip();
		
		private var _id:int;
		
		public function BetSpot(asset:MovieClip) {
			_asset=asset;
			chipsPlaced = [];
			chipValue = 0;
			lastBet = 0;
			_asset.buttonMode = true;
			_asset.mouseChildren = false;
			//_asset.alpha = 0;
			asset.addChild(_chipHolder);
		}

		public function id():int{
			return _id;
		}
		public function get mainChip():Betchip{
			var chip:Betchip=null;
			if (_chipHolder.numChildren>0)
				chip=(_chipHolder.getChildAt(_chipHolder.numChildren-1)) as Betchip;
			
			return chip; 
		}
		public function get x():Number{
			return _asset.x;
		}
		public function get y():Number{
			return _asset.y;
		}
		
		public function set x(val:Number):void{
			_asset.x =val;
		}
		public function set y(val:Number):void{
			_asset.y=val;
		}
		
		public function get display():MovieClip{
			 return _asset;
		}
		public function get name():String{
			return _name;
		}
		public function set name(val:String):void{
			_name=val;
			_asset.name=val;
		}
		
		public function get chipSelected():Number {
			var betspotView:IBetSpotsViewCom= _asset.parent as IBetSpotsViewCom;
			return betspotView.chipSelecedValue;
		}
		public function get balance():Number {
			var betspotView:IBetSpotsViewCom= _asset.parent as IBetSpotsViewCom;
			return betspotView.balance;
		}

		private function rollOver(evt:MouseEvent):void {
			hightLightSignal.dispatch(this.name);
			_asset.visible = true;
			if (chipValue > 0 && chipValue < min) {

				messageSignal.dispatch(MessageEvent.SHOW_MIN_SPOT,this);
			}
		}

		private function rollOut(evt:MouseEvent):void {

			removeLightSignal.dispatch(this.name);

		}

		public function placeChip(evt:MouseEvent):void {
			placeBetOnTable(chipSelected);
		}

		public function chipHolder():MovieClip{
			return _chipHolder;
		}
		public function addChip(chip:Betchip):void{
			_chipHolder.addChild(chip);
		}
		public function placeBetOnTable(value:Number):void {
			var newValue:Number = chipValue + value;
			var totalBetPlaced:Number = (_asset.parent as IBetSpotsViewCom).getTotalBet() + value;
			debug("totalBetPlaced",totalBetPlaced,"balance",balance,"newValue",newValue,"max",max);
			if(totalBetPlaced <= balance && balance > 0) {
				if(newValue <= max) {
				
					if (newValue >=min){
						updateBet(value);
						updateBetSignal.dispatch(this);
					}
					else{
						messageSignal.dispatch(MessageEvent.SHOW_MIN_SPOT ,this);
					}
				}
				else {
					messageSignal.dispatch(MessageEvent.SHOW_MAX_SPOT,this)
				}				
			}
			else {
				messageSignal.dispatch(MessageEvent.SHOW_NOT_ENOUGH_MONEY,this);
			}
		}
		
		public function updateBet(value:Number):void {
			chipValue += value;
			chipsPlaced.push(value);
		}

		public function clean():void {
			chipsPlaced = [];
			chipValue = 0;
			_chipHolder.removeChildren();
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
				
				_chipHolder.removeChildren();
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
			//removeHighlight();
			//_asset.visible = false;
			_asset.mouseEnabled = false;
			_asset.buttonMode = false;
			_asset.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			_asset.removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			_asset.removeEventListener(MouseEvent.MOUSE_DOWN, placeChip);
		}

		public function enable():void {
			//_asset.visible = true;
			_asset.mouseEnabled = true;
			_asset.buttonMode = true;
			_asset.addEventListener(MouseEvent.ROLL_OVER, rollOver);
			_asset.addEventListener(MouseEvent.ROLL_OUT, rollOut);
			_asset.addEventListener(MouseEvent.MOUSE_DOWN, placeChip);			
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