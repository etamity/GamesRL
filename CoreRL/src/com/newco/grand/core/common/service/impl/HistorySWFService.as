package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	
	import org.assetloader.loaders.SWFLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class HistorySWFService implements IService
	{
		[Inject]
		public var flashVars:FlashVars;
		public var loader:SWFLoader;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var urls:URLSModel;
		[Inject]
		public var contextView:ContextView;
		private var _onComplete:Function;
		
		public var display:MovieClip;
		public function HistorySWFService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			if (display==null)
			{
				_onComplete=onComplete;
				loader =new SWFLoader(new URLRequest(urls.historySWF));
				loader.onError.add(showError);
				loader.onComplete.add(setConfig);			
				loader.start();
			} else
			{
				display.visible=true;
			}
		}
		private function setConfig(signal:LoaderSignal, mc:MovieClip):void {
			display=mc;
			display.init(flashVars.user_id, true);
			display.x = contextView.view.stage.stageWidth / 2 - display.width/2;
			display.y = contextView.view.stage.stageHeight / 2 - display.height/2;
			display.visible = true;
			contextView.view.addChild(display);
			if (_onComplete!=null)
				_onComplete();
		}
		private function showError(signal:ErrorSignal):void {
			debug("error");
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}