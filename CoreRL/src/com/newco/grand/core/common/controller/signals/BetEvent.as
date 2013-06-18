package com.newco.grand.core.common.controller.signals {
	
	public class BetEvent {
		
		public static const START_GAME:String = "BetEvent.START_GAME";
		public static const CHIP_BET:String = "BetEvent.CHIP_BET";
		public static const UPDATE_BET:String = "BetEvent.UPDATE_BET";
		public static const TOTAL_BET:String = "BetEvent.TOTAL_BET";
		public static const CLOSE_BETS:String = "BetEvent.CLOSE_BETS";
		public static const NEIGHBOUR_BETS:String = "BetEvent.NEIGHBOUR_BETS";
		public static const SEND_BETS:String = "BetEvent.SEND_BETS";
		public static const BETS_ACCEPTED:String = "BetEvent.BETS_ACCEPTED";
		public static const BETS_REJECTED:String = "BetEvent.BETS_REJECTED";
		public static const NOT_ALL_BETS_ACCEPTED:String = "BetEvent.NOT_ALL_BETS_ACCEPTED";
		public static const UNDO:String = "BetEvent.UNDO";
		public static const CLEAR:String = "BetEvent.CLEAR";
		public static const REPEAT:String = "BetEvent.REPEAT";
		public static const DOUBLE:String = "BetEvent.DOUBLE";
		public static const CONFRIM:String = "BetEvent.CONFRIM";
		public static const FAVOURITES:String = "BetEvent.FAVOURITES";
	}
}