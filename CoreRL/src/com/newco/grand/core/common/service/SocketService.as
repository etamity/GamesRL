package com.newco.grand.core.common.service {

	import com.newco.grand.core.common.model.Actor;
	import com.newco.grand.core.common.model.FlashVars;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	
	public class SocketService extends Actor implements ISocketService {
		
		[Inject]
		public var flashVars:FlashVars;
	
		private var _socket:XMLSocket;
		private var _socketOpen:Boolean;
		
		public function SocketService() {
			_socket = new XMLSocket();
			configureListeners(_socket);
		}
		
		private function configureListeners(evt:IEventDispatcher):void {
			evt.addEventListener(Event.CLOSE, closeHandler);
			evt.addEventListener(Event.CONNECT, connectHandler);
			evt.addEventListener(DataEvent.DATA, dataHandler);
			evt.addEventListener(IOErrorEvent.IO_ERROR, socketIOErrorHandler);
			evt.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		public function connectToSocket(server:String, port:int):void {
			try {
				_socket.connect(server, port);
				debug(server, port);
			} 
			catch (error:Error) {}
		}
		
		public function closeSocketConnection():void {				    
			_socket.close();
			_socketOpen = false;
		}
		
		private function closeHandler(evt:Event):void {			
			_socketOpen = false;
		}		
		
		private function connectHandler(evt:Event):void {
			_socketOpen = true;
			subscribeToSocket();
		}
		
		private function securityErrorHandler(evt:SecurityErrorEvent):void {
			debug("CONNECTION SECURITY ERROR");
		}
		
		private function socketIOErrorHandler(evt:IOErrorEvent):void {
			debug("CONNECTION IO ERROR");
		}	
				
		protected function subscribeToSocket():void {
			var subscribe:XML = new XML("<subscribe channel='session-" + flashVars.user_id + "'></subscribe>");
			sendMessage(subscribe);
			debug("SUBSCRIBE XML: " + subscribe);
		}
		
		protected function subscribeToChannel():void {
			var subscribe:XML = new XML("<subscribe channel='table-" + flashVars.table_id + "'><player id='" + flashVars.user_id + "' vtid=''></player></subscribe>");
			sendMessage(subscribe);
			debug("SUBSCRIBE TO CHANNEL XML: " + subscribe);
		}
		
		protected function dataHandler(evt:DataEvent):void {
			
		}
		
		public function sendMessage(msg:XML):void {
			if(_socketOpen){
				_socket.send(msg);
				debug("SENDING MESSAGE: " + msg);
			}
		}
		
		protected function debug(...args):void {
			trace(this, args);
		}
	}
}