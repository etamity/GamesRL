package com.newco.grand.core.common.service {
	
	public interface ISocketService	{
		function connectToSocket(server:String, port:int):void;
		function closeSocketConnection():void;
	}
}