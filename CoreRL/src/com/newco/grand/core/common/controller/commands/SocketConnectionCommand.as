package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.service.ISocketService;
	import com.newco.grand.core.utils.GameUtils;
	
	public class SocketConnectionCommand extends BaseCommand {
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var gameService:ISocketService;
		
		override public function execute():void {
			debug("Connect ", flashVars.socketServer,flashVars.port);
			gameService.connectToSocket(flashVars.socketServer, flashVars.port);
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}