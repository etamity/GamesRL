package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.WinnerListService;
	import com.newco.grand.core.utils.GameUtils;
	
	public class WinnersCommand extends BaseCommand {
		
		[Inject]
		public var service:WinnerListService;
		
		[Inject]
		public var urls:URLSModel;
	
		
		[Inject]
		public var flashvars:FlashVars;

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