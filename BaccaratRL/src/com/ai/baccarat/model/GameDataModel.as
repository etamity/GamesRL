package com.ai.baccarat.model {
	import com.ai.core.model.GameData;
	
	public class GameDataModel extends GameData {
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