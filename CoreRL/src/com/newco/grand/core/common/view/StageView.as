package com.newco.grand.core.common.view {
	import com.newco.grand.core.common.view.interfaces.IStageView;
	
	import flash.display.Sprite;
	
	
	public class StageView extends UIView implements IStageView {		
		public function StageView() {
			super();
			visible=true;

		}
		override public function initDisplay():void{
			_display=new StageAsset();
			addChild(_display);
		}

		override public function align():void {
			//bg.width = stage.stageWidth;
			//bg.height = stage.stageHeight;
			//preloaderMC.x = (bg.width - preloaderMC.width) / 2;
			//preloaderMC.y = (bg.height - preloaderMC.height) / 2;
		}
		
		public function showPreloader():void {
			_display.preloaderMC.visible = true;
			_display.preloaderMC.play();
		}

		public function hidePreloader():void {
			_display.preloaderMC.visible = false;
			_display.preloaderMC.stop();
		}
		
	}
}