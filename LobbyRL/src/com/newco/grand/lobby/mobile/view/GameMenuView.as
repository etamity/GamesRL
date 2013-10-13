package com.newco.grand.lobby.mobile.view
{
	import com.newco.grand.core.common.view.SMButton;
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;

	public class GameMenuView extends GameMenuAsset
	{
		public var baccaratBtn:SMButton;
		public var rouletteBtn:SMButton;
		public var blackjackBtn:SMButton;
		
		public var gameSingal:Signal=new Signal();
		public function GameMenuView()
		{
			super();
			
			baccaratBtn=new SMButton(baccarat);
			rouletteBtn=new SMButton(roulette);
			blackjackBtn=new SMButton(blackjack);
			blackjackBtn.enabled=false;
			baccarat.addEventListener(MouseEvent.CLICK,selectGame);
			roulette.addEventListener(MouseEvent.CLICK,selectGame);
			blackjack.addEventListener(MouseEvent.CLICK,selectGame);
			baccaratLabel.mouseEnabled=false;
			rouletteLabel.mouseEnabled=false;
			blackjackLabel.mouseEnabled=false;
			visible=false;
		}
		
		private function selectGame(evt:MouseEvent):void{
			var target:SimpleButton=evt.target as SimpleButton;
			visible=false;
			gameSingal.dispatch(target.name);
		}
		public function updateLanguage():void{
			
		}
	}
}