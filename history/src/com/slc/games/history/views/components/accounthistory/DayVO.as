package com.slc.games.history.views.components.accounthistory {

	/**
	 * Basic value object for storing user activity on a given date.
	 *
	 * @author Elliot Harris
	 */
	public class DayVO {
		public var date:String;
		public var stake:Number;
		public var currency:String;
		public var win:Number;

		public function DayVO() {
		}
	}
}

