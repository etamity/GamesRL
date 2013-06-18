package com.ai.core.common.controller.commands {
	
	import com.ai.core.common.model.Chat;
	import com.ai.core.service.ChatSocketService;
	import com.ai.core.utils.GameUtils;
	
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