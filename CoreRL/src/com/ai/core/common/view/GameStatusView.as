package com.ai.core.common.view {
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	public class GameStatusView extends GameStatusAsset {
		
		private var _messageFormat:TextFormat = new TextFormat("Arial", 14, 0xFFAF32, true);
		private var _blinkCounter:int = 0;
		
		public function GameStatusView() {
			visible = false
		}
		
		public function init():void {
			align();
			visible = true;
			time.visible=false;
			setLightSOff();
			//messageBlinkBG.visible = false;
		}
		
		public function align():void {			
			x = 626;
			y = 0;
		}
		
		private function alignMessage():void {
			messageTxt.autoSize = TextFieldAutoSize.CENTER;
			messageTxt.y = 108 + (87.85 - messageTxt.height) / 2;
		}
		
		public function set message(value:String):void {
			messageTxt.text = value;
			messageTxt.setTextFormat(_messageFormat);
			alignMessage();
		}
		
		public function setLightOn(label:String):void{
			setLightSOff();
			switch (label){
				case "amber":
					amberMC.gotoAndStop("on");
					break;
				case "green":
					greenMC.gotoAndStop("on");
					break;
				case "red":
					redMC.gotoAndStop("on");
					break;
			}
		}
		
		
		public function setLightSOff():void{
			amberMC.gotoAndStop("off");
			greenMC.gotoAndStop("off");
			redMC.gotoAndStop("off");
		}
		
		public function set timer(value:String):void {
			time.text = value;
		}
		
		public function set timerColor(value:uint):void {
			time.textColor = value;
		}
		
		public function highlightMessageBG(clr:uint = 0x990000):void {
			/*var colorTransform:ColorTransform = messageBlinkBG.transform.colorTransform;
			colorTransform.color = clr;
			messageBlinkBG.transform.colorTransform = colorTransform;
			messageBlinkBG.visible = true;
			messageBlinkBG.alpha = 1;
			Tweener.removeTweens(messageBlinkBG);
			Tweener.addTween(messageBlinkBG, {alpha:0, time:3, delay:1, onComplete:removeMessageHighlightBG});
		*/
		}	
		
		private function removeMessageHighlightBG():void {
			/*messageBlinkBG.visible = false;
			Tweener.removeTweens(messageBlinkBG);*/
		}
	}
}