package com.ai.core.common.view {
	import com.ai.core.utils.StringUtils;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class LoginView extends LoginAsset {
		public var loginSignal:Signal=new Signal();
		public function LoginView() {
			visible = false;
		}		
		
		public function init():void {			
			align();
			loginBtn.addEventListener(MouseEvent.CLICK, login);
		}
		
		public function align():void {
			x = (stage.stageWidth  - width) / 2;
			y = (stage.stageHeight  - height) / 2;
			visible = true;
		}

		private function login(event:MouseEvent):void {
			loginSignal.dispatch(id, password);
		}
		
		public function set id(value:String):void {
			loginTxt.text = value;
		}
		
		public function get id():String {
			return StringUtils.trim(loginTxt.text);
		}
		
		public function get password():String {
			return StringUtils.trim(passwordTxt.text);
		}
		
		public function set password(value:String):void {
			passwordTxt.text = value;
		}
		
		public function set error(value:String):void {
			errorTxt.text = value;
		}
		
	}
}