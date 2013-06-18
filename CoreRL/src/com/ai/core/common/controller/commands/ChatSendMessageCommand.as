package com.ai.core.common.controller.commands {
	
	import com.ai.core.model.Chat;
	import com.ai.core.model.FlashVars;
	import com.ai.core.service.ChatSocketService;
	import com.ai.core.utils.GameUtils;
	
	public class ChatSendMessageCommand extends BaseCommand	{
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var service:ChatSocketService;
		
		[Inject]
		public var chat:Chat;
		
		override public function execute():void	{
			var message:XML = new XML("<command channel='" + flashVars.room + "'><message>" + escape(chat.message) + "</message></command>");
			service.sendMessage(message);
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}