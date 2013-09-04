package com.newco.grand.core.common.view {
	import com.newco.grand.core.common.view.interfaces.IChatView;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import fl.controls.UIScrollBar;
	
	import org.osflash.signals.Signal;
	
	public class ChatView extends Sprite implements IChatView{
		
		private const DEFAULT_FONT_COLOUR:String 	= "#FFAF32";
		private const TEXT_FONT_COLOUR:String 		= "#FFFFFF";
		private const DEALER_FONT_COLOUR:String 	= "#FFFF99";
		private const USER_JOIN_FONT_COLOUR:String 	= "#00FF00";
		private const USER_LEFT_FONT_COLOUR:String 	= "#FF0000";	
		private var Scroll:UIScrollBar= new UIScrollBar();
		
		public var _sendSignal:Signal=new Signal();
		protected var _display:*;
		public function ChatView() {
			initDisplay();
			visible = false;
			Scroll.scrollTarget =_display.receiveTxt;
			Scroll.direction="vertical";
			Scroll.x=198;
			Scroll.y=44;
			Scroll.height=130;
			addChild(Scroll);
		}
		public function initDisplay():void{
			_display=new ChatAsset();
			addChild(_display);
		}
		public function get sendSignal():Signal{
			return _sendSignal;
		}
		public function init():void {
			align();
			visible = true;
		}
		public function get display():*{
			return this;
		}
		public function align():void {			
			x = stage.stageWidth - width;
			//x = 0;
			//y = 0;
		}
		
		public function set dealer(value:String):void {
			_display.dealerTxt.text = value;
		}
		
		public function setWelcomeMessage(message:String):void {
			_display.receiveTxt.htmlText = getMessageFormatted(message, DEFAULT_FONT_COLOUR);
			addListeners();
		}
		
		public function setMessage(sender:String, message:String):void {
			_display.receiveTxt.htmlText += (sender != "") ? getMessageFormatted(sender + ": ", DEFAULT_FONT_COLOUR) + getMessageFormatted(message, TEXT_FONT_COLOUR) : getMessageFormatted(message, TEXT_FONT_COLOUR);
			//receiveTxt.verticalScrollPosition = receiveTxt.maxVerticalScrollPosition;
			_display.receiveTxt.scrollV += Math.ceil(message.length / 20);
		    Scroll.update();
		}
		
		private function getMessageFormatted(message:String, fontColour:String):String {
			return "<font color='" + fontColour + "'>" + message + "</font>";
		}
		
		private function addListeners():void {			
			_display.sendBtn.addEventListener(MouseEvent.CLICK, sendMessage);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.ENTER)	{
				sendMessage();
			}
		}
		
		private function sendMessage(event:MouseEvent = null):void {			
			if(_display.sendTxt.text != "") {
				//dispatchEvent(new ChatEvent(ChatEvent.SEND_MESSAGE));
				_sendSignal.dispatch();
			}
		}
		
		private function setFocus(focus:Boolean):void {
			_display.sendTxt.stage.focus = (focus) ? _display.sendTxt : stage;
		}
		
		public function get message():String {
			
			/*var xml:String="<rtf><text>"+sendTxt.text+"</text><sprites/><facebookID>"+
				FacebookAPI.getInstance().UID+
		"</facebookID><firstName>"+FacebookAPI.getInstance().firstName+"</firstName></rtf>";*/
			
			return _display.sendTxt.text;
		}
		
		public function clear():void {
			_display.sendTxt.text = "";
			setFocus(true);
		}
	}
}