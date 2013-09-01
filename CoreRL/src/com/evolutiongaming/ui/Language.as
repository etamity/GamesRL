package com.evolutiongaming.ui {
	/**
	 * Language class that stores the XML file (Singleton)
	 * @author Adi
	*/
    public class Language {		
		/**
		 * Stores the XML data loaded from the XML
		*/
        private var xmlData:XML;
		
		/**
		 * Holds the instance of the class
		*/
		static private var instance:Language;
		
		
        /**
		 * Constructor
		*/
		public function Language(enforcer:SingletonEnforcer) {			
            
        }
		
		/**
		 * Function to check and create the instance of the class if it doesn't exist
		 * @return instance of this class
		*/
		public static function getInstance():Language {
			if (Language.instance == null) {
				Language.instance = new Language(new SingletonEnforcer());
			}
			return Language.instance;
		}
		
		/**
		 * Function to set the XML once it is loaded
		 * @param val - XML data
		*/
		public function set xml(val:XML):void {			
            xmlData = val;
		}
		
		/**
		 * Function to get the XML
		 * @return XML data
		*/
		public function get xml():XML {			
            return xmlData;
		}
		
		/**
		 * Function that get the XML node based on the parameter passed and returns it
		 * @param name - node name to find in the XML
		 * @return value of the node found
		*/
		public function getProperty(name:String):String {
			return xmlData[name];
		}
		
		/**
		 * Function that get the XML node based on the parameter passed
		 * @param name - node name to find in the XML
		 * @param att - attribute to find in the node
		 * @return value of the node found
		*/
		public function getAttribute(name:String, att:String):* {
			return xmlData[name].@[att];
		}
	}  
}

class SingletonEnforcer {}