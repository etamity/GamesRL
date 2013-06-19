package com.newco.grand.core.mobile.view
{
	import com.newco.grand.core.common.view.VideoView;
	
	public class VideoView extends com.newco.grand.core.common.view.VideoView
	{
		public function VideoView()
		{
			super();
			frame.visible=false;
			bg.visible=false;
		}
		override public function align():void {		
			setSize(640, 511);
		}
	}
}