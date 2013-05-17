package com.ai.baccarat.classic.view {
	
	import com.ai.baccarat.classic.model.BaccaratConstants;
	import com.ai.core.utils.FormatUtils;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.Betchip;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;

	public class BetSpotsView extends BetSpotsAsset implements IBetSpotsView{
		private var _betspot:BetSpot;
		private var _betchip:Betchip;
		//private var _winMarkerMC:WinMarker;
		private var _chipsPlacedOrder:Array = [];
		private var _lastChipsPlacedOrder:Array = [];
		private var _betBatch:Object;
		private var _betSpotsName:Array;
		private var _repeat:Boolean = false;
		private var _payouts:Array;
		private var _betSpotsArray:Array;
		private var _betSpotHash:Dictionary;
		private var _multiChips:Boolean=false;
		
		public var messageSignal:Signal=new Signal();
		public var updateBetSignal:Signal=new Signal();
		public var hightLightSignal:Signal=new Signal();
		public var removeLightSignal:Signal=new Signal();
		

		
		public function BetSpotsView() {
			_betSpotsArray=new Array();
			_betSpotsName = new Array("player", "banker", "tie", "pair_player", "pair_banker");
			_payouts = new Array(2, 1.95, 9, 12, 12);
			_betSpotHash=new Dictionary();
			hideSpotsMc();
			visible = false;
			stop();
		}

		public function get multiChips():Boolean{
			return _multiChips;
		}
		
		
		public function setMode(mode:String="pairs"):void{
			var label:String;
			switch (mode){
				case BaccaratConstants.TYPE_CLASSIC:
					_betSpotsName.pop();
					_betSpotsName.pop();
					label=mode;
				break;
				case BaccaratConstants.TYPE_DRAGONTIGER:
					_betSpotsName.pop();
					_betSpotsName.pop();
					_payouts = new Array(2, 2, 8);
					label=mode;
					break;
				case BaccaratConstants.TYPE_PAIRS:
					_payouts = new Array(2, 1.95, 9, 12, 12);
					label=mode;
					break;
				default:
					_betSpotsName.pop();
					_betSpotsName.pop();
					label=BaccaratConstants.TYPE_CLASSIC;
					break;
			}
			gotoAndStop(label);
			createBetSpots();
			disableBetting();
		}
		
		public function set multiChips(value:Boolean):void{
			 _multiChips=value;
		}
		public function init():void {
			align();
			debug("createBetSpots");
		}
		
		public function registerPoints(dictionary:Dictionary):void{
			for (var i:uint = 0; i < _betSpotsName.length; i++) {
				_betspot = _betSpotsArray[i];
				dictionary[_betspot.name] = new Point(_betspot.x,_betspot.y);
				
			}
		}
		
		private function hideSpotsMc():void{
			
			var betspot:MovieClip;
			for (var i:uint = 0; i < _betSpotsName.length; i++) {
				betspot=MovieClip(getChildByName("spot_" + _betSpotsName[i]));
				betspot.visible=false;
			}
		}
		
		public function align():void {			
			visible = true;
		}
		
		
		private function createBetSpots():void {
			var betspot:MovieClip;
			var betspotmc:BetSpot;
			for (var i:uint = 0; i < _betSpotsName.length; i++) {
				betspot=MovieClip(getChildByName("spot_" + _betSpotsName[i]));
				betspotmc = new BetSpot();
				betspotmc.name = _betSpotsName[i];
				betspotmc.transform.matrix= betspot.transform.matrix;
				betspotmc.x = betspot.x;
				betspotmc.y = betspot.y;
				betspot.visible=false;
				addChild(betspotmc);
				_betSpotsArray.push(betspotmc);
				_betSpotHash[_betSpotsName[i]]=betspotmc;
				
				/*betspotmc.addEventListener(BetEvent.UPDATE_BET, updateBet);
		
				betspotmc.addEventListener(MessageEvent.SHOW_NOT_ENOUGH_MONEY, setMessage);
				betspotmc.addEventListener(MessageEvent.SHOW_MIN_SPOT, setMessage);
				betspotmc.addEventListener(MessageEvent.SHOW_MAX_SPOT, setMessage);*/
				betspotmc.updateBetSignal.add(updateBet);
				betspotmc.messageSignal.add(setMessage);
				
			}
			
		}
		
		private function setMessage(type:String,target:BetSpot):void {
			//dispatchEvent(event);
			messageSignal.dispatch(type,target);
		}
		
		
		private function updateChipBet(target:BetSpot):void {
			_betspot = BetSpot(getChildByName(target.name));
			_betspot.placeBetOnTable(_betspot.chipSelected);
		}

		private function updateBet(target:BetSpot):void {
			if(!_repeat) {
				_chipsPlacedOrder.push(target.name);
			}
			createChip(target.name);
			updateBetSignal.dispatch(target);
		}
		
		private function highlight(target:Betchip):void {
			//dispatchEvent(event);
			hightLightSignal.dispatch(target);
		}
		
		private function removeHighlight(target:Betchip):void {
			removeLightSignal.dispatch(target);
		}
		
		
		public function highlightSpot(value:String):void {
			_betSpotHash[value].highlight();
		}
		
		public function removeHighlightSpot(value:String):void {
			_betSpotHash[value].removeHighlight();
		}
		public function getbetSpotByName(name:String):BetSpot{
			return _betSpotHash[name];
		}
		public function createChip(value:String):void {
			_betspot = _betSpotHash[value];

			_betchip = new Betchip();
			_betchip.name = value + "chip";

			_betchip.scaleX=1.3;

			//_betchip.addEventListener(BetEvent.CHIP_BET, updateChipBet);
			//_betchip.addEventListener(HighlightEvent.HIGHLIGHT, highlight);
			//_betchip.addEventListener(HighlightEvent.REMOVE_HIGHLIGHT, removeHighlight);
			_betchip.betchipSignal.add(updateChipBet);
			_betchip.hightLightSignal.add(highlight);
			_betchip.removeLightSignal.add(removeHighlight);

			_betchip.x = - _betchip.width / 2;
			_betchip.y =(multiChips==true)? ((- _betchip.height / 2)-_betspot.chipHolder.numChildren* 5): (- _betchip.height / 2);
			_betchip.betspotName = _betspot.name;
			_betchip.chipValue = _betspot.chipValue;
			_betchip.updateChipColor(_betspot.lastChipPlaced);
			_betspot.addChip(_betchip);
		} 
		
		public function set chipSelected(value:Number):void {
			for (var i:uint = 0; i < _betSpotsArray.length; i++) {
					_betspot = _betSpotsArray[i];
					_betspot.chipSelected = value;

			}
		}
		
		public function setLimits(min:int, max:int):void {
			for (var i:uint = 0; i < _betSpotsArray.length; i++) {
			_betspot = _betSpotsArray[i];
				if (_betspot != null) {
					_betspot.min = min;
					_betspot.max = max;
				}
			}
		}
		
		public function set balance(value:Number):void {
			for (var i:uint = 0; i < _betSpotsArray.length; i++) {
					_betspot = _betSpotsArray[i];
					_betspot.balance = value;
		
			}
		}
		
		public function createBet(value:int, i:int):void {
			_betspot =  _betSpotsArray[i];
			_betspot.placeBetOnTable(value);
		}
		
		
		public function getWinnings(code:String):Number {
			var index:int =int(code);
			_betspot =  _betSpotsArray[index];
			_betchip = _betspot.mainChip;
			if (_betspot != null && _betchip != null) {
				_betchip.chipValue = _betspot.chipValue * _payouts[index];
				_betchip.updateChipColor(999);
				return _betspot.chipValue * _payouts[index];
			}
			return 0;
		}
		public function getPairsWinnings(code:String):Number {
			var index:int =int(code);
			_betspot =  _betSpotsArray[index];
			_betchip = _betspot.mainChip;
			if (_betspot != null && _betchip != null) {
				_betchip.chipValue = _betspot.chipValue * _payouts[index];
				_betchip.updateChipColor(999);
				return _betspot.chipValue * _payouts[index];
			}
			return 0;
		}
		
		public function undo():void {
			if(_chipsPlacedOrder.length > 0) {
				var lastBet:String = _chipsPlacedOrder[_chipsPlacedOrder.length - 1];
				_betspot = BetSpot(getChildByName(lastBet));
				_betspot.undo();
				_chipsPlacedOrder.pop();
			}
			else {
				clearBets();
			}
		}
		
		public function repeat():void {
			_repeat = true;
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspot = _betSpotsArray[i];
				if(_betspot != null && _betspot.lastBet > 0) {					
					_betspot.repeat();
				}
			}
			_repeat = false;
		}
		
		public function double():void {
			_repeat = true;
			for (var i:int = 0; i <  _betSpotsArray.length; i++) {
				_betspot = _betSpotsArray[i];
				if(_betspot != null && _betspot.lastBet > 0) {
					_betspot.double();
				} 
			}
			_repeat = false;
		}
		
		public function get betString():String {
			_betBatch = {};
			var betBatchString:String = "";
			var bet:Number;
			for (var i:int = 0; i < _betSpotsName.length; i++) {
				_betspot = _betSpotsArray[i];
				if(_betspot.chipHolder.numChildren>0) {
					bet = FormatUtils.floatCorrection(_betspot.chipValue);
					if (bet > 0 && bet >= _betspot.min) {
						betBatchString += "&" + i + "=" + bet;
						_betspot.lastBet = bet;
						betBatch[i] = true;
					}
					else {
						_betspot.lastBet = 0;
						_betspot.clean();
						betBatch[i] = false;
					}
				}
			}
			return betBatchString;
		}
		
		public function get betBatch():Object {
			return _betBatch
		}
		
		public function get lastBet():Number {
			var bet:Number = 0;
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspot = _betSpotsArray[i];
				if(_betspot != null) {
					bet += _betspot.lastBet;
				}
			}
			debug("LAST BET: " + bet);
			return bet;
		}
		
		public function enableBetting():void {
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspot = _betSpotsArray[i];
				_betspot.enable();

			}

		}
		
		public function disableBetting():void {
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspot = _betSpotsArray[i];
				_betspot.disable();
			}
		}
		
		public function clearBets():void {
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspot = _betSpotsArray[i];
					_betspot = _betSpotsArray[i];
					_betspot.clean();
			}
			_chipsPlacedOrder = [];
			//_winMarkerMC.visible = false;
			_repeat = false;
		}
		
		public function getTotalBet():Number {
			var bet:Number = 0;
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspot = _betSpotsArray[i];
				bet += _betspot.chipValue;
				
			}
			return bet;
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}


