package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.core.common.view.interfaces.IStageView;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	public class StageMediator extends Mediator{
		
		[Inject]
		public var view:IStageView;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var flashVars:FlashVars;
		private var _sound:SoundTransform = new SoundTransform();
		
		override public function initialize():void {
			
			signalBus.add(ModelReadyEvent.READY,setupModel);
			signalBus.add(SignalConstants.STARTUP,showPreloader);
			signalBus.add(LoginEvent.INITIALIZE,hidePreloader);
			signalBus.add(LoginEvent.LOGIN,showPreloader);
			signalBus.add(StateTableConfigEvent.LOADED,hidePreloader);
			signalBus.add(TaskbarActionEvent.FULLSCREEN_CLICKED,toggleFullScreen);
			signalBus.add(TaskbarActionEvent.SOUND_CLICKED,toggleSound);
			signalBus.add(TaskbarActionEvent.HELP_CLICKED,toggleHelp);

			//signalBus.add(UIEvent.VIDEO_STOP, showGraphics);
			//if (FlashVars.PLATFORM==FlashVars.DESKTOP_PLATFORM || FlashVars.PLATFORM==FlashVars.WEB_PLATFORM)
			//if (flashVars.videoplayer==Constants.STAGEVIDEO_TYPE)
			signalBus.add(UIEvent.STAGE_GRAPHIC, showHideGraphics);
			//signalBus.add(UIEvent.BACKGROUND_GRAPHIC, showHideGraphics);
		}
		private function showHideGraphics(signal:BaseSignal):void {
			var show:Boolean=signal.params.show;
			view.view.visible=show;
		}
		private function updateLanguage(signal:BaseSignal):void{
			view.updateLanguage();
		}
		private function errorEvents():void{
			//signalBus.add(LoginEvent.LOGIN_SUCCESS,hidePreloader);
			//signalBus.add(LoginEvent.LOGIN_FAILURE,hidePreloader);
		}
		
		private function setupModel(signal:BaseSignal):void {
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
			view.init();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
			
			_sound.volume = 1;
			SoundMixer.soundTransform = _sound;
		}
		

		private function showPreloader(signal:BaseSignal):void {
			view.showPreloader();
		}
		
		private function hidePreloader(signal:BaseSignal):void {
			view.hidePreloader();
		}
		
		private function toggleFullScreen(signal:BaseSignal):void {
			if (contextView.view.stage.displayState == StageDisplayState.NORMAL) {
				//contextView.view.stage.displayState = StageDisplayState.FULL_SCREEN;
				contextView.view.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
				game.fullscreen = true;
			}
			else {
				contextView.view.stage.displayState = StageDisplayState.NORMAL;
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