package com.evolutiongaming.ui {
	/**
	 * Style class that stores the XML file (Singleton)
	 * @author Adi
	*/
    public class Style {		
		/**
		 * Stores the XML data loaded from the XML
		*/
        private var xmlData:XML;
		
		/**
		 * Holds the instance of the class
		*/
		static private var instance:Style;		
		
        /**
		 * Constructor
		*/
		public function Style(enforcer:SingletonEnforcer) {			
            
        }
		
		/**
		 * Function to check and create the instance of the class if it doesn't exist
		 * @return instance of this class
		*/
		public static function getInstance():Style {
			if (Style.instance == null) {
				Style.instance = new Style(new SingletonEnforcer());
			}
			return Style.instance;
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
		 * Function that get the XML node based on the parameter passed
		 * @param name - node name to find in the XML
		 * @param att - attribute to find in the node
		 * @return value of the node found
		*/
		public function getAttribute(name:String, att:String):* {
			return xmlData[name].@[att];
		}
		
		/**
		 * Function that get the XML node attribute based on the parameters passed
		 * @param name - node name to find in the XML
		 * @return value of the node found
		*/
		public function getProperty(name:String):* {
			return xmlData[name];
		}
		
		/**
		 * Function that set the XML node attribute based on the parameters passed
		 * @param name - node name to set in the XML
		 * @param val - value to be set
		*/
		public function setProperty(name:String, val:String):void {
			xmlData[name] = val;
		}
		
		/**
		 * Function that get the XML node based on the parameter passed, returns as a uint hexidecimal colour value
		 * @param name - node name to find in the XML
		 * @return value of the node found
		*/
		public function getPropertyAsColor(name:String):uint {			
			return uint("0x" + xmlData[name]);			
		}
	}  
}

class SingletonEnforcer {}