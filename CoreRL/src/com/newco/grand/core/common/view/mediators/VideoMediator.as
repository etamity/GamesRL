package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.VideoModel;
	import com.newco.grand.core.common.view.interfaces.IVideoView;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.media.StageVideoAvailability;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	public class VideoMediator extends Mediator {
		
		[Inject]
		public var view:IVideoView;
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var videoModel:VideoModel;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;
		
		private var stageAvailable:Boolean;
		
		//private var videoMask:Sprite = new Sprite();
		
		private var _topDisplayObject:DisplayObject;
		private function onAddtoStageEvent(evt:Event):void{
			contextView.view.stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoState);
		}
		private function onStageVideoState(evt:StageVideoAvailabilityEvent):void{
			var stageAvailable:Boolean = (evt.availability == StageVideoAvailability.AVAILABLE);
			debug("StageVideo Available:" ,stageAvailable);
		}
		override public function initialize():void {
			//view.addEventListener(Event.ADDED_TO_STAGE,onAddtoStageEvent)
			addViewListener(Event.ADDED_TO_STAGE,onAddtoStageEvent);
			addViewListener(Event.REMOVED_FROM_STAGE,onRemoveFromStageEvent);
			signalBus.add(VideoEvent.CONNECT,initializeVideo);
			signalBus.add(VideoEvent.PLAY,setVideoStream);
			signalBus.add(VideoEvent.FULLSCREEN,videoFullscreen);
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
			signalBus.add(UIEvent.BACKGROUND_GRAPHIC,showHidePreloader);
		}
		private function updateLanguage(signal:BaseSignal):void{
			view.updateLanguage();
		}
		private function onRemoveFromStageEvent(evt:Event):void{
			view.stream.close();
		}
	/*	protected function setFrameMask(width:Number, height:Number, viewport:Rectangle):void
		{
			
			videoMask.graphics.beginFill(0xFF0000);
			videoMask.graphics.drawRect(0, 0, viewport.x, height);
			videoMask.graphics.drawRect(viewport.x+viewport.width, 0, width - (viewport.x+viewport.width), height);
			videoMask.graphics.drawRect(viewport.x, 0, viewport.width, viewport.y);
			videoMask.graphics.drawRect(viewport.x, viewport.y+viewport.height, viewport.width, height-( viewport.y+viewport.height));
			videoMask.graphics.endFill();

			
		}*/
		private function initializeVideo(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
			view.signalBus.add(UIEvent.VIDEO_FULLSCREEN,videoFullscreen);
			view.signalBus.add(UIEvent.VIDEO_REFRESH,videoRefresh);
			view.signalBus.add(UIEvent.VIDEO_STOP,videoStop);
			view.signalBus.add(UIEvent.VIDEO_XMODE,videoXmode);

			//view.videoFullscreenSignal.add(videoFullscreen);
			//view.videoRefreshSignal.add(videoRefresh);
		}
		
		private function showHidePreloader(signal:BaseSignal):void{
			var showed:Boolean=signal.params.show;
			view.showHidePreloader(showed);
		}
		
		private function videoStop(signal:BaseSignal):void {
			videoModel.stopStream();
			signalBus.dispatch(UIEvent.BACKGROUND_GRAPHIC,{show:true});
		}
		
		private function videoXmode(signal:BaseSignal):void {
			videoModel.changeStream();
		}
		private function setupVideo(event:VideoEvent):void {
			/*if (flashVars.videoplayer=="stagevideo"){
				view.toggleStageVideo(true);
			}
			else if (flashVars.videoplayer=="video")
				view.toggleStageVideo(false);*/
			//view.setupOsmfPlayer(flashVars.params.streamUrl);
			//var streamUrl:String= flashVars.params.streamUrl;

		}
		private function setVideoStream(signal:BaseSignal):void {
			view.stream = signal.params.stream;
			var stagevideo:Boolean= signal.params.stagevideo;
			view.stream.play(StringUtils.trim(videoModel.streamName));
			debug(flashVars.videoplayer,"stagevideo=",stagevideo);
			if (flashVars.videoplayer==Constants.STAGEVIDEO_TYPE.toLowerCase() || stagevideo==true){
			view.toggleStageVideo(true);
			}
			else if (flashVars.videoplayer==Constants.VIDEO_TYPE.toLowerCase() || flashVars.videoplayer=="")
			view.toggleStageVideo(false);
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
		private function videoRefresh(signal:BaseSignal):void{
			videoModel.refreshStream();
		}
		private function videoFullscreen(signal:BaseSignal):void {
			
			view.showFullscreen(null);
			
			/*if(!view.fullscreen) {
				_viewChildIndex = contextView.view.getChildIndex(view);
				contextView.view.setChildIndex(view, contextView.view.numChildren-1);
			} else {
				contextView.view.setChildIndex(view, _viewChildIndex);
			}*/
			/*if (_topDisplayObject==null)
				_topDisplayObject=contextView.view.getChildAt(contextView.view.numChildren-1);
			
			contextView.view.swapChildren(view.display,_topDisplayObject);*/
		}
		
	}
}