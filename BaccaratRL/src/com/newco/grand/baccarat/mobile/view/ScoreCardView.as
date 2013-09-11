package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.baccarat.classic.view.ScoreCardView;
	import com.newco.grand.baccarat.classic.view.interfaces.IScoreCardView;
	
	public class ScoreCardView extends com.newco.grand.baccarat.classic.view.ScoreCardView implements IScoreCardView
	{
		public function ScoreCardView()
		{
			super();
		}
		override public function align():void{
			x= 55;
			visible=true;
		}
	}
}