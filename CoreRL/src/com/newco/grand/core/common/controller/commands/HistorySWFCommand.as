package com.newco.grand.core.common.controller.commands
{
	import com.newco.grand.core.common.service.impl.HistorySWFService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HistorySWFCommand extends Command
	{
		[Inject]
		public var historySWFService:HistorySWFService
		public function HistorySWFCommand()
		{
			super();
		}
		override public function execute():void {
			historySWFService.load();
		}
	}
}