package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.assetloader.base.Param;
	import org.assetloader.core.IParam;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	
	public class XMLService
	{
		protected var loader:XMLLoader;
		protected var params:URLVariables;
		public var onError:ErrorSignal;
		[Inject]
		public var signalBus:SignalBus;
		
		public function XMLService()
		{
			params=new URLVariables();
		}
		
		public function get parameters():Object{
			return params;
		}
		public function loadURL(url:String,onComplete:Function=null,onError:Function=null,noCache:Boolean=true):void
		{
			var rtime:String;
			var urlRequest:URLRequest;
			debug(url,params);
			urlRequest= new URLRequest(url);
			loader=new XMLLoader(urlRequest);
			if (noCache){
				var param:IParam=new Param(Param.PREVENT_CACHE, true);
				loader.addParam(param);
			}
			urlRequest.data=params;
			if (onComplete!=null)
				loader.onComplete.add(onComplete);
			if (onError!=null)
				loader.onComplete.add(onError);
			loader.start();
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}