package com.ai.core.service {
	
	import com.ai.core.controller.signals.ChatEvent;
	import com.ai.core.model.Chat;
	import com.ai.core.model.IGameData;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	
	import flash.events.DataEvent;
	
	public class ChatSocketService extends SocketService {
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var chat:Chat;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function ChatSocketService() {			
			
		}
		
		override protected function dataHandler(event:DataEvent):void {
			debug("[SOCKET] DATA: " + event.data);			
			var node:XML = new XML(event.data);
			if(node.name().localName == "message") {
				signalBus.dispatch(ChatEvent.PROCESS_MESSAGE, {node:node});				
			}
		}
		
		override protected function subscribeToSocket():void {
			var subscribe:String = "<subscribe channel='" + chat.room + "'><id type='" + player.type + "' vtid='" + flashVars.vt_id + "'>" + player.id + "</id></subscribe>";
			debug("[CHAT] SUBSCRIBE XML: " + subscribe);
			sendMessage(new XML(subscribe));
		}
	}
}