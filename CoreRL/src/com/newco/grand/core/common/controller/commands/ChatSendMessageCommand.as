package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.model.Chat;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.service.ChatSocketService;
	import com.newco.grand.core.utils.GameUtils;
	
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