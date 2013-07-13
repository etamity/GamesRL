package com.newco.grand.core.common.view {
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import fl.controls.UIScrollBar;
	
	import org.osflash.signals.Signal;
	
	public class ChatView extends ChatAsset {
		
		private const DEFAULT_FONT_COLOUR:String 	= "#FFAF32";
		private const TEXT_FONT_COLOUR:String 		= "#FFFFFF";
		private const DEALER_FONT_COLOUR:String 	= "#FFFF99";
		private const USER_JOIN_FONT_COLOUR:String 	= "#00FF00";
		private const USER_LEFT_FONT_COLOUR:String 	= "#FF0000";	
		private var Scroll:UIScrollBar= new UIScrollBar();
		
		public var sendSignal:Signal=new Signal();
		
		public function ChatView() {
			visible = false;
			Scroll.scrollTarget =receiveTxt;
			Scroll.direction="vertical";
			Scroll.x=199.35;
			Scroll.y=27.65;
			Scroll.height=137.95;
			addChild(Scroll);
		}
		
		public function init():void {
			align();
			visible = true;
		}
		
		public function align():void {			
			//x = stage.stageWidth - width;
			x = 0;
			y = 0;
		}
		
		public function set dealer(value:String):void {
			dealerTxt.text = value;
		}
		
		public function setWelcomeMessage(message:String):void {
			receiveTxt.htmlText = getMessageFormatted(message, DEFAULT_FONT_COLOUR);
			addListeners();
		}
		
		public function setMessage(sender:String, message:String):void {
			receiveTxt.htmlText += (sender != "") ? getMessageFormatted(sender + ": ", DEFAULT_FONT_COLOUR) + getMessageFormatted(message, TEXT_FONT_COLOUR) : getMessageFormatted(message, TEXT_FONT_COLOUR);
			//receiveTxt.verticalScrollPosition = receiveTxt.maxVerticalScrollPosition;
			receiveTxt.scrollV += Math.ceil(message.length / 20);
		    Scroll.update();
		}
		
		private function getMessageFormatted(message:String, fontColour:String):String {
			return "<font color='" + fontColour + "'>" + message + "</font>";
		}
		
		private function addListeners():void {			
			sendBtn.addEventListener(MouseEvent.CLICK, sendMessage);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.ENTER)	{
				sendMessage();
			}
		}
		
		private function sendMessage(event:MouseEvent = null):void {			
			if(sendTxt.text != "") {
				//dispatchEvent(new ChatEvent(ChatEvent.SEND_MESSAGE));
				sendSignal.dispatch();
			}
		}
		
		private function setFocus(focus:Boolean):void {
			sendTxt.stage.focus = (focus) ? sendTxt : stage;
		}
		
		public function get message():String {
			
			/*var xml:String="<rtf><text>"+sendTxt.text+"</text><sprites/><facebookID>"+
				FacebookAPI.getInstance().UID+
		"</facebookID><firstName>"+FacebookAPI.getInstance().firstName+"</firstName></rtf>";*/
			
			return sendTxt.text;
		}
		
		public function clear():void {
			sendTxt.text = "";
			setFocus(true);
		}
	}
}