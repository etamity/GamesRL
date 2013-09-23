package com.newco.grand.core.common.controller.commands
{
	import com.newco.grand.core.common.service.impl.TableConfigService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class TableDataCommand extends Command
	{
		[Inject]
		public var service:TableConfigService;
		public function TableDataCommand()
		{
			super();
		}
		override public function execute():void {
			service.load();	
		}
	}
}