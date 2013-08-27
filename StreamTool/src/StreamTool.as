package
{
	import com.smart.uicore.controls.Button;
	import com.smart.uicore.controls.TextArea;
	import com.smart.uicore.controls.TextInput;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.events.StageVideoEvent;
	import flash.events.VideoEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideo;
	import flash.media.StageVideoAvailability;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;

	[SWF(width = "800", height = "640", frameRate = "24",wmode="direct")]
	
	public class StreamTool extends Sprite
	{
		//private static const FILE_NAME:String = "video-file.mov";
		private static const INTERVAL:Number = 500;
		private static const BORDER:Number = 20;
		
		private var legend:TextField = new TextField();
		private var sv:StageVideo;
		private var nc:NetConnection;
		private var ns:NetStream;
		private var rc:Rectangle;
		private var video:Video;
		private var thumb:Shape;
		private var interactiveThumb:Sprite;
		private var totalTime:Number;
		
		private var videoWidth:int;
		private var videoHeight:int;
		private var outputBuffer:String = new String();
		private var rect:Rectangle = new Rectangle(0, 0, 0, BORDER);
		private var videoRect:Rectangle = new Rectangle(0, 0, 0, 0);
		private var gotStage:Boolean;
		private var stageVideoInUse:Boolean;
		private var classicVideoInUse:Boolean;
		private var accelerationType:String;
		private var infos:String = new String();
		private var available:Boolean;
		private var inited:Boolean;
		private var played:Boolean;
		private var container:Sprite;

		private var _streamName:String;
		private var _server:String;
		private var _application:String;
		private var _url:String="rtmp://213.86.83.8/smartlivecasinolive-live/7BJ1";
		
		//rtmp://213.86.83.8/smartlivecasinolive-live/7BJ1
		//http://213.86.1.217:1935/SGGLive/R1800/playlist.m3u8
		
		private var _debugText:TextArea;
		public function StreamTool()
		{
			// Make sure the app is visible and stage available
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onAddedToStage(event:Event):void
		{
			// Scaling
			createUI();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			legend.autoSize = TextFieldAutoSize.LEFT;
			
			// Debug infos
			legend.multiline = true;
			legend.background = true;
			legend.backgroundColor = 0xFFFFFFFF;
			addChild(legend);
			
			// Thumb seek Bar
			thumb = new Shape();
			
			interactiveThumb = new Sprite();
			interactiveThumb.addChild(thumb);
			addChild(interactiveThumb);
			
			// Connections
			nc = new NetConnection();
			nc.client={ onBWDone: function():void{} };
			nc.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);		
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
	

			
			// Screen
			video = new Video();
			video.smoothing = true;
			
			// Video Events
			// the StageVideoEvent.STAGE_VIDEO_STATE informs you if StageVideo is available or not
			stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoState);
			// in case of fallback to Video, we listen to the VideoEvent.RENDER_STATE event to handle resize properly and know about the acceleration mode running
			video.addEventListener(VideoEvent.RENDER_STATE, videoStateChange);
			
			// Input Events
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(Event.RESIZE,  onResize);
			//stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		
		private function createUI():void{
			var text:TextInput=new TextInput();
			var button:Button=new Button();
			button.label="Connect";
			text.x=200;
			text.width=350;
			text.text="rtmp://213.86.83.8/smartlivecasinolive-live/R1";
			button.x=text.x+text.width;
			addChild(text);
			addChild(button)
			_debugText=new TextArea();
			_debugText.y= stage.stageHeight-_debugText.height;
			_debugText.width=stage.stageWidth;
			addChild(_debugText);
			_debugText.visible=false;

			var debugBtn:Button=new Button();
			debugBtn.label="Debug";
			debugBtn.x=button.x+button.width;
			debugBtn.addEventListener(MouseEvent.CLICK,function (evt:MouseEvent):void{
				_debugText.visible=!_debugText.visible;
				
			});
			
			addChild(debugBtn);
			button.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void{
				_url=text.text;
				var stream:Array=_url.split("//");
				var streams:Array=stream[1].split("/");
				_server = streams[0];
				_streamName= streams[streams.length-1];				
				_application= _url.replace("rtmp://"+_server+"/","");
				_application=_application.replace("/"+_streamName,"");
				
				
				var video_sever:String="rtmp://"+_server+"/"+_application;
				trace("_server",_server);
				trace("_application",_application);
				trace("_streamName",_streamName);
				trace("[video_sever]:",video_sever);
				nc.connect(video_sever);
			});
			
		}
		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace(event.text);
		}
		private function connectStream():void	{
			ns = new NetStream(nc);
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			ns.client ={ onBWDone: function():void{

			
			} };
			ns.addEventListener(IOErrorEvent.IO_ERROR, IOError);
			ns.bufferTime = 1;
			if (stageVideoInUse)
			sv.attachNetStream(ns);
			else
			video.attachNetStream(ns);
			
		
			ns.play(trim(_streamName));
			
			
		}
		
		public function trim(str:String):String {
			var j:Number = 0;
			var strlen:Number = str.length;
			var k:Number;
			
			while (str.charAt(j) == " ") {				
				j++;
			}
			if(j > 0){
				str = str.substring(j, strlen);
				if (j == strlen) {
					return str;
				}
			}
			
			k = str.length - 1;
			while (str.charAt(k) == " ") {				
				k--;
			}
			str = str.substring(0, k + 1);			
			return str;
		}
		
		private function IOError(event:IOErrorEvent):void {
			trace("Error on StageVideo Player stream");
		}
		private function netStatusHandler(event:NetStatusEvent):void {
			trace("NetStatusEvent: " + event.info.code);
			_debugText.htmlText +=event.info.code +"<br />"
				switch (event.info.code) {
					case "NetConnection.Connect.Success":

						connectStream();
						break;
					case "NetStream.Play.Start":
					
						break;
					case "NetStream.Play.Stop":
			
						break;
					case "NetStream.Buffer.Full":
				
						break;
					case "NetStream.Buffer.Empty":
					
						break;
					case "NetStream.Pause.Notify":
						//break;
					case "NetStream.Unpause.Notify":
		
						break;
			}
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			_debugText.htmlText +="["+event.type+"] "+event.text +"<br />"
			trace("SecurityErrorEvent: " + event);
		}
		
		private function IOErrorHandler(event:IOErrorEvent):void {
			_debugText.htmlText +="["+event.type+"] "+event.text +"<br />"
			trace("IOErrorEvent: " + event);
		}
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onNetStatus(event:NetStatusEvent):void
		{
			if ( event.info == "NetStream.Play.StreamNotFound" )
				legend.text = "Video file passed, not available!";
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onFrame(event:Event):void 
		{
			var ratio:Number = (ns.time / totalTime) * (stage.stageWidth - (BORDER << 1));
			rect.width = ratio;
			thumb.graphics.clear();
			thumb.graphics.beginFill(0xFFFFFF);
			thumb.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);	
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onClick(event:MouseEvent):void
		{
			if ( event.stageY >= interactiveThumb.y - BORDER && event.stageX <= stage.stageWidth - BORDER )
			{
				var seekTime:Number = (stage.mouseX - BORDER) * ( totalTime / (stage.stageWidth - (BORDER << 1) ) );
				ns.seek( seekTime );	
			}
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onKeyDown(event:KeyboardEvent):void
		{	
			if ( event.keyCode == Keyboard.O )
			{
				if ( available )
					// We toggle the StageVideo on and off (fallback to Video and back to StageVideo)
					toggleStageVideo(inited=!inited);
				
			} else if ( event.keyCode == Keyboard.F )
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
			} else if ( event.keyCode == Keyboard.SPACE )
			{
				ns.togglePause();
			}
		}
		
		/**
		 * 
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */		
		private function getVideoRect(width:uint, height:uint):Rectangle
		{	
			var videoWidth:uint = width;
			var videoHeight:uint = height;
			var scaling:Number = Math.min ( stage.stageWidth / videoWidth, stage.stageHeight / videoHeight );
			
			videoWidth *= scaling, videoHeight *= scaling;
			
			var posX:uint = stage.stageWidth - videoWidth >> 1;
			var posY:uint = stage.stageHeight - videoHeight >> 1;
			
			videoRect.x = posX;
			videoRect.y = posY;
			videoRect.width = videoWidth;
			videoRect.height = videoHeight;
			
			return videoRect;
		}
		
		/**
		 * 
		 * 
		 */		
		private function resize ():void
		{	
			if ( stageVideoInUse )
			{
				// Get the Viewport viewable rectangle
				rc = getVideoRect(sv.videoWidth, sv.videoHeight);
				// set the StageVideo size using the viewPort property
				sv.viewPort = rc;
			} else 
			{
				// Get the Viewport viewable rectangle
				rc = getVideoRect(video.videoWidth, video.videoHeight);
				// Set the Video object size
				video.width = rc.width;
				video.height = rc.height;
				video.x = rc.x, video.y = rc.y;
			}
			
			interactiveThumb.x = BORDER, interactiveThumb.y = stage.stageHeight - (BORDER << 1);
			legend.text = infos;
		}
		
		/**
		 * 
		 * @param evt
		 * 
		 */		
		public function onMetaData ( evt:Object ):void
		{
			totalTime = evt.duration;
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onStageVideoState(event:StageVideoAvailabilityEvent):void
		{	
			// Detect if StageVideo is available and decide what to do in toggleStageVideo
			toggleStageVideo(available = inited = (event.availability == StageVideoAvailability.AVAILABLE));
			//toggleStageVideo(false);
			trace("onStageVideoState: " + event.availability );
		}
		
		/**
		 * 
		 * @param on
		 * 
		 */		
		private function toggleStageVideo(on:Boolean):void
		{	
			infos = "StageVideo Running (Direct path) : " + on + "\n";
			
			// If we choose StageVideo we attach the NetStream to StageVideo
			if (on) 
			{
				stageVideoInUse = true;
				if ( sv == null )
				{
					sv = stage.stageVideos[0];
					sv.addEventListener(StageVideoEvent.RENDER_STATE, stageVideoStateChange);
				}
				if (classicVideoInUse)
				{
					// If we use StageVideo, we just remove from the display list the Video object to avoid covering the StageVideo object (always in the background)
					stage.removeChild ( video );
					classicVideoInUse = false;
				}
			} else 
			{
				// Otherwise we attach it to a Video object
				if (stageVideoInUse)
					stageVideoInUse = false;
				classicVideoInUse = true;
				stage.addChildAt(video, 0);
			}
			
			if ( !played ) 
			{
				played = true;
				/*if (ns!=null)
				ns.play();*/
			}
		} 
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function onResize(event:Event):void
		{
			resize();		
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function stageVideoStateChange(event:StageVideoEvent):void
		{	
			infos += "StageVideoEvent received\n";
			infos += "Render State : " + event.status + "\n";
			resize();
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function videoStateChange(event:VideoEvent):void
		{	
			infos += "VideoEvent received\n";
			infos += "Render State : " + event.status + "\n";
			resize();
		}
	}
}
