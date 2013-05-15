package com.ai.baccarat.classic.view.scorecard.display.tabs {
	
	import com.ai.core.view.ui.buttons.GeneralButton;
	import com.ai.core.view.ui.buttons.GeneralButtonEvent;
	import com.ai.core.view.ui.buttons.IGeneralButton;
	import com.ai.core.view.ui.views.BaseView;
	
	import flash.display.MovieClip;

	/**
	 * Manages a group of buttons and ensures only one of them may be selected
	 * at once.
	 * 
	 * @author Elliot Harris
	 */
	public class TabMenu extends BaseView implements ITabMenu {
		
		protected var _buttonsContainer:MovieClip;
		
		protected var _buttons:Array = new Array();
		
		public function TabMenu(target:MovieClip) {
			super(target);			
			init();
		}
		
		/**
		 * Checks for a buttonsContainer and initialises any button movieclips
		 * found therein.
		 * 
		 * If no container is found one is created.
		 */
		protected function init():void {
			_buttonsContainer = _target.getChildByName("buttonsContainer") as MovieClip;
			if(_buttonsContainer) {
				for(var i:uint; i < _buttonsContainer.numChildren; i++) {
					var m:MovieClip = _buttonsContainer.getChildAt(i) as MovieClip;
					var b:IGeneralButton = new GeneralButton(m, _buttons.length);
					if (i == 0) {
						b.isSelected = true;
					}
					_buttons.push( b );
				}
			}
			else {
				_buttonsContainer = new MovieClip();
			}			
			_target.addEventListener(GeneralButtonEvent.CLICK, onButtonClick)
		}
		
		protected function onButtonClick(e:GeneralButtonEvent):void {
			for each(var button:IGeneralButton in _buttons) {
				button.isSelected = button.id == e.id;
			}
		}
		
		/**
		 * Adds a tab from the outside without it having to be inside the
		 * buttons container and initialised within this class.
		 */
		public function addTab(button:IGeneralButton):void {
			button.id = _buttons.length;
			_buttons.push( button );
		}
		
		public function get buttons():Array{ return _buttons; }
	}
}