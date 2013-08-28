package com.newco.grand.lobby.classic.view.scorecard.display.tabs {
	
	import com.newco.grand.core.common.view.ui.buttons.IGeneralButton;
	import com.newco.grand.core.common.view.ui.views.IBaseView;
	
	public interface ITabMenu extends IBaseView {
		function addTab(button:IGeneralButton):void
		function get buttons():Array	
	}
}