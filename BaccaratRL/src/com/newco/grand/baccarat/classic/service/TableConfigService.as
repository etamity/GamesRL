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
	import com.newco.grand.core.utils.StringUtils;
	import com.newco.grand.core.common.model.VideoModel;
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
		
		[Inject]
		public var videoModel:VideoModel;
		public function TableConfigService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			loadState();
		}
		private function loadState():void {

			debug("State ",urls.state);
			/*service.addLoader(new XMLLoader(new URLRequest(stateUrl), Constants.SERVER_STATE));
			service.getLoader(Constants.SERVER_STATE).onError.add(showError);
			service.getLoader(Constants.SERVER_STATE).onHttpStatus.add(showStatus);
			service.getLoader(Constants.SERVER_STATE).onComplete.add(setState);	
			service.start();*/
			service.loadURL(urls.state,setState,showError);
		}
		
		private function setState(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			game.chips = String(xml.chip_amounts).split(",");
			game.table = xml.table_name;
			player.currencyCode = xml.currency_code;
			
			//service.remove(Constants.SERVER_STATE);
			loadSettings();

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
			var streamUrl:String= flashVars.streamUrl;
			var lowerCaseStreamUr:String= streamUrl.toLowerCase();
			
			if (streamUrl!="" && streamUrl.search("rtmp://")!=-1)
			{
				
				if (streamUrl !=""){
					var params:Array = String(streamUrl).split("//");
					params.shift();
					
					var paramStr:String= params[0];
					params=paramStr.split("/");
					var sever:String = params[0];
					var videoName:String= params[params.length-1];
					var application:String= String(streamUrl).replace("rtmp://"+sever+"/","");
					application=application.replace("/"+videoName,"");
					
					
					game.server=sever;
					game.videoStream=videoName;
					game.videoApplication = application;
					
				}
			}
			
			if (streamUrl!="" && (lowerCaseStreamUr.search(".mp4")!=-1 || lowerCaseStreamUr.search(".flv")!=-1))
			{
				game.server="";
				game.videoStream=lowerCaseStreamUr;
				game.videoStreams=new Array(lowerCaseStreamUr);
				game.videoApplication="";
			}
			else
			{
				videoModel.servers = String(game.videoSettings.videoservers).split(",");
				game.server=videoModel.servers[0];
				if (game.videoSettings.application.@withGameName=="false")
					game.videoApplication = game.videoSettings.application;
				else
					game.videoApplication = StringUtils.trim(game.videoSettings.application+"/"+FlashVars.GAMECLIENT.toLowerCase());
			}
			
			/*if (game.server !="")
			videoService.servers=new Array(game.server);*/

			
			
			debug("[game.videoStreams]:"+game.videoStreams);
			videoModel.settings=game.videoSettings;
			
					
			loadTableConfig();

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
			
			if (xml["gameconfig-param"].@videoip!="" && xml["gameconfig-param"].@videoip!=null && xml["gameconfig-param"].@videoip!=undefined)
			{
				game.server= xml["gameconfig-param"].@videoip;
				debug("game.server:",game.server);
			}
			//service.remove(Constants.SERVER_TABLE_CONFIG);
			if (xml["gameconfig-param"].@videoapp!="" && xml["gameconfig-param"].@videoapp!=null && xml["gameconfig-param"].@videoapp!=undefined)
			{
				game.videoApplication= xml["gameconfig-param"].@videoapp;
				debug("game.videoApplication:",game.videoApplication);
			}
			var streams:Array=new Array(xml["gameconfig-param"].@low_stream,xml["gameconfig-param"].@med_stream,xml["gameconfig-param"].@hi_stream);
			game.videoStreams=streams;
			game.httpStream=xml["gameconfig-param"].@httpStream;
			if (xml["gameconfig-param"].@xmodeStream!="" && xml["gameconfig-param"].@xmodeStream!=null&& xml["gameconfig-param"].@xmodeStream!=undefined)
			game.xmodeStream=xml["gameconfig-param"].@xmodeStream;
			debug("game.videoStreams:",game.videoStreams);
	
			
			
			if (game.videoStreams !=null)
				videoModel.streams= game.videoStreams;
			if (game.videoApplication !="")
				videoModel.application=game.videoApplication;
			
			signalBus.dispatch(ModelReadyEvent.READY);
			signalBus.dispatch(SocketEvent.CONNECT_GAME);
			signalBus.dispatch(VideoEvent.CONNECT);
			signalBus.dispatch(StateTableConfigEvent.LOADED);
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
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