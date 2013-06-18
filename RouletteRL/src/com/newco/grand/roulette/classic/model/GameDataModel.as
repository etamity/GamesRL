package com.newco.grand.roulette.classic.model {
	
	import com.ai.core.common.model.GameData;
	
	public class GameDataModel extends GameData {
		

		private var _dozenMin:Number;
		private var _dozenMax:int;
		private var _lowMin:Number;
		private var _lowMax:int;
		private var _highMin:Number;
		private var _highMax:int;
		private var _straightMin:Number;
		private var _straightMax:int;
		private var _evenMin:Number;
		private var _evenMax:int;
		private var _oddMin:Number;
		private var _oddMax:int;
		private var _columnMin:Number;
		private var _columnMax:int;
		private var _blackMin:Number;
		private var _blackMax:int;
		private var _redMin:Number;
		private var _redMax:int;
		private var _splitMin:Number;
		private var _splitMax:int;
		private var _trioMin:Number;
		private var _trioMax:int;
		private var _sixMin:Number;
		private var _sixMax:int;
		private var _fiveMin:Number;
		private var _fiveMax:int;
		private var _cornerMin:Number;
		private var _cornerMax:int;


		private var _result:Number;

		private var _recentResults:XMLList;

		
		public function get result():Number {
			return _result;
		}
		
		public function set result(value:Number):void {
			_result = value;
		}
		
		public function get recentResults():XMLList {
			return _recentResults;
		}
		
		public function set recentResults(value:XMLList):void {
			_recentResults = value;
		}

		public function get dozenMin():Number {
			return _dozenMin;
		}

		public function set dozenMin(value:Number):void {
			_dozenMin = value;
		}

		public function get dozenMax():int {
			return _dozenMax;
		}

		public function set dozenMax(value:int):void {
			_dozenMax = value;
		}

		public function get lowMin():Number {
			return _lowMin;
		}

		public function set lowMin(value:Number):void {
			_lowMin = value;
		}

		public function get lowMax():int {
			return _lowMax;
		}

		public function set lowMax(value:int):void {
			_lowMax = value;
		}

		public function get highMin():Number {
			return _highMin;
		}

		public function set highMin(value:Number):void {
			_highMin = value;
		}

		public function get highMax():int {
			return _highMax;
		}

		public function set highMax(value:int):void {
			_highMax = value;
		}

		public function get straightMin():Number {
			return _straightMin;
		}

		public function set straightMin(value:Number):void {
			_straightMin = value;
		}

		public function get straightMax():int {
			return _straightMax;
		}

		public function set straightMax(value:int):void {
			_straightMax = value;
		}

		public function get evenMin():Number {
			return _evenMin;
		}

		public function set evenMin(value:Number):void {
			_evenMin = value;
		}

		public function get evenMax():int {
			return _evenMax;
		}

		public function set evenMax(value:int):void {
			_evenMax = value;
		}

		public function get oddMin():Number {
			return _oddMin;
		}

		public function set oddMin(value:Number):void {
			_oddMin = value;
		}

		public function get oddMax():int {
			return _oddMax;
		}

		public function set oddMax(value:int):void {
			_oddMax = value;
		}

		public function get columnMin():Number {
			return _columnMin;
		}

		public function set columnMin(value:Number):void {
			_columnMin = value;
		}

		public function get columnMax():int {
			return _columnMax;
		}

		public function set columnMax(value:int):void {
			_columnMax = value;
		}

		public function get blackMin():Number {
			return _blackMin;
		}

		public function set blackMin(value:Number):void {
			_blackMin = value;
		}

		public function get blackMax():int {
			return _blackMax;
		}

		public function set blackMax(value:int):void {
			_blackMax = value;
		}

		public function get redMin():Number {
			return _redMin;
		}

		public function set redMin(value:Number):void {
			_redMin = value;
		}

		public function get redMax():int {
			return _redMax;
		}

		public function set redMax(value:int):void {
			_redMax = value;
		}

		public function get splitMin():Number {
			return _splitMin;
		}

		public function set splitMin(value:Number):void {
			_splitMin = value;
		}

		public function get splitMax():int {
			return _splitMax;
		}

		public function set splitMax(value:int):void {
			_splitMax = value;
		}

		public function get trioMin():Number {
			return _trioMin;
		}

		public function set trioMin(value:Number):void {
			_trioMin = value;
		}

		public function get trioMax():int {
			return _trioMax;
		}

		public function set trioMax(value:int):void {
			_trioMax = value;
		}

		public function get sixMin():Number {
			return _sixMin;
		}

		public function set sixMin(value:Number):void {
			_sixMin = value;
		}

		public function get sixMax():int {
			return _sixMax;
		}

		public function set sixMax(value:int):void {
			_sixMax = value;
		}

		public function get fiveMin():Number {
			return _fiveMin;
		}

		public function set fiveMin(value:Number):void {
			_fiveMin = value;
		}

		public function get fiveMax():int {
			return _fiveMax;
		}

		public function set fiveMax(value:int):void {
			_fiveMax = value;
		}		

		public function get cornerMin():Number {
			return _cornerMin;
		}

		public function set cornerMin(value:Number):void {
			_cornerMin = value;
		}

		public function get cornerMax():int {
			return _cornerMax;
		}

		public function set cornerMax(value:int):void {
			_cornerMax = value;
		}

	}
}