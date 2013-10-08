package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.core.common.view.GameStatusView;
	
	public class GameStatusView extends com.newco.grand.core.common.view.GameStatusView
	{
		public function GameStatusView()
		{
			super();
		}
		override public function align():void{
			x = stage.stageWidth -154;
			y = 0;
		}
		override public function initDisplay():void{
			_display=new Mobile_GameStatusAsset();
			addChild(_display);
		}
	}
}