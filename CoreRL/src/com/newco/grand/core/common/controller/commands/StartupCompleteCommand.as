package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
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
			if(flashVars.localhost) {
				signalBus.dispatch(LoginEvent.INITIALIZE);
			} else 
			{
				signalBus.dispatch(LoginEvent.LOGIN_SUCCESS);
				signalBus.dispatch(StartupDataEvent.SEAT);
				signalBus.dispatch(StartupDataEvent.LOAD);
			}
		}
		

	}
}