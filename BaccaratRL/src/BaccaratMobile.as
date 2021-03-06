package
{
	import com.newco.grand.baccarat.configs.BaccaratBundle;
	import com.newco.grand.baccarat.configs.BaccaratMobileConfig;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.smart.uicore.ui.UI;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	[SWF(width = "640", height = "960", frameRate = "30", backgroundColor = "#4C4C4C",wmode="direct")]
	public class BaccaratMobile extends Sprite
	{

		protected var context:IContext; 
		public function BaccaratMobile()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onAddToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			UI.init(this.stage,24);
			//UI.topSprite.alpha=0.3;
			FlashVars.GAMECLIENT=Constants.BACCARAT;
			FlashVars.SKIN_ENABLE=false;
			FlashVars.PLATFORM=FlashVars.AIR_PLATFORM;

			//FlashVars.PLATFORM=FlashVars.TESTING_PLATFORM;	
			start();
		}
		
		private function start():void{
			context = new Context()
				.install(BaccaratBundle)
				.configure(
					BaccaratMobileConfig,
					new ContextView(this)
				);
		}
	}
}