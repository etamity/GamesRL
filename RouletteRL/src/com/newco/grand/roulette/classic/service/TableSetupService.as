package com.newco.grand.roulette.classic.service
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.controller.signals.SocketEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.controller.signals.WinnersEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SettingsModel;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.TableConfig;
	import com.newco.grand.core.common.model.TableState;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.HttpStatusSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class TableSetupService
	{
		[Inject]
		public var service:XMLService;
		
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
		
		[Inject]
		public var tableConfig:TableConfig;
		
		[Inject]
		public var tableState:TableState;
		
		[Inject]
		public var settings:SettingsModel;
		public function TableSetupService()
		{
		}
		private function setup():void {

		}
		
		private function setState(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			game.chips = String(xml.chip_amounts).split(",");
			game.table = xml.table_name;
			player.currencyCode = xml.currency_code;
		}
		
		private function loadSettings():void {
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("Error:" +signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}