package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.errors.IOError;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class URLSService implements IService
	{
		[Inject]
		public var urlsModel:URLSModel;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var gameData:IGameData;
		[Inject]
		public var service:XMLService;
		[Inject]
		public var signalBus:SignalBus;
		
		private var _onComplete:Function;
		
		public function URLSService()
		{
			super();
	
		}
		private function setConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			//urlsModel.server= xml.common.server;
			urlsModel.server=flashVars.server;
			
			if (xml.common.server!=null && 
				xml.common.server!=undefined && 
				xml.common.server!="")
				urlsModel.server= xml.common.server;
			
			urlsModel.authentication= xml.common.authentication;
			urlsModel.balance= xml.common.balance;
			urlsModel.chatConfig= xml.common.chatConfig;
			urlsModel.historySWF=xml.common.historySWF;
			urlsModel.freeplay= xml.common.freeplay;
			urlsModel.style= xml.common.style;
			urlsModel.seat= xml.common.seat;
			urlsModel.help= xml.common.help;
			urlsModel.language= xml.common.language;
			urlsModel.langICON= xml.common.langICON;
			urlsModel.lobby= xml.common.lobby;
			urlsModel.login= xml.common.login;
			urlsModel.players= xml.common.players;
			urlsModel.results= xml.common.results;
			urlsModel.settings= xml.common.settings;
			urlsModel.tableConfig = xml.common.tableConfig;
			urlsModel.skin= xml.common.skin;
			urlsModel.tournament=xml.common.tournament;
			urlsModel.accountHistory=xml.common.accountHistory;
			urlsModel.activityHistory=xml.common.activityHistory;
			urlsModel.languages=xml.languages[0];
			debug("urlsModel.languages",urlsModel.languages);
			
			if (StringUtils.trim(FlashVars.GAMECLIENT.toLowerCase())==StringUtils.trim(Constants.BACCARAT.toLowerCase()))
			{
				urlsModel.sendBets =xml.baccarat.sendBets;
				urlsModel.state =xml.baccarat.state;
				urlsModel.winners=xml.baccarat.winners;
				urlsModel.statistics=xml.baccarat.statistics;
				urlsModel.skin=(xml.baccarat.skin!=undefined)?xml.baccarat.skin:xml.common.skin;
			}
			
			if (StringUtils.trim(FlashVars.GAMECLIENT.toLowerCase())==StringUtils.trim(Constants.ROULETTE.toLowerCase()))
			{
				urlsModel.sendBets =xml.roulette.sendBets;
				urlsModel.state =xml.roulette.state;
				urlsModel.winners=xml.roulette.winners;
				urlsModel.statistics=xml.roulette.statistics;
				urlsModel.skin=(xml.roulette.skin!=undefined)?xml.baccarat.skin:xml.common.skin;
			}
			if (StringUtils.trim(FlashVars.GAMECLIENT.toLowerCase())==StringUtils.trim(Constants.LOBBY.toLowerCase()))
			{
				urlsModel.statistics=xml.baccarat.statistics;
			}
			
			urlsModel.xml=xml;
			
			
			if (_onComplete!=null)
			_onComplete();
			
			debug("state:",urlsModel.state);
		}
		public function load(onComplete:Function=null):void{
			debug("loading urls xml:  " + flashVars.urls);
			debug("Server:  " + flashVars.server);
			_onComplete=onComplete;
			try{
			service.loadURL(flashVars.urls,setConfig,showError);
			}
			catch (err:IOError)
			{
				debug("error " + err.errorID + " : " +err.message);
				//signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:err.errorID + " : " +err.message});
			}
		}
		private function showError(signal:ErrorSignal):void {
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message + " : " + flashVars.urls});
			debug("error " + signal.message);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		
		}
	}
}