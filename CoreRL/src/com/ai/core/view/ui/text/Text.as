package com.ai.core.view.ui.text {

	import com.ai.core.view.ui.views.BaseView;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * Basic text view. Provides a universal point for handling
	 * text including the setting of styles via the Styles
	 * singleton.
	 *
	 * @author Elliot Harris
	 */
	public class Text extends BaseView implements IText {
		protected var _textField:TextField;
		protected var _style:String         = "txt";
		protected var _enableStyles:Boolean = true;

		/**
		 * @param target A TextField to be controlled by this class. Is added
		 * to a new Sprite object which takes on the DisplayList properties
		 * of the TextField and inserted into the same place.
		 */
		public function Text(target:TextField) {
			/*
			 * Create a new target Sprite to send to the subclass, giving it
			 * the same positional properties as the TextField and adding it
			 * back to the former parent of the TextField (the interface is
			 * therefore unaffectede visually, but there is now a Sprite
			 * between the TextField and its former parent)
			 */
			var newTarget:Sprite = new Sprite();
			newTarget.x = target.x;
			newTarget.y = target.y;
			target.x = target.y = 0;
			target.parent.addChild(newTarget);
			newTarget.addChild(target)

			_textField = target;
			_textField.embedFonts = false;
			applyStyle();

			super(newTarget);
		}

		/**
		 * Applies the current style, as indicated by the _style property,
		 * to the current text. Needs to be re-applied every time the text
		 * changes.
		 */
		protected function applyStyle():void {
			if (_enableStyles) {
				var tf:TextFormat = _textField.getTextFormat();
				//tf.color = Style.getInstance().getPropertyAsColor(_style + "Color");
				_textField.setTextFormat(tf);
			}
		}

		/**
		 * Assigns a style, as defined within the Style singleton, to the
		 * text.
		 */
		public function set style(v:String):void {
			if (v != _style) {
				_style = v;
				applyStyle();
			}
		}

		public function get enableStyles():Boolean {
			return _enableStyles;
		}

		public function set enableStyles(v:Boolean):void {
			_enableStyles = v;
		}

		//The functions below defer to the TextField object, 		
		public function get autoSize():String {
			return _textField.autoSize;
		}

		public function set autoSize(v:String):void {
			_textField.autoSize = v;
		}

		public function get caretIndex():int {
			return _textField.caretIndex;
		}

		public function get htmlText():String {
			return _textField.htmlText;
		}

		public function set htmlText(v:String):void {
			_textField.htmlText = v;
			applyStyle();
		}

		public function get multiline():Boolean {
			return _textField.multiline;
		}

		public function set multiline(v:Boolean):void {
			_textField.multiline = v;
		}

		public function get text():String {
			return _textField.text;
		}

		public function set text(v:String):void {
			_textField.text = v;
			applyStyle();
		}

		public function get textHeight():Number {
			return _textField.textHeight;
		}

		public function get textWidth():Number {
			return _textField.textWidth;
		}

		public function get type():String {
			return _textField.type;
		}

		public function set type(v:String):void {
			_textField.type = v;
		}

		public function get wordWrap():Boolean {
			return _textField.wordWrap;
		}

		public function set wordWrap(v:Boolean):void {
			_textField.wordWrap = v;
		}

		override public function set width(v:Number):void {
			_textField.width = v;
		}

		override public function set height(v:Number):void {
			_textField.height = v;
		}

		/**
		 * The actual TextField object.
		 */
		public function get textField():TextField {
			return _textField;
		}
	}
}

