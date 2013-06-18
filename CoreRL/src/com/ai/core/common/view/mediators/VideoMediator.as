package com.ai.core.common.view.mediators {
	
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.VideoEvent;
	import com.ai.core.common.model.FlashVars;
	import com.ai.core.common.model.SignalBus;
	import com.ai.core.service.VideoService;
	import com.ai.core.utils.GameUtcom.ai.core.common.view.VideoViewview.VideoView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.StageVideoAvailabilityEvent;
	import flash.geom.Rectangle;
	import flash.media.StageVideoAvailability;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class VideoMediator extends Mediator {
		
		[Inject]
		public var view:VideoView;
		
		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var videoSevvice:VideoService;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;
		
		private var stageAvailable:Boolean;
		
		private var videoMask:Sprite = new Sprite();
		private var _topDisplayObject:DisplayObject;
		private function onAddtoStageEvent(evt:Event):void{
			view.stage.addEventListener(StageVideoAvailabilityEvent.STAGE_VIDEO_AVAILABILITY, onStageVideoState);
		}
		private function onStageVideoState(evt:StageVideoAvailabilityEvent):void{
			var stageAvailable:Boolean = (evt.availability == StageVideoAvailability.AVAILABLE);
			debug("StageVideo Available:" ,stageAvailable);
		}
		override public function initialize():void {
			view.addEventListener(Event.ADDED_TO_STAGE,onAddtoStageEvent)
			signalBus.add(VideoEvent.CONNECT,initializeVideo);
			signalBus.add(VideoEvent.PLAY,setVideoStream);
		}
		protected function setFrameMask(width:Number, height:Number, viewport:Rectangle):void
		{
			
			videoMask.graphics.beginFill(0xFF0000);
			videoMask.graphics.drawRect(0, 0, viewport.x, height);
			videoMask.graphics.drawRect(viewport.x+viewport.width, 0, width - (viewport.x+viewport.width), height);
			videoMask.graphics.drawRect(viewport.x, 0, viewport.width, viewport.y);
			videoMask.graphics.drawRect(viewport.x, viewport.y+viewport.height, viewport.width, height-( viewport.y+viewport.height));
			videoMask.graphics.endFill();

			
		}
		private function initializeVideo(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
			view.videoFullscreenSignal.add(videoFullscreen);
			view.videoRefreshSignal.add(videoRefresh);
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
			debug(flashVars.videoplayer);
			if (flashVars.videoplayer=="stagevideo"){
			view.toggleStageVideo(true);
			}
			else if (flashVars.videoplayer=="video" || flashVars.videoplayer=="")
			view.toggleStageVideo(false);
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
		private function videoRefresh():void{
			videoSevvice.refreshStream();
		}
		private function videoFullscreen(target:MovieClip):void {
			/*if(!view.fullscreen) {
				_viewChildIndex = contextView.view.getChildIndex(view);
				contextView.view.setChildIndex(view, contextView.view.numChildren-1);
			} else {
				contextView.view.setChildIndex(view, _viewChildIndex);
			}*/
			if (_topDisplayObject==null)
				_topDisplayObject=contextView.view.getChildAt(contextView.view.numChildren-1);
			
			contextView.view.swapChildren(view,_topDisplayObject);
		}
		
	}
}