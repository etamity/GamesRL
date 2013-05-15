package com.ai.core.view {
	
	import flash.text.TextFormat;
	
	import fl.controls.UIScrollBar;
	public class PlayersView extends PlayersAsset {
		
		private var _players:XML;
		private var _txtFormat:TextFormat = new TextFormat("Arial", 12, 0xFFFFFF, false);
		private var Scroll:UIScrollBar= new UIScrollBar();
		public function PlayersView() {
			visible = false;
			Scroll.scrollTarget =playersTxt;
			Scroll.direction="vertical";
			Scroll.x=151;
			Scroll.y=7.2;
			Scroll.height=362.55;
			addChild(Scroll);
		}		
		
		public function init():void {			
			align();
		}
		
		public function align():void {
			visible = true;
			Scroll.visible=false;
		}

		public function get players():XML {
			return _players;
		}

		public function set players(value:XML):void {
			_players = value;
			showPlayers();
		}
		
		private function showPlayers():void {
			playersTxt.text = "";
			for each (var item:XML in players.user) {
				if (item != "onlinecasinolar o" )
				{
					playersTxt.appendText(item + "\n");
				}
			}
			playersTxt.scrollV += Math.ceil(playersTxt.length / 20);
			Scroll.update();
			playersTxt.setTextFormat(_txtFormat);
			if(playersTxt.selectable)
				playersTxt.selectable = false;
		}
	}
}