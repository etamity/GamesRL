package com.newco.grand.core.common.controller.commands
{
	import com.newco.grand.core.common.service.impl.HelpSWFService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HelpSWFCommand extends Command
	{
		[Inject]
		public var helpSWFService:HelpSWFService
		public function HelpSWFCommand()
		{
			super();
		}
		override public function execute():void {
			helpSWFService.load();
		}
	}
}