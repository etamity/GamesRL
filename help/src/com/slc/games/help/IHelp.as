package com.slc.games.help {

	import com.slc.games.help.model.HelpModel;

	public interface IHelp {
		function init(loadURLXML:Boolean = true):void
		function loadHelp(helpId:String, title:String = ""):void
		function set visible(v:Boolean):void
		function get model():HelpModel
	}
}

