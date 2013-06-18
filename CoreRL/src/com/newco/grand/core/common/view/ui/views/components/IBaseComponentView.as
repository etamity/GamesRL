package com.newco.grand.core.common.view.ui.views.components {

	import com.newco.grand.core.common.view.ui.views.IBaseView;

	/**
	 * ...
	 * @author Elliot Harris
	 */
	public interface IBaseComponentView extends IBaseView {
		function parseXML(xml:XML):void

		function get isInitialised():Boolean
		function set isInitialised(v:Boolean):void
		function set back(v:Boolean):void
	}

}

