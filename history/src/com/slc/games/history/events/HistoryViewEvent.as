package com.slc.games.history.events {

	import flash.events.Event;

	/**
	 * Events dispatched from any of the views.
	 *
	 * @author Elliot Harris
	 */
	public class HistoryViewEvent extends Event {
		//These indicate a button has been clicked which triggers another view to be shown
		public static const CURRENT_ACTIVITY_CLICK:String = "currentActivityClick";
		public static const ACCOUNT_HISTORY_CLICK:String  = "accountHistoryClick";
		public static const DAY_ITEM_CLICK:String         = "dayItemClick";
		public static const TRANSACTION_CLICK:String      = "transactionClick";
		public static const GAME_CLICK:String             = "gameClick";

		private var _selectedDay:String;
		private var _gameId:String;
		private var _gameLabel:String;

		public function HistoryViewEvent(type:String, selectedDay:String = null, gameId:String = null, gameLabel:String = null) {
			super(type, true, true);

			_selectedDay = selectedDay;
			_gameId = gameId;
			_gameLabel = gameLabel;
		}

		public function get selectedDay():String {
			return _selectedDay;
		}

		public function get gameId():String {
			return _gameId;
		}

		public function get gameLabel():String {
			return _gameLabel;
		}
	}
}

