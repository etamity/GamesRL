package com.newco.grand.core.common.view.uicomps
{
	import com.newco.grand.core.common.view.interfaces.IAccordion;
	import com.smart.uicore.controls.Accordion;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class AccordionUIView extends Sprite implements IAccordion
	{
		private var _accordion:Accordion
		
		public var compWidth:Number=170;
		public var compHeight:Number=529;
		public function AccordionUIView()
		{
			visible = false;
			_accordion=new Accordion();
			addChild(_accordion);
			_accordion.setSize(compWidth,compHeight);
			_accordion.defaultButtonHeight=33;
	
		}
		
		public function get contentHeight():int{
			return compHeight- _accordion.buttons.length*_accordion.defaultButtonHeight;
		}
		public function init():void
		{
			align();
		}
		
		public function align():void {
			visible = true;
		}

		public function resize(width:Number,height:Number):void{
			_accordion.setSize(width,height);
		}
		public function add(mc:MovieClip, title:String, toolTipMsg:String=""):void
		{
			_accordion.add(title,mc);
			//IUIView(mc).setSize(170,529-_accordion.buttons.length*_accordion.defaultButtonHeight);
		}
	}
}