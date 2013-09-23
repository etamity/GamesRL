package com.newco.grand.core.common.model
{
	public class TableConfig
	{
		private var xmlData:XML;
		public function TableConfig()
		{
		}
		public function set xml(val:XML):void {
			xmlData = val;
		}
		public function get xml():XML {
			return xmlData;
		}
		public function getProperty(name:String):String {
			return xmlData["gameconfig-param"].@[name];
		}
		public function getPropertyAsNumber(name:String):Number {
			return Number(xmlData["gameconfig-param"].@[name]);
		}
	}
}