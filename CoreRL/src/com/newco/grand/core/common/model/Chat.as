package com.newco.grand.core.common.model {
	
	public class Chat extends Actor {
		
		/*<config>
		<session>online</session>
		<username>adireddy</username>
		<room>game-7nyiaws9tgqrzaz3-nl5pe00j2t6klsn5</room>
		<userid>kiw3w6ltl4i05c9q</userid>
		<usertype>player</usertype>
		<server>chatproduction.smartlivecasino.com</server>
		<port>5654</port>
		<soundenabled>false</soundenabled>
		<server_signup_path>http://chatproduction.smartlivecasino.com:8080/ChatAppExternalWeb/rest/chat/external/signup</server_signup_path>
		<server_signup_string>193dcba286bc79afd40ebb19dd4cc6c0515462814a98c503511b8f11d191cb7b8b02afce61c3bc01b6f45f47504e1b169a44e616e6201335ab382e5159f9eb4eb33ef33710932267e6065a80064d97875fe4b41050ce12bf646352b8500eb5d2fb97a253738d52e403ab56e8d71bf49ddd1a7677c5654e00d8a427ace0ecc701943e1c044c68d84b2a27e2aca5ed2808a68f5b6e18a15d57c8cc186da2f35449f337e166076cfac4c3fc22370fd4ec24490d9bbdb73381e56bdded953eb332d61b450657efd78eb4349daff93766cbc384cacaa17e6f226391ba15cba284c9a56c120d06e0d94ba537b9d636b37a06b26d978853fc03325b1af9ccdedd7cc5655ea381f8ceb37adf8ebd349993f18bb62b32d05b4ed07c6bfdcfb7e477c30978cdc5583a241b29526c40055c9247adf726f48e6322fa1cce29f6d09b61755f8f42db848bace13a83221c2791d74ec6baea604e7f7f7047852a203bf513ccbd0f0dd57e00947e39e4f043e1db36ff104c348cb3409584b96bef83d3049189e143221b4f7ac5fd78440fb4d05f743e5d63ebefffd4a83e5fa378fc93ffb515d3234f8f35a5abb1b9ee6e713580ac485bd5c0017763016cac0da181ac7519293d53de282e396b8dfac932e05acbd4e462319e70910d1d2ffd2f79af7425fccb260e184b00791f6d7c2e07ce99e72b0a798e936ed3cb9d5e26629c20ca6724aaa2d9561e10c5f70bda516d942c37b34f2232599535bee0e582a2814c2d46c669d33474494f08d1da3885fa5b786ef57b424df87b9797f2330ab7bddcbc115f4ea39fe1d8fc1c997878aae24845da2b0c3322e6ae1eadea8edca14196f0f34d9a07f4552c0b9d155cfb89cdc5583a241b2952b7843487ce1490a6fdbf2f36173c589632f9ba940f0d62efea85e8a6fb942c709d049291da808f23bcb9b39ea7cbaf7a796eeac63f4b23a632029d3521129f2cfc0f62866defd30f3e1ce2e84327121ee87f3662b80fd2d220d7d41b7354eccfdfd28012f02600953266ecb30ba100a78a3060839a765811e93db281bff6e2b654e5c12e8ed642f5f9a12f286e4f8acfe24845da2b0c3322263779c8d3ed45c5b5b7207bf6ee2379797b36048533654c0ecce05fa6118a555798959c636869f378d2a42319ad078e4f1b3ef296463d5547921e5ea420c5f79a3c4b1e86c7a1caf12f82bc84e237f13183d72118e9ecad1fb673a0db32f39cb522c7e5e353a64790d5f24d780015b5ebd9056a9760c446d1b4372a0495d6388c3f20e0e05bceb37caef25d24dc4e0f12db203ad6c26f3876ac2253d211e4ef341fcc116c2901fd8bd46c71112c43d65c1497cc697253db294c443963ace4c98422acc0a009d158d23c5befc6e097b90855f16b38e26ab618b2ec847cd51037b8c4412bda101ab3641a1baa85e13168c8cc186da2f354492815fd344c7f26cc37fc3b38ea4f5e4496de8d1557d955a1e7e533b30f412c07eb22b33821573513be440713144518ec2bb1ad13702b32219cabcd1fd34a82e2</server_signup_string>
		</config>
		*/
		
		private var _room:String;
		private var _server:String;
		private var _port:int = 0;
		private var _serverSignupPath:String;
		private var _serverSignupString:String;
		
		private var _sender:String;
		private var _message:String;
		
		public function get room():String {
			return _room;
		}
		
		public function set room(value:String):void {
			_room = value;
		}		
		
		public function get server():String {
			return _server;
		}
		
		public function set server(value:String):void {
			_server = value;
		}
		
		public function get port():int {
			return _port;
		}
		
		public function set port(value:int):void {
			_port = value;
		}
		
		public function get serverSignupPath():String {
			return _serverSignupPath;
		}
		
		public function set serverSignupPath(value:String):void {
			_serverSignupPath = value;
		}
		public function get serverSignupString():String {
			return _serverSignupString;
		}

		public function set serverSignupString(value:String):void {
			_serverSignupString = value;
		}

		public function get sender():String {
			return _sender;
		}

		public function set sender(value:String):void {
			_sender = value;
		}

		public function get message():String {
			return _message;
		}

		public function set message(value:String):void {
			_message = value;
		}
	}
}