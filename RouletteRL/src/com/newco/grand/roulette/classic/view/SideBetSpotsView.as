package com.newco.grand.roulette.classic.view {

	public class SideBetSpotsView extends BetSpotsView{
		public function SideBetSpotsView() {
			super();
		}
		
		override public function initDisplay():void{
			_display=new BetBoardPanelAsset();
			addChild(_display);
		}
		
		override public function align():void {			
			//x = 168;
			y = 235;
		}
	}
}