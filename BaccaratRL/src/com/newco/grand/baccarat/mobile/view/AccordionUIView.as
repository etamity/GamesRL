package com.newco.grand.baccarat.mobile.view
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
			y=190;
			view.y=190;
			_compHeight=320;
			_display.setSize(_compWidth,_compHeight);
			visible=true;
		}
	}
}