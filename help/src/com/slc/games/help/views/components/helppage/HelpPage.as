package com.slc.games.help.views.components.helppage {

	import com.slc.ui.views.components.BaseComponentView;
	
	import flash.display.Sprite;

	public class HelpPage extends BaseComponentView {

		protected var _textArea:Object;

		public function HelpPage(target:Sprite) {
			super(target);
			_textArea = _target.getChildByName("textArea");
		}

		public function set htmlText(v:String):void {
			_textArea.htmlText = v;
			_textArea.verticalScrollPosition = 0;
		}
	}
}

