package {
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.roulette.configs.RouletteBundle;
	import com.newco.grand.roulette.configs.RouletteConfig;
	import com.smart.uicore.controls.ToolTip;
	import com.smart.uicore.ui.UI;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	[SWF(width = "1186", height = "667", frameRate = "30", backgroundColor = "#4C4C4C")]
	//[SWF(width = "990", height = "610", frameRate = "30", backgroundColor = "#000000")]
	public class RouletteRL extends Sprite {
		
		protected var context:IContext; 
		
		public function RouletteRL() {
			MonsterDebugger.initialize(this);
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		private function onAddToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			FlashVars.SKIN_ENABLE=true;
			UI.init(stage,24);
			ToolTip.setDefaultToolTipStyle(0,0xFFFFFF,0xDDDDDD,1,1,0x666666,0.5);
			FlashVars.GAMECLIENT=Constants.ROULETTE;
			start();
		}
		
		private function start():void{
			context = new Context()
				.install(RouletteBundle)
				.configure(
					RouletteConfig,
					new ContextView(this)
				);
		}
	}
}