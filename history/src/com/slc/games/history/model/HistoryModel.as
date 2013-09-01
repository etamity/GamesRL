package com.slc.games.history.model {

	/**
	 * Data store for the History component. Has no internal logic.
	 *
	 * @author Elliot Harris
	 */
	public class HistoryModel {
		//These Config distinguish between the different views
		public const LOADING:String                = "loading";
		public const CURRENT_DAY_ACTIVITY:String   = "currentDayActivity";
		public const SELECTED_DAY_ACTIVITY:String  = "selectedDayActivity";
		public const ACCOUNT_HISTORY:String        = "accountHistory";
		public const TRANSACTION:String            = "transaction";
		public const ROULETTE:String               = "roulette";
		public const BLACKJACK:String              = "blackjack";
		public const BACCARAT:String               = "baccarat";

		//Game identifiers as found in the dayXML
		public const ROULETTE_LABEL:String         = "Roulette";
		public const BLACKJACK_LABEL:String        = "Blackjack";
		public const BACCARAT_LABEL:String         = "Baccarat";

		//URLs to be called for the various views
		private var _currentDayActivityURL:String  = "dayXML.jsp";
		private var _selectedDayActivityURL:String = "dayXML.jsp";
		private var _accountHistoryURL:String      = "historyXML.jsp";
		private var _transactionURL:String         = "transactionXML.jsp";
		private var _gameURL:String                = "gameXML.jsp";

		//ID of the current user to be used when making server calls
		private var _userId:String;

		//Game and Game ID to show the history of that game by default (used in AAMS for returning players)
		private var _game:String;
		private var _gameId:String;

		//Loaded XML. Saved here until a new load occurs or the component is closed
		private var _currentDayActivityXML:XML;
		private var _selectedDayActivtyXML:XML;
		private var _accountHistoryXML:XML;
		private var _transactionXML:XML;
		private var _gameXML:XML;

		//Previous IDs for specific server calls. Is compared to the next ID
		//to determin whether or not to make the call again.
		private var _lastSelectedDay:String;
		private var _lastTransactionGameId:String;
		private var _lastRouletteGameId:String;
		private var _lastBlackjackGameId:String;
		private var _lastBaccaratGameId:String;

		public function HistoryModel() {
		}

		public function get lastSelectedDay():String {
			return _lastSelectedDay;
		}

		public function set lastSelectedDay(v:String):void {
			_lastSelectedDay = v;
		}

		public function get lastTransactionGameId():String {
			return _lastTransactionGameId;
		}

		public function set lastTransactionGameId(v:String):void {
			_lastTransactionGameId = v;
		}

		public function get lastRouletteGameId():String {
			return _lastRouletteGameId;
		}

		public function set lastRouletteGameId(v:String):void {
			_lastRouletteGameId = v;
		}

		public function get lastBlackjackGameId():String {
			return _lastBlackjackGameId;
		}

		public function set lastBlackjackGameId(v:String):void {
			_lastBlackjackGameId = v;
		}

		public function get lastBaccaratGameId():String {
			return _lastBaccaratGameId;
		}

		public function set lastBaccaratGameId(v:String):void {
			_lastBaccaratGameId = v;
		}

		public function get userId():String {
			return _userId;
		}

		public function set userId(v:String):void {
			_userId = v;
		}

		public function get game():String {
			return _game;
		}

		public function set game(v:String):void {
			_game = v;
		}

		public function get gameId():String {
			return _gameId;
		}

		public function set gameId(v:String):void {
			_gameId = v;
		}

		//URLS		
		public function get currentDayActivityURL():String {
			return _currentDayActivityURL;
		}

		public function set currentDayActivityURL(v:String):void {
			_currentDayActivityURL = v;
		}

		public function get selectedDayActivityURL():String {
			return _selectedDayActivityURL;
		}

		public function set selectedDayActivityURL(v:String):void {
			_selectedDayActivityURL = v;
		}

		public function get accountHistoryURL():String {
			return _accountHistoryURL;
		}

		public function set accountHistoryURL(v:String):void {
			_accountHistoryURL = v;
		}

		public function get transactionURL():String {
			return _transactionURL;
		}

		public function set transactionURL(v:String):void {
			_transactionURL = v;
		}

		public function get gameURL():String {
			return _gameURL;
		}

		public function set gameURL(v:String):void {
			_gameURL = v;
		}

		//XML
		public function get currentDayActivityXML():XML {
			return _currentDayActivityXML;
		}

		public function set currentDayActivityXML(v:XML):void {
			_currentDayActivityXML = v;
		}

		public function get accountHistoryXML():XML {
			return _accountHistoryXML;
		}

		public function set accountHistoryXML(v:XML):void {
			_accountHistoryXML = v;
		}

		public function get selectedDayActivtyXML():XML {
			return _selectedDayActivtyXML;
		}

		public function set selectedDayActivtyXML(v:XML):void {
			_selectedDayActivtyXML = v;
		}

		public function get transactionXML():XML {
			return _transactionXML;
		}

		public function set transactionXML(v:XML):void {
			_transactionXML = v;
		}

		public function get gameXML():XML {
			return _gameXML;
		}

		public function set gameXML(v:XML):void {
			_gameXML = v;
		}
	}
}

