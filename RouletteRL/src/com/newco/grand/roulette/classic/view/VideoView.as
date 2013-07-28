package com.newco.grand.roulette.classic.view
{
	import com.newco.grand.core.common.view.VideoView;
	
	public class VideoView extends com.newco.grand.core.common.view.VideoView
	{
		public function VideoView()
		{
			super();
		}
		override public function align():void{
			x = 360;
			setSize(448, 318);
		}
	}
}