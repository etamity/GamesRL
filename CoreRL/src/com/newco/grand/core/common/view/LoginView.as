package com.newco.grand.core.common.view {
	import com.newco.grand.core.common.view.interfaces.ILoginView;
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class LoginView extends Sprite implements ILoginView {
		private var _loginSignal:Signal=new Signal();
		protected var _display:*;
		public function LoginView() {
			visible = false;
			initDisplay();
		}		
		public function initDisplay():void{
			_display=new LoginAsset();
			addChild(_display);
		}
		
		public function init():void {			
			align();
			_display.loginBtn.addEventListener(MouseEvent.CLICK, login);
		}
		
		public function get display():*{
			return this;
		}
		
		public function align():void {
			x = (stage.stageWidth  - width) / 2;
			y = (stage.stageHeight  - height) / 2;
			visible = true;
		}
		public function get loginSignal():Signal{
			return _loginSignal;
		}
		
		private function login(event:MouseEvent):void {
			_loginSignal.dispatch(id, password);
		}
		
		public function set id(value:String):void {
			_display.loginTxt.text = value;
		}
		
		public function get id():String {
			return StringUtils.trim(_display.loginTxt.text);
		}
		
		public function get password():String {
			return StringUtils.trim(_display.passwordTxt.text);
		}
		
		public function set password(value:String):void {
			_display.passwordTxt.text = value;
		}
		
		public function set error(value:String):void {
			_display.errorTxt.text = value;
		}
		
	}
}