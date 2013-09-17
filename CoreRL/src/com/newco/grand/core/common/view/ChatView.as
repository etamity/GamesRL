package com.newco.grand.core.common.view {
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.interfaces.IChatView;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import fl.controls.UIScrollBar;
	
	import org.osflash.signals.Signal;
	
	public class ChatView extends UIView implements IChatView{
		
		private const DEFAULT_FONT_COLOUR:String 	= "#FFAF32";
		private const TEXT_FONT_COLOUR:String 		= "#FFFFFF";
		private const DEALER_FONT_COLOUR:String 	= "#FFFF99";
		private const USER_JOIN_FONT_COLOUR:String 	= "#00FF00";
		private const USER_LEFT_FONT_COLOUR:String 	= "#FF0000";	
		protected var Scroll:UIScrollBar= new UIScrollBar();
		
		public var _sendSignal:Signal=new Signal();
		protected var _skin:ChatAsset;
		
		protected var sendBtn:SMButton;
		public function ChatView() {
			super();
		}
		override public function initDisplay():void{
			 _skin=new ChatAsset();
			addChild( _skin);
			visible = false;
			Scroll.scrollTarget = _skin.receiveTxt;
			Scroll.direction="vertical";
			Scroll.x=198;
			Scroll.y=44;
			Scroll.height=130;
			addChild(Scroll);
			sendBtn=new SMButton(_skin.sendBtn);
			_display= _skin;
		}
		public function get sendSignal():Signal{
			return _sendSignal;
		}
		override public function updateLanguage():void{
			_display.titleTxt.text =LanguageModel.CHAT;
			 sendBtn.label=LanguageModel.SEND;
		}
		override public function align():void {			
			x = stage.stageWidth - width;
		}
		
		public function set dealer(value:String):void {
			_display.titleTxt.text =LanguageModel.CHAT + " -- " + value;
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
			sendBtn.skin.addEventListener(MouseEvent.CLICK, sendMessage);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
		}
		
		private function keyDownHandler(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.ENTER)	{
				sendMessage();
			}
		}
		
		private function sendMessage(event:MouseEvent = null):void {			
			if(_skin.sendTxt.text != "") {
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