package com.newco.grand.roulette.mobile.view
{
	import com.newco.grand.roulette.classic.view.VideoView;
	
	public class VideoView extends com.newco.grand.roulette.classic.view.VideoView
	{
		public function VideoView()
		{
			super();
		}
		override public function initDisplay():void{
			super.initDisplay();
			_display.videoButton.mouseEnabled=false;
			_display.bg.width=720;
			_display.bg.height=440;
		}
		override public function align():void{
			//x = 360;
			setSize(720, 440);
		}
	}
}