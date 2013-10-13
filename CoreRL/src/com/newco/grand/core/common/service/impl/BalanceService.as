package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class BalanceService implements IService
	{
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var player:Player;
		[Inject]
		public var flashvars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		public function BalanceService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			loadBalance();
		}
		private function loadBalance():void {
			/*if(!service.hasLoader(Constants.SERVER_BALANCE)) {
				debug(urls.balance);
				service.addLoader(new XMLLoader(new URLRequest(urls.balance), Constants.SERVER_BALANCE));
				service.getLoader(Constants.SERVER_BALANCE).onError.add(showError);
				service.getLoader(Constants.SERVER_BALANCE).onComplete.add(setBalance);
				service.start();
				
			}*/
			debug(urls.balance);
			service.loadURL(urls.balance,setBalance,showError);
		}
		
		private function setBalance(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			player.id = xml.userid;
			flashvars.user_id=player.id;
			player.balance = Number(xml.balance);
			player.bonus = Number(xml.bonus_balance);
			player.currencyCode = xml.currency_code;
			player.currency = xml.currency;
			//service.remove(Constants.SERVER_BALANCE);
			
			signalBus.dispatch(BalanceEvent.LOADED);
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error");
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}