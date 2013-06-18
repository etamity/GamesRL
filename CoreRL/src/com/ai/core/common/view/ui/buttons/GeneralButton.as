package com.ai.core.common.view.ui.buttons {

	import com.ai.core.common.model.Style;
	import com.ai.core.common.view.ui.text.IText;
	import com.ai.core.common.view.ui.text.Text;
	import com.ai.core.common.view.ui.views.BaseView;
	import com.ai.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * A very basic button class which utilises the BaseView class, and
	 * is intrinsically linked to both the Style singleton and the Text
	 * view. The class responds to and dispatches mouse events, along
	 * with any ID which has been set. It also applies appropriate
	 * styling based on the mouse state. Finally, it can be used as a
	 * toggle button (for example in a tab menu), where its state is
	 * either true or false as indicated by the isSelected property
	 *
	 * @author Elliot Harris
	 */
	public class GeneralButton extends BaseView implements IGeneralButton {
		public static const MOUSE_STATE_DOWN:String  = "MouseDown";
		public static const MOUSE_STATE_OVER:String  = "MouseOver";
		public static const MOUSE_STATE_OUT:String   = "MouseOut";
		public static const MOUSE_STATE_UP:String    = "MouseUp";
		public static const MOUSE_STATE_CLICK:String = "Click";

		protected var _targetMC:MovieClip;
		protected var _id:int                        = -1;

		protected var _fill:Sprite;
		protected var _label:IText;

		//Fill colours
		protected var _defaultColour1:uint;
		protected var _defaultColour2:uint;
		protected var _rollOverColour1:uint;
		protected var _rollOverColour2:uint;
		protected var _selectedColour1:uint;
		protected var _selectedColour2:uint;

		protected var _style:String                  = "no style";

		//Text colours
		protected var _defaultTxtStyle:String        = "defaultBtnTxt"
		protected var _rolloverTxtStyle:String       = "rollOverBtnTxt";
		protected var _selectedTxtStyle:String       = "selectedBtnTxt";

		protected var _mouseState:String             = MOUSE_STATE_OUT;
		protected var _isSelected:Boolean            = false;

		/**
		 * @param target Basic target property but typed as a MovieClip. This allows
		 * the button to move to specific frames depending on the mouse state.
		 * @param id Optional numeric id by which this button may be identified later.
		 */
		public function GeneralButton(target:MovieClip, id:int = -1) {
			super(target);
			_targetMC = _target as MovieClip;
			_id = id;

			/*
			 * The fill is the container into which a gradient is drawn depending on the
			 * state of the mouse and/or the isSelected Boolean. The appropriate style
			 * colours are obtained here and saved into variables for use throughout the
			 * button's lifetime.
			 */
			_fill = _target.getChildByName("fill") as Sprite;
			style = ""
			changeFillColour(_defaultColour1, _defaultColour2);

			/*
			 * If a TextField with an instance name of "label" is present, it
			 * is automatically picked up and passed to a Text view instance
			 */
			var t:TextField = _target.getChildByName("label") as TextField;
			if (t) {
				_label = new Text(t);
				_label.style = _defaultTxtStyle;
			}

			_target.buttonMode = true;
			_target.mouseChildren = false;

			_targetMC.gotoAndStop(1); //In case multiple frames are used for button states

			addEventListeners();
		}

		protected function addEventListeners():void {
			_target.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_target.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_target.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_target.addEventListener(MouseEvent.CLICK, onClick);

			/*
			 * This is error-handled because if the target is not yet in the display list, the
			 * target.stage property won't exist. If it does not, an event listened for on the
			 * target will indicate when it has been added to the display list. At that point
			 * we can be sure to access the target.stage property
			 */
			try {
				_target.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			catch (e:TypeError) {
				_target.addEventListener(Event.ADDED_TO_STAGE, onTargetAddedToDisplayList)
			}
		}

		protected function removeEventListeners():void {
			_target.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_target.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_target.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_target.removeEventListener(MouseEvent.CLICK, onClick);
			_target.removeEventListener(Event.ADDED_TO_STAGE, onTargetAddedToDisplayList);
			try {
				_target.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
			catch (e:TypeError) {

			}
		}

		protected function onTargetAddedToDisplayList(e:Event):void {
			_target.removeEventListener(Event.ADDED_TO_STAGE, onTargetAddedToDisplayList);
			_target.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		protected function changeFillColour(colour1:uint, colour2:uint):void {
			if (_fill) {
				GameUtils.createGradient(_fill, colour1, colour2);
			}
		}

		protected function onMouseDown(e:MouseEvent = null):void {
			_mouseState = MOUSE_STATE_DOWN;
			if (e) {
				_target.dispatchEvent(new GeneralButtonEvent(GeneralButtonEvent.MOUSE_DOWN, e, _id));
			}
		}

		protected function onMouseOver(e:MouseEvent = null):void {
			if (!_isSelected) {
				_mouseState = MOUSE_STATE_OVER;
				changeFillColour(_rollOverColour1, _rollOverColour2);
				if (_label) {
					_label.style = _rolloverTxtStyle;
				}
			}
			if (e) {
				_target.dispatchEvent(new GeneralButtonEvent(GeneralButtonEvent.MOUSE_OVER, e, _id));
			}
		}

		protected function onMouseOut(e:MouseEvent = null):void {
			if (!_isSelected) {
				_mouseState = MOUSE_STATE_OUT;
				changeFillColour(_defaultColour1, _defaultColour2);
				if (_label) {
					_label.style = _defaultTxtStyle;
				}
			}
			if (e) {
				_target.dispatchEvent(new GeneralButtonEvent(GeneralButtonEvent.MOUSE_OUT, e, _id));
			}
		}

		protected function onMouseUp(e:MouseEvent = null):void {
			_mouseState = MOUSE_STATE_UP;
			if (e) {
				_target.dispatchEvent(new GeneralButtonEvent(GeneralButtonEvent.MOUSE_UP, e, _id));
			}
		}

		protected function onClick(e:MouseEvent = null):void {
			_mouseState = MOUSE_STATE_CLICK;
			if (e) {
				_target.dispatchEvent(new GeneralButtonEvent(GeneralButtonEvent.CLICK, e, _id));
			}
		}

		protected function onMouseMove(e:MouseEvent = null):void {
		}

		public function get id():int {
			return _id;
		}

		public function set id(v:int):void {
			_id = v;
		}

		/**
		 * Changes the 'selected' on/off state of the button.
		 */
		public function get isSelected():Boolean {
			return _isSelected;
		}

		public function set isSelected(v:Boolean):void {
			if (_isSelected != v) //Only proceed if the state has changed
			{
				_isSelected = v;
				_target.buttonMode = !v; //A value of true means this button cannot be selected
				//again until an external class changes the state to false

				//Apply the correct style based on the value of the isSelected property and
				//the mouse state.
				if (v) {
					changeFillColour(_selectedColour1, _selectedColour2);
					if (_label) {
						_label.style = _selectedTxtStyle;
					}
				}
				else {
					if (_mouseState == MOUSE_STATE_OVER || _mouseState == MOUSE_STATE_CLICK) {
						onMouseOver();
					}
					else {
						onMouseOut();
					}
				}
			}
		}

		/**
		 * Text label displayed within the button, if a label object is present.
		 */
		public function set label(v:String):void {
			if (_label) {
				_label.text = v;
			}
		}

		/**
		 * The actual IText label object. May be null
		 */
		public function get labelObject():IText {
			return _label;
		}

		public function set style(style:String):void {
			if (style != _style) {
				_style = style;
				if (style != "") {
					style += "_";
				}

				_defaultColour1 = Style.getColor(Style.DEFAULTBTNCOLOR1);
				_defaultColour2 = Style.getColor(Style.DEFAULTBTNCOLOR2);
				_rollOverColour1 = Style.getColor(Style.ROLLOVERBTNCOLOR1);
				_rollOverColour2 = Style.getColor(Style.ROLLOVERBTNCOLOR2);
				_selectedColour1 =Style.getColor(Style.SELECTEDBTNCOLOR1);
				_selectedColour2 = Style.getColor(Style.SELECTEDBTNCOLOR2);

				if (_mouseState == MOUSE_STATE_OVER || _mouseState == MOUSE_STATE_CLICK) {
					onMouseOver();
				}
				else {
					onMouseOut();
				}
			}
		}

		/**
		 * The text used in the default button state
		 */
		public function get defaultTxtStyle():String {
			return _defaultTxtStyle;
		}

		public function set defaultTxtStyle(v:String):void {
			_defaultTxtStyle = v;
		}

		/**
		 * The text used in the rollover button state
		 */
		public function get rolloverTxtStyle():String {
			return _rolloverTxtStyle;
		}

		public function set rolloverTxtStyle(v:String):void {
			_rolloverTxtStyle = v;
		}

		/**
		 * The text used in the selected button state
		 */
		public function get selectedTxtStyle():String {
			return _selectedTxtStyle;
		}

		public function set selectedTxtStyle(v:String):void {
			_selectedTxtStyle = v;
		}
	}
}

