package com.newco.grand.roulette.classic.service
{
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
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
			
			/*	
			service.addLoader(new XMLLoader(new URLRequest(stateUrl), Constants.SERVER_STATE));
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
			
			loadSettings();

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
			/*eventDispatcher.dispatchEvent(new ModelReadyEvent(ModelReadyEvent.READY));
			eventDispatcher.dispatchEvent(new SocketEvent(SocketEvent.CONNECT_GAME));
			eventDispatcher.dispatchEvent(new VideoEvent(VideoEvent.CONNECT));
			eventDispatcher.dispatchEvent(new PlayersEvent(PlayersEvent.LOAD));
			eventDispatcher.dispatchEvent(new WinnersEvent(WinnersEvent.LOAD));
			eventDispatcher.dispatchEvent(new StatisticsEvent(StatisticsEvent.LOAD));
			eventDispatcher.dispatchEvent(new StateTableConfigEvent(StateTableConfigEvent.LOADED));*/
			

			
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
			
			//service.remove(Constants.SERVER_TABLE_CONFIG);
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
			signalBus.dispatch(UIEvent.SETUP_LAYOUT);
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("Error:" +signal.message);
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}