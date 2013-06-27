package com.newco.grand.lobby.classic.model
{
	public class TableModel
	{
		private var _tableName:String;
		private var _tableid:String;
		private var _vtid:String;
		private var _dealerName:String;
		private var _gameType:String;
		private var _game:String;
		private var _max:Number;
		private var _min:Number;
		private var _timings:String;
		public function TableModel()
		{
		}
		
		public function loadFromXML(data:XML):void{
			_tableName=data.@name;
			_tableid=data.@table_id;
			_vtid=data.@vt_id;
			_dealerName=data.@dealer;
			_gameType=data.@game_type;
			_game=data.@game;
			_max=data.@max;
			_min=data.@min;
			_timings=data.@timings;
		}
		
		public function get tableName():String{
			return _tableName;
		}
		public function get tableid():String{
			return _tableid;
		}
		public function get vtid():String{
			return _vtid;
		}
		public function get dealerName():String{
			return _dealerName;
		}
		public function get gameType():String{
			return _gameType;
		}
		public function get game():String{
			return _game;
		}
		public function get max():Number{
			return _max;
		}
		public function get min():Number{
			return _min;
		}
		public function get timings():String{
			return _timings;
		}
	}
}