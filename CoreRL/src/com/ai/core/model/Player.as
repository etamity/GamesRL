package com.ai.core.model {
	
	import com.ai.core.utils.FormatUtils;
	
	public class Player extends Actor {
		
		/*<balance>100.00</balance>
		<bonus_balance>0.00</bonus_balance>
		<currency_code>$</currency_code>
		<session_balance>null</session_balance>
		<currency>USD</currency>
		<required_playthrough>Bonus Not Active</required_playthrough>
		<current_playthrough>Bonus Not Active</current_playthrough>
		<server>livecasino.smartliveaffiliates.com</server>
		<casinoid>0rnu7w1c8xhbuhtn</casinoid>
		<userid>q8wftl5ea5u4j6hg</userid>
		<site>null</site>
		*/
		
		private var _balance:Number = 0;
		private var _balanceFormatted:String;
		private var _bettingBalance:Number = 0;
		private var _bettingBalanceFormatted:String;
		private var _bonus:Number = 0;
		private var _sessionBalance:Number = 0;
		private var _bet:Number = 0;
		private var _lastBet:Number = 0;
		private var _betFormatted:String = "0";
		private var _currency:String;
		private var _currencyCode:String;
		private var _id:String;
		private var _name:String;
		private var _type:String;
		private var _session:String;
		private var _seatCount:int;
		private var _betString:String;
		private var _betCount:int;
		private var _winnings:Number;
		
		private var _savedBets:Array= new Array();
		
		public function get balance():Number {
			return _balance;
		}

		public function get savedBets():Array{
			return _savedBets;
		}
		public function set savedBets(val:Array):void{
			 _savedBets=val;
		}
		public function set balance(value:Number):void {
			_balance = value;
			bettingBalance = value;
			balanceFormatted = FormatUtils.formatBalance(value);
		}
		
		public function get balanceFormatted():String {
			return _currencyCode + _balanceFormatted;
		}
		
		public function set balanceFormatted(value:String):void {
			_balanceFormatted = value;
		}
		
		public function get bettingBalance():Number {
			return _bettingBalance;
		}
		
		public function set bettingBalance(value:Number):void {
			_bettingBalance = value;
			bettingBalanceFormatted = FormatUtils.formatBalance(value);
		}
		
		public function get bettingBalanceFormatted():String {
			return _currencyCode + _bettingBalanceFormatted;
		}
		
		public function set bettingBalanceFormatted(value:String):void {
			_bettingBalanceFormatted = value;
		}
		
		public function get bet():Number {
			return _bet;
		}
		
		public function set lastBet(value:Number):void {
			_lastBet = value;
		}
		
		public function get lastBet():Number {
			return _lastBet;
		}
		
		public function set bet(value:Number):void {
			_bet = value;
			betFormatted = FormatUtils.formatBalance(value);
		}
		
		public function get betFormatted():String {
			return _betFormatted;
		}
		
		public function set betFormatted(value:String):void {
			_betFormatted = value;
		}

		public function get bonus():Number {
			return _bonus;
		}

		public function set bonus(value:Number):void {
			_bonus = value;
		}

		public function get sessionBalance():Number {
			return _sessionBalance;
		}

		public function set sessionBalance(value:Number):void {
			_sessionBalance = value;
		}

		public function get currency():String {
			return _currency;
		}

		public function set currency(value:String):void {
			_currency = value;
		}

		public function get currencyCode():String {
			return _currencyCode;
		}

		public function set currencyCode(value:String):void {
			_currencyCode = value;
		}

		public function get id():String {
			return _id;
		}

		public function set id(value:String):void {
			_id = value;
		}

		public function get name():String {
			return _name;
		}

		public function set name(value:String):void {
			_name = value;
		}
		
		public function get type():String {
			return _type;
		}
		
		public function set type(value:String):void {
			_type = value;
		}

		public function get session():String {
			return _session;
		}

		public function set session(value:String):void {
			_session = value;
		}

		public function get seatCount():int {
			return _seatCount;
		}

		public function set seatCount(value:int):void {
			_seatCount = value;
		}

		public function get betString():String {
			return _betString;
		}

		public function set betString(value:String):void {
			_betString = value;
		}

		public function get betCount():int {
			return _betCount;
		}

		public function set betCount(value:int):void {
			_betCount = value;
		}

		public function get winnings():Number {
			return _winnings;
		}

		public function set winnings(value:Number):void {
			_winnings = value;
		}
		
		public function addFaouritesBets(col1:String,col2:String):void{
			var obj:Object = {};
			obj[''+col1] = _name + " : " + String(_savedBets.length);
			obj[''+col2] =betFormatted;
			obj.betString= betString;
			_savedBets.push(obj);
		}
		
	}
}