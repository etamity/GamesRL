package com.newco.grand.core.common.view {
	
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.IVideoView;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StageVideoEvent;
	import flash.events.VideoEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.net.NetStream;
	
	import caurina.transitions.Tweener;
	
	import org.osmf.containers.MediaContainer;
	import org.osmf.elements.VideoElement;
	import org.osmf.events.LoaderEvent;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.net.NetLoader;
	import org.osmf.net.StreamType;
	import org.osmf.net.StreamingURLResource;
	
	public class VideoView extends UIView implements IVideoView {		
		protected var _fullscreen:Boolean=false;
		
		private var _sv:StageVideo=null;  
		
		private var _stageVideoInUse:Boolean=false;
		private var _classicVideoInUse:Boolean=true;
		private var _stream:NetStream;
		private var  _displayContainer:MediaContainer;
		private var _player:MediaPlayer;
		private var _playerSprite:MediaPlayerSprite;
		private var _netLoader:NetLoader;

		/*public var videoRefreshSignal:Signal= new Signal();
		public var videoFullscreenSignal:Signal= new Signal();
		public var videoAutoFullScreenSignal:Signal= new Signal();*/
		
		protected var _signalBus:SignalBus=new SignalBus();
		
		public var showFullSize:Boolean=false;
		
		
		public function VideoView() {
			super();
			_display.video.smoothing = true;
			_display.VideoRefreshBtn.iconMC.gotoAndStop(1);
			_display.VideoFullscreenBtn.iconMC.gotoAndStop(1);
			
			_display.VideoFullscreenBtn.buttonMode = true;
			_display.VideoRefreshBtn.buttonMode=true;
			_display.xmodeBtn.buttonMode=true;
			_display.stopStreamBtn.buttonMode=true;
			_display.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
			_display.VideoFullscreenBtn.addEventListener(MouseEvent.CLICK, showFullscreen);
			_display.VideoRefreshBtn.addEventListener(MouseEvent.CLICK, refreshVideo);
			_display.xmodeBtn.addEventListener(MouseEvent.CLICK, xmodeVideo);
			_display.stopStreamBtn.addEventListener(MouseEvent.CLICK, stopVideo);
			
			//_display.video.addEventListener(VideoEvent.RENDER_STATE, onRenderEvent);
		}
		private function onRenderEvent(evt:VideoEvent):void{
			_display.video.removeEventListener(VideoEvent.RENDER_STATE, onRenderEvent);
			_signalBus.dispatch(UIEvent.VIDEO_LOADED,{target:evt.target});
		}
		
		override public function initDisplay():void{
			_display=new VideoAsset();
			addChild( _display);
	
		}
		
		public function get signalBus():SignalBus{
			return _signalBus;
		}

		public function setupOsmfPlayer(streamUrl:String):void{
			if ( _displayContainer==null)
			{
			_netLoader = new NetLoader();
			_netLoader.addEventListener( LoaderEvent.LOAD_STATE_CHANGE, onLoaderStateChange );
			var media:VideoElement = new VideoElement( new StreamingURLResource(streamUrl,StreamType.LIVE,NaN,NaN,null,false), _netLoader );
			_playerSprite = new MediaPlayerSprite();
			_playerSprite.media=media;
			_playerSprite.x= _display.video.x;
			_playerSprite.y= _display.video.y;
			_playerSprite.width= _display.video.width;
			_playerSprite.height= _display.video.height;
			addChild( _playerSprite );
			}
			
			 _display.bg.alpha=0;
			 _display.bg.buttonMode=true;
			 _display.video.visible=false;
			visible = true;
		}
		
		public function showHidePreloader(showed:Boolean):void{
			_display.preloader.visible=showed;
		}
		private function onLoaderStateChange( e:LoaderEvent ) :void
		{
			debug( "MediaElement is: " + e.newState );
		}
		public function getStageVideo():StageVideo{
			var v:Vector.<StageVideo> = stage.stageVideos;       
		     
			if ( v.length >= 1 )       
			{       
				_sv = v[0];  
			}else
				throw new Error("Your device is not supporting Stagevideo.");
			
			return _sv;
		}
		public function get viewPort():Rectangle{
			if (_sv)
			return _sv.viewPort;
			else
			return new Rectangle(x, y ,width, height);
		}
		public function toggleStageVideo(on:Boolean):void       
		{              
			// if StageVideo is available, attach the NetStream to StageVideo  
			
			debug("toggleStageVideo",on);
			if (on==true)       
			{       
				_stageVideoInUse = true;       
				if ( _sv == null )       
				{       
					_sv = getStageVideo();       
					 _display.video.visible=false;
					 _display.frame.visible=false;
					 _display.bg.alpha=0;
					 _display.bg.buttonMode=true;
					 _display.bg.visible=false;
					_sv.addEventListener(StageVideoEvent.RENDER_STATE, stageVideoStateChange);  
				}       
				_sv.attachNetStream(_stream);       
				if (_classicVideoInUse)       
				{       
					// If using StageVideo, just remove the Video object from       
					// the display list to avoid covering the StageVideo object       
					// (always in the background)       
					//stage.removeChild ( video );      
					_classicVideoInUse = false;       
				}       
			} else       
			{       
				// Otherwise attach it to a Video object      
				 _display.video.visible=true;
				 _display.frame.visible=true;
				 _display.bg.visible=false;
				if (_stageVideoInUse)       
					_stageVideoInUse = false;       
				_classicVideoInUse = true;           
			
				//stage.addChildAt(video, 0);       
			}          
			align();
		}       
		
		private function stageVideoStateChange(event:StageVideoEvent):void       
		{          
			var status:String = event.status;       
			resize();       
		}
		protected function resize():void       
		{     
			var rc:Rectangle;
			rc = computeVideoRect( _display.video.width,  _display.video.height);      
			if (_sv)
			_sv.viewPort = rc;       
		}
		
		private function computeVideoRect(s:Number, b:Number):Rectangle
		{
			return new Rectangle(x+ _display.bg.x,y+ _display.bg.y,s,b);
		}
		override public function init():void {
			updateLanguage();
			if (showFullSize)
				setFullSizeScreen();
			else
				align();
		}
		override public function align():void {			
			x = 175;
			setSize(448, 318);
			//setSize(820, 610);
		}
		
		public function set stream(value:NetStream): void {
			_stream=value;
			 _display.video.attachNetStream(_stream);  
			visible = true;
		}
		
		public function get fullscreen():Boolean {
			return _fullscreen;
		}
		
		public function setSize(width:int, height:int):void {
			 _display.video.width = width;
			 _display.video.height = height;
			 _display.bg.width = width;
			 _display.bg.height = height;
			 _display.preloader.x= (_display.bg.width -  _display.preloader.width )/ 2 ;
			 _display.preloader.y=( _display.bg.height -  _display.preloader.height) / 2;
			//resize();
		}
		public function get stream():NetStream{
			return _stream;
		}
		
		private function refreshVideo(event:MouseEvent):void {
			
			 _display.video.clear();
			//videoRefreshSignal.dispatch();
			_signalBus.dispatch(UIEvent.VIDEO_REFRESH,{target:event.target});
		}
		
		private function stopVideo(event:MouseEvent):void {
			
			_display.video.clear();
			_display.preloader.visible=false;
			//videoRefreshSignal.dispatch();
			_signalBus.dispatch(UIEvent.VIDEO_STOP,{target:event.target});
		}
		private function xmodeVideo(event:MouseEvent):void {
			
			_display.video.clear();
			//videoRefreshSignal.dispatch();
			_signalBus.dispatch(UIEvent.VIDEO_XMODE,{target:event.target});
		}
		public function showFullscreen(event:MouseEvent):void {
			resizeVideo(event);
			_fullscreen = !_fullscreen;
			resize();
			//dispatchEvent( new UIEvent(UIEvent.VIDEO_FULLSCREEN, event.target));
		}
		
		public function setFullSizeScreen():void{
			 _display.video.width = 986;
			 _display.video.height = 670;
			 _display.video.x=0;
			 _display.video.y=0;
			 _display.frame.visible=false;
			 _display.bg.visible=false;
			 _display.videoButton.removeEventListener(MouseEvent.CLICK, showFullscreen);
			 _display.VideoFullscreenBtn.removeEventListener(MouseEvent.CLICK, showFullscreen);
		}
		
		public function resizeVideo(event:MouseEvent=null):void {
			 _display.videoButton.removeEventListener(MouseEvent.CLICK, showFullscreen);
			if(!_fullscreen) {
				//this.scaleX = 1.55;
				//this.scaleY = 1.55;
				//videoFullscreenSignal.dispatch(event.target);
				// _display.frame.visible=false;
				// _display.bg.visible=false;
				//signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
		
				Tweener.addTween(this, {scaleX:1.8, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1.58, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
					//videoFullscreenSignal.dispatch(event.target);
			
					 _display.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
					
				}});				
			} else {
				//this.scaleX = 1;
				//this.scaleY = 1;
				// _display.frame.visible=true;
				// _display.bg.visible=false;
				//Tweener.addTween( _display.bg, {width:455, time:0.75, transition:"easeInOutQuart", onUpdate:function():void {resize(); }});
				//Tweener.addTween( _display.bg, {height:325, time:0.75, transition:"easeInOutQuart",onUpdate:function():void {resize(); }});
				Tweener.addTween(this, {scaleX:1, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
				//videoFullscreenSignal.dispatch(event.target);
					//signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
				 _display.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
				
				}});
			}
		}

	}
}