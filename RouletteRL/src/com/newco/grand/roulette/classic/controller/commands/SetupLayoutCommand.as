package com.newco.grand.roulette.classic.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.view.interfaces.IChatView;
	import com.newco.grand.core.common.view.interfaces.IGameStatusView;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.roulette.classic.view.interfaces.ILimitsView;
	
	import robotlegs.bender.extensions.contextView.ContextView;


	public class SetupLayoutCommand extends BaseCommand
	{

		[Inject]
		public var contextView:ContextView;
		
		
		[Inject]
		public var taskbarView:ITaskbarView;
		
		[Inject]
		public var gameStatusView:IGameStatusView;
		
		[Inject]
		public var betSpotsView:IBetSpotsView;
		
		[Inject]
		public var chatView:IChatView;
		
		[Inject]
		public var limitsView:ILimitsView;
		public function SetupLayoutCommand()
		{
			super();
		}

		override public function execute():void {
			setupLayout();
		}

		private function setupLayout():void{
			taskbarView.view.y=550;
			//taskbarView.view.visible=false;
			gameStatusView.view.x=665;
			//gameStatusView.view.visible=false;
			chatView.view.x=810;
			//chatView.view.visible=false;
			limitsView.view.y=494;
			limitsView.view.x=5;
			betSpotsView.view.y=0;
			//betSpotsView.view.visible=false;

		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}

