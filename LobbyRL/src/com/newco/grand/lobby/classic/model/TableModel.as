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
		
		private var _streamSever:String;
		private var _streamApplication:String;
		private var _streamName:String;
		private var _streamMode:String;
		
		private var _xml:XML;
		
		public function TableModel()
		{

		}
		public function setStreamPath(val:String):void{
			var streams:Array=val.split("/");
			_streamSever = streams[0];
			_streamApplication= streams[1];
			
			//_streamName= streams[2];
		}
		
		public function set streamMode(val:String):void{
			_streamMode=val;
		}
		public function get streamMode():String{
			return _streamMode;
		}
		public function setData(data:XML):void{
			_tableName=data.@name;
			_streamName=data.@streamName;
			_tableid=data.@table_id;
			_vtid=data.@vt_id;
			_dealerName=data.@dealer;
			_gameType=data.@game_type;
			_max=data.@max;
			_min=data.@min;
			_timings=data.@timings;
			_xml=data;
			//trace("tablexml",data);
		}
		public function get xml():XML{
			return _xml;
		}
		public function get streamSever():String{
			return _streamSever;
		}		
		public function get streamApplication():String{
			return _streamApplication;
		}		
		public function get streamName():String{
			return _streamName;
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
		public function set game(val:String):void{
			_game=val;
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