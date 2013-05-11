package com.ai.core.view {

	import com.ai.core.utils.FormatUtils;
	import com.ai.core.utils.GameUtils;
	
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;

	public class Betchip extends BetchipAsset {

		private var _chipValue:Number;
		private var _betspotName:String;
		private var _txtFormat:TextFormat;

		public var hightLightSignal:Signal=new Signal();
		public var removeLightSignal:Signal=new Signal();
		public var betchipSignal:Signal=new Signal();
		public function Betchip() {
			_txtFormat = new TextFormat("Arial", 11, 0x000000, true);
			chipValue = 0;
			buttonMode = true;
			mouseChildren = false;
			addEventListener(MouseEvent.ROLL_OVER, rollOver);
			addEventListener(MouseEvent.ROLL_OUT, rollOut);
			addEventListener(MouseEvent.MOUSE_DOWN, placeChip);	
		}
		
		public function disable():void {
			buttonMode = false;
			removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, placeChip);	
			greyOutChip();
		}

		private function rollOver(evt:MouseEvent):void {
			//dispatchEvent(new HighlightEvent(HighlightEvent.HIGHLIGHT, betspotName));
			hightLightSignal.dispatch(betspotName);
		}
		
		private function rollOut(evt:MouseEvent):void {
			//dispatchEvent(new HighlightEvent(HighlightEvent.REMOVE_HIGHLIGHT, betspotName));
			removeLightSignal.dispatch(betspotName);
		}		
		
		public function placeChip(evt:MouseEvent):void {
			//dispatchEvent(new BetEvent(BetEvent.CHIP_BET, betspotName));
			betchipSignal.dispatch(betspotName);
		}

		public function updateChipColor(value:Number):void {
			GameUtils.adjustFilter(base.color,value);
			
			/*try {
				base.color.gotoAndStop("c" + value);
			}
			catch(error:Error) {
				base.color.gotoAndStop("repeat");
			}*/
		}

		public function clean():void {
			chipValue = 0;			
		}

		public function createBet(amt:Number):void {
			clean();
			chipValue = amt;
		}

		private function placeChipForRepeat(amt:int):void {
			chipValue = amt;
		}

		public function set chipValue(amt:Number):void {
			_chipValue = amt;
			value.text = FormatUtils.formatChipText(amt);
			value.setTextFormat(_txtFormat);
		}

		public function get chipValue():Number {
			return _chipValue;
		}
		
		public function set betspotName(value:String):void {
			_betspotName = value;
		}
		
		public function get betspotName():String {
			return _betspotName;
		}
		
		public function greyOutChip():void {
			/*var newColorTransform:ColorTransform = this.transform.colorTransform;
			newColorTransform.color = GameUtils.findChipColor(-1);
			this.transform.colorTransform = newColorTransform;*/
			this.alpha = 0.68;
		}

		private function debug(...args):void {
			trace(this, args);
		}
	}
}