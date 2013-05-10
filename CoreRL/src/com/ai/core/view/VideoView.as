package com.ai.core.view {
	
	import com.ai.core.utils.GameUtils;
	
	import flash.events.MouseEvent;
	import flash.events.StageVideoEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.net.NetStream;
	
	import caurina.transitions.Tweener;
	
	import org.osflash.signals.Signal;
	import org.osmf.containers.MediaContainer;
	import org.osmf.elements.VideoElement;
	import org.osmf.events.LoaderEvent;
	import org.osmf.media.MediaPlayer;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.net.NetLoader;
	import org.osmf.net.StreamType;
	import org.osmf.net.StreamingURLResource;
	
	public class VideoView extends VideoAsset {
		
		private var _fullscreen:Boolean=false;
		
		private var sv:StageVideo=null;  
		
		private var stageVideoInUse:Boolean=false;
		private var classicVideoInUse:Boolean=true;
		private var _stream:NetStream;
		private var _display:MediaContainer;
		private var _player:MediaPlayer;
		private var _playerSprite:MediaPlayerSprite;
		private var _netLoader:NetLoader;
		
		public var videoRefreshSignal:Signal= new Signal();
		public var videoFullscreenSignal:Signal= new Signal();
		public var videoAutoFullScreenSignal:Signal= new Signal();
		public var showFullSize:Boolean=false;
		
		public function VideoView() {
			visible = false;
			VideoRefreshBtn.iconMC.gotoAndStop(1);
			VideoFullscreenBtn.iconMC.gotoAndStop(1);
			
			VideoFullscreenBtn.buttonMode = true;
			VideoRefreshBtn.buttonMode=true;
			videoButton.addEventListener(MouseEvent.CLICK, showFullscreen);
			VideoFullscreenBtn.addEventListener(MouseEvent.CLICK, showFullscreen);
			VideoRefreshBtn.addEventListener(MouseEvent.CLICK, refreshVideo);
			
		}

		public function setupOsmfPlayer(streamUrl:String):void{
			if (_display==null)
			{
			_netLoader = new NetLoader();
			_netLoader.addEventListener( LoaderEvent.LOAD_STATE_CHANGE, onLoaderStateChange );
			var media:VideoElement = new VideoElement( new StreamingURLResource(streamUrl,StreamType.LIVE,NaN,NaN,null,false), _netLoader );
			_playerSprite = new MediaPlayerSprite();
			_playerSprite.media=media;
			_playerSprite.x=video.x;
			_playerSprite.y=video.y;
			_playerSprite.width=video.width;
			_playerSprite.height=video.height;
			addChild( _playerSprite );
			}
			
			bg.alpha=0;
			bg.buttonMode=true;
			video.visible=false;
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
				sv = v[0];  
			}else
				throw new Error("Your device is not supporting Stagevideo.");
			
			return sv;
		}
		public function get viewPort():Rectangle{
			if (sv)
			return sv.viewPort;
			else
			return new Rectangle(x, y ,width, height);
		}
		public function toggleStageVideo(on:Boolean):void       
		{              
			// if StageVideo is available, attach the NetStream to StageVideo       
			if (on)       
			{       
				stageVideoInUse = true;       
				if ( sv == null )       
				{       
					sv = getStageVideo();       
					video.visible=false;
					
					bg.alpha=0;
					bg.buttonMode=true;
					sv.addEventListener(StageVideoEvent.RENDER_STATE, stageVideoStateChange);  
				}       
				sv.attachNetStream(_stream);       
				if (classicVideoInUse)       
				{       
					// If using StageVideo, just remove the Video object from       
					// the display list to avoid covering the StageVideo object       
					// (always in the background)       
					//stage.removeChild ( video );       
					classicVideoInUse = false;       
				}       
			} else       
			{       
				// Otherwise attach it to a Video object      
				video.visible=true;
				bg.visible=true;
				if (stageVideoInUse)       
					stageVideoInUse = false;       
				classicVideoInUse = true;       
				video.attachNetStream(_stream);       
				//stage.addChildAt(video, 0);       
			}           
		}       
		
		private function stageVideoStateChange(event:StageVideoEvent):void       
		{          
			var status:String = event.status;       
			resize();       
		}
		private function resize():void       
		{     
			var rc:Rectangle;
			rc = computeVideoRect(video.width, video.height);      
			if (sv)
			sv.viewPort = rc;       
		}
		
		private function computeVideoRect(s:Number, b:Number):Rectangle
		{
			return new Rectangle(x+bg.x,y+bg.y,s,b);
		}
		public function init():void {
			
			if (showFullSize)
				setFullSizeScreen();
			else
				align();
		}
		
		public function align():void {			
			x = 170;
			setSize(448, 318);
		}
		
		public function set stream(value:NetStream): void {
			_stream=value;
			video.attachNetStream(_stream);       
			visible = true;
		}
		
		public function get fullscreen():Boolean {
			return _fullscreen;
		}
		
		public function setSize(width:int, height:int):void {
			video.width = width;
			video.height = height;
			//resize();
		}
		
		private function refreshVideo(event:MouseEvent):void {
			
			video.clear();
			videoRefreshSignal.dispatch(event.target);
		}
		
		private function showFullscreen(event:MouseEvent):void {
			resizeVideo(event);
			_fullscreen = !_fullscreen;
			resize();
			//dispatchEvent( new UIEvent(UIEvent.VIDEO_FULLSCREEN, event.target));
		}
		
		public function setFullSizeScreen():void{
			video.width = 990;
			video.height = 610;
			video.x=0;
			video.y=0;
			frame.visible=false;
			bg.visible=false;
			videoButton.removeEventListener(MouseEvent.CLICK, showFullscreen);
			VideoFullscreenBtn.removeEventListener(MouseEvent.CLICK, showFullscreen);
		}
		
		private function resizeVideo(event:MouseEvent=null):void {
			if(!_fullscreen) {
				//this.scaleX = 1.55;
				//this.scaleY = 1.55;
				videoFullscreenSignal.dispatch(event.target);
				
				Tweener.addTween(this, {scaleX:1.8, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1.55, time:0.75, transition:"easeInOutQuart"});

				Tweener.addTween(bg, {width:529, time:0.75, transition:"easeInOutQuart",onUpdate:function():void { resize(); }});
				Tweener.addTween(bg, {height:339, time:0.75, transition:"easeInOutQuart",onUpdate:function():void {resize(); }});
				
			} else {
				//this.scaleX = 1;
				//this.scaleY = 1;
				Tweener.addTween(bg, {width:455, time:0.75, transition:"easeInOutQuart", onUpdate:function():void {resize(); }});
				Tweener.addTween(bg, {height:325, time:0.75, transition:"easeInOutQuart",onUpdate:function():void {resize(); }});
				Tweener.addTween(this, {scaleX:1, time:0.75, transition:"easeInOutQuart"});
				Tweener.addTween(this, {scaleY:1, time:0.75, transition:"easeInOutQuart", onComplete:function ():void{
				videoFullscreenSignal.dispatch(event.target);
					
				}});
			}
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}