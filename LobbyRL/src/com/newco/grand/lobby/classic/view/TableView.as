package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	import com.newco.grand.lobby.classic.model.TableModel;
	
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	import org.osflash.signals.Signal;
	
	public class TableView extends TableAsset
	{
		//protected var _display:TableAsset;
		private var _video:Video;
		
		private var _server:String;
		private var _streamName:String;
		private var _streamApplication:String;
		
		private var _tableModel:TableModel;
		
		private var nc:NetConnection;
		private var ns:NetStream;
		
		public var playDetialSignal:Signal=new Signal();
		public var stopDetialSignal:Signal=new Signal();
		public var openGameSignal:Signal=new Signal();
		public function TableView()
		{
			
			_video=new Video();
			addChild(_video);
			//initDisplay();
			_video.x=3;
			_video.y=5;
			_video.width=width-4*2;
			_video.height=height-5*2;
			
			buttonMode=true;
			this.addEventListener(MouseEvent.CLICK,doGameClick);
			this.addEventListener(MouseEvent.ROLL_OVER,doRollOver);
			this.addEventListener(MouseEvent.ROLL_OUT,doRollOut);
		}
		
		private function doGameClick(evt:MouseEvent):void{
			openGameSignal.dispatch(_tableModel);
		}
		private function doRollOver(evt:MouseEvent):void{
			playDetialSignal.dispatch();
		}
		private function doRollOut(evt:MouseEvent):void{
			stopDetialSignal.dispatch();
		}
		public function init():void
		{
		}
		
		public function align():void
		{
		}
		
		/*public function initDisplay():void
		{
			_display= new TableAsset();
			addChild(_display);
		}
		*/
		
		public function playStream():void{
			nc = new NetConnection();
			nc.client={ onBWDone: function():void{} };
			nc.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);		
			nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			
			
			trace("video_sever",streamPath);
			nc.connect(streamPath);
		}
		
		public function get streamPath():String{
			return _tableModel.streamMode+"://"+_server+"/"+_streamApplication;
		}
		
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("SecurityErrorEvent: " + event);
		}
		
		private function IOErrorHandler(event:IOErrorEvent):void {
			trace("IOErrorEvent: " + event);
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace(event.text);
		}
		
		private function connectStream():void	{
			ns = new NetStream(nc);
			ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			ns.client ={ onBWDone: function():void{} };
			ns.addEventListener(IOErrorEvent.IO_ERROR, IOError);
			ns.bufferTime = 0.3;

			_video.attachNetStream(ns);
			
			
			ns.play(_streamName);
			
			
		}
		
		
		public function destory():void{
			ns.close();
			nc.close();
	
			nc=null;
			ns=null;
			_video.clear();
			_video=null;
			
		}
		
		private function IOError(event:IOErrorEvent):void {
			trace("Error on Player stream");
		}
		private function netStatusHandler(event:NetStatusEvent):void {
			trace("NetStatusEvent: " + event.info.code);
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
					break;
				case "NetStream.Unpause.Notify":
					
					break;
			}
		}
		public function setModel(data:TableModel):void{
			tableName.text=data.tableName.toUpperCase();
			min.text=String(data.min);
			max.text=String(data.max);
			_server =data.streamSever;
			_streamApplication= data.streamApplication;
			_streamName=data.streamName;
			_tableModel=data;
			//playStream();
		}
	}
}