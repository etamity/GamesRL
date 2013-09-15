package com.newco.grand.core.common.view {
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.interfaces.ILoginView;
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class LoginView extends UIView implements ILoginView {
		private var _loginSignal:Signal=new Signal();
		protected var _skin:LoginAsset;
		public function LoginView() {
			super();
		}		
		override public function updateLanguage():void{
			 _skin.loginBtnLabel.text=LanguageModel.LOGIN;
			 _skin.userNameLabel.text=LanguageModel.USERNAME;
			 _skin.passwordLabel.text=LanguageModel.PASSWORD;
		}
		override public function initDisplay():void{
			 _skin=new LoginAsset();
			 _skin.loginBtnLabel.mouseEnabled=false;
			addChild( _skin);
			 _skin.loginBtn.addEventListener(MouseEvent.CLICK, login);
			
			_display= _skin;
		}
		
		override public function align():void {
			if (stage!=null)
			{
			x = (stage.stageWidth  - width) / 2;
			y = (stage.stageHeight  - height) / 2;
			}
		}
		public function get loginSignal():Signal{
			return _loginSignal;
		}
		
		private function login(event:MouseEvent):void {
			_loginSignal.dispatch(id, password);
		}
		
		public function set id(value:String):void {
			_display.userNameTxt.text = value;
		}
		
		public function get id():String {
			return StringUtils.trim(_display.userNameTxt.text);
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