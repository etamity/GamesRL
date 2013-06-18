package com.ai.core.common.view.ui.views.components {

	import com.ai.core.common.view.ui.buttons.GeneralButton;
	import com.ai.core.common.view.ui.buttons.GeneralButtonEvent;
	import com.ai.core.common.view.ui.views.BaseView;
	import com.ai.core.common.view.ui.views.ViewEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * This is actually a fairly specific view. It's purpose is to define a view
	 * which accepts XML to intialise or modify its state, and to provide a
	 * Boolean property to indicate whether or not this has yet occurred.
	 *
	 * <p>This class has been used in the History component and the Roulette
	 * Statistics component, and for that reason is shared here. However its
	 * applicability across other projects is debateable.</p>
	 *
	 * @author Elliot Harris
	 */
	public class BaseComponentView extends BaseView implements IBaseComponentView {
		protected var _isInitialised:Boolean = false;

		protected var _back:GeneralButton;

		public function BaseComponentView(target:Sprite) {
			super(target);

			var backButton:MovieClip = _target.getChildByName("back") as MovieClip;
			if (backButton) {
				_back = new GeneralButton(backButton);
				_back.addEventListener(GeneralButtonEvent.CLICK, onBackClick);
			}
		}

		protected function onBackClick(e:GeneralButtonEvent):void {
			dispatchEvent(new ViewEvent(ViewEvent.BACK_CLICK));
		}

		/**
		 * Initialises the component according to the functionality
		 * implemented by the specific subclass. Calling this once
		 * should result in the isInitialised property being set to
		 * true.
		 *
		 * @param xml An XML object containing the data used to initialise
		 * the component.
		 */
		public function parseXML(xml:XML):void {

		}

		/**
		 * Indicates whether the component has been initialised once or
		 * more through the passing of XML.
		 */
		public function get isInitialised():Boolean {
			return _isInitialised;
		}

		public function set isInitialised(v:Boolean):void {
			_isInitialised = v;
		}

		public function set back(v:Boolean):void {
			if (!v) {
				_back.visible = false;
			}
			else {
				_back.visible = true;
			}
		}
	}

}

