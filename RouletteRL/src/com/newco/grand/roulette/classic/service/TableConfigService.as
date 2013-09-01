package com.newco.grand.roulette.classic.service
{
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
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
	import com.newco.grand.roulette.classic.model.GameDataModel;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class TableConfigService implements IService
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
		
		public function TableConfigService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
		}
		
		private function loadState():void {
			debug("State ",urls.state);
		/*	service.addLoader(new XMLLoader(new URLRequest(stateUrl), Constants.SERVER_STATE));
			service.getLoader(Constants.SERVER_STATE).onError.add(showError);
			service.getLoader(Constants.SERVER_STATE).onComplete.add(setState);			
			service.start();*/
			debug("State ",urls.state);
			service.loadURL(urls.state,setState,showError);
		}
		
		private function setState(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			game.chips = String(xml.chip_amounts).split(",");
			game.table = xml.table;
			game.recentResults = xml.recentresults;
			player.currencyCode = xml.currency_code;
			
			//service.remove(Constants.SERVER_STATE);
			loadTableConfig();
		}
		
		private function loadSettings():void{
			/*service.addLoader(new XMLLoader(new URLRequest(urls.settings), Constants.SERVER_SETTING));
			service.getLoader(Constants.SERVER_SETTING).onError.add(showError);
			service.getLoader(Constants.SERVER_SETTING).onComplete.add(setSetting);			
			service.start();*/
			debug("Settings ",urls.settings);
			service.loadURL(urls.settings,setSetting,showError);
		}
		private function setSetting(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			game.server = xml["videoservers"];
			
			game.videoSettings=xml;
			
			
			/*eventDispatcher.dispatchEvent(new ModelReadyEvent(ModelReadyEvent.READY));
			eventDispatcher.dispatchEvent(new SocketEvent(SocketEvent.CONNECT_GAME));
			eventDispatcher.dispatchEvent(new VideoEvent(VideoEvent.CONNECT));
			eventDispatcher.dispatchEvent(new PlayersEvent(PlayersEvent.LOAD));
			eventDispatcher.dispatchEvent(new WinnersEvent(WinnersEvent.LOAD));
			eventDispatcher.dispatchEvent(new StatisticsEvent(StatisticsEvent.LOAD));
			eventDispatcher.dispatchEvent(new StateTableConfigEvent(StateTableConfigEvent.LOADED));*/
			
			signalBus.dispatch(ModelReadyEvent.READY);
			signalBus.dispatch(SocketEvent.CONNECT_GAME);
			signalBus.dispatch(VideoEvent.CONNECT);
			signalBus.dispatch(StateTableConfigEvent.LOADED);
			
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
			//debug(xml);
			game.min = xml["gameconfig-param"].@table_bet_min_limit;
			game.max = xml["gameconfig-param"].@table_bet_max_limit;
			game.dozenMin = xml["gameconfig-param"].@dozen_bet_min;
			game.dozenMax = xml["gameconfig-param"].@dozen_bet_max;
			game.highMin = xml["gameconfig-param"].@high_bet_min;
			game.highMax = xml["gameconfig-param"].@high_bet_max;
			game.lowMin = xml["gameconfig-param"].@low_bet_min;
			game.lowMax = xml["gameconfig-param"].@low_bet_max;
			game.straightMin = xml["gameconfig-param"].@straight_bet_min;
			game.straightMax = xml["gameconfig-param"].@straight_bet_max;
			game.oddMin = xml["gameconfig-param"].@odd_bet_min;
			game.oddMax = xml["gameconfig-param"].@odd_bet_max;
			game.evenMin = xml["gameconfig-param"].@even_bet_min;
			game.evenMax = xml["gameconfig-param"].@even_bet_max;
			game.columnMin = xml["gameconfig-param"].@column_bet_min;
			game.columnMax = xml["gameconfig-param"].@column_bet_max;
			game.blackMin = xml["gameconfig-param"].@black_bet_min;
			game.blackMax = xml["gameconfig-param"].@black_bet_max;
			game.redMin = xml["gameconfig-param"].@red_bet_min;
			game.redMax = xml["gameconfig-param"].@red_bet_max;
			game.trioMin = xml["gameconfig-param"].@trio_bet_min;
			game.trioMax = xml["gameconfig-param"].@trio_bet_max;
			game.splitMin = xml["gameconfig-param"].@split_bet_min;
			game.splitMax = xml["gameconfig-param"].@split_bet_max;
			game.fiveMin = xml["gameconfig-param"].@five_number_bet_min;
			game.fiveMax = xml["gameconfig-param"].@five_number_bet_max;
			game.sixMin = xml["gameconfig-param"].@six_number_bet_min;
			game.sixMax = xml["gameconfig-param"].@six_number_bet_max;
			game.cornerMin = xml["gameconfig-param"].@corner_bet_min;
			game.cornerMax = xml["gameconfig-param"].@corner_bet_max;
			game.server= xml["gameconfig-param"].@broadcast_ip2;
			
			//service.remove(Constants.SERVER_TABLE_CONFIG);
			var streams:Array=new Array(xml["gameconfig-param"].@low_stream,xml["gameconfig-param"].@med_stream,xml["gameconfig-param"].@high_stream);
			game.videoStreams=streams;
			
			loadSettings();
			
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("Error:" +signal.message);
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}