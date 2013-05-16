package com.ai.core.view.uicomps
{
	import com.ai.core.view.interfaces.IAccordion;
	import com.smart.uicore.controls.Accordion;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class AccordionUIView extends Sprite implements IAccordion
	{
		private var _accordion:Accordion
		public function AccordionUIView()
		{
			visible = false;
			_accordion=new Accordion();
			addChild(_accordion);
			_accordion.setSize(170,529);
			_accordion.defaultButtonHeight=33;
		}
		
		public function init():void
		{
			align();
		}
		
		public function align():void {
			visible = true;
		}
		public function add(mc:MovieClip, title:String, toolTipMsg:String=""):void
		{
			_accordion.add(title,mc);
		
	
		}
	}
}