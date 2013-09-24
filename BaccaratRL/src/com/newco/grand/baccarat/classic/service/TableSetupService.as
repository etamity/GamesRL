package com.newco.grand.baccarat.classic.service
{
	import com.newco.grand.baccarat.classic.controller.signals.WinnersEvent;
	import com.newco.grand.baccarat.classic.model.GameDataModel;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.controller.signals.SocketEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.utils.GameUtils;
	
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
			
			//service.remove(Constants.SERVER_STATE);
			loadTableConfig();
		}
		
		private function loadSettings():void{
			/*service.addLoader(new XMLLoader(new URLRequest(urls.settings), Constants.SERVER_SETTING));
			service.getLoader(Constants.SERVER_SETTING).onError.add(showError);
			service.getLoader(Constants.SERVER_SETTING).onComplete.add(setSetting);		
			service.getLoader(Constants.SERVER_SETTING).onHttpStatus.add(showStatus);
			service.start();*/
			
			debug("Settings ",urls.settings);
			service.loadURL(urls.settings,setSetting,showError);
		}
		
		public function showStatus(signal:HttpStatusSignal):void{
			debug("Status:" +signal.status);
		}
		
		private function setSetting(signal:LoaderSignal, xml:XML):void {
			
			game.server = xml["videoservers"];
			game.videoSettings=xml;
			
			
			signalBus.dispatch(ModelReadyEvent.READY);
			signalBus.dispatch(SocketEvent.CONNECT_GAME);
			signalBus.dispatch(VideoEvent.CONNECT);
			signalBus.dispatch(StateTableConfigEvent.LOADED);
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
			//service.remove(Constants.SERVER_SETTING);
		}
		
		private function loadTableConfig():void {
			/*debug('TableConfig URL ' + tableConfigUrl);
			service.addLoader(new XMLLoader(new URLRequest(tableConfigUrl), Constants.SERVER_TABLE_CONFIG));
			service.getLoader(Constants.SERVER_TABLE_CONFIG).onError.add(showError);
			service.getLoader(Constants.SERVER_TABLE_CONFIG).onComplete.add(setTableConfig);
			service.start();*/
			
			debug("TableConfig ",urls.tableConfig);
			service.loadURL(urls.tableConfig,setTableConfig,showError);
		}
		
		private function setTableConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			game.min = xml["gameconfig-param"].@table_bet_min_limit;
			game.max = xml["gameconfig-param"].@table_bet_max_limit;
			game.idle_limit_games=xml["gameconfig-param"].@idle_limit_games;
			game.videoStream= xml["gameconfig-param"].@high_stream;
			
			game.banker_max_bet=xml["gameconfig-param"].@banker_max_bet;
			game.banker_min_bet=xml["gameconfig-param"].@banker_min_bet;
			
			game.player_max_bet=xml["gameconfig-param"].@player_max_bet;
			game.player_min_bet=xml["gameconfig-param"].@player_min_bet;
			
			game.pairs_player_max_bet=xml["gameconfig-param"].@pair_player_max_bet;
			game.pairs_player_min_bet=xml["gameconfig-param"].@pair_player_min_bet;
			
			game.pairs_banker_max_bet=xml["gameconfig-param"].@pair_banker_max_bet;
			game._pairsbanker_min_bet=xml["gameconfig-param"].@pair_banker_min_bet;
			
			game.tie_max_bet=xml["gameconfig-param"].@tie_max_bet;
			game.tie_min_bet=xml["gameconfig-param"].@tie_min_bet;
			game.videoStream= xml["gameconfig-param"].@low_stream;
			
			//service.remove(Constants.SERVER_TABLE_CONFIG);
			
			var streams:Array=new Array(xml["gameconfig-param"].@low_stream,xml["gameconfig-param"].@med_stream,xml["gameconfig-param"].@hi_stream);
			game.videoStreams=streams;
			debug("game.videoStreams:",game.videoStreams);
			loadSettings();
			
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