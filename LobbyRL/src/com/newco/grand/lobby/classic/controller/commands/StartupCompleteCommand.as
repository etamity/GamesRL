package com.newco.grand.lobby.classic.controller.commands
{
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.model.SignalBus;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class StartupCompleteCommand extends Command
	{
		[Inject]
		public var signalBus:SignalBus;
		public function StartupCompleteCommand()
		{
			super();
		}
		override public function execute():void {	
			signalBus.dispatch(LanguageAndStylesEvent.LOAD);
		}
	}
}