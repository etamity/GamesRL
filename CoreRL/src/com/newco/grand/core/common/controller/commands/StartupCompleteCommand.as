package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	
	public class StartupCompleteCommand extends BaseCommand {
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		public function StartupCompleteCommand() {
			super();
		}
		
		override public function execute():void	{
			signalBus.dispatch(UIEvent.SETUP_VIEWS);
		}
		

	}
}