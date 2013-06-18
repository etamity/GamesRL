package com.ai.core.common.view.ui.text {

	import com.ai.core.common.view.ui.views.IBaseView;

	import flash.text.TextField;

	public interface IText extends IBaseView {
		function set style(v:String):void
		function get enableStyles():Boolean
		function set enableStyles(v:Boolean):void

		function get autoSize():String
		function set autoSize(v:String):void
		function get caretIndex():int
		function get htmlText():String
		function set htmlText(v:String):void
		function get multiline():Boolean
		function set multiline(v:Boolean):void
		function set text(v:String):void
		function get text():String
		function get textHeight():Number
		function get textWidth():Number
		function get type():String
		function set type(v:String):void
		function get wordWrap():Boolean
		function set wordWrap(v:Boolean):void

		function get textField():TextField
	}
}

