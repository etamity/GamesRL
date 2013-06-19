package com.newco.grand.core.common.view.interfaces
{
	import com.newco.grand.core.common.model.SignalBus;
	
	import flash.net.NetStream;

	public interface IVideoView extends IUIView
	{
		function set stream(value:NetStream): void;
		function toggleStageVideo(on:Boolean):void;
		function get signalBus():SignalBus;
	}
}