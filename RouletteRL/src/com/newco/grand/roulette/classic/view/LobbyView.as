package com.newco.grand.roulette.classic.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class LobbyView extends LobbyAsset
	{
		public function LobbyView()
		{
			visible = false;
			
			closeButton.addEventListener(MouseEvent.CLICK, closeClick);
			closeButton.buttonMode = true;
		}
		
		private function closeClick(evt:MouseEvent):void {
			visible = false;
		}
		
		public function set lobby(value:MovieClip):void {
			addChild(value);
		}
		
	}
}