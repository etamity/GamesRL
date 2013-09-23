package com.newco.grand.core.common.model
{
	public class Settings
	{
		private var xmlData:XML;
		public function Settings()
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