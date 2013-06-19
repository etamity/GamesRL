package com.newco.grand.core.mobile.view
{
	import com.newco.grand.core.common.view.GameStatusView;
	
	public class GameStatusView extends com.newco.grand.core.common.view.GameStatusView
	{
		public function GameStatusView()
		{
			super();
		}
		override public function align():void {			
			x = stage.stageWidth -width;
			y = 0;
		}
	}
}