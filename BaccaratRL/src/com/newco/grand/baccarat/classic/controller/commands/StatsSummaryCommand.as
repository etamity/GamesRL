package com.newco.grand.baccarat.classic.controller.commands {
	
	import com.newco.grand.baccarat.classic.service.StatsSummaryService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class StatsSummaryCommand extends Command {
		
		[Inject]
		public var service:StatsSummaryService;
		override public function execute():void {
			service.load();	
		}
	
	}
}