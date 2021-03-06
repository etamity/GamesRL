package com.newco.grand.core.common.view
{
	import com.newco.grand.core.common.model.BaseObject;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.text.TextField;
	
	import fl.motion.AdjustColor;
	
	import org.osflash.signals.Signal;
	

	public class SMButton extends BaseObject
	{
		private var button:SimpleButton;
		public var url:String;
		private var _label:String;
		
		public var upStateText:TextField;
		private var _params:Object=new Object();
		
		public var onClick:Signal=new Signal();
		public function SMButton(btn:SimpleButton)
		{
			super();
			button=btn;
			button.addEventListener(MouseEvent.CLICK,doClick);
			var sp:DisplayObjectContainer=button.upState as DisplayObjectContainer;
			if (sp!=null) {
				var n:uint=sp.numChildren;
				for (var i:int=0; i < n; i++) {
					var txt:*= sp.getChildAt(i);
					if (txt is TextField) {
						upStateText= TextField(txt);
						//upStateText.setTextFormat(_textFormat);
						
					}
				}
			}
		}
		private function doClick(evt:MouseEvent):void{
			onClick.dispatch(this);
		}
		public function get params():Object{
			return _params;
		}
		public function set params(val:Object):void{
			_params=val;
		}
		public function set label(text:String):void{
			if (text !=null && text!="")
			update(text);
		}
		
		public function get label():String{
			return _label;
		}
		
		public function set enabled(val:Boolean):void{
		
			button.enabled=val;
			button.mouseEnabled=val;
			if (val==false)
			{
			button.alpha= 0.8;
			GameUtils.setEnableFilter(button,false);
		
			}
			else
			{
			button.alpha= 1;
			GameUtils.setEnableFilter(button);
			}
		}
		
	    public function get visible():Boolean{
			return button.visible;
		}
		public function set visible(val:Boolean):void{
			 button.visible=val;
		}
		public function get enabled():Boolean{
			return button.enabled;
		}
		public function get skin():SimpleButton{
			return button;
		}
		public static function adjustFilterPro(mc:DisplayObject, brightness:int,contrast:int,saturation:int, hue:int):void {
			//colors = hue:Number = 0, sat:Number = 0, brigh:Number = 0, con:Number = 0;
			//var colors:Array            = findChipMatrixColor(val);
			
			//all 4 must contain a value of an integer, if one is not set, it will not work
			var colorFilter:AdjustColor = new AdjustColor();
			var mColorMatrix:ColorMatrixFilter;
			var mMatrix:Array           = [];
			
			colorFilter.brightness = brightness;
			colorFilter.contrast = contrast;
			colorFilter.saturation = saturation;
			colorFilter.hue = hue;
			
			mMatrix = colorFilter.CalculateFinalFlatArray();
			mColorMatrix = new ColorMatrixFilter(mMatrix);
			mc.filters = [mColorMatrix];
		}
		
		private function update(text:String):void {
			_label=text;
			updateText(button.upState, text);
			updateText(button.overState, text);
			updateText(button.downState, text);
			
			
		}
		
		
		public function updateText(o:DisplayObject,text:String):void {
			var sp:DisplayObjectContainer=o as DisplayObjectContainer;
			if (sp!=null) {
				var n:uint=sp.numChildren;
				for (var i:int=0; i < n; i++) {
					var txt:*= sp.getChildAt(i);
					if (txt is TextField) {
						TextField(txt).text=text;
						TextField(txt).mouseEnabled=false;
					}
				}
			}
		}
		
	}
}