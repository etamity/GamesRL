package com.newco.grand.core.common.view {
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import caurina.transitions.Tweener;
	
	public class Tooltip extends TooltipMcAsset {
		
		private var _target:Object;
		private var _centered:Boolean;
		private var _tooltipText:TextField;
		private var _txtFormat:TextFormat;
		
		private const TOOLTIP_Y_POSITION:uint = 3;
		private const TEXT_X_POSITION:uint = 6;
		private const TEXT_Y_POSITION:uint = 2;
		private const FONT_SIZE:uint = 10;
		private const BREATHING_SPACE:uint = 16;
		private const TIME_BEFORE_SHOWING_TOOLTIP:Number = 0.5;
		private const TIME_BEFORE_HIDING_TOOLTIP:Number = 2;
		
		public function Tooltip() {
			_txtFormat = new TextFormat("Arial", FONT_SIZE, 0x000000, true);
			createTooltip();
			makeMeInvisible();
		}
		
		public function addListeners():void {
			_target.removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
			_target.addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		//public function showTip(txt:String, obj:MovieClip, valign:String = "top", halign:String = "center", xoffset:Number = 0, yoffset:Number = 0, delay:Number = 0, fadeAway:Boolean = true, multi:Boolean = false, txtwidth:Number = 100):void {
		public function showTooltip(target:Object, txt:String):void {
			_target = target;
			addListeners();
			
			_tooltipText.text = txt;
			_tooltipText.autoSize = TextFieldAutoSize.LEFT;
			_tooltipText.setTextFormat(_txtFormat);
			backgroundMc.width = _tooltipText.textWidth + BREATHING_SPACE;
			var xPos:uint = (_centered) ? (_target.width / 2) + (_target.x - width / 2) : _target.x + _target.width - backgroundMc.width;
			x = xPos;
			y = _target.y - height - TOOLTIP_Y_POSITION;
			
			visible = true;
			trace(this,"showTooltip");
			alpha = 0;
			Tweener.removeTweens(this);
			Tweener.addTween(this, {time:0.2, alpha:1, delay:TIME_BEFORE_SHOWING_TOOLTIP, onComplete:hideTooltip, onCompleteParams:[TIME_BEFORE_HIDING_TOOLTIP]});
		}

		public function hideTooltip(delay:Number = 0):void {
			if(alpha == 0 && delay == 0) {
				makeMeInvisible();
			}
			else {
				Tweener.removeTweens(this);
				Tweener.addTween(this, {time:0.2, alpha:0, delay:delay, onComplete:makeMeInvisible});
			}
		}
		
		private function onMouseOut(event:MouseEvent):void {
			hideTooltip();
		}
		
		private function makeMeInvisible():void {
			visible = false;
		}
		
		private function createTooltip():void {
			createTextField();
			alpha = 0;
			addChild(_tooltipText);
		}
		
		private function createTextField():void {
			_tooltipText = new TextField();			
			_tooltipText.selectable = false;
			_tooltipText.x = TEXT_X_POSITION;
			_tooltipText.y = TEXT_Y_POSITION;
		}	
	}
}