package com.ai.baccarat.classic.view {
	
	import com.ai.baccarat.classic.model.BaccaratConstants;
	import com.ai.core.utils.FormatUtils;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.BetSpot;
	import com.ai.core.view.Betchip;
	import com.ai.core.view.interfaces.IBetSpotsView;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;

	public class BetSpotsView extends BetSpotsAsset implements IBetSpotsView{
		private var _betspotMC:BetSpot;
		private var _betchipMC:Betchip;
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
		private var _chipSelecedValue:Number=0;
		private var _balance:Number=0;
		
		public function BetSpotsView() {
			_betSpotsArray=new Array();
			_betSpotsName = new Array("player", "banker", "tie", "pair_player", "pair_banker");
			_payouts = new Array(2, 1.95, 9, 12, 12);
			_betSpotHash=new Dictionary();
			hideSpotsMc();
			visible = false;
			stop();
		}

		public function get chipSelecedValue():Number{
			return _chipSelecedValue;
		}
			
		public function get balance():Number{
			return _balance;
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
				_betspotMC = _betSpotsArray[i];
				dictionary[_betspotMC.name] = new Point(_betspotMC.x,_betspotMC.y);
				
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
				betspotmc = new BetSpot(new BetSpotAsset());
				betspotmc.name = _betSpotsName[i];
				betspotmc.display.transform.matrix= betspot.transform.matrix;
				betspotmc.display.highlight.visible=false;
				betspotmc.x = betspot.x;
				betspotmc.y = betspot.y;
				betspot.visible=false;
				addChild(betspotmc.display);
				_betSpotsArray.push(betspotmc);
				_betSpotHash[_betSpotsName[i]]=betspotmc;
				
				betspotmc.updateBetSignal.add(updateBet);
				betspotmc.messageSignal.add(setMessage);
				
			}
			
		}
		
		private function setMessage(type:String,target:BetSpot):void {
			//dispatchEvent(event);
			messageSignal.dispatch(type,target);
		}
		
		private function getBetspotByName(val:String):BetSpot{
			return _betSpotHash[val] as BetSpot;
		}
		private function updateChipBet(target:String):void {
			_betspotMC = getBetspotByName(target);
			_betspotMC.placeBetOnTable(_chipSelecedValue);
		}

		private function updateBet(target:BetSpot):void {
			if(!_repeat) {
				_chipsPlacedOrder.push(target.name);
			}
			createChip(target.name);
			updateBetSignal.dispatch(target);
		}
		
		private function highlight(target:String):void {
			//dispatchEvent(event);
			hightLightSignal.dispatch(target);
		}
		
		private function removeHighlight(target:String):void {
			removeLightSignal.dispatch(target);
		}
		
		
		public function highlightSpot(value:String):void {
			_betSpotHash[value].highlight();
			_betSpotHash[value].display.highlight.visible=false;
		}
		
		public function removeHighlightSpot(value:String):void {
			_betSpotHash[value].removeHighlight();
			_betSpotHash[value].display.highlight.visible=false;
		}
		public function getbetSpotByName(name:String):BetSpot{
			return _betSpotHash[name];
		}
		public function createChip(value:String):void {
			_betspotMC = getBetspotByName(value);
			_betchipMC=_betspotMC.mainChip;
			if (_betchipMC==null)
			{
			_betchipMC = new Betchip();
			_betchipMC.name = value + "chip";
			_betspotMC.addChip(_betchipMC);

			_betchipMC.x =  - _betchipMC.width / 2;
			_betchipMC.y =  - _betchipMC.height / 2;
			_betchipMC.betchipSignal.add(updateChipBet);
			_betchipMC.hightLightSignal.add(highlight);
			_betchipMC.removeLightSignal.add(removeHighlight);
			
			_betchipMC.betspotName = _betspotMC.name;
			}
			_betchipMC.chipValue = _betspotMC.chipValue;
			_betchipMC.updateChipColor(_betspotMC.lastChipPlaced);
		} 
		
		public function set chipSelected(value:Number):void {
			_chipSelecedValue=value;
		}
		
		public function setLimits(i:int,min:int, max:int):void {
			_betspotMC = _betSpotsArray[i];
			if (_betspotMC != null) {
				_betspotMC.min = min;
				_betspotMC.max = max;
			}
		}
		
		public function set balance(value:Number):void {
			_balance=value;
		}
		
		public function createBet(value:int, i:int):void {
			_betspotMC =  _betSpotsArray[i];
			_betspotMC.placeBetOnTable(value);
		}
		
		
		public function getWinnings(code:String):Number {
			var index:int =int(code);
			_betspotMC =  _betSpotsArray[index];
			_betchipMC = Betchip(_betspotMC.mainChip);
			if (_betspotMC != null && _betchipMC != null) {
				_betchipMC.chipValue = _betspotMC.chipValue * _payouts[index];
				_betchipMC.updateChipColor(999);
				return _betspotMC.chipValue * _payouts[index];
			}
			return 0;
		}
		public function getPairsWinnings(code:String):Number {
			var index:int =int(code);
			_betspotMC =  _betSpotsArray[index];
			_betchipMC =Betchip(_betspotMC.mainChip);
			if (_betspotMC != null && _betchipMC != null) {
				_betchipMC.chipValue = _betspotMC.chipValue * _payouts[index];
				_betchipMC.updateChipColor(999);
				return _betspotMC.chipValue * _payouts[index];
			}
			return 0;
		}
		
		public function undo():void {
			if(_chipsPlacedOrder.length > 0) {
				var lastBet:String = _chipsPlacedOrder[_chipsPlacedOrder.length - 1];
				_betspotMC =getbetSpotByName(lastBet);
				_betchipMC=_betspotMC.mainChip;
				_betspotMC.undo();
				_chipsPlacedOrder.pop();
				_betchipMC.chipValue = _betspotMC.chipValue;
				_betchipMC.updateChipColor(_betspotMC.lastChipPlaced);
				if (_betspotMC.chipValue==0)
					_betspotMC.clean();
			}
			else {
				clearBets();
			}

		}
		
		public function repeat():void {
			_repeat = true;
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspotMC = _betSpotsArray[i];
				if(_betspotMC != null && _betspotMC.lastBet > 0) {					
					_betspotMC.repeat();
				}
			}
			_repeat = false;
		}
		
		public function double():void {
			_repeat = true;
			for (var i:int = 0; i <  _betSpotsArray.length; i++) {
				_betspotMC = _betSpotsArray[i];
				if(_betspotMC != null && _betspotMC.lastBet > 0) {
					_betspotMC.double();
				} 
			}
			_repeat = false;
		}
		
		public function get betString():String {
			_betBatch = {};
			var betBatchString:String = "";
			var bet:Number;
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspotMC = _betSpotsArray[i];
				if(_betspotMC.chipValue>0) {
					bet = FormatUtils.floatCorrection(_betspotMC.chipValue);
					if (bet > 0 && bet >= _betspotMC.min) {
						betBatchString += "&" + i + "=" + bet;
						_betspotMC.lastBet = bet;
						betBatch[i] = true;
					}
					else {
						_betspotMC.lastBet = 0;
						_betspotMC.clean();
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
				_betspotMC = _betSpotsArray[i];
				if(_betspotMC != null) {
					bet += _betspotMC.lastBet;
				}
			}
			debug("LAST BET: " + bet);
			return bet;
		}
		
		public function enableBetting():void {
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspotMC = _betSpotsArray[i];
				_betspotMC.enable();
				_betspotMC.display.highlight.visible=true;
			}

		}
		
		public function disableBetting():void {
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspotMC = _betSpotsArray[i];
				_betspotMC.disable();
				_betspotMC.display.highlight.visible=false;
			}
		}
		
		public function clearBets():void {
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
					_betspotMC = _betSpotsArray[i];
					_betspotMC.clean();
			}
			_chipsPlacedOrder = [];
			//_winMarkerMC.visible = false;
			_repeat = false;
		}
		
		public function getTotalBet():Number {
			var bet:Number = 0;
			for (var i:int = 0; i < _betSpotsArray.length; i++) {
				_betspotMC = _betSpotsArray[i];
				bet += _betspotMC.chipValue;
				
			}
			return bet;
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}


