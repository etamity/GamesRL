package
{
	import com.newco.grand.baccarat.configs.BaccaratBundle;
	import com.newco.grand.baccarat.configs.BaccaratConfig;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.smart.uicore.controls.ToolTip;
	import com.smart.uicore.ui.UI;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	//[SWF(width = "990", height = "610", frameRate = "30", backgroundColor = "#4C4C4C")]
	[SWF(width = "100", height = "100", frameRate = "30", backgroundColor = "#4C4C4C")]
	public class BaccaratRL extends Sprite
	{

		protected var context:IContext; 
		public function BaccaratRL()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onAddToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			UI.init(this.stage,24);
			ToolTip.setDefaultToolTipStyle(0,0xFFFFFF,0xDDDDDD,1,1,0x666666,0.5);
			FlashVars.SKIN_ENABLE=true;
			FlashVars.GAMECLIENT=Constants.BACCARAT;
			start();
		}
		
		private function start():void{
			context = new Context()
				.install(BaccaratBundle)
				.configure(
					BaccaratConfig,
					new ContextView(this)
				);
		}
	}
}