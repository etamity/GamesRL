package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.baccarat.classic.view.StatisticsView;
	
	public class StatisticsView extends com.newco.grand.baccarat.classic.view.StatisticsView
	{
		public function StatisticsView()
		{
			super();
		}
		
		override public function align():void{
			x=stage.stageWidth-width;
			y=220;
		}
	}
}