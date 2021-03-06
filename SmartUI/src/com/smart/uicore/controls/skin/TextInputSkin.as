package com.smart.uicore.controls.skin 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	
	import com.smart.uicore.controls.TextInput;
	import com.smart.uicore.controls.managers.DefaultStyle;
	import com.smart.uicore.controls.modeStyles.ButtonStyle;
	import com.smart.uicore.controls.support.RoundRectAdvancedDraw;
	import com.smart.uicore.controls.support.UIComponent;
	import com.smart.uicore.controls.managers.SkinThemeColor;

	/**
	 * ...
	 * @author flashk
	 */
	public class TextInputSkin extends ActionDrawSkin
	{
		
		private var tar:TextInput;
		private var mot:MotionSkinControl;
		private var shape:Shape;
		private var styleSet:Object;
		
		public function TextInputSkin() 
		{
			shape = new Shape();
		}
		
		override public function init(target:UIComponent,styleSet:Object):void {
			this.styleSet = styleSet;
			tar = target as TextInput;
			tar.addChildAt(shape, 0);
			mot = new MotionSkinControl(tar, shape);
		}
		
		public function get skinDisplayObject():DisplayObject {
			return shape;
		}
		
		override public function reDraw():void {
			shape.graphics.clear();
			var width:Number = tar.compoWidth - 0;
			var height:Number = tar.compoHeight -0;
			SkinThemeColor.initTextFillStyle(shape.graphics,width,height);
			var ew:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_WIDTH];
			var eh:Number = styleSet[ButtonStyle.DEFAULT_SKIN_ELLIPSE_HEIGHT];
			RoundRectAdvancedDraw.drawAdvancedRoundRect(shape.graphics, 0+DefaultStyle.graphicsDrawOffset, 0+DefaultStyle.graphicsDrawOffset, width, height, ew, eh, ew, eh, ew, eh, ew,eh,ew,eh);
			shape.cacheAsBitmap = true;
		}
		
	}
}