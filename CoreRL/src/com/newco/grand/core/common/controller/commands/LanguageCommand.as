package com.newco.grand.core.common.controller.commands
{
	import com.newco.grand.core.common.service.impl.LanguageService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class LanguageCommand extends Command
	{
		[Inject]
		public var langService:LanguageService;
		public function LanguageCommand()
		{
			super();
		}
		override public function execute():void {
			langService.load();
		}
	}
}