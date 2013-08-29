package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.service.impl.SendBetsService;
	
	public class BetsCommand extends BaseCommand {
		
		[Inject]
		public var service:SendBetsService;
		
		public function BetsCommand():void{
	
		}
		
		override public function execute():void {
			service.load();
		}
	}
}