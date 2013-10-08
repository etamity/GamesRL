package com.newco.grand.core.common.model {
	
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class VideoModel extends Actor {
		
		private static const STARTED_PLAYING:String = "NetStream.Play.Start";
		private static const STREAM_NOT_FOUND:String = "NetStream.Play.StreamNotFound";
		private static const CONNECTION_CLOSED:String = "NetConnection.Connect.Closed";
		private static const CONNECTION_SUCCESSFUL:String = "NetConnection.Connect.Success";
		
		private static const RELOAD:String = "reload";
		private static const UPGRADE:String = "up";
		private static const DOWNGRADE:String = "down";
	
		
		private var _servers:Array = new Array("213.86.83.8");
		private var _streams:Array = new Array("R1"); //7BJ1 , "TvRoulette2"
		private var _application:String = "smartlivecasinolive-live"; //"smartlivecasinolive-live";
		private var _server:String;
		private var _serverIndex:uint=0;
		private var _streamName:String;
		private var _streamIndex:uint;
		private var _stream:NetStream;
		private var _connection:NetConnection;
		private var _soundTransform:SoundTransform;
		
		private var _videoCheckTimer:Timer;
		private var _videoReconnectTimer:Timer;
		private var _availabilityTimer:Timer;
		private var _waitTimer:Timer;
		private var _switchTimer:Timer;
		
		private var _videoStopped:Boolean;
		private var _streamAvailable:Boolean;
		private var _downgradeCheck:Boolean;
		private var _waiting:Boolean;
		
		private var _videoStartTime:uint;
		
		private var _settings:XML;
		
		private var _maxBuffer:uint;
		
		private var _buffer_min:uint;
		
		private var _tempStreamName:String;
		
		private var _bwCheck:uint;
		
		[Inject]
		public var _flashvars:FlashVars;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var signalBus:SignalBus;
		
		private var debugTimer:Timer;
		public function VideoModel() {
			NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;			
			_connection = new NetConnection();			
			_connection.client = { onBWDone: function():void{} };
			_connection.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			_connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);		
			_connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_soundTransform = new SoundTransform();
			
			_waitTimer = new Timer(10000);
			_waitTimer.addEventListener(TimerEvent.TIMER, waitingTimeCheck);
			
			_switchTimer = new Timer(10000);
			_switchTimer.addEventListener(TimerEvent.TIMER, checkAndSwitchVideo);
			
			_videoCheckTimer = new Timer(1000);
			_videoCheckTimer.addEventListener(TimerEvent.TIMER, checkVideo);
			
			_videoReconnectTimer = new Timer(5000);
			_videoReconnectTimer.addEventListener(TimerEvent.TIMER, checkVideoConnection);
			
			_availabilityTimer = new Timer(10000);
			_availabilityTimer.addEventListener(TimerEvent.TIMER, checkStreamAvailability);
			
			_maxBuffer = 1;
			_buffer_min=0.3;
			_bwCheck = 500;
		}		
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace(event.text);
		}
		public function init():void {
			_streamAvailable = false;
			_downgradeCheck = false;
			_streamName = _streams[_streams.length - 1];
			_streamIndex = _streams.length - 1;
			_server =game.server;
			debug("_flashvars.streamServerID: "+_flashvars.streamServerID);
			
			if (_flashvars.streamServerID!="$streamServerID" && _flashvars.streamServerID!=undefined )
			{
				_server =servers[_flashvars.streamServerID]
			}
			_videoStartTime = getTimer();
		
			createConnection();
		}
		public function get stream():NetStream{
			return _stream;
		}
		public function connect(streamUrl:String):void{
			_connection.connect(streamUrl);
		}
		private function createConnection():void {
			debug("server: "+_server);
			debug("streamName: "+_streamName);
			debug("application: "+_application);
			debug("rtmp://" + _server + "/" + _application);
			debug("httpStream: "+game.httpStream);
		
			if (game.httpStream!="" && FlashVars.PLATFORM==FlashVars.AIR_PLATFORM)
			{
				_streamName=game.httpStream;
				_connection.connect(null);
			}else
			{
				if (_server!="" && _application!="" && _streamName.search(".mp4")==-1)
					_connection.connect("rtmp://" + _server + "/" + _application);
				else if (_streamName.search(".mp4")!=-1){
					_connection.connect(null);
					//connectStream();
				}
			}
			
			//_videoCheckTimer.start();
			//_availabilityTimer.start();
			_waitTimer.start();
			_waiting = true;
			_videoStopped = false;
		}
		
		private function connectStream():void	{
			_stream = new NetStream(_connection);
			_stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_stream.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			_stream.client = { onBWDone: function():void{} };
			_stream.bufferTime =0.3;//delay;
			_stream.inBufferSeek = true;
			_stream.useHardwareDecoder=true;
			_stream.bufferTimeMax = _maxBuffer;
			signalBus.dispatch(VideoEvent.PLAY,{stream:_stream,stagevideo:(game.httpStream!="" && FlashVars.PLATFORM==FlashVars.AIR_PLATFORM)?true:false});
			debug("streamName: "+StringUtils.trim(_streamName));
			if (debugTimer==null)
			{
				debugTimer=new Timer(1000);
				debugTimer.addEventListener(TimerEvent.TIMER,function ():void{
					debug("buffer length:" + String(_stream.bufferLength) +" fps:" +String(_stream.currentFPS));
					//signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:"buf leng:" + String(_stream.bufferLength) +" fps:" +String(_stream.currentFPS)+" livedelay: "+ String(_stream.liveDelay)+ " bufferTimeMax:"+String(_stream.bufferTimeMax) });
				/*	if (_stream.bufferLength > 2) {
						//_stream.step(1);
						_stream.seek(1);
						
					}
					*/
				});
				
			}  
			debugTimer.start();
			//_stream.play(StringUtils.trim(_streamName));
		}
		
		
		public function refreshStream():void{
			_stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_connection.close();
			_stream.close();
			createConnection();
		}
		
		public function changeStream():void{
			_tempStreamName=_streamName;
			_streamName=game.xmodeStream;
			game.xmodeStream=_tempStreamName;
			refreshStream();
		}
		
		public function stopStream():void{
			_stream.removeEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_stream.close();
			_connection.close();
			debugTimer.stop();

		}
		
		private function netStatusHandler(event:NetStatusEvent):void {
			debug("NetStatusEvent: " + event.info.code);
			switch (event.info.code) {
				case CONNECTION_SUCCESSFUL:
					connectStream();
					break;
				case STREAM_NOT_FOUND:
					game.httpStream="";
					createConnection();
					break;
				case STARTED_PLAYING:
					//_video.onVideoStarted();
					break;
				case CONNECTION_CLOSED:
					//_stream.close();
					//_connection.close();
					_videoStopped = true;
					_videoReconnectTimer.start();
					debugTimer.stop();
				
					break;
				case "NetConnection.Connect.Rejected":
					_server=_servers[_serverIndex];
					if (_serverIndex<_servers.length-1)
					_serverIndex++;
					else
					_serverIndex=0;
					break;
			}
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			debug("SecurityErrorEvent: " + event);
		}
		
		private function IOErrorHandler(event:IOErrorEvent):void {
			debug("IOErrorEvent: " + event);
			_stream.close();
			_connection.close();
			_videoCheckTimer.stop();
		}
		
		public function onMetaData(info:Object):void {
			_streamAvailable = true;
			//_video.onMetaData(info);
		}
		public function get delay():Number {
			var delay:uint = 0;
			if (_streamAvailable && stream != null) {
				delay = (buffer > 3) ? 3 : buffer;
			}
			return delay;
		}
		
		public function get buffer():Number {
			if (_streamAvailable && stream != null) {
				return _stream.bufferLength+0.3;
			}
			else {
				return 0.3;
			}
		}
		
		public function close(... args):void {
			_stream.close();
			_connection.close();
			_videoCheckTimer.stop();
		}
		
		public function onBWDone():void {
			
		}
		
		public function set volume(volume:Number):void {
			_soundTransform.volume = volume;
			_stream.soundTransform = _soundTransform;
		}
		
		public function set servers(servers:Array):void {
			_servers = servers;
		}
		
		public function get servers():Array {
			return _servers;
		}
		
		public function set streams(streams:Array):void {
			_streams = streams;
		}
		
		public function get streams():Array {
			return _streams;
		}
		
		public function set application(app:String):void {
			_application = app;
		}
		
		public function get application():String {
			return _application;
		}
		
		public function set settings(settings:XML):void {
			_settings = settings;
			_maxBuffer = Number(settings.buffer_max) + 1;
			_bwCheck = Number(settings.bandwidth);
			_buffer_min=Number(settings.buffer_min);
			_streamIndex = _streams.length - 1;
			
			
		}
		
		private function switchStream(type:String, clear:Boolean = false):void {
			debug("SWITCHING STREAM: " + type + "CLEAR: " + clear + " VIDEO QUALITY: ");			
			switch (type) {
				case DOWNGRADE:
					_streamIndex = _streamIndex - 1;
					break;
				case UPGRADE:
					_streamIndex = _streamIndex + 1;
					break;
			}
			_streamName = _streams[_streamIndex];
			debug("SWITCHING VIDEO: " + type + " FEED: " + _streamName);
			if (clear) {
				_stream.close();
				//_video.clear();
				//_video.stream = _stream;
				_stream.play(StringUtils.trim(_streamName));
			}
			else {
				_stream.pause();
				var seekTime:Number = _stream.time;
				_stream.play(_streamName);
				_stream.seek(seekTime);
				_stream.resume();
			}
			
			if (_streamIndex == 2) {
				_maxBuffer = Number(_settings.buffer_max);
				_bwCheck = Number(_settings.bandwidth) / 2;
			}
			else if (_streamIndex == 1) {
				_maxBuffer = uint(_settings.buffer_max) + 3; 
				_bwCheck = uint(_settings.bandwidth) / 2;
			}
			else if (_streamIndex == 0) {
				_maxBuffer = uint(_settings.buffer_max) + 7;
				_bwCheck = uint(_settings.bandwidth) / 3;
			}
			
			_waitTimer.start();
			_waiting = true;
			
			_streamAvailable = false;
			_availabilityTimer.start();
		}
		
		private function checkVideo(event:TimerEvent):void {
			if (_streamAvailable && !_downgradeCheck) {
				if(!_waiting) {
					if (_stream.bufferLength >= _maxBuffer) {
						debug("BUFFER CHECK FAILED WAITING FOR IT TO SETTLE DOWN");
						_downgradeCheck = true;
						_switchTimer.start();
					}
					else if (_stream.currentFPS < uint(_settings.fps_min) && _stream.info.videoBytesPerSecond < _bwCheck) {						
						if (_streamIndex == 0) {
							debug("FPS CHECK FAILED, NOT RELOADING AS THE FEED IS ALREADY LOW");
							switchStream(RELOAD);
						}
						else {
							debug("FPS CHECK FAILED DOWNGRADING");
							switchStream(DOWNGRADE);
						}
					}
				}
			}
		}
		public function get streamName():String{
			return _streamName;
		}
		private function checkAndSwitchVideo(evt:TimerEvent):void {
			_switchTimer.stop();
			_downgradeCheck = false;
			debug("BUFFER AGAIN: " + _stream.bufferLength);
			debug("FPS AGAIN: " + _stream.currentFPS);
			debug("BUFFER MAX SETTING: " + uint(_settings.buffer_max));
			debug("FPS MAX SETTING: " + uint(_settings.fps_max));
			if (_stream.bufferLength >= _maxBuffer) {
				debug("[VIDEO] BUFFER MAX: " + _maxBuffer);
				if(_stream.info.videoBytesPerSecond < _bwCheck && _streamIndex > 0) {
					debug("BUFFER CHECK FAILED AFTER WAITING SO DOWNGRADING");
					switchStream(DOWNGRADE);
				}
				else if (_stream.info.videoBytesPerSecond >= _bwCheck || _streamIndex == 0) {
					debug("BUFFER CHECK FAILED AFTER WAITING SO RELOADING");
					switchStream(RELOAD);
				}
			}
		}
		
		private function waitingTimeCheck(evt:TimerEvent):void {
			_waitTimer.stop();
			_waiting = false;
		}
		
		private function checkVideoConnection(evt:TimerEvent):void {
			if (_videoStopped) {				
				createConnection();
			}
			else {
				_videoReconnectTimer.stop();
			}
		}
		
		private function checkStreamAvailability(evt:TimerEvent):void {			
			if (!_streamAvailable) {
				if (_streamIndex > 0) {
					switchStream(DOWNGRADE);
					debug("STREAM NOT AVAILABLE... SWITCHING FEED");
				}
				else {
					switchStream(RELOAD);
					debug("STREAM NOT AVAILABLE... RELOADING SAME FEED AGAIN");
				}
				//dispatchEvent(new Event("VideoLoaded"));
			}
			else {
				_availabilityTimer.stop()
			}
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}