package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.service.impl.BalanceService;
	
	public class BalanceCommand extends BaseCommand {
		
		[Inject]
		public var service:BalanceService;
		
	    override public function execute():void {
			service.load();
		}
	
	}
}