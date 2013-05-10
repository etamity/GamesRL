package com.ai.core.model.vo
{
	import flash.events.EventDispatcher;
	
	public class UserLoginData extends EventDispatcher
	{
		private var _id:String;
		private var _password:String;

		public function get password():String
		{
			return _password;
		}
		
		public function set password(value:String):void
		{
			_password = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
	}
}