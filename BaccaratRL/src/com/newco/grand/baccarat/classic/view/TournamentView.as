package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.tournamenet.PlayerList;
	import com.newco.grand.baccarat.classic.view.tournamenet.TimerControl;
	import com.newco.grand.core.utils.GameUtils;

	public class TournamentView extends TournamenetAsset
	{
		private var playerList:PlayerList;
		private var timerControl:TimerControl;
		public function TournamentView()
		{
		}
		
		public function loadXML(url:String):void{
			debug(url);
			playerList = new PlayerList(url);
			playerList.y = 50;
			playerList.x = 3;
			addChild(playerList);
			
			timerControl = new TimerControl( new Date(2013, 06, 20, 24, 00) );
			
			timerControl.x = 5;
			timerControl.y = 245;
			timerControl.scaleX=timerControl.scaleY=0.6;
			addChild(timerControl);
			
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}

	}
}