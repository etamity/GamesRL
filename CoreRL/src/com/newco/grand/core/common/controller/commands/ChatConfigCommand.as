package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.service.impl.ChatConfigService;
	
	public class ChatConfigCommand extends BaseCommand {
	
		[Inject]
		public var service:ChatConfigService;
		override public function execute():void {
			service.load();			
		}
		
	
	}
}