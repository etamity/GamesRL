package com.newco.grand.core.common.model
{
	public class TableState
	{
		private var xmlData:XML;
		public function TableState()
		{
		}
		public function set xml(val:XML):void {
			xmlData = val;
		}
		public function get xml():XML {
			return xmlData;
		}
		public function getProperty(name:String):String {
			return xmlData[name];
		}
		public function getPropertyAsNumber(name:String):Number {
			return Number(xmlData[name]);
		}
	}
}