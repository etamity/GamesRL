package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.view.interfaces.IStatisticsView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.SignalBus;
	
	import flash.events.MouseEvent;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StatisticsMediator extends Mediator
	{
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var view:IStatisticsView;
		public function StatisticsMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(StatisticsEvent.SUMMARYLOADED, loadstatsSum);
			view.showHideSignal.add(doShowHide);
			signalBus.add(VideoEvent.SWITCHSTREAM, showHideRightBar);
		}
		private function showHideRightBar(signal:BaseSignal):void{
			var streamName:String=signal.params.streamName;
			if (streamName=="xmode"){
				view.extended=false;
				signalBus.dispatch(StatisticsEvent.SHOWHIDE,{extended:false});
			}
			else
			{
				view.extended=true;
				signalBus.dispatch(StatisticsEvent.SHOWHIDE,{extended:true});
			}
		}
		private function doShowHide(extended:Boolean):void{
			signalBus.dispatch(StatisticsEvent.SHOWHIDE,{extended:extended});
		}
		private function updateLanguage(signal:BaseSignal):void{
			view.updateLanguage();
		}
		private function loadstatsSum(signal:BaseSignal):void {
			var xml:XML=signal.params.xml;
			view.load(xml);
		}
		private function setupModel(signal:BaseSignal):void {
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
			view.init();
		}

	}
}