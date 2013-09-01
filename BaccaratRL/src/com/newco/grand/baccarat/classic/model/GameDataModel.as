package com.newco.grand.baccarat.classic.model {
	import com.newco.grand.core.common.model.GameData;
	
	public class GameDataModel extends GameData {
		
		private var _player_bet_min:Number=1;
		private var _player_bet_max:Number=1000;
		
		private var _banker_bet_min:Number=1;
		private var _banker_bet_max:Number=1000;
		
		private var _tie_bet_min:Number=1;
		private var _tie_bet_max:Number=1000;
		
		private var _player_pairs_bet_min:Number=1;
		private var _player_pairs_bet_max:Number=1000;
		
		private var _banker_pairs_bet_min:Number=1;
		private var _banker_pairs_bet_max:Number=1000;
		
		public var idle_limit_games:int=10;
	
		public function get _pairsbanker_min_bet():Number{
			return _banker_pairs_bet_min;
		}
		public function get pairs_banker_max_bet():Number{
			return _banker_pairs_bet_max;
		}
		
		
		public function get player_min_bet():Number{
			return _player_bet_min;
		}
		public function get player_max_bet():Number{
			return _player_bet_max;
		}
		public function get banker_min_bet():Number{
			return _banker_bet_min;
		}
		public function get banker_max_bet():Number{
			return _banker_bet_max;
		}
		public function get tie_min_bet():Number{
			return _tie_bet_min;
		}
		public function get tie_max_bet():Number{
			return _tie_bet_max;
		}
		public function get pairs_player_min_bet():Number{
			return _player_pairs_bet_min;
		}
		public function get pairs_player_max_bet():Number{
			return _player_pairs_bet_max;
		}

		
		public function set _pairsbanker_min_bet(val:Number):void{
			_banker_pairs_bet_min=val;
		}
		public function set pairs_banker_max_bet(val:Number):void{
			_banker_pairs_bet_max=val;
		}
		
		
		public function set player_min_bet(val:Number):void{
			 _player_bet_min=val;
		}
		public function set player_max_bet(val:Number):void{
			_player_bet_max =val;
		}
		public function set banker_min_bet(val:Number):void{
			_banker_bet_min=val;
		}
		public function set banker_max_bet(val:Number):void{
			_banker_bet_max=val;
		}
		public function set tie_min_bet(val:Number):void{
			_tie_bet_min=val;
		}
		public function set tie_max_bet(val:Number):void{
			_tie_bet_max =val;
		}
		public function set pairs_player_min_bet(val:Number):void{
			_player_pairs_bet_min=val;
		}
		public function set pairs_player_max_bet(val:Number):void{
			_player_pairs_bet_max=val;
		}
		public function getBespotName(code:String):String{
			var betspotName:String;
			switch (code)
			{
				case "0":
					betspotName=BaccaratConstants.PLAYER;
					break;
				case "1":
					betspotName=BaccaratConstants.BANKER;
					break;
				case "2":
					betspotName=BaccaratConstants.TIE;
					break;
				case "3":
					betspotName=BaccaratConstants.PAIRPLAYER;
					break;
				case "4":
					betspotName=BaccaratConstants.PAIRBANKER;
					break;
			}
			return betspotName;
		}
		
		public function getBespotIndex(side:String):int{
			var index:int;
			switch (side)
			{
				case BaccaratConstants.PLAYER:
					index=0;
					break;
				case BaccaratConstants.BANKER:
					index=1;
					break;
				case BaccaratConstants.TIE:
					index=2;
					break;
				case BaccaratConstants.PAIRPLAYER:
					index=3;
					break;
				case BaccaratConstants.PAIRBANKER:
					index=4;
					break;
			}
			return index;
		}
	}
}