package com.ai.core.controller.commands {
	
	import com.ai.core.controller.signals.TaskbarActionEvent;
	import com.ai.core.model.IGameData;
	import com.ai.core.utils.GameUtils;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class TaskbarActionCommand extends Command {
		
		[Inject]
		public var event:TaskbarActionEvent;
		
		[Inject]
		public var type:String;
		
		[Inject]
		public var game:IGameData;

		override public function execute():void	{
			debug("event.type: " + type);
			switch (type) {
				case TaskbarActionEvent.CHIP_CLICKED:
					
					break;
				
				case TaskbarActionEvent.UNDO_CLICKED:
					
					break;
				case TaskbarActionEvent.REPEAT_CLICKED:
					
					break;
			}
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}