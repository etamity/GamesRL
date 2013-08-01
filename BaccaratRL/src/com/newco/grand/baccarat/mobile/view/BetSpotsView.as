package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.baccarat.classic.view.BetSpotsView;
	
	public class BetSpotsView extends com.newco.grand.baccarat.classic.view.BetSpotsView
	{
		public function BetSpotsView()
		{
			super();
		}
		override public function initDisplay():void{
			_display= new Mobile_BetSpotsAsset();
			addChild(_display);
		}
		
		override public function align():void{
			x=0;
			visible=true;
		}
	}
}