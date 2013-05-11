package com.ai.roulette.view {
	
	import com.ai.core.view.accordion.Accordion;
	
	import flash.display.MovieClip;
	
	public class AccordionView extends AccordionAsset {

		private var _accordion:Accordion;
		private var _headers:Array;
		
		public function AccordionView() {
			visible = false;
			_accordion = new Accordion(170, 529, 3, 170, 33, true);
			_headers = new Array();			
			addChild(_accordion);
		}		
		
		public function init():void {			
			align();
		}
		
		public function align():void {
			visible = true;
		}
		
		public function add(mc:MovieClip, title:String, toolTipMsg:String = ""):void {
			var header:HeaderVertical = new HeaderVertical();
			_accordion.addPanel(header, mc, bold(title));
			_accordion.openPanel(1);
			_headers.push(header);
		}
		
		private function bold(txt:String):String {
			return "<b>"+txt+"</b>";
		}
	}
}