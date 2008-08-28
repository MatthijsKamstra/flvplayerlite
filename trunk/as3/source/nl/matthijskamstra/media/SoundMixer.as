/**
* SoundMixer (AS3), version 1.0
*
* Enter description here
*
* <pre>
*  ____                   _      ____ 
* |  __| _ __ ___    ___ | | __ |__  |
* | |   | '_ ` _ \  / __|| |/ /    | |
* | |   | | | | | || (__ |   <     | |
* | |__ |_| |_| |_| \___||_|\_\  __| |
* |____|                        |____|
* 
* </pre>
*
* @class  	: 	SoundMixer
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	1.0 - class creation (AS3)
* @since 	:	28-8-2008 11:53 
* 
* Changelog:
*
* 		v 1.0 [28-8-2008 11:53] - Initial release
*
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	

	public class SoundMixer {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundMixer;
		public static var CLASS_NAME : String = "SoundMixer";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundMixer";
		// vars
		public static var targetObj:DisplayObjectContainer;		
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.SoundMixer; // import
		*			var __SoundMixer:SoundMixer = new SoundMixer ( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function SoundMixer( $targetObj:DisplayObjectContainer = null ) {
			trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			if ( $targetObj == null ) { return; } ;
			targetObj = $targetObj;
			initSoundMixer ( targetObj ) ;
		}
		
		/**
		* initSoundMixer used to jumpstart everything
		* 
		* @usage   	import nl.matthijskamstra.media.SoundMixer; // import
		*			var __SoundMixer:SoundMixer = new SoundMixer ();
		*			__SoundMixer.initSoundMixer( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function initSoundMixer( $targetObj:DisplayObjectContainer ) {
			trace( "\t|\t $targetObj : " + $targetObj );
			
		}
		
		//////////////////////////////////////// static ////////////////////////////////////////		
		
		/**
		* staticSoundMixer function to jumpstart
		* 
		* @usage   	import nl.matthijskamstra.media.SoundMixer; // import
		*			SoundMixer.staticSoundMixer( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		static public function staticSoundMixer( $targetObj:DisplayObjectContainer ):void{
			var __staticSoundMixer:SoundMixer = new SoundMixer( );
			__staticSoundMixer.initSoundMixer( $targetObj );
			
		}
		
		//////////////////////////////////////// Listener ////////////////////////////////////////
		
		
	} // end class
	
} // end package
