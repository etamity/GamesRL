package com.ai.core.common.controller.commands {
	
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.LoginEvent;
	import com.ai.core.common.controller.signals.StartupDataEvent;
	import com.ai.core.model.Constants;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.utils.StringUtils;
	
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class LoginCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var signal:BaseSignal;
		
		[Inject]
		public var signalBus:SignalBus;
		
/*		private var _loginRequest:URLRequest;
		private var httpService:HTTPService = new HTTPService();
		public var loginSO:SharedObject;*/
		
		private var id:String;
		private var password:String;
		override public function execute():void {
			id=signal.params.id;
		 	password=signal.params.password;
			//login();
		}
		/*		
		public function loginGrand():void {

	
			loginSO = SharedObject.getLocal("login");
			if (id != "" && password != "") {
				
				var loginURL:String = StringUtils.parseURL(urls.login, {"#USERNAME#":id, "#PASSWORD#":password } );

				httpService.url = loginURL;
				httpService.resultFormat = "e4x";
				httpService.method = "POST";
				httpService.addEventListener(ResultEvent.RESULT, checkGrandAuthenticationResponse);
				httpService.send( {"UserName":id , "password":password, "ipAddress":"127.0.0.1"} );

				
				loginSO.data.username = id;
				loginSO.data.password = password;
				loginSO.flush();
				} 
		}
		
		private function checkGrandAuthenticationResponse(event:ResultEvent):void {
			httpService.removeEventListener(ResultEvent.RESULT, checkGrandAuthenticationResponse);
			var xml:XML = event.result as XML;
			debug(xml);
			if (xml.hasOwnProperty("session")) {
				player.session = xml.session;
				signalBus.dispatch(LoginEvent.LOGIN_SUCCESS);
				signalBus.dispatch(StartupDataEvent.SEAT);
				signalBus.dispatch(StartupDataEvent.LOAD);
			}
			else {
				signalBus.dispatch(LoginEvent.LOGIN_FAILURE);
			}
		}
		
		private function login():void {
			_loginRequest = new URLRequest(urls.login);
			_loginRequest.method = "POST";
			var loginData:URLVariables = new URLVariables();
			loginData.userName = id;
			loginData.password = password;
			loginData.IPAddress = "127.0.0.1";
			_loginRequest.data = loginData;
			
			service.addLoader(new XMLLoader(_loginRequest, Constants.SERVER_LOGIN));
			service.getLoader(Constants.SERVER_LOGIN).onError.add(showError);
			service.getLoader(Constants.SERVER_LOGIN).onComplete.add(checkLoginResponse);
			service.start();
			debug(urls.login, loginData);
		}
		
		private function checkLoginResponse(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			service.remove(Constants.SERVER_LOGIN);
			if (xml.hasOwnProperty("result") && xml.result == "OK") {
				//if(xml.MemberDetails.GEOCountry == "UK" || xml.MemberDetails.GEOCountry == "GB") {

				player.session = xml.MemberDetails.SLCSessionID;
				urls.authentication += "?req=1&smart_id=nl5pe00j2t6klsn56t7xnkbwlr20q4jl&smart_pass=123456&ext_id=" + xml.MemberDetails.MemberId + "&page=003&firstname=" + xml.MemberDetails.Firstname + "&lastname=" + xml.MemberDetails.Lastname + "&password=na&lang=en&brand=&currency=" + xml.MemberDetails.Currency + "&country=" + xml.MemberDetails.Country + "&remote_ip=127.0.0.1&output=1&nickname=" + xml.MemberDetails.Username + "&affiliate_id=&utype=0&gameType=mini_roulette&tid=7nyiaws9tgqrzaz3&session_id=" + xml.MemberDetails.SessionID;
				_loginRequest = new URLRequest(urls.authentication);
				_loginRequest.method = "GET";
				
				service.addLoader(new XMLLoader(_loginRequest, Constants.SERVER_AUTHENTICATE));
				service.getLoader(Constants.SERVER_AUTHENTICATE).onError.add(showError);
				service.getLoader(Constants.SERVER_AUTHENTICATE).onComplete.add(checkAuthenticationResponse);
				service.start();				
				debug(urls.authentication);
			}
			else {
				signalBus.dispatch(LoginEvent.LOGIN_FAILURE);
			}
		}
		
		private function checkAuthenticationResponse(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			service.remove(Constants.SERVER_AUTHENTICATE);
			if (xml.hasOwnProperty("session")) {
				player.session = xml.session;
				signalBus.dispatch(LoginEvent.LOGIN_SUCCESS);
				signalBus.dispatch(StartupDataEvent.SEAT);
				signalBus.dispatch(StartupDataEvent.LOAD);
			}
			else {
				signalBus.dispatch(LoginEvent.LOGIN_FAILURE);
			}
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("error", signal);
		}*/
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}