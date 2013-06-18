package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class FBLoginCommand extends BaseCommand {
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var signal:BaseSignal;
		
		private var _loginRequest:URLRequest;
		
		override public function execute():void {
			loginGrand();
		}
		public function loginGrand():void {
			var id:String=signal.params.id;
			var password:String=signal.params.password;
			if (id != "" && password != "") {
				var firstName:String= id.split(".")[0];
				var lastName:String= id.split(".")[1];
				var loginURL:String =urls.login+ "?first_name=#FIRSTNAME#&last_name=#LASTNAME#";
			
				loginURL=StringUtils.parseURL(loginURL, {"#FIRSTNAME#":firstName, "#LASTNAME#":lastName });
				debug(loginURL);
				service.addLoader(new XMLLoader(new URLRequest(loginURL), Constants.SERVER_LOGIN));
				service.getLoader(Constants.SERVER_LOGIN).onError.add(showError);
				service.getLoader(Constants.SERVER_LOGIN).onComplete.add(checkGrandAuthenticationResponse);			
				service.start();
				} 
		}
		
		private function checkGrandAuthenticationResponse(signal:LoaderSignal, xml:XML):void {

			debug(xml);
			if (xml.hasOwnProperty("session")) {
				player.session    = xml.session;
				flashvars.user_id = xml.userid;
			
				signalBus.dispatch(LoginEvent.LOGIN_SUCCESS);
				signalBus.dispatch(StartupDataEvent.SEAT);
				signalBus.dispatch(StartupDataEvent.LOAD);
				signalBus.dispatch(BalanceEvent.LOAD);
			}
			else {
				signalBus.dispatch(LoginEvent.LOGIN_FAILURE);
			}
			service.remove(Constants.SERVER_LOGIN);
		}
	
		private function showError(signal:ErrorSignal):void {
			debug("error", signal);
			signalBus.dispatch(MessageEvent.ERROR,{error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
		
	}
}