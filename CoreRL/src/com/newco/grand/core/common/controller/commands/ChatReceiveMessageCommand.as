package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ChatEvent;
	import com.newco.grand.core.common.model.Chat;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.service.ChatSocketService;
	import com.newco.grand.core.utils.GameUtils;
	
	public class ChatReceiveMessageCommand extends BaseCommand	{
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var service:ChatSocketService;
		
		[Inject]
		public var chat:Chat;
		
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var signal:BaseSignal;
		private const WELCOME:String = "ALERT_WELCOME";
		
		override public function execute():void	{			
			parseReceivedMessage();
		}
		
		private function parseReceivedMessage():void {
			/**
			<message channel="game-casino-holdem" vtid="">
				<name type="PLAY" userId="27sgzciyeilxoksi">ernesto</name>
				<text>asdf</text>
				<time>1286889720736</time>
				<msg_action>MSG_NORMAL</msg_action>
			</message>
			**/
			var xml:XML = XML(signal.params.node);
			chat.sender = xml.name;
			chat.message = unescape(xml.text);
			
			if(xml.msg_action == WELCOME) {
				signalBus.dispatch(ChatEvent.SHOW_WELCOME_MESSAGE);
			}
			else {
				signalBus.dispatch(ChatEvent.SHOW_MESSAGE);
			}
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}