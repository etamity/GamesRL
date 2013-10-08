package com.newco.grand.roulette.mobile.view
{
	import com.newco.grand.roulette.classic.view.VideoView;
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	public class VideoView extends com.newco.grand.roulette.classic.view.VideoView
	{
		public function VideoView()
		{
			super();
		}
		override public function initDisplay():void{
			//super.initDisplay();
			_display=new Mobile_VideoAsset();
			addChild( _display);
			_display.videoButton.mouseEnabled=false;
			_display.bg.width=680;
			_display.bg.height=460;
		}
		override public function align():void{
			//x = 360;
			setSize(680, 460);
		}
		override public function resizeVideo(event:MouseEvent=null):void {
			_display.videoButton.removeEventListener(MouseEvent.CLICK, showFullscreen);
			if(!_fullscreen) {
				//this.scaleX = 1.55;
				//this.scaleY = 1.55;
				//videoFullscreenSignal.dispatch(event.target);
				//_display.frame.visible=false;
				//_display.bg.visible=false;
				//signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
				
				Tweener.addTween(this, {x:0,width:960, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {y:0,height:640, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
					//videoFullscreenSignal.dispatch(event.target);
					
					_display.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
					
				}});				
			} else {
				//this.scaleX = 1;
				//this.scaleY = 1;
				//_display.frame.visible=true;
				//_display.bg.visible=false;
				//Tweener.addTween(_display.bg, {width:455, time:0.75, transition:"easeInOutQuart", onUpdate:function():void {resize(); }});
				//Tweener.addTween(_display.bg, {height:325, time:0.75, transition:"easeInOutQuart",onUpdate:function():void {resize(); }});
				Tweener.addTween(this, {x:0,width:770, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {y:0,height:517, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
					//videoFullscreenSignal.dispatch(event.target);
					//signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
					_display.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
					
				}});
			}
		}
	}
}