package com.newco.grand.core.common.view {
	import com.newco.grand.core.common.view.interfaces.IGameStatusView;
	
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class GameStatusView extends Sprite implements IGameStatusView {
		
		private var _messageFormat:TextFormat = new TextFormat("Arial", 14, 0xFFAF32, true);
		private var _blinkCounter:int = 0;
		protected var _display:*;
		public function GameStatusView() {
			visible = false
			initDisplay();
		}
		public function initDisplay():void{
			_display=new GameStatusAsset();
			addChild(_display);
		}
		public function init():void {
			align();
			visible = true;
			_display.time.visible=false;
			setLightSOff();
			//messageBlinkBG.visible = false;
		}
		public function get display():*{
			return _display;
		}
		public function align():void {			
			x = 626;
			y = 0;
		}
		
		private function alignMessage():void {
			_display.messageTxt.autoSize = TextFieldAutoSize.CENTER;
			_display.messageTxt.y = 108 + (87.85 - _display.messageTxt.height) / 2;
		}
		
		public function set message(value:String):void {
			_display.messageTxt.text = value;
			_display.messageTxt.setTextFormat(_messageFormat);
			alignMessage();
		}
		
		public function setLightOn(label:String):void{
			setLightSOff();
			switch (label){
				case "amber":
					_display.amberMC.gotoAndStop("on");
					break;
				case "green":
					_display.greenMC.gotoAndStop("on");
					break;
				case "red":
					_display.redMC.gotoAndStop("on");
					break;
			}
		}
		
		
		public function setLightSOff():void{
			_display.amberMC.gotoAndStop("off");
			_display.greenMC.gotoAndStop("off");
			_display.redMC.gotoAndStop("off");
		}
		
		public function set timer(value:String):void {
			_display.time.text = value;
		}
		
		public function set timerColor(value:uint):void {
			_display.time.textColor = value;
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