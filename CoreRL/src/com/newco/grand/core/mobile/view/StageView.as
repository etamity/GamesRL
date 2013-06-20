package com.newco.grand.core.mobile.view {
	import com.newco.grand.core.common.view.StageView;
	
	public class StageView extends com.newco.grand.core.common.view.StageView
	{
		public function StageView() {
			super();
		}
		override public function initDisplay():void{
			_display=new Mobile_StageAsset();
			addChild(_display);
		}
		
	}
}