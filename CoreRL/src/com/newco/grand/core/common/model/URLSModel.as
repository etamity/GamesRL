package com.newco.grand.core.common.model
{
	import com.newco.grand.core.utils.GameUtils;
	
	public class URLSModel extends Actor
	{		
		private var _server:String 		= "";
		
		private var _authentication:String = "https://livecasino.smartliveaffiliates.com/cgibin/SmartAuthentication";
		private var _login:String 		= "http://m.smartlivecasino.com/WebServices/Login.aspx";
		private var _lobby:String 		= "/player/games/tables.swf";
		private var _help:String 		= "/player/games/help/Help.swf";
		private var _freeplay:String 	= "/cgibin/mobile_launcher.jsp";
		private var _language:String 	= "/player/games/languages/";
		private var _style:String 		= "/player/games/styles/";
		
		private var _state:String 		= "/cgibin/roulette/state.jsp";
		private var _tableConfig:String = "/cgibin/tableconfig.jsp";
		private var _sendBets:String 	= "/cgibin/roulette/placebets.jsp";
		private var _chatConfig:String 	= "/cgibin/chat/config.jsp";
		private var _results:String 	= "/cgibin/roulette/history.jsp";
		private var _statistics:String 	= "/cgibin/roulette/stats.jsp";
		private var _players:String 	= "/cgibin/common/participants.jsp";
		private var _winners:String 	= "/cgibin/facebook/winnerList.jsp";
		private var _settings:String 	= "/player/games/assets/settings.xml";
		private var _balance:String 	= "/cgibin/balance.jsp";
		private var _seat:String        = "/cgibin/sitdown.jsp";
		private var _skin:String        = "/player/games/prepare/skins/skin.swf";
		private var urlsXml:XML ;
		[Inject]
		public var flashVars:FlashVars;
		
		public function URLSModel()
		{
			super();
		}
		public function testing():void {
			//_authentication = "http://everest.smartlivegaming.com/cgibin/SmartAuthentication";
			//_server = "http://everest.smartlivegaming.com";
			_server = "https://livecasino.smartliveaffiliates.com";
		}
		
		public function set server(value:String):void {
			_server = value;
		}
		
		public function get server():String {
			return _server;
		}
		public function get balance():String {
			return server + _balance;
		}
		
		public function get skin():String{
			return server +_skin;
		}
		
		public function set skin(value:String):void{
			_skin=value;
		}
		public function set balance(value:String):void {
			_balance = value;
		}
		public function get lobby():String {
			return server + _lobby;
		}
		public function set lobby(value:String):void {
			_lobby = value;
		}
		public function get help():String {
			if( flashVars.localhost )
				return "player/games/help/Help.swf";
			return server + _help;
		}
		public function set help(value:String):void {
			_help = value;
		}
		public function get login():String {
			
			var index:int = _login.search("http://");
			if (index>=0)
			return  _login;
			else
			return server + _login
		}

		public function set login(value:String):void {
			_login = value;
		}
		
		public function get freeplay():String {
			return server + _freeplay + "?client="+ flashVars.client +"&version=social&aid=onlinecasinolar";
		}
		
		public function set freeplay(value:String):void {
			_freeplay = value;
		}
		
		public function get language():String {
			if( flashVars.localhost )
				return "xml/" + flashVars.lang + ".xml";
			
			return server + _language + flashVars.lang + ".xml";
		}
		
		public function set language(value:String):void {
			_language = value;
		}
		
		public function get style():String {
			if( flashVars.localhost )
				return "xml/" + flashVars.client + ".xml";
			
			//return server + _style + flashVars.client + ".xml";
			return server + _style + "slc" + ".xml";
		}
		
		public function set style(value:String):void {
			_style = value;
		}
		
		
		public function get authentication():String {
			return _authentication;
		}
		
		public function set authentication(value:String):void {
			_authentication = value;
		}
		
		public function get state():String {
			return server + _state;
		}
		
		public function set state(value:String):void {
			_state = value;
		}
		
		public function get tableConfig():String {
			return server + _tableConfig;
		}
		
		public function set tableConfig(value:String):void {
			_tableConfig = value;
		}
		
		public function get sendBets():String {
			return server + _sendBets;
		}
		
		public function set sendBets(value:String):void {
			_sendBets = value;
		}
		
		public function get chatConfig():String {
			return server + _chatConfig;
		}
		
		public function set chatConfig(value:String):void {
			_chatConfig = value;
		}
		
		public function get results():String {
			return server + _results;
		}
		
		public function set results(value:String):void {
			_results = value;
		}
		
		public function get players():String {
			return server + _players;
		}
		
		public function set players(value:String):void {
			_players = value;
		}

		public function get winners():String {
			return server + _winners;
		}
		public function set winners(value:String):void {
			_winners = value;
		}
		
		public function get statistics():String {
			return server + _statistics;
		}
		public function set statistics(value:String):void {
			_statistics = value;
		}
		
		public function get seat():String {
			return server + _seat;
		}
		public function set seat(value:String):void {
			_seat = value;
		}
		
		public function get settings():String{
			return server + _settings;
		}
		public function set settings(value:String):void{
			 _settings = value;
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}