package com.newco.grand.core.common.controller.signals {
	
	
	
	public class TooltipEvent {
		
		public static const SHOW_DEFAULT:String = "TooltipEvent.SHOW_DEFAULT";
		
		private var _target:Object;
		public  function get target():Object {
			return _target;
		}
		
		public function set target(value:Object):void {
			_target = value;
		}
	}
}