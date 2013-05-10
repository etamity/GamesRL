package com.ai.core.view.ui.buttons {

	import com.ai.core.view.ui.text.IText;
	import com.ai.core.view.ui.views.IBaseView;

	public interface IGeneralButton extends IBaseView {
		function get id():int
		function set id(v:int):void

		function set label(v:String):void

		function get labelObject():IText

		function get isSelected():Boolean
		function set isSelected(v:Boolean):void

		function set style(style:String):void

		function get defaultTxtStyle():String
		function set defaultTxtStyle(v:String):void

		function get rolloverTxtStyle():String
		function set rolloverTxtStyle(v:String):void

		function get selectedTxtStyle():String
		function set selectedTxtStyle(v:String):void
	}
}

