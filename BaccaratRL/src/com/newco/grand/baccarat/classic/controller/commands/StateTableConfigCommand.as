package com.newco.grand.baccarat.classic.controller.commands {
	
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.controller.signals.WinnersEvent;
	import com.newco.grand.baccarat.classic.model.GameDataModel;
	import com.ai.core.common.controller.signals.ModelReadyEvent;
	import com.ai.core.common.controller.signals.PlayersEvent;
	import com.ai.core.common.controller.signals.SocketEvent;
	import com.ai.core.common.controller.signals.StateTableConfigEvent;
	import com.ai.core.common.controller.signals.VideoEvent;
	import com.ai.core.common.model.Constants;
	import com.ai.core.common.model.FlashVars;
	import com.ai.core.common.model.Player;
	import com.ai.core.common.model.SignalBus;
	import com.ai.core.common.model.URLSModel;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.HttpStatusSignal;
	import org.assetloader.signals.LoaderSignal;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class StateTableConfigCommand extends Command {
		
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
			configUrl();
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
			service.getLoader(Constants.SERVER_STATE).onHttpStatus.add(showStatus);
			service.getLoader(Constants.SERVER_STATE).onComplete.add(setState);	
			service.start();
		}
		
		private function setState(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			game.chips = String(xml.chip_amounts).split(",");
			game.table = xml.table;
			player.currencyCode = xml.currency_code;
			
			service.remove(Constants.SERVER_STATE);
			loadTableConfig();
		}
		
		private function loadSettings():void{
			service.addLoader(new XMLLoader(new URLRequest(urls.settings), Constants.SERVER_SETTING));
			service.getLoader(Constants.SERVER_SETTING).onError.add(showError);
			service.getLoader(Constants.SERVER_SETTING).onComplete.add(setSetting);		
			service.getLoader(Constants.SERVER_SETTING).onHttpStatus.add(showStatus);
			service.start();
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
			debug(xml);
			game.min = xml["gameconfig-param"].@table_bet_min_limit;
			game.max = xml["gameconfig-param"].@table_bet_max_limit;
			
			game.videoStream= xml["gameconfig-param"].@high_stream;

			game.banker_bet_max=xml["gameconfig-param"].@banker_bet_max;
			game.banker_bet_min=xml["gameconfig-param"].@banker_bet_min;
			
			game.player_bet_max=xml["gameconfig-param"].@player_bet_max;
			game.player_bet_min=xml["gameconfig-param"].@player_bet_min;
			
			game.player_pairs_bet_max=xml["gameconfig-param"].@player_pairs_bet_max;
			game.player_pairs_bet_min=xml["gameconfig-param"].@player_pairs_bet_min;
			
			game.banker_pairs_bet_max=xml["gameconfig-param"].@banker_pairs_bet_max;
			game.banker_pairs_bet_min=xml["gameconfig-param"].@banker_pairs_bet_min;
			
			game.tie_bet_max=xml["gameconfig-param"].@tie_bet_max;
			game.tie_bet_min=xml["gameconfig-param"].@tie_bet_min;
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