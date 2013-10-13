package com.newco.grand.core.common.view.interfaces
{
	import com.newco.grand.core.common.model.SignalBus;
	
	import flash.events.MouseEvent;
	import flash.net.NetStream;

	public interface IVideoView extends IUIView
	{
		function set stream(value:NetStream): void;
		function get stream():NetStream;
		function toggleStageVideo(on:Boolean):void;
		function get signalBus():SignalBus;
		function showFullscreen(evt:MouseEvent):void;
		
		function showHidePreloader(showed:Boolean):void;
	}
}