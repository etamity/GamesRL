package com.newco.grand.roulette.configs
{
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
	import robotlegs.bender.framework.api.IBundle;
	import robotlegs.bender.framework.api.IContext;
	
	public class RouletteBundle implements IBundle
	{	
		public function extend(context:IContext):void
		{
			context.install(
				MVCSBundle,
				SignalCommandMapExtension);
		}
	}
}