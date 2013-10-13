package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.view.VideoView;
	
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	public class VideoView extends com.newco.grand.core.common.view.VideoView
	{
		public function VideoView()
		{
			super();
			showFullSize=true;

			
		}
		
		override public function align():void{
			x = 0;
			y = 0;
			setSize(1184, 666);
			//setSize(1186, 667);
			//setSize(1280, 720);
			
			_display.bg.visible=false;
			_display.frame.visible=false;
			_display.VideoRefreshBtn.x=992;
			_display.VideoRefreshBtn.y=627;
			
			_display.VideoFullscreenBtn.visible=false;
			
			_display.xmodeBtn.x=952;
			_display.xmodeBtn.y=627;
			
			_display.stopStreamBtn.x=912;
			_display.stopStreamBtn.y=627;
			
		}
		
		override public function resizeVideo(event:MouseEvent=null):void {
			_display.videoButton.removeEventListener(MouseEvent.CLICK, showFullscreen);
			if(!_fullscreen) {
				//this.scaleX = 1.55;
				//this.scaleY = 1.55;
				//videoFullscreenSignal.dispatch(event.target);
				_display.frame.visible=false;
				_display.bg.visible=false;
				_signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
				
				Tweener.addTween(this, {scaleX:1.8, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1.78, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
					//videoFullscreenSignal.dispatch(event.target);
					
					_display.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
					
				}});				
			} else {
				//this.scaleX = 1;
				//this.scaleY = 1;
				_display.frame.visible=true;
				_display.bg.visible=false;
				//Tweener.addTween(_display.bg, {width:455, time:0.75, transition:"easeInOutQuart", onUpdate:function():void {resize(); }});
				//Tweener.addTween(_display.bg, {height:325, time:0.75, transition:"easeInOutQuart",onUpdate:function():void {resize(); }});
				Tweener.addTween(this, {scaleX:1, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
					//videoFullscreenSignal.dispatch(event.target);
					_signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
					_display.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
					
				}});
			}
		}
	}
}