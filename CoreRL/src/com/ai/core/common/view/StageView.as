package com.ai.core.common.view {
	
	
	
	public class StageView extends StageAsset {		
		
		public function StageView() {
			visible = true;
			errorMsg.visible=false;
		}
		
		public function init():void {
			align();
		}
		
		public function align():void {
			//bg.width = stage.stageWidth;
			//bg.height = stage.stageHeight;
			//preloaderMC.x = (bg.width - preloaderMC.width) / 2;
			//preloaderMC.y = (bg.height - preloaderMC.height) / 2;
		}
		
		public function showPreloader():void {
			preloaderMC.visible = true;
			preloaderMC.play();
		}
		
		public function hidePreloader():void {
			preloaderMC.visible = false;
			preloaderMC.stop();
		}
		
		public function setErrorMessage(val:String):void{
			errorMsg.text=val;
			errorMsg.visible=true;
			
		}
		
	}
}