package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.service.impl.PlayerService;
	
	public class PlayersCommand extends BaseCommand {
		
		[Inject]
		public var service:PlayerService;
		override public function execute():void {
			service.load();	
		}
	
	}
}