package com.ai.core.view.interfaces
{
	public interface IPlayersView
	{
		function init():void;
		function align():void;
		function set players(value:XML):void;
		function get players():XML;
	}
}