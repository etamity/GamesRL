package com.newco.grand.roulette.classic.view
{
	import com.newco.grand.core.common.view.GameStatusView;
	
	import org.osflash.signals.Signal;
	
	public class GameStatusView extends com.newco.grand.core.common.view.GameStatusView
	{
		public var sg:Signal=new Signal();
		public function GameStatusView()
		{
			super();
		}
		override public function align():void {			
			x = 665;
			y = 0;
		}
	}
}