package com.newco.grand.core.common.view.uicomps
{
	import com.newco.grand.core.common.view.interfaces.IAccordion;
	import com.smart.uicore.controls.Accordion;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class AccordionUIView extends Sprite implements IAccordion
	{
		private var _display:*
		
		public var compWidth:Number=170;
		public var compHeight:Number=529;
		
		public function AccordionUIView()
		{
			visible = false;
			initDisplay();
			_display.setSize(compWidth,compHeight);
			_display.defaultButtonHeight=33;
	
		}
		public function initDisplay():void{
			_display=new Accordion();
			addChild(_display);
		}
		public function get display():*{
			return this;
		}
		public function get contentHeight():int{
			return compHeight- _display.buttons.length*_display.defaultButtonHeight;
		}
		public function init():void
		{
			align();
		}
		
		public function align():void {
			visible = true;
		}

		public function resize(width:Number,height:Number):void{
			_display.setSize(width,height);
		}
		public function add(mc:MovieClip, title:String, toolTipMsg:String=""):void
		{
			_display.add(title,mc);
			//IUIView(mc).setSize(170,529-_accordion.buttons.length*_accordion.defaultButtonHeight);
		}
	}
}