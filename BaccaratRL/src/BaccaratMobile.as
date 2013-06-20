package
{
	import com.newco.grand.baccarat.configs.BaccaratBundle;
	import com.newco.grand.baccarat.configs.BaccaratMobileConfig;
	import com.newco.grand.core.common.model.FlashVars;
	import com.smart.uicore.controls.ToolTip;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	[SWF(width = "640", height = "960", frameRate = "24", backgroundColor = "#4C4C4C")]
	public class BaccaratMobile extends Sprite
	{

		protected var context:IContext; 
		public function BaccaratMobile()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onAddToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			FlashVars.AIR_MODE=true;
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