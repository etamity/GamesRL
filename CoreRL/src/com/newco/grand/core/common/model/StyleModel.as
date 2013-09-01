package com.newco.grand.core.common.model {
	
	public dynamic class StyleModel extends Actor {
		public static var BGCOLOR1:String;
		public static var BGCOLOR2:String;
		public static var OVERLAY:String;
		public static var LOBBYTRANSPARENCY:String;
		public static var SUBBGCOLOR1:String;
		public static var SUBBGCOLOR2:String;
		public static var BORDERCOLOR:String;
		public static var BORDERCOLOR_THICKNESS:String;
		public static var TITLECOLOR:String;
		public static var HIGHLIGHTCOLOR:String;
		public static var LOBBYDETAILSCOLOR:String;
		
		public static var TXTCOLOR:String;
		public static var ROULETTE_VIEW_SELECTION:String;
		public static var LOBBY_TABLE_ROLLOVER:String;
		public static var BJ_SEAT_SELECTION:String;
		public static var HISTORYBGCOLOR1:String;
		public static var HISTORYBGCOLOR2:String;
		public static var HISTORYHEADERBG1:String;
		public static var HISTORYHEADERBG2:String;
		public static var HISTORYTITLETXTCOLOR:String;
		public static var HEADERTXTCOLOR:String;
		public static var DEFAULTTXTCOLOR:String;
		
		public static var DEFAULTBTNCOLOR1:String;
		public static var DEFAULTBTNCOLOR2:String;
		public static var ROLLOVERBTNCOLOR1:String;
		public static var ROLLOVERBTNCOLOR2:String;
		public static var SELECTEDBTNCOLOR1:String;
		public static var SELECTEDBTNCOLOR2:String;
		public static var DEFAULTBTNTXTCOLOR:String;
		public static var ROLLOVERBTNTXTCOLOR:String;
		public static var SELECTEDBTNTXTCOLOR:String;
		
		public static var HELPBGCOLOR1:String;
		public static var HELPBGCOLOR2:String;
		public static var HELPHEADERBG1:String;
		public static var HELPHEADERBG2:String;
		public static var HELPTITLETXTCOLOR:String;
		public static var HELPTXTCOLOR:String;
		public static var HELPCONTENTSTXTROLLOVERCOLOR:String;
		
		public static var ROULETTESTATSBGCOLOR1:String;
		public static var ROULETTESTATSBGCOLOR2:String;
		public static var ROULETTESTATSHEADERBG1:String;
		public static var ROULETTESTATSHEADERBG2:String;
		public static var ROULETTESTATSTITLETXTCOLOR:String;		
		
		public static var CASHIER:String;
		public static var CASHIER_URL:String;
		public static var CASHIER_W:String;
		public static var CASHIER_H:String;
		public static var CASHIER_LABEL:String;
		public static var RESPONSIBLE:String;
		public static var RESPONSIBLE_URL:String;
		public static var RESPONSIBLE_W:String;
		public static var RESPONSIBLE_H:String;
		public static var RESPONSIBLE_LABEL:String;
		public static var HELP:String;		
		public static var HELP_LABEL:String;
		public static var HISTORY:String;
		public static var FULLSCREEN:String;
		public static var XMLDATA:XML;
		
		public static var MENUBAR_XML:String;
		
		public static function getColor(val:String):uint{
			return uint("0x"+val);
		}
		
	}
}