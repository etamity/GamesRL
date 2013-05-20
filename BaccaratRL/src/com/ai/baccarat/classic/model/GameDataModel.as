package com.ai.baccarat.classic.model {
	import com.ai.core.model.GameData;
	
	public class GameDataModel extends GameData {
		
		private var _player_bet_min_limit:Number=1;
		private var _player_bet_max_limit:Number=1000;
		
		private var _banker_bet_min_limit:Number=1;
		private var _banker_bet_max_limit:Number=1000;
		
		private var _tie_bet_min_limit:Number=1;
		private var _tie_bet_max_limit:Number=1000;
		
		private var _player_pairs_bet_min:Number=1;
		private var _player_pairs_bet_max:Number=1000;
		
		private var _banker_pairs_bet_min:Number=1;
		private var _banker_pairs_bet_max:Number=1000;
		
		
		public function get banker_pairs_bet_min():Number{
			return _banker_pairs_bet_min;
		}
		public function get banker_pairs_bet_max():Number{
			return _banker_pairs_bet_max;
		}
		
		
		public function get player_bet_min_limit():Number{
			return _player_bet_min_limit;
		}
		public function get player_bet_max_limit():Number{
			return _player_bet_max_limit;
		}
		public function get banker_bet_min_limit():Number{
			return _banker_bet_min_limit;
		}
		public function get banker_bet_max_limit():Number{
			return _banker_bet_max_limit;
		}
		public function get tie_bet_min_limit():Number{
			return _tie_bet_min_limit;
		}
		public function get tie_bet_max_limit():Number{
			return _tie_bet_max_limit;
		}
		public function get player_pairs_bet_min():Number{
			return _player_pairs_bet_min;
		}
		public function get player_pairs_bet_max():Number{
			return _player_pairs_bet_max;
		}

		
		public function set banker_pairs_bet_min(val:Number):void{
			_banker_pairs_bet_min=val;
		}
		public function set banker_pairs_bet_max(val:Number):void{
			_banker_pairs_bet_max=val;
		}
		
		
		public function set player_bet_min_limit(val:Number):void{
			 _player_bet_min_limit=val;
		}
		public function set player_bet_max_limit(val:Number):void{
			_player_bet_max_limit =val;
		}
		public function set banker_bet_min_limit(val:Number):void{
			_banker_bet_min_limit=val;
		}
		public function set banker_bet_max_limit(val:Number):void{
			_banker_bet_max_limit=val;
		}
		public function set tie_bet_min_limit(val:Number):void{
			_tie_bet_min_limit=val;
		}
		public function set tie_bet_max_limit(val:Number):void{
			_tie_bet_max_limit =val;
		}
		public function set player_pairs_bet_min(val:Number):void{
			_player_pairs_bet_min=val;
		}
		public function set player_pairs_bet_max(val:Number):void{
			_player_pairs_bet_max=val;
		}
		public function getBespotName(code:String):String{
			var betspotName:String;
			switch (code)
			{
				case "0":
					betspotName="player";
					break;
				case "1":
					betspotName="banker";
					break;
				case "2":
					betspotName="tie";
					break;
				case "3":
					betspotName="pair_player";
					break;
				case "4":
					betspotName="pair_banker";
					break;
			}
			return betspotName;
		}
	}
}