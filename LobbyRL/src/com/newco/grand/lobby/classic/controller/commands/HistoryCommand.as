package com.newco.grand.lobby.classic.controller.commands
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class HistoryCommand extends Command
	{
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var service:IAssetLoader;
		[Inject]
		public var urls:URLSModel;
		[Inject]
		public var flashVars:FlashVars;
		private var ACCOUNTXML:String="ACCOUNTXML";
		private var ACTIVITYXML:String="ACTIVITYXML";
		
		private var account_url:String;
		private var activity_url:String;
		public function HistoryCommand()
		{
			super();
		}
		override public function execute():void {
			account_url =urls.accountHistory+"?user_id="+flashVars.user_id;
			service.addLoader(new XMLLoader(new URLRequest(account_url), ACCOUNTXML));
			service.getLoader(ACCOUNTXML).onError.add(showErrorAccount);
			service.getLoader(ACCOUNTXML).onComplete.add(setConfigAccount);
			
			activity_url =urls.activityHistory+"?user_id="+flashVars.user_id;
			service.addLoader(new XMLLoader(new URLRequest(activity_url), ACTIVITYXML));
			service.getLoader(ACTIVITYXML).onError.add(showErrorActivity);
			service.getLoader(ACTIVITYXML).onComplete.add(setConfigActivity);	
			service.start();
		}
		private function showErrorActivity(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message + "::" +activity_url});
		}
		private function showErrorAccount(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message + "::" +account_url});
		}
		private function setConfigActivity(signal:LoaderSignal, xml:XML):void{
			debug(xml);
			signalBus.dispatch(LobbyEvents.ACTIVITYHISTORY_LOADED,{xml:xml});
		}
		private function setConfigAccount(signal:LoaderSignal, xml:XML):void{
			debug(xml);
			signalBus.dispatch(LobbyEvents.ACCOUNTHISTORY_LOADED,{xml:xml});
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}