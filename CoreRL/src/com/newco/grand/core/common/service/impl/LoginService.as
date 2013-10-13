package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class LoginService implements IService
	{
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		private var _id:String;
		
		private var _password:String;
		
		private var _loginRequest:URLRequest;
		
		public function LoginService()
		{
		}
		public function get id():String{
			return _id;
		}
		public function get password():String{
			return _password;
		}
		
		public function set id(val:String):void{
			_id=val;
		}
		public function set password(val:String):void{
			_password=val;
		}
		
		public function load(onComplete:Function=null):void
		{
			//
			if (FlashVars.PLATFORM==FlashVars.TESTING_PLATFORM)
				skipLogin();
			else
				loginGrand();
		}
		public function loginGrand():void {

			if (id != "" && password != "") {
				var p_username:String= id;
				var p_password:String= password;
				var loginURL:String;
				
				loginURL=StringUtils.parseURL(urls.login, {"#USERNAME#":p_username, "#PASSWORD#":p_password });
				debug(loginURL);
				/*service.addLoader(new XMLLoader(new URLRequest(loginURL), Constants.SERVER_LOGIN));
				service.getLoader(Constants.SERVER_LOGIN).onError.add(showError);
				service.getLoader(Constants.SERVER_LOGIN).onComplete.add(checkGrandAuthenticationResponse);
				
				service.start();*/
				service.loadURL(loginURL,checkGrandAuthenticationResponse,showError);
			} 
		}
		
		private function skipLogin():void {
			signalBus.dispatch(LoginEvent.LOGIN_SUCCESS);
			signalBus.dispatch(StartupDataEvent.SEAT);
			signalBus.dispatch(StartupDataEvent.LOAD);
			signalBus.dispatch(BalanceEvent.LOAD);
			
		}
		
		
		private function checkGrandAuthenticationResponse(signal:LoaderSignal, xml:XML):void {
			
			debug(xml);
			if (xml.hasOwnProperty("user_id")) {
				//player.session    = xml.session;
				flashvars.user_id = xml.user_id;
				
				signalBus.dispatch(LoginEvent.LOGIN_SUCCESS);
				signalBus.dispatch(StartupDataEvent.SEAT);
				signalBus.dispatch(StartupDataEvent.LOAD);
				signalBus.dispatch(BalanceEvent.LOAD);
			}
			else {
				signalBus.dispatch(LoginEvent.LOGIN_FAILURE);
			}
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error", signal);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
		
	}
}