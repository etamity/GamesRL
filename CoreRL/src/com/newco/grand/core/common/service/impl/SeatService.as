package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class SeatService implements IService
	{
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		public function SeatService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			setSeat();
		}
		private function setSeat():void{
			debug(urls.seat);
			/*service.addLoader(new XMLLoader(new URLRequest(seat), Constants.SERVER_SIT));
			service.getLoader(Constants.SERVER_SIT).onError.add(showError);
			service.getLoader(Constants.SERVER_SIT).onComplete.add(responseSeat);			
			service.start();*/
			service.loadURL(urls.seat,responseSeat,showError);
		}
		private function responseSeat(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			
			//service.remove(Constants.SERVER_SIT);
			
		}
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}