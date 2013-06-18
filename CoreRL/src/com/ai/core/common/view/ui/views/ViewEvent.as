package com.ai.core.common.view.ui.views {

	import flash.events.Event;

	public class ViewEvent extends Event {
		public static const CLOSE_CLICK:String = "closeClick";
		public static const BACK_CLICK:String  = "backClick";

		public function ViewEvent(type:String) {
			super(type, true, true);
		}
	}
}

