package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.core.common.view.GameStatusView;
	
	public class GameStatusView extends com.newco.grand.core.common.view.GameStatusView
	{
		public function GameStatusView()
		{
			super();
		}
		override public function init():void {
			super.init();
			visible = true;
		}
		override public function align():void {
			x = 666;
		}
	}
}