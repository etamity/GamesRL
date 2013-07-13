package com.newco.grand.baccarat.mobile.controller
{
	import com.newco.grand.baccarat.classic.view.AnimationPanelView;
	import com.newco.grand.baccarat.classic.view.ScoreCardView;
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.view.ChatView;
	import com.newco.grand.core.common.view.ErrorMessageView;
	import com.newco.grand.core.common.view.LoginView;
	import com.newco.grand.core.common.view.MessageBoxView;
	import com.newco.grand.core.common.view.uicomps.AccordionUIView;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.mobile.view.GameStatusView;
	import com.newco.grand.core.mobile.view.StageView;
	import com.newco.grand.core.mobile.view.TaskbarView;
	import com.newco.grand.core.mobile.view.VideoView;
	import robotlegs.bender.extensions.contextView.ContextView;
	import com.newco.grand.baccarat.mobile.view.BetSpotsView;
	import com.newco.grand.baccarat.mobile.view.CardsPanelView;
	import com.newco.grand.baccarat.mobile.view.TableGraphicView;
	public class SetupViewCommand extends BaseCommand
	{
		[Inject]
		public var contextView:ContextView;
		
		public function SetupViewCommand()
		{
			super();
		}
		
		override public function execute():void {
			setupView();
		}
		
		private function setupView():void {
			contextView.view.addChild(new StageView());
			contextView.view.addChild(new VideoView());
			contextView.view.addChild(new TableGraphicView());
			contextView.view.addChild(new LoginView());
			//contextView.view.addChild(new AccordionUIView());
			contextView.view.addChild(new TaskbarView());
			contextView.view.addChild(new GameStatusView())
			//contextView.view.addChild(new ChatView());
			contextView.view.addChild(new BetSpotsView());
			contextView.view.addChild(new CardsPanelView());
			contextView.view.addChild(new AnimationPanelView());
			
			if (FlashVars.DEBUG_MODE==true)
				contextView.view.addChild(new ErrorMessageView());


			
			
			if (FlashVars.DEBUG_MODE==true)
				contextView.view.addChild(new ErrorMessageView());

		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}