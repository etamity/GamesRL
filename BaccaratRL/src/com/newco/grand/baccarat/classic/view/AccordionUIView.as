package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.core.common.view.uicomps.AccordionUIView;
	
	public class AccordionUIView extends com.newco.grand.core.common.view.uicomps.AccordionUIView
	{
		public function AccordionUIView()
		{
			super();
		}
		override public function align():void{
			x= stage.stageWidth -width;
			display.y=190;
			_compHeight=420;
			_display.setSize(_compWidth,_compHeight);
			visible=true;
		}
	}
}