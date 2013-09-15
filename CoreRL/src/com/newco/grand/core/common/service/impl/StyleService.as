package com.newco.grand.core.common.service.impl
{
	import com.evolutiongaming.ui.Style;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.BaseObject;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.StyleModel;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;

	public class StyleService extends BaseObject implements IService
	{
		[Inject]
		public var service:XMLService;

		[Inject]
		public var urls:URLSModel;

		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var flashVars:FlashVars;

		private var onComplete:Function;

		public function StyleService()
		{
		}

		public function load(onComplete:Function=null):void
		{
			this.onComplete=onComplete;
			loadStyle();
		}

		private function loadStyle():void
		{
			debug(urls.style);
			service.loadURL(urls.style, setStyle, showError);
		}

		private function setStyle(signal:LoaderSignal, xml:XML):void
		{
			debug(xml);
			Style.getInstance().xml=xml;
			var nodeName:String;
			var attributes:XMLList;
			try
			{
				StyleModel.XMLDATA=xml;
				for each (var node:XML in xml.children())
				{
					nodeName=String(node.name().localName).toUpperCase();
					StyleModel[nodeName]=node.text();
					attributes=node.@*;
					for each (var node_att:XML in attributes)
					{
						StyleModel[nodeName + "_" + node.name()]=node;
					}
					if (node.children().length() > 0)
					{
						StyleModel[nodeName + "_XML"]=node;
					}
				}
			}
			catch (err:Error)
			{
				signalBus.dispatch(MessageEvent.SHOWERROR, {target: this, error: err.name + " : " + err.message + " on node:" + node});

			}
			finally
			{
				signalBus.dispatch(LanguageAndStylesEvent.STYLE_LOADED);
				if (onComplete != null)
					onComplete();
	
			}
		}

		private function showError(signal:ErrorSignal):void
		{
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR, {target: this, error: signal.message});
		}

	}
}
