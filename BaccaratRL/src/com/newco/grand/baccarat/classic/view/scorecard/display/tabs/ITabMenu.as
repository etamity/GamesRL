package com.newco.grand.baccarat.classic.view.scorecard.display.tabs {
	
	import com.ai.core.view.ui.buttons.IGeneralButton;
	import com.ai.core.view.ui.views.IBaseView;
	
	public interface ITabMenu extends IBaseView {
		function addTab(button:IGeneralButton):void
		function get buttons():Array	
	}
}