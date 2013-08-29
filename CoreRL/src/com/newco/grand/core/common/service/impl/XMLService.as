package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.assetloader.base.Param;
	import org.assetloader.core.IParam;
	import org.assetloader.loaders.XMLLoader;
	
	public class XMLService
	{
		protected var params:URLVariables;
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
			var loader:XMLLoader=new XMLLoader(urlRequest);
			if (noCache){
				var param:IParam=new Param(Param.PREVENT_CACHE, true);
				loader.addParam(param);
			}
			urlRequest.data=params;
			if (onComplete!=null)
				loader.onComplete.add(onComplete);
			if (onError!=null)
				loader.onError.add(onError);
			
			loader.start();
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}