package com.newco.grand.core.common.controller.commands {	
	
	import com.newco.grand.core.common.controller.signals.ChatEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.WinnersEvent;
	import com.newco.grand.core.common.model.SignalBus;
	
	public class StartupDataCommand extends BaseCommand {

		[Inject]
		public var signalBus:SignalBus;
		override public function execute():void {
			signalBus.dispatch(StateTableConfigEvent.LOAD);
			signalBus.dispatch(StartupDataEvent.LOADED);
			signalBus.dispatch(ChatEvent.LOAD_CONFIG);
			signalBus.dispatch(UIEvent.SETUP_ASSET);
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
		}
		
	}
}