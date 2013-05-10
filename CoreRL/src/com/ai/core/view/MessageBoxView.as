package com.ai.core.view
{
	import flash.text.TextFormat;
	
	import caurina.transitions.Tweener;
	public class MessageBoxView extends MessageBoxAsset
	{
		private var _messageFormat:TextFormat = new TextFormat("Arial", 14, 0xCCCCCC, true);
		private var _blinkCounter:int = 0;
		
		public function MessageBoxView()
		{
			visible = false
		}
		
		public function init():void {
			align();
			//messageBlinkBG.visible = false;
		}
		public function align():void {			
			x = stage.stageWidth /2 -width/2;
			y = stage.stageHeight/2 -height /2;
			show();
		}
		private function alignMessage():void {
			//alertTxt.autoSize = TextAlign.CENTER;
			//messageTxt.y = messageBG.y + (messageBG.height - messageTxt.height) / 2;
			show();
		}
		
		public function set message(value:String):void {
			alertTxt.text = value;
			alertTxt.setTextFormat(_messageFormat);
			alignMessage();
			//show();
		}
		public function show():void{
			this.alpha=0;
			this.visible =true;
			Tweener.addTween(this, {alpha:1, time:3, delay:2,onComplete:hide});
			
		}
		public function hide():void{
			Tweener.addTween(this, {alpha:0, time:3, onComplete:function ():void {
			this.visible=false;
			
			}});
		}
		public function highlightMessageBG(clr:uint = 0x990000):void {
			/*var colorTransform:ColorTransform = bg_mc.transform.colorTransform;
			colorTransform.color = clr;
			bg_mc.transform.colorTransform = colorTransform;
			visible = true;
			bg_mc.alpha = 1;
			Tweener.removeTweens(bg_mc);
			Tweener.addTween(this, {alpha:0, time:3, delay:1, onComplete:removeMessageHighlightBG});*/
			
		}	
		
		public function removeMessageHighlightBG():void {
		
			//Tweener.resumeTweens(bg_mc);
		}
		
	}
}