package com.newco.grand.core.common.view.uicomps
{
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.interfaces.IAccordion;
	import com.smart.uicore.controls.Accordion;
	import com.smart.uicore.controls.modeStyles.ButtonStyle;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class AccordionUIView extends Sprite implements IAccordion
	{
		protected var _display:Accordion;
		
		protected var _compWidth:Number=200;
		protected var _compHeight:Number=529;
		
		public function AccordionUIView()
		{
			visible = false;
			initDisplay();
			_display.setSize(_compWidth,_compHeight);
			_display.setStyle(ButtonStyle.TEXT_COLOR,"#FFFFFF");
			_display.setStyle(ButtonStyle.TEXT_OVER_COLOR,"#00CC00");
			_display.setStyle(ButtonStyle.TEXT_DOWN_COLOR,"#00CC00");
			_display.defaultButtonHeight=26;
			_display.defaultGapHeight=2;
	
		}
		public function updateLanguage():void{
		}
		public function get view():Sprite{
			return this;
		}
		public function initDisplay():void{
			_display=new Accordion();
			addChild(_display);
		}
		public function get display():*{
			return _display;
		}
		public function get contentHeight():int{
			return _compHeight- _display.buttons.length*(_display.defaultButtonHeight+_display.defaultGapHeight);
		}
		public function set compHeight(val:int):void{
			_compHeight=val;
		}
		public function get compHeight():int{
			return _compHeight;
		}
		public function init():void
		{
			updateLanguage();
			align();
		}
		
		public function align():void {
			visible = true;
			_display.setSize(_compWidth,_compHeight);
			
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