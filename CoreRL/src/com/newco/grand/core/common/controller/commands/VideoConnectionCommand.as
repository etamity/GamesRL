package com.newco.grand.core.common.controller.commands {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.VideoModel;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
	public class VideoConnectionCommand extends BaseCommand {
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var videoModel:VideoModel;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signal:BaseSignal;
		
		override public function execute():void {
			switch (signal.type)	{				
				case VideoEvent.CONNECT: 
				
					videoModel.init();
	
					
					break;
				
				case VideoEvent.PLAY:
					//dispatch(new VideoEvent(SocketDataEvent.DATA_LOADED, node));
					break;
			}
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}