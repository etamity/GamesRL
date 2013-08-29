package com.newco.grand.baccarat.classic.controller.commands {
	
	import com.newco.grand.baccarat.classic.service.TableConfigService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class StateTableConfigCommand extends Command {
		
		[Inject]
		public var service:TableConfigService;
		override public function execute():void {
			service.load();	
		}
	
	}
}