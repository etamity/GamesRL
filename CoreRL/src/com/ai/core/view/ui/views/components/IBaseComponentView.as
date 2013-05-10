package com.ai.core.view.ui.views.components {

	import com.ai.core.view.ui.views.IBaseView;

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

