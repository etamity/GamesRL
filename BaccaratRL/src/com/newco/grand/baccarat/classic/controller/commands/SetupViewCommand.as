package com.newco.grand.baccarat.classic.controller.commands
{
	import com.newco.grand.baccarat.classic.view.AnimationPanelView;
	import com.newco.grand.baccarat.classic.view.BetSpotsView;
	import com.newco.grand.baccarat.classic.view.CardsPanelView;
	import com.newco.grand.baccarat.classic.view.ScoreCardView;
	import com.newco.grand.baccarat.classic.view.TableGraphicView;
	import com.ai.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.utils.GameUtils;
	import com.ai.core.common.view.ChatView;
	import com.ai.core.common.view.GameStatusView;
	import com.ai.core.common.view.LoginView;
	import com.ai.core.common.view.MessageBoxView;
	import com.ai.core.common.view.StageView;
	import com.ai.core.common.view.TaskbarView;
	import com.ai.core.common.view.VideoView;
	import com.ai.core.common.view.uicomps.AccordionUIView;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class SetupViewCommand extends BaseCommand
	{
		[Inject]
		public var contextView:ContextView;
		
		public function SetupViewCommand()
		{
			super();
		}
		
		override public function execute():void {
			//setupView();
		}
		
		private function setupView():void {
			contextView.view.addChild(new StageView());
			contextView.view.addChild(new VideoView());
			contextView.view.addChild(new TableGraphicView());
			contextView.view.addChild(new LoginView());
			contextView.view.addChild(new AccordionUIView());
			contextView.view.addChild(new TaskbarView());
			contextView.view.addChild(new GameStatusView())
			contextView.view.addChild(new ChatView());
			contextView.view.addChild(new BetSpotsView());
			contextView.view.addChild(new CardsPanelView());
			contextView.view.addChild(new AnimationPanelView());
			contextView.view.addChild(new ScoreCardView());
			contextView.view.addChild(new MessageBoxView());

		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}