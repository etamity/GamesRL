package com.newco.grand.roulette.classic.view
{
	import com.newco.grand.core.common.view.uicomps.AccordionUIView;

	public class AccordionUIView extends com.newco.grand.core.common.view.uicomps.AccordionUIView
	{
		public function AccordionUIView()
		{
			super();
		}
		override public function align():void{
			x= stage.stageWidth -width+2;
			_compHeight=610;
			_display.setSize(_compWidth,_compHeight);
			visible=true;
		}
		

	}
}