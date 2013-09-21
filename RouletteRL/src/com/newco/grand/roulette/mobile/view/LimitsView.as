package com.newco.grand.roulette.mobile.view
{
	import com.newco.grand.roulette.classic.view.LimitsView;
	
	public class LimitsView extends com.newco.grand.roulette.classic.view.LimitsView
	{
		public function LimitsView()
		{
			super();
		}
		override public function initDisplay():void{
			_display=new Mobile_TableLimitsAsset();
			addChild(_display);
		}
		
	}
}