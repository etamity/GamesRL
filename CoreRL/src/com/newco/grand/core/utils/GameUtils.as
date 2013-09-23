package com.newco.grand.core.utils {
	
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	
	import fl.motion.AdjustColor;
	
	public class GameUtils {
		public static function findChipMatrixColor(val:Number):Array {
			switch (val) {
				case -1:
					return [15, 40, -100, 0];
					break;
				case 0.5:
					return [30, 40, 40, -170];
					break;
				case 1:
					return [22, 50, 54, -140];
					break;
				case 2:
					return [40, 50, 40, -157];
					break;
				case 5:
					return [20, 50, 20, -14];
					break;
				case 10:
					return [20, 60, 0, -98];
					break;
				case 25:
					return [0, 40, 20, 50];
					break;
				case 50:
					return [0, 40, 30, 100];
					break;
				case 100:
					return [6, 40, 0, -180];
					break;
				case 500:
					return [20, 40, 10, -27];
					break;
				case 1000:
					return [0, 40, 40, 152];
					break;
				case 5000:
					return [10, 54, 0, 0];
					break;
				case 10000:
					return [18, 44, 33, -152];
					break;
				case 50000:
					return [16, 29, 29, 167];
					break;
				default:
					return findChipMatrixColor(getChipColor(val));
					break;
			}
		}
		
		public static function getChipColor(val:Number):Number {
			var color:Number = 0;
			if (val >= 0 && val < 0.9) {
				color = 0.5;
			}
			if (val >= 0.9 && val < 2) {
				color = 1;
			}
			if (val >= 2 && val < 5) {
				color = 2;
			}
			if (val >= 5 && val < 10) {
				color = 5;
			}
			if (val >= 10 && val < 25) {
				color = 10;
			}
			if (val >= 25 && val < 50) {
				color = 25;
			}
			if (val >= 50 && val < 100) {
				color = 50;
			}
			if (val >= 100 && val < 500) {
				color = 100;
			}
			if (val >= 500 && val < 1000) {
				color = 500;
			}
			if (val >= 1000 && val < 5000) {
				color = 1000;
			}
			if (val >= 5000 && val < 10000) {
				color = 5000;
			}
			if (val >= 10000 && val < 50000) {
				color = 10000;
			}
			if (val >= 50000) {
				color = 50000;
			}
			return color;
		}

		
		public static function findChipColor(val:int):uint {
			switch(val) {
				case -1:
					return 0x929292; //GREYED OUT STATE
					break;
				case 0.5:
					return 0xFAAD65; //PEACH
					break;
				case 1:
					return 0x666666; //WHITE GREY
					break;
				case 2:
					return 0xFF82D6; //PINK
					break;
				case 5:
					return 0xCE1D00; //RED
					break;					
				case 10:
					return 0x00BEF3; //MID BLUE
					break;
				case 25:
					return 0x00A500; //GREEN
					break;
				case 50:
					return 0xAA7942; //BROWN
					break;
				case 100:
					return 0x000000; //BLACK
					break;
				case 500:
					return 0x8548B0; //PURPLE
					break;
				case 1000:
					return 0xDE9807; //YELLOW
					break;
				case 5000:
					return 0xDE7571; //BROWN RED
					break;
				case 10000:
					return 0x006699; //BLUE
					break;
				case 50000:
					return 0x929292; //GREY
					break;
				default:
					return 0x929292; //GREY
					break;
			}
		}
		
		public static function findRouletteBetspotColor(val:int):String {
			if (val == -1) {
				return "C";
			}
			if (val == 0) {
				return "GREEN";
			}
			
			var red:String = "#1#3#5#7#9#12#14#16#18#19#21#23#25#27#30#32#34#36#";
			var black:String = "#2#4#6#8#10#11#13#15#17#20#22#24#26#28#29#31#33#35#";
			if (red.indexOf("#" + val + "#") != -1) {
				return "RED";
			}
			else if (black.indexOf("#" + val + "#") != -1) {
				return "BLACK";
			}
			return "C";
		}
		
		public static function findBaccaratCardLabel(val:int):String{
			var cardLabel:String;
			switch (val){
			case 0: cardLabel="c102";break;
			case 1: cardLabel="c103";break;
			case 2: cardLabel="c104";break;
			case 3: cardLabel="c105";break;
			case 4: cardLabel="c106";break;
			case 5: cardLabel="c107";break;
			case 6: cardLabel="c108";break;
			case 7: cardLabel="c109";break;
			case 8: cardLabel="c110";break;
			case 9: cardLabel="c111";break;
			case 10: cardLabel="c112";break;
			case 11: cardLabel="c113";break;
			case 12: cardLabel="c101";break;
			case 13: cardLabel="c402";break;
			case 14: cardLabel="c403";break;
			case 15: cardLabel="c404";break;
			case 16: cardLabel="c405";break;
			case 17: cardLabel="c406";break;
			case 18: cardLabel="c407";break;
			case 19: cardLabel="c408";break;
			case 20: cardLabel="c409";break;
			case 21: cardLabel="c410";break;
			case 22: cardLabel="c411";break;
			case 23: cardLabel="c412";break;
			case 24: cardLabel="c413";break;
			case 25: cardLabel="c401";break;
			case 26: cardLabel="c302";break;
			case 27: cardLabel="c303";break;
			case 28: cardLabel="c304";break;
			case 29: cardLabel="c305";break;
			case 30: cardLabel="c306";break;
			case 31: cardLabel="c307";break;
			case 32: cardLabel="c308";break;
			case 33: cardLabel="c309";break;
			case 34: cardLabel="c310";break;
			case 35: cardLabel="c311";break;
			case 36: cardLabel="c312";break;
			case 37: cardLabel="c313";break;
			case 38: cardLabel="c301";break;
			case 39: cardLabel="c202";break;
			case 40: cardLabel="c203";break;
			case 41: cardLabel="c204";break;
			case 42: cardLabel="c205";break;
			case 43: cardLabel="c206";break;
			case 44: cardLabel="c207";break;
			case 45: cardLabel="c208";break;
			case 46: cardLabel="c209";break;
			case 47: cardLabel="c210";break;
			case 48: cardLabel="c211";break;
			case 49: cardLabel="c212";break;
			case 50: cardLabel="c213";break;
			case 51: cardLabel="c201";break;
			}
			return cardLabel;
		}
		public static function findBaccaratCardValue(val:int):int {
			var cardValue:Number = 0;
			if (val >= 0 && val <= 7) {
				cardValue = val + 2;
			}
			else if (val >= 13 && val <= 20) {
				cardValue = val - 11;
			}
			else if (val >= 26 && val <= 33) {
				cardValue = val - 24;
			}
			else if (val >= 39 && val <= 46) {
				cardValue = val - 37;
			}
			else if (val == 12 || val == 25 || val == 38 || val == 51) {
				cardValue = 1;
			}
			else if (val > 0) {
				cardValue = 0;
			}
			return cardValue;
		}
		
		public static function findBlackjackCardValue(val:int):int {
			var cardValue:Number = 0;
			if (val >= 0 && val <= 7) {
				cardValue = val + 2;
			}
			else if (val >= 13 && val <= 20) {
				cardValue = val - 11;
			}
			else if (val >= 26 && val <= 33) {
				cardValue = val - 24;
			}
			else if (val >= 39 && val <= 46) {
				cardValue = val - 37;
			}
			else if (val == 12 || val == 25 || val == 38 || val == 51) {
				cardValue = 111;
			}
			else if (val > 0) {
				cardValue = 10;
			}
			return cardValue;
		}
		
		public static function randomNumber(low:int = 0, high:int = 1):int {
			return Math.floor(Math.random() * (1 + high - low)) + low;
		}
		
		public static function removeChildren(mc:MovieClip):void {
			var children:Array = new Array();
			for (var i:int = 0; i < mc.numChildren; i++) {
				children.push(mc.getChildAt(i));
			}
			for (i = 0; i < children.length; i++) {
				children[i].parent.removeChild(children[i]);
			}
		}
		
		public static function adjustFilter(mc:MovieClip, val:Number):void {
			//colors = hue:Number = 0, sat:Number = 0, brigh:Number = 0, con:Number = 0;
			var colors:Array            = findChipMatrixColor(val);
			
			//all 4 must contain a value of an integer, if one is not set, it will not work
			var colorFilter:AdjustColor = new AdjustColor();
			var mColorMatrix:ColorMatrixFilter;
			var mMatrix:Array           = [];
			
			colorFilter.brightness = colors[0];
			colorFilter.contrast = colors[1];
			colorFilter.saturation = colors[2];
			colorFilter.hue = colors[3];
			
			mMatrix = colorFilter.CalculateFinalFlatArray();
			mColorMatrix = new ColorMatrixFilter(mMatrix);
			mc.filters = [mColorMatrix];
		}

		
		public static function setEnableFilter(mc:DisplayObject, enable:Boolean=true):void {
			//colors = hue:Number = 0, sat:Number = 0, brigh:Number = 0, con:Number = 0;
			//var colors:Array            = findChipMatrixColor(val);
			
			//all 4 must contain a value of an integer, if one is not set, it will not work
			var colorFilter:AdjustColor = new AdjustColor();
			var mColorMatrix:ColorMatrixFilter;
			var mMatrix:Array           = [];
			
			colorFilter.brightness = 0;
			colorFilter.contrast = 0;
			colorFilter.saturation = 0;
			colorFilter.hue = 0;
			
			if (!enable)
			{
				colorFilter.saturation = -100;
			}
			
			mMatrix = colorFilter.CalculateFinalFlatArray();
			mColorMatrix = new ColorMatrixFilter(mMatrix);
			mc.filters = [mColorMatrix];
		}
		
		/**
		 * Creates a two-tone, 90 degree gradient within a given DisplayObjectContainer.
		 *
		 * @param container The container into which the gradient will be drawn.
		 * @param colourA The first (top) colour of the gradient.
		 * @param colourB The second (bottom) colour of the gradient.
		 * @param width The width of the gradient. If not specified, the current
		 * width of the container is used.
		 * @param height The height of the gradient. If not specified, the current
		 * height of the container is used.
		 */
		public static function createGradient(container:DisplayObjectContainer, colourA:uint, colourB:uint, width:Number = -1, height:Number = -1):void {
			var w:Number      = width != -1 ? width : container.width;
			var h:Number      = height != -1 ? height : container.height;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, h, Math.PI / 2, w / 2, 0);
			
			var s:Shape = new Shape();
			s.graphics.beginGradientFill(GradientType.LINEAR, [colourA, colourB], [1, 1], [0, 255], matrix);
			s.graphics.drawRect(0, 0, w / container.scaleX, h / container.scaleY);
			container.addChild(s);
		}
		
		/**
		 * Function to search an array for specific item
		 * @param arr - Array to search
		 * @param val - value to search
		 * @return true/false
		 */
		public static function hasItem(arr:Array, val:*):Boolean {
			for (var i:int = 0; i < arr.length; i++) {
				if (arr[i] == val) {
					return true;
				}
			}
			return false;
		}
		
		public static function log(caller:*,...args):void {
			trace(caller,args);

			MonsterDebugger.trace(caller, args);
		}
	}
}