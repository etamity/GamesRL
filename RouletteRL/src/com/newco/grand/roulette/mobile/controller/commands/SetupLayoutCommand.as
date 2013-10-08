package com.newco.grand.roulette.mobile.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.view.interfaces.IErrorMessageView;
	import com.newco.grand.core.common.view.interfaces.IGameStatusView;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.roulette.classic.view.interfaces.ILimitsView;
	import com.newco.grand.roulette.classic.view.interfaces.IResultsClassicView;
	
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
		public var gameResult:IResultsClassicView;
		
		[Inject]
		public var limitsView:ILimitsView;
		
		//[Inject]
		//public var errorView:IErrorMessageView;
		public function SetupLayoutCommand()
		{
			super();
		}

		override public function execute():void {
			setupLayout();
		}

		private function setupLayout():void{
			taskbarView.view.y=496;
			gameStatusView.view.x=10;
			gameStatusView.view.y=50;
			gameResult.view.x=345;
			gameResult.view.y=427;
			limitsView.view.y=446;
			limitsView.view.x=0;
			betSpotsView.view.y=0;
			//errorView.view.y=errorView.view.stage.stageHeight-errorView.view.height;

		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}

