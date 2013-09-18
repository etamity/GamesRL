package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.uicomps.AccordionUIView;
	
	public class AccordionUIView extends com.newco.grand.core.common.view.uicomps.AccordionUIView
	{
		public function AccordionUIView()
		{
			super();
		}
		
		override public function updateLanguage():void{
			_display.buttons[0].label= LanguageModel.PLAYERS;
			_display.buttons[1].label= LanguageModel.WINNERLIST;
			_display.buttons[2].label= LanguageModel.TOURNAMENT;
		}
		
		override public function align():void{
			x= stage.stageWidth -width;
			view.y=190;
			_compHeight=420;
			_display.setSize(_compWidth,_compHeight);
			visible=true;
		}
	}
}