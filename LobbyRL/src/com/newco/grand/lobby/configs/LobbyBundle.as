package com.newco.grand.lobby.configs
{
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
	import robotlegs.bender.framework.api.IBundle;
	import robotlegs.bender.framework.api.IContext;
	
	public class LobbyBundle implements IBundle
	{
		public function extend(context:IContext):void
		{
			context.install(
				MVCSBundle,
				SignalCommandMapExtension);
		}
	}
}


