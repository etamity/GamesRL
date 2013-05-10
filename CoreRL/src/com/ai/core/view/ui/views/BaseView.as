package com.ai.core.view.ui.views {

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * The basis of most classes which include a user interface. The role
	 * of this class is to separate the interface from the code through
	 * a process of decomposition. To this end, a target Sprite is passed
	 * which contains the desired interface. View which extend this class
	 * may expect something else, as long as they ultimately pass a Sprite
	 * to the super constructor. This could mean a sub view expects a
	 * MovieClip which is a valid subclass of Sprite, or perhaps it takes
	 * a TextField, before placing that into a Sprite and sending the
	 * result to the super constructor.
	 *
	 * <p>Part of the concept is to use event bubbling so that all views
	 * have an implicit line of communication through the Display List.
	 * The BaseView therefore implements the IEventDispatcher interface
	 * and defers all the functions therein to the target sprite.</p>
	 *
	 * <p>Also included are some of the more common DisplayObject/Sprite
	 * getter setter methods, which also defer to the target Sprite.</p>
	 *
	 * @author Elliot Harris
	 */
	public class BaseView implements IBaseView {
		protected var _target:Sprite;

		/**
		 * @param target The sprite object containing the interface.
		 */
		public function BaseView(target:Sprite) {
			_target = target;
		}

		//IEventDispatcher implementation
		final public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			_target.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		final public function dispatchEvent(event:Event):Boolean {
			return _target.dispatchEvent(event);
		}

		final public function hasEventListener(type:String):Boolean {
			return _target.hasEventListener(type);
		}

		final public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			_target.removeEventListener(type, listener, useCapture);
		}

		final public function willTrigger(type:String):Boolean {
			return _target.willTrigger(type);
		}

		public function get visible():Boolean {
			return _target.visible;
		}

		public function set visible(v:Boolean):void {
			_target.visible = v;
		}

		public function get width():Number {
			return _target.width;
		}

		public function set width(v:Number):void {
			_target.width = v;
		}

		public function get height():Number {
			return _target.height;
		}

		public function set height(v:Number):void {
			_target.height = v;
		}

		public function get x():Number {
			return _target.x;
		}

		public function set x(v:Number):void {
			_target.x = v;
		}

		public function get y():Number {
			return _target.y;
		}

		public function set y(v:Number):void {
			_target.y = v;
		}

		public function get scaleX():Number {
			return _target.scaleX;
		}

		public function set scaleX(v:Number):void {
			_target.scaleX = v;
		}

		public function get scaleY():Number {
			return _target.scaleY;
		}

		public function set scaleY(v:Number):void {
			_target.scaleY = v;
		}

		/**
		 * Provides access to the target Sprite which contains the user interface.
		 */
		public function get target():Sprite {
			return _target;
		}
	}

}

