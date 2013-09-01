package com.slc.games.help.events {

	import flash.events.Event;

	public class ContentsEvent extends Event {
		public static const CONTENTS_ITEM_CLICK:String = "contentsItemClick";

		private var _index:uint;

		public function ContentsEvent(type:String, index:uint) {
			super(type, true, true);

			_index = index;
		}

		public function get index():uint {
			return _index;
		}
	}
}

