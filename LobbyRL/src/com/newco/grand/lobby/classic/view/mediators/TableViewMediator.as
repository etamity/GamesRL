package com.newco.grand.lobby.classic.view.mediators
{
	import com.newco.grand.core.common.model.SignalBus;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class TableViewMediator extends Mediator
	{
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var signalBus:SignalBus;
		

		public function TableViewMediator()
		{
			super();
		}
		override public function initialize():void {
			
		}
	}
}