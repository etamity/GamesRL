package com.newco.grand.core.common.view.ui.views {

	import flash.display.Sprite;
	import flash.events.IEventDispatcher;

	/**
	 * Interface for the BaseView class. Provides direct access
	 * to the target Sprite as well as some of the more common
	 * properties for easier use.
	 *
	 * @author Elliot Harris
	 */
	public interface IBaseView extends IEventDispatcher {

		function get visible():Boolean
		function set visible(v:Boolean):void

		function get width():Number
		function set width(v:Number):void

		function get height():Number
		function set height(v:Number):void

		function get x():Number
		function set x(v:Number):void

		function get y():Number
		function set y(v:Number):void

		function get scaleX():Number
		function set scaleX(v:Number):void

		function get scaleY():Number
		function set scaleY(v:Number):void

		function get target():Sprite
	}

}

