package com.newco.grand.core.mobile.view{
		
		import com.newco.grand.core.common.view.TaskbarView;
		
		public class TaskbarView extends com.newco.grand.core.common.view.TaskbarView {
	
			public function TaskbarView() {
				super();
			}
			
			override public function initDisplay():void{
				_display=new Mobile_TaskbarAsset();
				addChild(_display);
			}
			override public function align():void {			
				x = 0;
				y=830;
			}
		}
}