package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.base.Param;
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.core.IParam;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class BalanceCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var player:Player;

		[Inject]
		public var signalBus:SignalBus;
		
	    override public function execute():void {
			loadBalance();
		}
		private function loadBalance():void {
			if(!service.hasLoader(Constants.SERVER_BALANCE)) {
				debug(urls.balance);
				service.addLoader(new XMLLoader(new URLRequest(urls.balance), Constants.SERVER_BALANCE));
				service.getLoader(Constants.SERVER_BALANCE).onError.add(showError);
				service.getLoader(Constants.SERVER_BALANCE).onComplete.add(setBalance);
				service.start();
			}
		}
		
		private function setBalance(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			player.id = xml.userid;
			player.balance = Number(xml.balance);
			player.bonus = Number(xml.bonus_balance);
			player.currencyCode = xml.currency_code;
			player.currency = xml.currency;
			service.remove(Constants.SERVER_BALANCE);

			signalBus.dispatch(BalanceEvent.LOADED);
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}