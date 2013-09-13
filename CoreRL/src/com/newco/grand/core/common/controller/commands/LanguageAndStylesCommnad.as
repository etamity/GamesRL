package com.newco.grand.core.common.controller.commands
{
	import com.newco.grand.core.common.service.impl.LanguageService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class LanguageAndStylesCommnad extends Command
	{
		[Inject]
		public var service:LanguageService;
		public function LanguageAndStylesCommnad()
		{
			super();
		}
		override public function execute():void {
			service.load();	
		}
		
	}
}