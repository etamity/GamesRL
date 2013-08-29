package com.newco.grand.core.common.controller.commands {	
	
	import com.newco.grand.core.common.service.impl.LanguageService;
	
	public class StartupDataCommand extends BaseCommand {

		[Inject]
		public var service:LanguageService;
		override public function execute():void {
			service.load();	
		}
		
	}
}