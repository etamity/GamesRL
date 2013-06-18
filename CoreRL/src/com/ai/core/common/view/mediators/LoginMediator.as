package com.ai.core.common.view.mediators {
	
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.LoginEvent;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.vo.UserLoginData;
	import com.ai.core.utils.GameUtcom.ai.core.common.view.LoginViewview.LoginView;
	
	import flash.events.Event;
	import flash.net.SharedObject;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class LoginMediator extends Mediator{
		
		[Inject]
		public var view:LoginView;
		
		[Inject]
		public var signalBus:SignalBus;
		
		private var _loginSO:SharedObject;

		override public function initialize():void {

			signalBus.add(LoginEvent.INITIALIZE,setupModel);
		}
		
		private function setupModel(signal:BaseSignal):void {
			initializeView();			
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			
			signalBus.add(LoginEvent.LOGIN,hideView);
			signalBus.add(LoginEvent.LOGIN_SUCCESS,removeView);
			signalBus.add(LoginEvent.LOGIN_FAILURE,setError);
			
		}
		
		private function initializeView():void {
			view.init();
			view.id = "170413a";
			view.password = "test11";
			_loginSO = SharedObject.getLocal("login");
			if (_loginSO.data.id != null) {
				view.id = _loginSO.data.id;
			}	
			view.loginSignal.add(login);
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
				view.error = "Please enter a valid username and password.";
			}
		}
		
		private function hideView(signal:BaseSignal):void {
			view.visible = false;
		}
		
		private function removeView(signal:BaseSignal):void {
			view.parent.removeChild(view);
		}
		
		private function setError(signal:BaseSignal):void {
			view.visible = true;
			view.error = "Login Failed. Please try again.";
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}