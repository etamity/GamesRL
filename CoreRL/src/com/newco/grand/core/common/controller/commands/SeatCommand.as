package com.newco.grand.core.common.controller.commands
{
	import com.newco.grand.core.common.service.impl.SeatService;

	public class SeatCommand extends BaseCommand
	{
		[Inject]
		public var service:SeatService;

		public function SeatCommand()
		{
			super();
		}
		override public function execute():void {
			service.load();	
		}

	}
}