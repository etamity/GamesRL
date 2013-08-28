package com.newco.grand.core.common.service
{
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
	import org.assetloader.signals.LoaderSignal;
	
	public class URLSService extends XMLService
	{
		[Inject]
		public var urlsModel:URLSModel;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var gameData:IGameData;
		
		private var _xmlurl:String="xml/urls.xml";
		
		private var _onComplete:Function;
		
		public function URLSService()
		{
			super();
	
		}
		private function setConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			debug("GameType:"+FlashVars.GAMECLIENT.toLowerCase(),Constants.BACCARAT.toLowerCase());
			//urlsModel.server= xml.common.server;
			urlsModel.server=flashVars.server;
			urlsModel.authentication= xml.common.authentication;
			urlsModel.balance= xml.common.balance;
			urlsModel.chatConfig= xml.common.chatConfig;
			urlsModel.freeplay= xml.common.freeplay;
			urlsModel.help= xml.common.help;
			urlsModel.language= xml.common.language;
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
			
			
			urlsModel.urlsXml=xml;
			if (_onComplete!=null)
			_onComplete();
			debug("state:",urlsModel.state);
		}
		public function load(onComplete:Function):void{
			debug("loading Config  " + _xmlurl);
			debug("Server  " + urlsModel.server);

		
			if (flashVars.localhost==false)
			{
				_xmlurl=urlsModel.server+"/player/games/xml/urls.xml";
			}
				
			
			_onComplete=onComplete;
			loadURL(_xmlurl,setConfig);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		
		}
	}
}