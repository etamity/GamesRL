package com.ai.core.common.view.mediators {
	
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.LoginEvent;
	import com.ai.core.common.controller.signals.ModelReadyEvent;
	import com.ai.core.common.controller.signals.StartupDataEvent;
	import com.ai.core.common.controller.signals.TaskbarActionEvent;
	import com.ai.core.common.model.IGameData;
	import com.ai.core.common.model.SignalBus;
	import com.ai.core.common.model.SignalConstants;
	import comcom.ai.core.common.view.StageView
	import com.ai.core.view.StageView;
	
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StageMediator extends Mediator{
		
		[Inject]
		public var view:StageView;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var signalBus:SignalBus;
		
		private var _sound:SoundTransform = new SoundTransform();
		
		override public function initialize():void {
			
			signalBus.add(ModelReadyEvent.READY,setupModel);
			signalBus.add(SignalConstants.STARTUP,showPreloader);
			signalBus.add(LoginEvent.INITIALIZE,hidePreloader);
			signalBus.add(LoginEvent.LOGIN,showPreloader);
			//signalBus.add(LoginEvent.LOGIN_SUCCESS,hidePreloader);
			//signalBus.add(LoginEvent.LOGIN_FAILURE,hidePreloader);
			signalBus.add(StartupDataEvent.LOAD,hidePreloader);

			signalBus.add(TaskbarActionEvent.FULLSCREEN_CLICKED,toggleFullScreen);
			signalBus.add(TaskbarActionEvent.SOUND_CLICKED,toggleSound);
			signalBus.add(TaskbarActionEvent.HELP_CLICKED,toggleHelp);

		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			view.hidePreloader();
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			
			_sound.volume = 1;
			SoundMixer.soundTransform = _sound;
		}
		
		private function setErrorMessage(signal:BaseSignal):void{
			var errorID:String=signal.params.errorID;
		}
		
		private function showPreloader(signal:BaseSignal):void {
			view.showPreloader();
		}
		
		private function hidePreloader(signal:BaseSignal):void {
			view.hidePreloader();
		}
		
		private function toggleFullScreen(signal:BaseSignal):void {
			if (view.stage.displayState == StageDisplayState.NORMAL) {
				view.stage.displayState = StageDisplayState.FULL_SCREEN;
				game.fullscreen = true;
			}
			else {
				view.stage.displayState = StageDisplayState.NORMAL;
				game.fullscreen = false;
			}
		}
		
		private function toggleHelp(signal:BaseSignal):void {
			
		}
		
		private function toggleSound(signal:BaseSignal):void {
			_sound.volume = (_sound.volume == 1) ? 0 : 1;
			game.sound = Boolean(_sound.volume);
			SoundMixer.soundTransform = _sound;
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}