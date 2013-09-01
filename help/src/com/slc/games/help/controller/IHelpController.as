package com.slc.games.help.controller {

	import flash.events.IEventDispatcher;

	public interface IHelpController extends IEventDispatcher {
		function loadXML():void
		function close():void
		function loadHelpPage(index:uint):void
	}
}

