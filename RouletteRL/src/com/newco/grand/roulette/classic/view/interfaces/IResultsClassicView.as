package com.newco.grand.roulette.classic.view.interfaces
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	public interface IResultsClassicView extends IUIView
	{
		function get xml():XMLList;
		function addResult(item:XML):void;
		function addCancel():void;
		function set xml(value:XMLList):void;
	}
}