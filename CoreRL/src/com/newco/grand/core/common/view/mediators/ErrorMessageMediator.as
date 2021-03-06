package com.newco.grand.core.common.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.IErrorMessageView;
	
	import flash.utils.getQualifiedClassName;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class ErrorMessageMediator extends Mediator
	{
		[Inject]
		public var view:IErrorMessageView;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function ErrorMessageMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY,setupModel);
			signalBus.add(MessageEvent.SHOWERROR,setErrorMessage);
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
			view.init();
		}
		private function updateLanguage(signal:BaseSignal):void{
			view.updateLanguage();
		}
		private function setupModel(signal:BaseSignal):void {
	
		}
		private function setErrorMessage(signal:BaseSignal):void{
			var target:*=signal.params.target;
			var error:String=signal.params.error;
			view.setErrorMessage(getQualifiedClassName(target)+":"+ error);
		}
		
	}
}