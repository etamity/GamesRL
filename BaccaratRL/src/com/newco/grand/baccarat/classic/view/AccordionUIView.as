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
			visible=true;
		}
	}
}