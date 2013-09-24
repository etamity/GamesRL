package com.newco.grand.core.common.model
{
	public class SettingsModel
	{
		private var xmlData:XML;
		public function SettingsModel()
		{
		}
		public function set xml(val:XML):void {
			xmlData = val;
		}
		public function get xml():XML {
			return xmlData;
		}
	}
}