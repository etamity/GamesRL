package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.tournamenet.PlayerList;
	import com.newco.grand.baccarat.classic.view.tournamenet.TimerControl;
	
	import flash.events.Event;

	public class TournamentView extends TournamenetAsset
	{
		private var playerList:PlayerList;
		private var timerControl:TimerControl;
		public function TournamentView()
		{
		}
		
		public function loadXML(url:String):void{
			playerList = new PlayerList(url);
			playerList.y = 50;
			playerList.x = 3;
			addChild(playerList);
			
			timerControl = new TimerControl( new Date(2013, 06, 20, 24, 00) );
			
			timerControl.x = 5;
			timerControl.y = 270;
			timerControl.scaleX=timerControl.scaleY=0.6;
			addChild(timerControl);
			
			addEventListener(Event.ADDED_TO_STAGE,resizeHandler);
		}
		
		private function resizeHandler(event:Event):void {

			playerList.updateNow( stage.stageHeight -  (timerControl.height + 45) );
		}
	}
}