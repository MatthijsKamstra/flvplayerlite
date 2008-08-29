/**
* SoundLiteMixer (AS3), version 1.0
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
* @class  	: 	SoundLiteMixer
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	1.0 - class creation (AS3)
* @since 	:	29-8-2008 15:16
* 
* Changelog:
*
* 		v 1.0 [29-8-2008 15:16] - Initial release
*
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	

	public class SoundLiteMixer {
		
		// Constants:
		public static var CLASS_REF 			= nl.matthijskamstra.media.SoundLiteMixer;
		public static var CLASS_NAME 	:String = "SoundLiteMixer";
		public static var LINKAGE_ID 	:String = "nl.matthijskamstra.media.SoundLiteMixer";
		
		// vars
		private var soundTrackArray		:Array;
		private var activeTrack			:uint;
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.SoundLiteMixer; // import
		*			var __SoundLiteMixer:SoundLiteMixer = new SoundLiteMixer ( ['foobar.mp3','foobar2.mp3','foobar3.mp3'] );
		*/
		public function SoundLiteMixer( $urlArray:Array, $startId:uint = 0 ) {
			// trace( "SoundLiteMixer.SoundLiteMixer > $urlArray : " + $urlArray );
			soundTrackArray = [];
			for (var i:int = 0; i < $urlArray.length; i++) 	{
				var _SoundLite:SoundLite = new SoundLite ($urlArray[i], {autoPlay:false});
				soundTrackArray.push (_SoundLite);
			}
			
			activeTrack = $startId;
			
			(soundTrackArray[$startId] as SoundLite).play();
			
		}
		
		
		public function activateTrack ($id:uint) {
			trace( "SoundLiteMixer.activateTrack > $id : " + $id );
			trace( "activeTrack : " + activeTrack );
			
			var totalMS:Number = (soundTrackArray[activeTrack] as SoundLite).trackTotal
			var skipMs:Number =  (soundTrackArray[activeTrack] as SoundLite).trackPosition ;
			trace( "skipMs : " + skipMs + "\t|\t totalMS : " + totalMS );

			
			//(soundTrackArray[activeTrack] as SoundLite).pause();
			(soundTrackArray[activeTrack] as SoundLite).stop();
			//(soundTrackArray[$id] as SoundLite).play(skipMs);
			(soundTrackArray[$id] as SoundLite).play();
			
			
			activeTrack = $id;
		}
		
		
		//////////////////////////////////////// static ////////////////////////////////////////		
		
		
		//////////////////////////////////////// Listener ////////////////////////////////////////
		
		
	} // end class
	
} // end package
