package com.ai.core.common.controller.commands {
	
	import com.ai.core.model.FlashVars;
	import com.ai.core.service.ISocketService;
	import com.ai.core.utils.GameUtils;
	
	public class SocketConnectionCommand extends BaseCommand {
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var gameService:ISocketService;
		
		override public function execute():void {
			debug("Connect ", flashVars.server,flashVars.port);
			gameService.connectToSocket(flashVars.server, flashVars.port);
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}