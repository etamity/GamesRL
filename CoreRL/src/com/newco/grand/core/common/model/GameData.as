package com.newco.grand.core.common.model
{
	import flash.utils.Dictionary;
	
	public class GameData extends Actor implements IGameData
	{
		private var _chips:Array = new Array(1, 5, 25, 50, 100, 500);
		private var _chipSelected:Number;
		private var _countdown:int;
		private var _videoStream:String;
		private var _videoApplication:String;
		private var _fullscreen:Boolean = false;
		private var _sound:Boolean = true;
		private var _min:Number;
		private var _max:int;
		private var _server:String;
		private var _gameID:String;
		private var _gameTime:String;
		private var _videoSettings:XML;
		
		private var _dealer:String;
		private var _table:String;
		private var _response:String;
		private var _resultXML:XML;
		private var _game:String;
		
		private var _gameType:String;
		private var _statusMessage:String;
		private var _layoutPoints:Dictionary;
		public function GameData()
		{
			super();
			_layoutPoints=new Dictionary();
		}
		
		public function get layoutPoints():Dictionary{
			return _layoutPoints;
		}
		public function get statusMessage():String{
			return _statusMessage;
		}
		public function set statusMessage(value:String):void{
			_statusMessage=value;
		}
		public function get game():String{
			return _game;
		}
		public function set game(value:String):void{
			_game=value;
		}
		public function get gameType():String{
			return 	_gameType;
		}
		public function set gameType(value:String):void{
			_gameType=value;
		}

		public function get resultXML():XML {
			return _resultXML;
		}
		
		public function set resultXML(value:XML):void {
			_resultXML = value;
		}
		public function get response():String {
			return _response;
		}
		
		public function set response(value:String):void {
			_response = value;
		}
		
		public function get dealer():String	{
			return _dealer;
		}
		
		public function set dealer(value:String):void {
			_dealer = value;
		}
		
		public function get table():String {
			return _table;
		}
		
		public function set table(value:String):void {
			_table = value;
		}
		
		public function get videoSettings():XML	{
			return _videoSettings;
		}
		
		public function set videoSettings(value:XML):void {
			_videoSettings = value;
		}
		public function get videoApplication():String	{
			return _videoApplication;
		}
		
		public function set videoApplication(value:String):void {
			_videoApplication = value;
		}
		public function get server():String	{
			return _server;
		}
		
		public function set server(value:String):void {
			_server = value;
		}
		public function get gameID():String {
			return _gameID;
		}
		
		public function set gameID(value:String):void {
			_gameID = value;
		}
		
		public function get gameTime():String {
			return _gameTime;
		}
		
		public function set gameTime(value:String):void {
			_gameTime = (value.toLowerCase() != "between games") ? value : "--";
		}
		public function set videoStream(value:String):void{
			
			_videoStream= value;
		}
		public function get videoStream():String{
			
			return _videoStream;
		}
		
		public function get countdown():int {
			return _countdown;
		}
		
		public function set countdown(value:int):void {
			_countdown = (value > 5) ? value - 5 : 0;
		}
		public function get chips():Array {
			return _chips;
		}
		
		public function set chips(value:Array):void {
			_chips = value;
			chipSelected = value[0];
		}
		
		public function get chipSelected():Number {
			return _chipSelected;
		}
		
		public function set chipSelected(value:Number):void {
			_chipSelected = value;
		}
		
		public function get fullscreen():Boolean {
			return _fullscreen;
		}
		
		public function set fullscreen(value:Boolean):void {
			_fullscreen = value;
		}
		
		public function get sound():Boolean {
			return _sound;
		}
		
		public function set sound(value:Boolean):void {
			_sound = value;
		}
		public function get min():Number {
			return _min;
		}
		
		public function set min(value:Number):void {
			_min = value;
		}
		
		public function get max():int {
			return _max;
		}
		
		public function set max(value:int):void {
			_max = value;
		}
	}
}