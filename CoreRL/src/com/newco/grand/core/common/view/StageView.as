package com.newco.grand.core.common.view {
	import com.newco.grand.core.common.view.interfaces.IStageView;
	
	import flash.display.Sprite;
	
	
	public class StageView extends Sprite implements IStageView {		
		protected var _display:*;
		public function StageView() {
			visible = true;
			initDisplay();

			_display.errorMsg.visible=false;
		}
		public function initDisplay():void{
			_display=new StageAsset();
			addChild(_display);
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
			_display.preloaderMC.visible = true;
			_display.preloaderMC.play();
		}
		public function get display():*{
			return this;
		}
		public function hidePreloader():void {
			_display.preloaderMC.visible = false;
			_display.preloaderMC.stop();
		}
		
		public function setErrorMessage(val:String):void{
			_display.errorMsg.text=val;
			_display.errorMsg.visible=true;
			
		}
		
	}
}