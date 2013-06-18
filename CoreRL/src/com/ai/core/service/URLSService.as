package com.ai.core.service
{
	import com.ai.core.common.controller.signals.MessageEvent;
	import com.ai.core.model.Actor;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.IGameData;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class URLSService extends Actor
	{
		[Inject]
		public var service:IAssetLoader;
		[Inject]
		public var urlsModel:URLSModel;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var gameData:IGameData;
		
		private const URLS_XML:String= "URLS_XML";
		
		private var _xmlurl:String="xml/urls.xml";
		
		private var _onComplete:Function;
		
		public function URLSService()
		{
			super();
		}
		private function setConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			urlsModel.server= xml.common.server;
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
			if (flashVars.game.toLowerCase()==Constants.BACCARAT.toLowerCase())
			{
				urlsModel.sendBets =xml.baccarat.sendBets;
				urlsModel.state =xml.baccarat.state;
				urlsModel.winners=xml.baccarat.winners;
				urlsModel.statistics=xml.baccarat.statistics;
				urlsModel.skin=(xml.baccarat.skin!=undefined)?xml.baccarat.skin:urlsModel.skin;
			}
			
			if (flashVars.game.toLowerCase()==Constants.ROULETTE.toLowerCase())
			{
				urlsModel.sendBets =xml.roulette.sendBets;
				urlsModel.state =xml.roulette.state;
				urlsModel.winners=xml.roulette.winners;
				urlsModel.statistics=xml.roulette.statistics;
				urlsModel.skin=(xml.roulette.skin!=undefined)?xml.baccarat.skin:urlsModel.skin;
			}
			if (_onComplete!=null)
			_onComplete();
			
		}
		public function loadConfig(onComplete:Function):void{
			debug("loading Config  " + _xmlurl);
			if (flashVars.localhost==false)
			{
				_xmlurl="/player/games/assets/urls.xml";
			}
				
			
			_onComplete=onComplete;
			service.addLoader(new XMLLoader(new URLRequest(_xmlurl), URLS_XML));
			service.getLoader(URLS_XML).onError.add(showError);
			service.getLoader(URLS_XML).onComplete.add(setConfig);			
			service.start();
		}
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.ERROR,{error:signal.message});
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}