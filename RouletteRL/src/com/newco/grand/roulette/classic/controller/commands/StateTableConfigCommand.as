package com.newco.grand.roulette.classic.controller.commands {
	
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.service.TableConfigService;
	
	public class StateTableConfigCommand extends BaseCommand {
		
		[Inject]
		public var service:TableConfigService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;

		override public function execute():void {
			service.load();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}