package com.ai.roulette.model {

	public class GameState {

		public static var CURRENT_STATE:Number;
		
		public static var INITIALISING:Number                = 0;
		public static var NO_GAME:Number                     = 1;
		public static var BETS_OPEN:Number                   = 2;
		public static var WAITING_FOR_BETS:Number            = 3;
		public static var PLACING_BETS:Number                = 4;
		public static var BETS_CLOSING:Number                = 5;
		public static var BETS_CLOSED:Number                 = 6;
		public static var SENDING_BETS:Number                = 7;
		public static var BETS_ACCEPTED:Number               = 8;
		public static var NOT_ALL_BETS_ACCEPTED:Number       = 9;
		public static var BETS_REJECTED:Number               = 10;
		public static var WAITING_FOR_DECISION:Number        = 11;
		public static var WAITING_FOR_INSURANCE:Number       = 12;
		public static var DECISION_CLOSING:Number            = 13;
		public static var WAITING_FOR_CARD:Number            = 14;
		public static var DEALING:Number                     = 15;
		public static var DEAL_HIDDEN:Number                 = 16;
		public static var WAITING_FOR_RESULT:Number          = 20;
		public static var CANCELLED:Number                   = 21;
		public static var SOCKET_FAILURE:Number              = 22;
		public static var RESULT:Number                      = 23;
		public static var GAME_OVER:Number                   = 24;

		// AUTO ROULETTE SPECIFIC STATES
		public static var WHEEL_POWERED_OFF:Number           = 51;
		public static var WHEEL_SWITCHED_ON:Number           = 52;
		public static var NO_BALL_IN_WHEEL:Number            = 53;
		public static var BALL_WRONG_DIRECTION:Number        = 54;
		public static var SENSOR_BROKEN:Number               = 55;
		public static var BALL_LAUNCH_FAILED_RETRYING:Number = 56;
		public static var UNDEFINED_ERROR:Number             = 57;
		public static var UNKNOWN_GAME_STATE:Number          = 58;
		
		// MOBILE SPECIFIC STATES
		public static var MOBILE_STARTUP:Number           	= 101;
		public static var MOBILE_FREE_PLAY:Number          	= 102;
		public static var MOBILE_REAL_PLAY:Number          	= 103;
		public static var MOBILE_LOGGED_IN:Number          	= 104;
		public static var MOBILE_LOGIN_FAILED:Number        = 105;

		public function GameState() {
			GameState.CURRENT_STATE = GameState.INITIALISING;
		}

		public static function set state(val:Number):void {
			GameState.CURRENT_STATE = val;
		}

		public static function get state():Number {
			return GameState.CURRENT_STATE;
		}
	}
}