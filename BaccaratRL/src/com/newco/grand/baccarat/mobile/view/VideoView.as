package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.core.common.view.VideoView;

	public class VideoView extends com.newco.grand.core.common.view.VideoView
	{
		public function VideoView()
		{
			super();
			//this.showFullSize=true;
		}
		override public function initDisplay():void{
			_display=new Mobile_VideoAsset();
			addChild(_display);
			_display.videoButton.mouseEnabled=false;
			_display.frame.visible=false;
			_display.bg.width=640;
			_display.bg.height=514;
		}
		override public function align():void {			
			x = 0;
			setSize(640, 514);
			//setSize(820, 610);
		}
	}
}
