package com.newco.grand.core.common.view {
	
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.IVideoView;
	
	import flash.events.MouseEvent;
	import flash.events.StageVideoEvent;
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
		private var  _skinContainer:MediaContainer;
		private var _player:MediaPlayer;
		private var _playerSprite:MediaPlayerSprite;
		private var _netLoader:NetLoader;

		/*public var videoRefreshSignal:Signal= new Signal();
		public var videoFullscreenSignal:Signal= new Signal();
		public var videoAutoFullScreenSignal:Signal= new Signal();*/
		
		protected var _signalBus:SignalBus=new SignalBus();
		
		public var showFullSize:Boolean=false;
		
		
		private var  _skin:VideoAsset;
		public function VideoView() {
			super();

		}
		
		override public function initDisplay():void{
			 _skin=new VideoAsset();
			addChild( _skin);
			_display= _skin;
			 _skin.VideoRefreshBtn.iconMC.gotoAndStop(1);
			 _skin.VideoFullscreenBtn.iconMC.gotoAndStop(1);
			
			 _skin.VideoFullscreenBtn.buttonMode = true;
			 _skin.VideoRefreshBtn.buttonMode=true;
			 _skin.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
			 _skin.VideoFullscreenBtn.addEventListener(MouseEvent.CLICK, showFullscreen);
			 _skin.VideoRefreshBtn.addEventListener(MouseEvent.CLICK, refreshVideo);
		}
		
		public function get signalBus():SignalBus{
			return _signalBus;
		}

		public function setupOsmfPlayer(streamUrl:String):void{
			if ( _skinContainer==null)
			{
			_netLoader = new NetLoader();
			_netLoader.addEventListener( LoaderEvent.LOAD_STATE_CHANGE, onLoaderStateChange );
			var media:VideoElement = new VideoElement( new StreamingURLResource(streamUrl,StreamType.LIVE,NaN,NaN,null,false), _netLoader );
			_playerSprite = new MediaPlayerSprite();
			_playerSprite.media=media;
			_playerSprite.x= _skin.video.x;
			_playerSprite.y= _skin.video.y;
			_playerSprite.width= _skin.video.width;
			_playerSprite.height= _skin.video.height;
			addChild( _playerSprite );
			}
			
			 _skin.bg.alpha=0;
			 _skin.bg.buttonMode=true;
			 _skin.video.visible=false;
			visible = true;
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
			if (on)       
			{       
				_stageVideoInUse = true;       
				if ( _sv == null )       
				{       
					_sv = getStageVideo();       
					 _skin.video.visible=false;
					
					 _skin.bg.alpha=0;
					 _skin.bg.buttonMode=true;
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
				 _skin.video.visible=true;
				 _skin.bg.visible=false;
				if (_stageVideoInUse)       
					_stageVideoInUse = false;       
				_classicVideoInUse = true;       
				 _skin.video.attachNetStream(_stream);       
			
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
			rc = computeVideoRect( _skin.video.width,  _skin.video.height);      
			if (_sv)
			_sv.viewPort = rc;       
		}
		
		private function computeVideoRect(s:Number, b:Number):Rectangle
		{
			return new Rectangle(x+ _skin.bg.x,y+ _skin.bg.y,s,b);
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
			 _skin.video.attachNetStream(_stream);       
			visible = true;
		}
		
		public function get fullscreen():Boolean {
			return _fullscreen;
		}
		
		public function setSize(width:int, height:int):void {
			 _skin.video.width = width;
			 _skin.video.height = height;
			//resize();
		}
		public function get stream():NetStream{
			return _stream;
		}
		
		private function refreshVideo(event:MouseEvent):void {
			
			 _skin.video.clear();
			//videoRefreshSignal.dispatch();
			_signalBus.dispatch(UIEvent.VIDEO_REFRESH,{target:event.target});
		}
		
		public function showFullscreen(event:MouseEvent):void {
			resizeVideo(event);
			_fullscreen = !_fullscreen;
			resize();
			//dispatchEvent( new UIEvent(UIEvent.VIDEO_FULLSCREEN, event.target));
		}
		
		public function setFullSizeScreen():void{
			 _skin.video.width = 800;
			 _skin.video.height = 560;
			 _skin.video.x=0;
			 _skin.video.y=0;
			 _skin.frame.visible=false;
			 _skin.bg.visible=false;
			 _skin.videoButton.removeEventListener(MouseEvent.CLICK, showFullscreen);
			 _skin.VideoFullscreenBtn.removeEventListener(MouseEvent.CLICK, showFullscreen);
		}
		
		public function resizeVideo(event:MouseEvent=null):void {
			 _skin.videoButton.removeEventListener(MouseEvent.CLICK, showFullscreen);
			if(!_fullscreen) {
				//this.scaleX = 1.55;
				//this.scaleY = 1.55;
				//videoFullscreenSignal.dispatch(event.target);
				// _skin.frame.visible=false;
				// _skin.bg.visible=false;
				//signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
		
				Tweener.addTween(this, {scaleX:1.8, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1.58, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
					//videoFullscreenSignal.dispatch(event.target);
			
					 _skin.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
					
				}});				
			} else {
				//this.scaleX = 1;
				//this.scaleY = 1;
				// _skin.frame.visible=true;
				// _skin.bg.visible=false;
				//Tweener.addTween( _skin.bg, {width:455, time:0.75, transition:"easeInOutQuart", onUpdate:function():void {resize(); }});
				//Tweener.addTween( _skin.bg, {height:325, time:0.75, transition:"easeInOutQuart",onUpdate:function():void {resize(); }});
				Tweener.addTween(this, {scaleX:1, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
				//videoFullscreenSignal.dispatch(event.target);
					//signalBus.dispatch(UIEvent.VIDEO_FULLSCREEN,{target:event.target});
				 _skin.videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
				
				}});
			}
		}

	}
}