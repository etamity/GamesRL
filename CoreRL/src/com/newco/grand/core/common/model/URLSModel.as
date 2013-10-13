package com.newco.grand.core.common.model
{
	import com.newco.grand.core.utils.GameUtils;

	public class URLSModel extends Actor
	{		
		private var _server:String 		= "https://live.extremelivegaming.com/";

		private var _authentication:String = "https://livecasino.smartliveaffiliates.com/cgibin/SmartAuthentication";
		private var _login:String 		= "http://m.smartlivecasino.com/WebServices/Login.aspx";
		private var _lobbySWF:String 		= "player/games/LobbyRL.swf";
		private var _lobby:String 		= "player/lobbyXML.jsp";
		private var _help:String 		= "player/games/help/Help.swf";
		private var _historySWF:String 		= "player/games/history/History.swf";
		private var _freeplay:String 	= "cgibin/mobile_launcher.jsp";
		private var _language:String 	= "player/games/languages/";
		private var _langICON:String 	= "player/games/xml/langs/png/";
		private var _style:String 		= "player/games/styles/";

		private var _state:String 		= "cgibin/roulette/state.jsp";
		private var _tableConfig:String = "cgibin/tableconfig.jsp";
		private var _sendBets:String 	= "cgibin/roulette/placebets.jsp";
		private var _chatConfig:String 	= "cgibin/chat/config.jsp";
		private var _results:String 	= "cgibin/roulette/history.jsp";
		private var _statistics:String 	= "cgibin/roulette/stats.jsp";
		private var _players:String 	= "cgibin/common/participants.jsp";
		private var _winners:String 	= "cgibin/facebook/winnerList.jsp";
		private var _settings:String 	= "player/games/assets/settings.xml";
		private var _balance:String 	= "cgibin/balance.jsp";
		private var _seat:String        = "cgibin/sitdown.jsp";
		private var _skin:String        = "player/games/cgibin/appconfig/skins/skin.swf";
		private var _tournament:String 	= "cgibin/appconfig/xml/tournament.xml";
		
		private var _accountHistory:String = "player/audit/historyXML2.jsp";
		private var _activityHistory:String=  "player/audit/historyXML.jsp";
		private var _opengame:String 	= "player/chat_board.jsp";
		private var _languages:XML;
		private var _flashVarsConfig:String= "cgibin/appconfig/xml/configs/configs.xml";
		private var _xml:XML ;
		[Inject]
		public var flashVars:FlashVars;

		[Inject]
		public var game:IGameData;

		[Inject]
		public var player:Player;

		public function URLSModel()
		{
			super();
		}
		
		public function get statsSummary():String{
			var path :String =_xml.baccarat.statssummary;
			var index:int = path.search("://");
			if (index>=0)
				return path+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
			return server + path+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
		}
		
		public function get lobbyAvatar():String {
			var path :String =_xml.lobby.avatars
			var index:int = path.search("://");
			if (index>=0)
				return path;
			return server + path;
		}
		public function get lobbyBG():String {
			var path :String;
			
			path =_xml.lobby.background.(@client==flashVars.client);
			if (FlashVars.PLATFORM==FlashVars.AIR_PLATFORM)
				path =_xml.lobby.background.(@client==flashVars.client+"_mobile");
			
			if (path=="" || path==null)
				path=_xml.lobby.background.(@client=="xlc");
			
			var index:int = path.search("://");
			if (index>=0)
				return path;
			return server + path;
		}
		public function get opengame():String {
			var index:int = _opengame.search("://");
			if (index>=0)
				return _opengame;
			return server + _opengame;
		}

		public function set opengame(value:String):void {
			_opengame = value;
		}

		public function get languages():XML{
			return _languages;
		}
		public function set languages(val:XML):void{
			_languages=val;
		}
		public function get flashVarsConfig():String{
			return _flashVarsConfig;
		}

		public function get xml():XML{
			return _xml;
		}
		public function set xml(val:XML):void{
			_xml=val;
		}
		public function get tournament():String {
			var index:int = _tournament.search("://");
			if (index>=0  
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _tournament+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
			return _server+_tournament+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
		}

		public function set tournament(value:String):void {
			_tournament = value;
		}

		public function set server(value:String):void {
			_server = value;
		}

		public function get server():String {
			if (flashVars.server.indexOf("://")==-1)
				return _server="https://"+flashVars.server;
			return flashVars.server;
		}
		public function get balance():String {
			var index:int = _balance.search("://");
			if (index>=0 
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _balance;
			return server + _balance;
		}

		public function get skin():String{
			var index:int = _skin.search("://");
			if (index>=0 
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return _skin;
			return server + _skin;
		}

		public function set skin(value:String):void{
			_skin=value;
		}
		public function set balance(value:String):void {
			_balance = value;
		}
		public function get lobbySWF():String {
			var index:int = _lobbySWF.search("://");
			if (index>=0)
				return  _lobbySWF;
			return server + _lobbySWF;
		}
		public function set lobbySWF(value:String):void {
			_lobbySWF = value;
		}
		public function get lobby():String {
			var index:int = _lobby.search("://");
			if (index>=0		
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _lobby;
			return server + _lobby;
		}
		public function set lobby(value:String):void {
			_lobby = value;
		}
		public function get langICON():String {
			var index:int = _langICON.search("://");
			if (index>=0 
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _langICON;
			return server + _langICON;
		}
		public function set langICON(value:String):void {
			_langICON = value;
		}
		public function get help():String {
			var index:int = _help.search("://");
			if (index>=0 
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _help;
			return server + _help+"?lang="+ flashVars.lang+"&server="+ flashVars.server;
		}
		public function set help(value:String):void {
			_help = value;
		}

		public function get historySWF():String {
			var index:int = _historySWF.search("://");
			if (index>=0)
				return  _historySWF;
			return server + _historySWF+ "?user_id="+flashVars.user_id+"&lang="+ flashVars.lang+"&server="+ flashVars.server+"&client="+ flashVars.client+ "&table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
		}
		public function set historySWF(value:String):void {
			_historySWF = value;
		}
		public function get login():String {

			var index:int = _login.search("://");
			if (index>=0)
				return  _login+ "?username=#USERNAME#&password=#PASSWORD#";
			else
				return server + _login+ "?username=#USERNAME#&password=#PASSWORD#";
		}

		public function get accountHistory():String{
			var index:int = _accountHistory.search("://");
			if (index>=0)
				return  _accountHistory;
			return  server +_accountHistory;
		}
		public function set accountHistory(val:String):void{
			_accountHistory= val;
		}
		public function set activityHistory(val:String):void{
			_activityHistory=val;
		}
		public function get activityHistory():String{
			var index:int = _activityHistory.search("://");
			if (index>=0)
				return  _activityHistory;
			return  server +_activityHistory;
		}
		public function set login(value:String):void {
			_login = value;
		}

		public function get freeplay():String {
			var index:int = _freeplay.search("://");
			if (index>=0)
				return _freeplay + "?client="+ flashVars.client +"&version=social&aid=onlinecasinolar";
			return server + _freeplay + "?client="+ flashVars.client +"&version=social&aid=onlinecasinolar";
		}

		public function set freeplay(value:String):void {
			_freeplay = value;
		}

		public function get language():String {
			var index:int = _language.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _language + flashVars.lang + ".xml";

			return server + _language + flashVars.lang + ".xml";
		}

		public function set language(value:String):void {
			_language = value;
		}

		public function get style():String {
			var index:int = _style.search("://");
			if (index>=0 
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return _style + flashVars.client  + ".xml";

			return server + _style + flashVars.client  + ".xml";
		}

		public function set style(value:String):void {
			_style = value;
		}


		public function get authentication():String {
			var index:int = _authentication.search("://");
			if (index>=0)
				return  _authentication;

			return server + _authentication
		}

		public function set authentication(value:String):void {
			_authentication = value;
		}

		public function get state():String {
			var index:int = _state.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _state+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
			return server + _state+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
		}

		public function set state(value:String):void {
			_state = value;
		}

		public function get tableConfig():String {
			var index:int = _tableConfig.search("://");
			if (index>=0 
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return _tableConfig+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
			return server + _tableConfig+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
		}

		public function set tableConfig(value:String):void {
			_tableConfig = value;
		}

		public function get sendBets():String {
			var index:int = _sendBets.search("://");
			if (index>=0)
				return _sendBets + "?user_id=" + flashVars.user_id+ "&table_id=" + flashVars.table_id+ "&vt_id="+flashVars.vt_id + "&game_id=" + game.gameID + player.betString + "&noOfBets=" + player.betCount;
			return server + _sendBets + "?user_id=" + flashVars.user_id+ "&table_id=" + flashVars.table_id+ "&vt_id="+flashVars.vt_id + "&game_id=" + game.gameID + player.betString + "&noOfBets=" + player.betCount;
		}

		public function set sendBets(value:String):void {
			_sendBets = value;
		}

		public function get chatConfig():String {
			var index:int = _chatConfig.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return _chatConfig + "?room_id=" + flashVars.room;
			return server + _chatConfig + "?room_id=" + flashVars.room;
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
			var index:int = _players.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _players+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
			return server + _players+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
		}

		public function set players(value:String):void {
			_players = value;
		}

		public function get winners():String {
			var index:int = _winners.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _winners+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
			return server + _winners+ "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id;
		}
		public function set winners(value:String):void {
			_winners = value;
		}

		public function get statistics():String {
			var index:int = _statistics.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return _statistics;
			return server + _statistics;
		}
		public function set statistics(value:String):void {
			_statistics = value;
		}

		public function get seat():String {
			var index:int = _seat.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return  _seat + "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id+"&user_id="+flashVars.user_id;
			return server + _seat + "?table_id=" + flashVars.table_id+"&vt_id="+flashVars.vt_id+"&user_id="+flashVars.user_id;
		}
		public function set seat(value:String):void {
			_seat = value;
		}

		public function get settings():String{
			var index:int = _settings.search("://");
			if (index>=0
				|| FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				return _settings;
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

