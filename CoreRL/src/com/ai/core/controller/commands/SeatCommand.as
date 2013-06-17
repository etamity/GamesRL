package com.ai.core.controller.commands
{
	import com.ai.core.controller.signals.MessageEvent;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;

	public class SeatCommand extends BaseCommand
	{
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		public function SeatCommand()
		{
			super();
		}
		override public function execute():void {
			setSeat();			
		}
		private function setSeat():void{
			var seat:String = urls.seat+ "?table_id=" + flashVars.table_id;
			debug(seat);
			service.addLoader(new XMLLoader(new URLRequest(seat), Constants.SERVER_SIT));
			service.getLoader(Constants.SERVER_SIT).onError.add(showError);
			service.getLoader(Constants.SERVER_SIT).onComplete.add(responseSeat);			
			service.start();
		}
		private function responseSeat(signal:LoaderSignal, xml:XML):void {
			debug(xml);
	
			service.remove(Constants.SERVER_SIT);
	
		}
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.ERROR,{error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}