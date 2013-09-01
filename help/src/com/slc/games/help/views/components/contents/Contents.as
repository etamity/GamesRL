package com.slc.games.help.views.components.contents {

	import com.slc.events.GeneralButtonEvent;
	import com.slc.games.help.events.ContentsEvent;
	import com.slc.ui.buttons.GeneralButton;
	import com.slc.ui.buttons.IGeneralButton;
	import com.slc.ui.views.components.BaseComponentView;

	import fl.containers.ScrollPane;

	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;

	public class Contents extends BaseComponentView {

		protected var _vSpacing:Number = 4;

		protected var _scrollPane:ScrollPane;
		protected var _scrollPaneSource:Sprite;
		protected var _buttons:Array;

		public function Contents(target:Sprite) {
			super(target);
			_scrollPane = _target.getChildByName("scrollPane") as ScrollPane;
		}

		protected function onItemClick(e:GeneralButtonEvent):void {
			for each (var button:IGeneralButton in _buttons) {
				button.isSelected = button.id == e.id;
			}
			dispatchEvent(new ContentsEvent(ContentsEvent.CONTENTS_ITEM_CLICK, e.id));
		}

		protected function createContentsItem():IGeneralButton {
			var b:IGeneralButton = new GeneralButton(new ContentsButton());
			b.labelObject.autoSize = TextFieldAutoSize.CENTER;
			b.labelObject.wordWrap = true;
			b.labelObject.multiline = true;
			b.rolloverTxtStyle = "helpContentsTxtRollover";
			return b;
		}

		override public function parseXML(xml:XML):void {
			_scrollPaneSource = new Sprite();
			_buttons = new Array();

			var items:XMLList = xml.item;
			var count:uint;
			var nextY:Number  = 0;
			for each (var node:XML in items) {
				var b:IGeneralButton = createContentsItem();
				b.isSelected = count == 0;
				b.id = count++;
				b.label = node.title;
				var f:Sprite         = new Sprite()
				f.graphics.beginFill(0, 0);
				f.graphics.drawRect(0, 0, b.width, b.height);
				b.target.addChildAt(f, 0);
				b.y = nextY;
				b.addEventListener(GeneralButtonEvent.CLICK, onItemClick);
				_buttons.push(b);
				_scrollPaneSource.addChild(b.target);
				nextY = b.y + b.height + _vSpacing;
			}
			_scrollPane.source = _scrollPaneSource;
			_isInitialised = true;
		}
	}
}

