package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.baccarat.classic.view.CardsPanelView;

	public class CardsPanelView extends com.newco.grand.baccarat.classic.view.CardsPanelView
	{
		public function CardsPanelView()
		{
			super();
		}

		override public function initDisplay():void
		{
			_display=new Mobile_CardsPanelAsset();
			addChild(_display);
		}
		override public function align():void{
			visible=true;
			x=0;
		}
	}
}
