package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.vo.UserLoginData;
	import com.newco.grand.core.common.view.interfaces.ILoginView;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.events.Event;
	import flash.net.SharedObject;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;

	public class LoginMediator extends Mediator{
		
		[Inject]
		public var view:ILoginView;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;
		
		private var _loginSO:SharedObject;

		override public function initialize():void {
			signalBus.add(LoginEvent.INITIALIZE,setupModel);
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
		}
		
		private function setupModel(signal:BaseSignal):void {
		
			initializeView();			
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
			
			signalBus.add(LoginEvent.LOGIN,hideView);
			signalBus.add(LoginEvent.LOGIN_SUCCESS,removeView);
			signalBus.add(LoginEvent.LOGIN_FAILURE,setError);
			
		}
		private function updateLanguage(signal:BaseSignal):void {
			view.updateLanguage();	
		}

		private function initializeView():void {

			view.id = "darwyn";
			view.password = "smartwyn";
			_loginSO = SharedObject.getLocal("cplogin");
			if (_loginSO.data.id != null) {
				view.id = _loginSO.data.id;
			}	
			view.loginSignal.add(login);
			view.init();
		}
		
		private function login(id:String,password:String):void {
			view.error = "";
			if(id != "" && password != "") {
				//eventDispatcher.dispatchEvent(event);
				var userLoginData:UserLoginData=new UserLoginData();
				userLoginData.id=id;
				userLoginData.password=password;
				signalBus.dispatch(LoginEvent.LOGIN,{id:id,password:password});
				_loginSO.data.id = id;
				_loginSO.flush();
			}
			else {
				view.error = LanguageModel.ENTER_VALID_USERNAME_PASSWORD; //"Please enter a valid username and password.";
			}
		}
		
		private function hideView(signal:BaseSignal):void {
			view.view.visible = false;
		}
		
		private function removeView(signal:BaseSignal):void {
			view.view.parent.removeChild(view.view);
		}
		
		private function setError(signal:BaseSignal):void {
			view.view.visible = true;
			view.error = LanguageModel.LOGIN_FAILED;//"Login Failed. Please try again.";
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}