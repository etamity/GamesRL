package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.model.Chat;
	import com.newco.grand.core.common.service.ChatSocketService;
	import com.newco.grand.core.utils.GameUtils;
	
	public class ChatConnectionCommand extends BaseCommand {
		
		[Inject]
		public var chat:Chat;
		
		[Inject]
		public var chatService:ChatSocketService;
		
		override public function execute():void {
			chatService.connectToSocket(chat.server, chat.port);
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}