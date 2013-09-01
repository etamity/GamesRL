package com.newco.grand.baccarat.classic.view {
	
	import com.newco.grand.baccarat.classic.model.BaccaratConstants;
	import com.newco.grand.baccarat.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.HighlightEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.BetSpot;
	import com.newco.grand.core.common.view.Betchip;
	import com.newco.grand.core.utils.FormatUtils;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class BetSpotsView extends Sprite implements IBetSpotsView{
		private var _betspotMC:BetSpot;
		private var _betchipMC:Betchip;
		private var _chipsPlacedOrder:Array = [];
		private var _lastChipsPlacedOrder:Array = [];
		private var _betBatch:Object;
		private var _betSpotsName:Array;
		private var _repeat:Boolean = false;
		private var _payouts:Array;
		private var _betSpotsArray:Array;
		private var _betSpotHash:Dictionary;
		private var _multiChips:Boolean=false;
		
		private var _signalBus:SignalBus=new SignalBus();
		
		
		private var _chipSelecedValue:Number=0;
		private var _balance:Number=0;
		protected var _display:*;
		public function BetSpotsView() {
			initDisplay();
			_betSpotsArray=new Array();
			_betSpotsName = new Array(
				BaccaratConstants.PLAYER, 
				BaccaratConstants.BANKER, 
				BaccaratConstants.TIE,
				BaccaratConstants.PAIRPLAYER, 
				BaccaratConstants.PAIRBANKER
			);
			_payouts = new Array(2, 1.95, 9, 12, 12);
			_betSpotHash=new Dictionary();
			hideSpotsMc();
			visible = false;
			_display.stop();
		}
		
		public function get signalBus():SignalBus{
			return _signalBus;
		}
		public function initDisplay():void{
			_display= new BetSpotsAsset();
			addChild(_display);
		}
		public function get display():*{
			return this;
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
			_display.gotoAndStop(label);
			createBetSpots();
			disableBetting();
		}
		
		public function set multiChips(value:Boolean):void{
			 _multiChips=value;
		}
		public function init():void {
			align();
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
				betspot=MovieClip(_display.getChildByName("spot_" + _betSpotsName[i]));
				betspot.visible=false;
			}
		}
		
		public function align():void {			
			visible = true;
			x=x-200;
			
		}
		
		
		private function createBetSpots():void {
			var betspot:MovieClip;
			var betspotmc:BetSpot;
			var mc:MovieClip;
			for (var i:uint = 0; i < _betSpotsName.length; i++) {
				betspot=MovieClip(_display.getChildByName("spot_" + _betSpotsName[i]));
				betspotmc = new BetSpot(new BetSpotAsset());
				betspotmc.name = _betSpotsName[i];
				betspotmc.display.transform.matrix= betspot.transform.matrix;
				betspotmc.display.highlight.visible=false;
				betspotmc.x = betspot.x;
				betspotmc.y = betspot.y;
				betspotmc.display.visible=true;
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
			//messageSignal.dispatch(type,target);
			_signalBus.dispatch(type,{target:target});
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
			//updateBetSignal.dispatch(target);
			_signalBus.dispatch(BetEvent.UPDATE_BET ,{target:target});
		}
		
		private function highlight(target:String):void {
			//dispatchEvent(event);
			//hightLightSignal.dispatch(target);
			_signalBus.dispatch(HighlightEvent.HIGHLIGHT,{target:target});
		}
		
		private function removeHighlight(target:String):void {
			//removeLightSignal.dispatch(target);
			_signalBus.dispatch(HighlightEvent.REMOVE_HIGHLIGHT,{target:target});
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
			//makeBetsignal.dispatch(value);
			_signalBus.dispatch(BetEvent.MAKEBET,{side:value});
		} 
		
		public function set chipSelecedValue(value:Number):void {
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
		
		public function getBetspotAmount(side:String):Number{
			_betspotMC = getBetspotByName(side);
			return _betspotMC.chipValue;
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}


