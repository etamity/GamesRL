package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.service.impl.LoginService;
	
	public class LoginCommand extends BaseCommand {
		
		[Inject]
		public var signal:BaseSignal;
		
		[Inject]
		public var service:LoginService;
		
		override public function execute():void {
			var id:String=signal.params.id;
			var password:String=signal.params.password;
			service.id=id;
			service.password=password;
			service.load();
		}
	
	}
}