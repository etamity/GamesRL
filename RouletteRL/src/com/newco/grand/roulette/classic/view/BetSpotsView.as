package com.newco.grand.roulette.classic.view {
	
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.HighlightEvent;
	import com.newco.grand.core.common.view.BetSpot;
	import com.newco.grand.core.common.view.Betchip;
	import com.newco.grand.roulette.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.core.utils.FormatUtils;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	public class BetSpotsView extends BetspotsAsset implements IBetSpotsView{
		
		public const SPOTS:Number = 166;
		public const NEIGHBOUR_SPOTS:Number = 39;
		
		private var _betspotMC:BetSpot;
		private var _betchipMC:Betchip;
		private var _winMarkerMC:WinMarker;
		private var _chipsPlacedOrder:Array = [];
		private var _lastChipsPlacedOrder:Array = [];
		private var _betBatch:Object;
		
		private var _repeat:Boolean = false;
		
		private var _messageSignal:Signal=new Signal();
		private var _updateBetSignal:Signal=new Signal();
		private var _hightLightSignal:Signal=new Signal();
		private var _removeLightSignal:Signal=new Signal();
		
		
		
		private var _neighbourBetsSignal:Signal=new Signal();
		private var _higilightNeighbourSignal:Signal=new Signal();
		private var _removeNeighbourSignal:Signal=new Signal();
		
		private var _chipSelecedValue:Number=0;
		private var _balance:Number=0;
		
		private var _betspotsHash:Dictionary=new Dictionary();
		public function BetSpotsView() {
			createBetspots();
			specialBetsMC.visible = false;
			visible = false;
		}
		public function get updateBetSignal():Signal{
			return _updateBetSignal;
		}
		public function get messageSignal():Signal{
			return _messageSignal;
		}
		public function get neighbourBetsSignal():Signal{
			return _neighbourBetsSignal;
		}
		public function get hightLightSignal():Signal{
			return _hightLightSignal;
		}
		public function get removeLightSignal():Signal{
			return _removeLightSignal;
		}
		public function get display():*{
			return this;
		}
		public function initDisplay():void{
			
		}
		public function init():void {
			align();
		}
		
		public function align():void {			
			//x = 168;
			y = 235;
			visible = true;
		}

		public function get chipSelecedValue():Number{
			return _chipSelecedValue;
		}
		
		public function get balance():Number{
			return _balance;
		}
		public function set chipSelecedValue(val:Number):void{
			_chipSelecedValue =val;
		}
		public function placeFavouritesBets(betString:String):void{
			var betsArray:Array = betString.split("&");
			var value:Array;
			var bets:int;
			var amount:Number;
			var betSpotMc:BetSpot;
			for (var i:int=1;i<betsArray.length ;i++)
			{
				var test:String=betsArray[i];
				value= String(betsArray[i]).split("=");
				bets=int(value[0]);
				betSpotMc= getBetspotByName(("bs"+String(bets)));
				amount=int(value[1]);
				if(_betspotMC != null){
				betSpotMc.placeBetOnTable(amount);

				}
				
				
			}
		}
		private function getBetspotByName(val:String):BetSpot{
			return _betspotsHash[val] as BetSpot;
		}
		private function createBetspots():void {
			var stageSpot:MovieClip;
			for (var i:int = 2; i < SPOTS; i++) {
				if (getChildByName("dz" + i) != null) {
					stageSpot = MovieClip(getChildByName("dz" + i));
					_betspotMC = new BetSpot(new BetspotAsset());
					_betspotMC.name = "bs" + i;
					//_betspotMC.id=i;
					_betspotMC.display.name=_betspotMC.name;
					_betspotMC.display.transform.matrix = stageSpot.transform.matrix;
					_betspotsHash[_betspotMC.name]=_betspotMC;
					addChild(_betspotMC.display);					
					stageSpot.visible = false;

					_betspotMC.updateBetSignal.add(updateBet);
					_betspotMC.messageSignal.add(setMessage);
					_betspotMC.hightLightSignal.add(highlight);
					_betspotMC.removeLightSignal.add(removeHighlight);
				}
			}
			//getChildByName("bs2").mask = zeroMask;
			getBetspotByName("bs2").display.mask = zeroMask;
			_winMarkerMC = new WinMarker();
			_winMarkerMC.visible = false;
			addChild(_winMarkerMC);
			disableBetting();
		}
		
		private function setMessage(type:String,target:BetSpot):void {
			//dispatchEvent(event);
			messageSignal.dispatch(type,target);
		}
		
		private function placeNeighbourBets(evt:MouseEvent):void {
			//dispatchEvent(new BetEvent(BetEvent.NEIGHBOUR_BETS, evt.target.name));
			neighbourBetsSignal.dispatch(BetEvent.NEIGHBOUR_BETS,this);
		}
		
		private function updateChipBet(target:String):void {
			_betspotMC = getBetspotByName((target));
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

			_hightLightSignal.dispatch(target);
		}
		
		private function removeHighlight(target:String):void {

			_removeLightSignal.dispatch(target);
		}
		
		private function higilightNeighbour(evt:MouseEvent):void {

			_higilightNeighbourSignal.dispatch(HighlightEvent.HIGHLIGHT,this);
		}
		
		private function removeHigilightNeighbour(evt:MouseEvent):void {

			_removeNeighbourSignal.dispatch(HighlightEvent.REMOVE_HIGHLIGHT,this)
		}
		
		public function highlightSpot(value:String):void {
			getBetspotByName((value)).highlight();
		}
		
		public function removeHighlightSpot(value:String):void {
			getBetspotByName((value)).removeHighlight();
		}
		
		public function createChip(value:String):void {
			_betspotMC = getBetspotByName(value);
			_betchipMC=Betchip(getChildByName(value + "chip"));
			if (_betchipMC==null)
			{
				_betchipMC = new Betchip();
				_betchipMC.name = value + "chip";
				var bounds:Rectangle    = _betspotMC.display.getBounds(this);
				var boundCentreX:Number = bounds.x + bounds.width / 2;
				var boundCentreY:Number = bounds.y + bounds.height / 2;
				_betchipMC.x = boundCentreX - _betchipMC.width / 2;
				_betchipMC.y = boundCentreY - _betchipMC.height / 2;
				_betchipMC.betchipSignal.add(updateChipBet);
				_betchipMC.hightLightSignal.add(highlight);
				_betchipMC.removeLightSignal.add(removeHighlight);
				_betchipMC.betspotName = _betspotMC.name;
				addChild(_betchipMC);
		
				swapChildren(_betchipMC, getChildAt(numChildren - 1));
			}
			_betchipMC.updateChipColor(_betspotMC.lastChipPlaced);
			_betchipMC.chipValue = _betspotMC.chipValue;
		
		}
		
		public function set chipSelected(value:Number):void {
			_chipSelecedValue=value;
		}
		
		public function get chipSelected():Number {

			 return _chipSelecedValue;
		}
		
		
		public function setLimits(i:int, min:int, max:int):void {
			_betspotMC = getBetspotByName(("bs" + i));
			if (_betspotMC != null) {
				_betspotMC.min = min;
				_betspotMC.max = max;
			}
		}
		
		public function set balance(value:Number):void {
			/*for (var i:uint = 2; i < SPOTS; i++) {
				if (getChildByName("bs" + i) != null) {
					_betspotMC = getBetspotByName(("bs" + i));
				}
			}
			if (_betspotMC!=null)
			_betspotMC.balance = value;*/
			
			_balance=value;
		}
		
		public function createBet(value:int, i:int):void {
			_betspotMC = getBetspotByName("bs" + i);
			_betspotMC.placeBetOnTable(value);
		}
		
		public function getWinnings(i:int, payout:int):Number {
			_betspotMC = getBetspotByName("bs" + i);
			_betchipMC = Betchip(getChildByName("bs" + i + "chip"));
			if (_betspotMC != null && _betchipMC != null) {
				_betchipMC.chipValue = _betspotMC.chipValue * payout;
				_betchipMC.updateChipColor(999);
				return _betspotMC.chipValue * payout;
			}
			return 0;
		}
		
		public function showWinningNumber(i:int):void {
			_betspotMC = getBetspotByName(("bs" + i));
			var bounds:Rectangle    = _betspotMC.display.getBounds(this);
			var boundCentreX:Number = bounds.x + bounds.width / 2;
			var boundCentreY:Number = bounds.y + bounds.height / 2;
			_winMarkerMC.x = boundCentreX - _winMarkerMC.width / 2;
			_winMarkerMC.y = boundCentreY - _winMarkerMC.height / 2;
			_winMarkerMC.visible = true;
			swapChildren(_winMarkerMC, getChildAt(numChildren - 1));
		}
		
		public function undo():void {
			if(_chipsPlacedOrder.length > 0) {
				var lastBet:String = _chipsPlacedOrder[_chipsPlacedOrder.length - 1];
				_betspotMC = getBetspotByName(lastBet);
				_betspotMC.undo();
				_betchipMC = Betchip(getChildByName(lastBet + "chip"));
				if(_betspotMC.chipValue > 0) {
					_betchipMC.chipValue = _betspotMC.chipValue;
					_betchipMC.updateChipColor(_betspotMC.lastChipPlaced);
				}
				else {
					removeChild(_betchipMC);
				}
				_betchipMC.chipValue = _betspotMC.chipValue;
				_chipsPlacedOrder.pop();
			}
			else {
				clearBets();
			}
		}
		
		public function repeat():void {
			_repeat = true;
			for (var i:int = 2; i < SPOTS; i++) {
				_betspotMC = getBetspotByName("bs" + i);
				if(_betspotMC != null && _betspotMC.lastBet > 0) {					
					_betspotMC.repeat();
				}
			}
			_repeat = false;
		}
		
		public function double():void {
			_repeat = true;
			for (var i:int = 2; i < SPOTS; i++) {
				_betspotMC = getBetspotByName(("bs" + i));
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
			for (var i:int = 2; i < SPOTS; i++) {
				_betspotMC = getBetspotByName(("bs" + i));
				_betchipMC = Betchip(getChildByName("bs" + i + "chip"));
				if(_betchipMC != null) {
					bet = FormatUtils.floatCorrection(_betspotMC.chipValue);
					if (bet > 0 && bet >= _betspotMC.min) {
						betBatchString += "&" + i + "=" + bet;
						_betspotMC.lastBet = bet;
						betBatch[i] = true;
					}
					else {
						_betspotMC.lastBet = 0;
						_betspotMC.clean();
						removeChild(_betchipMC);
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
			for (var i:int = 2; i < SPOTS; i++) {
				_betspotMC = getBetspotByName(("bs" + i));
				if(_betspotMC != null) {
					bet += _betspotMC.lastBet;
				}
			}
			debug("LAST BET: " + bet);
			return bet;
		}
		
		public function enableBetting():void {
			for (var i:int = 2; i < SPOTS; i++) {
				_betspotMC = getBetspotByName(("bs" + i));
				if (_betspotMC != null) {
					_betspotMC.enable();
				}
			}
			for (i = 0; i <= NEIGHBOUR_SPOTS; i++) {
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).buttonMode = true;
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).addEventListener(MouseEvent.ROLL_OVER, higilightNeighbour);
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).addEventListener(MouseEvent.ROLL_OUT, removeHigilightNeighbour);
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).addEventListener(MouseEvent.CLICK, placeNeighbourBets);
			}
		}
		
		public function disableBetting():void {
			for (var i:int = 2; i < SPOTS; i++) {
				_betspotMC = getBetspotByName(("bs" + i));
				if (_betspotMC != null) {
					_betspotMC.disable();
					if(_betspotMC.chipsPlaced.length > 0) {

						_betchipMC = Betchip(getChildByName("bs" + i + "chip"));
						if (_betchipMC != null) {
							_betchipMC.disable();
						}
					}
				
				}
			}
			for (i = 0; i <= NEIGHBOUR_SPOTS; i++) {
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).buttonMode = false;
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).mouseChildren = false;
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).removeEventListener(MouseEvent.ROLL_OVER, higilightNeighbour);
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).removeEventListener(MouseEvent.ROLL_OUT, removeHigilightNeighbour);
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).removeEventListener(MouseEvent.CLICK, placeNeighbourBets);
				MovieClip(neighbourBetsMC.popup.getChildByName("nb" + i)).alpha = 0;
			}
		}
		
		public function clearBets():void {
			for (var i:int = 2; i < SPOTS; i++) {
				_betspotMC = getBetspotByName(("bs" + i));
				if (getChildByName("bs" + i + "chip") != null) {
					_betspotMC.clean();
					removeChild(getChildByName("bs" + i + "chip"));
				}
			}
			_chipsPlacedOrder = [];
			_winMarkerMC.visible = false;
			_repeat = false;
		}
		
		public function getTotalBet():Number {
			var bet:Number = 0;
			for (var i:int = 0; i < SPOTS; i++) {
				_betspotMC = getBetspotByName(("bs" + i));
				if (_betspotMC != null) {
					bet += _betspotMC.chipValue;
				}
			}
			return bet;
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}