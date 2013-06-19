package com.newco.grand.core.mobile.view
{
	import com.newco.grand.core.common.view.VideoView;
	
	public class VideoView extends com.newco.grand.core.common.view.VideoView
	{
		public function VideoView()
		{
			super();
			showFullSize=true;
		}
		override public function align():void {	
			_display.frame.visible=false;
			_display.bg.visible=false;
			_display.mask=null;
			setSize(640, 511);
			super.resize();
		}
	}
}