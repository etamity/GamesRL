package com.ai.roulette.controller.commands {
	
	import com.ai.core.controller.commands.BaseCommand;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.PlayersEvent;
	import com.ai.core.controller.signals.SocketEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.controller.signals.VideoEvent;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	import com.ai.roulette.controller.signals.StatisticsEvent;
	import com.ai.roulette.controller.signals.WinnersEvent;
	import com.ai.roulette.model.GameDataModel;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class StateTableConfigCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
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
		
		public var vt_id:String="";
		
		
		private var stateUrl:String;
		private var tableConfigUrl:String;
		override public function execute():void {
			
			stateUrl = urls.state+ "?table_id=" + flashVars.table_id+vt_id;
			tableConfigUrl = urls.tableConfig + "?table_id=" + flashVars.table_id+vt_id;
			//configUrl();
			
			loadState();			
		}
		
		private function configUrl():void{
			if (flashVars.localhost){
				stateUrl ="xml/"+ flashVars.game+"_state.xml";
				tableConfigUrl= "xml/"+flashVars.game+"_tableconfig.xml";
			}else
			{
				stateUrl = urls.state+ "?table_id=" + flashVars.table_id+vt_id;
				tableConfigUrl = urls.tableConfig + "?table_id=" + flashVars.table_id+vt_id;
			}
		}
		
		private function loadState():void {
			if (String(flashVars.vt_id).length > 10) {
				vt_id = "&vt_id="+flashVars.vt_id;
			}
			else {
				vt_id = "";
			}
			debug("State ",stateUrl);
			service.addLoader(new XMLLoader(new URLRequest(stateUrl), Constants.SERVER_STATE));
			service.getLoader(Constants.SERVER_STATE).onError.add(showError);
			service.getLoader(Constants.SERVER_STATE).onComplete.add(setState);			
			service.start();
		}
		
		private function setState(signal:LoaderSignal, xml:XML):void {
			//debug(xml);
			game.chips = String(xml.chip_amounts).split(",");
			game.table = xml.table;
			game.recentResults = xml.recentresults;
			player.currencyCode = xml.currency_code;
			
			service.remove(Constants.SERVER_STATE);
			loadTableConfig();
		}
		
		private function loadSettings():void{
			service.addLoader(new XMLLoader(new URLRequest(urls.settings), Constants.SERVER_SETTING));
			service.getLoader(Constants.SERVER_SETTING).onError.add(showError);
			service.getLoader(Constants.SERVER_SETTING).onComplete.add(setSetting);			
			service.start();
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
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
			signalBus.dispatch(StatisticsEvent.LOAD);
			signalBus.dispatch(StateTableConfigEvent.LOADED);
			
			service.remove(Constants.SERVER_SETTING);
		}
		
		private function loadTableConfig():void {
			debug('TableConfig URL ' + tableConfigUrl);
			service.addLoader(new XMLLoader(new URLRequest(tableConfigUrl), Constants.SERVER_TABLE_CONFIG));
			service.getLoader(Constants.SERVER_TABLE_CONFIG).onError.add(showError);
			service.getLoader(Constants.SERVER_TABLE_CONFIG).onComplete.add(setTableConfig);
			service.start();
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
			game.videoStream= xml["gameconfig-param"].@high_stream;

			service.remove(Constants.SERVER_TABLE_CONFIG);
			
			
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