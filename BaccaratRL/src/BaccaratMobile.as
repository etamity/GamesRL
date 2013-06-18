package
{
	import com.newco.grand.baccarat.configs.BaccaratBundle;
	import com.newco.grand.baccarat.configs.BaccaratMobileConfig;
	import com.smart.uicore.controls.ToolTip;
	import com.smart.uicore.ui.UI;
	
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
			UI.init(this.stage,24);
			ToolTip.setDefaultToolTipStyle(0,0xFFFFFF,0xDDDDDD,1,1,0x666666,0.5);
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