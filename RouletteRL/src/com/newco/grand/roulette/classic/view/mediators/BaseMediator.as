package com.newco.grand.roulette.classic.view.mediators
{
	import com.newco.grand.core.utils.GameUtils;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class BaseMediator extends Mediator
	{
		public function BaseMediator()
		{
			super();
		}
		
		public function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}