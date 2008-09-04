/**
* SoundLinkMixer (AS3), version 1.0
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
* @class  	: 	SoundLinkMixer
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	1.0 - class creation (AS3)
* @since 	:	29-8-2008 15:16
* 
* Changelog:
* 		v 1.0 [29-8-2008 15:16] - Initial release
*
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	

	public class SoundLinkMixer {
		
		// Constants:
		public static var CLASS_REF 			= nl.matthijskamstra.media.SoundLinkMixer;
		public static var CLASS_NAME 	:String = "SoundLinkMixer";
		public static var LINKAGE_ID 	:String = "nl.matthijskamstra.media.SoundLinkMixer";
		
		// vars
		public var soundTrackArray		:Array;
		public var activeTrack			:uint;
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.SoundLinkMixer; // import
		*			var __SoundLinkMixer:SoundLinkMixer = new SoundLinkMixer ( [new track1(), new track2()] );
		*/
		public function SoundLinkMixer( $urlArray:Array, $startId:uint = 0 ) {
			//trace( "SoundLinkMixer.SoundLinkMixer > $urlArray : " + $urlArray + ", $startId : " + $startId );
			soundTrackArray = [];
			for (var i:int = 0; i < $urlArray.length; i++) 	{
				var _SoundLink:SoundLink = new SoundLink ($urlArray[i] );
				_SoundLink.volume (0);
				soundTrackArray.push (_SoundLink);
			}
			activeTrack = $startId;
			(soundTrackArray[$startId] as SoundLink).volume (1);
		}
		
		/**
		 * @usage	var _soundLinkMixer:SoundLinkMixer = new SoundLinkMixer ( [new track1(), new track2()] );
		 * 			_soundLinkMixer.activeTrack (1); // start track2
		 * @param	$id
		 */
		public function activateTrack ($id:uint) {
			//trace( "SoundLinkMixer.activateTrack > $id : " + $id );
			//trace( "activeTrack : " + activeTrack );
			for (var i:int = 0; i < soundTrackArray.length; i++) 	{
				(soundTrackArray[i] as SoundLink).volume (0);
			}
			(soundTrackArray[$id] as SoundLink).volume (1);
			activeTrack = $id;
		}
		
	} // end class
	
} // end package
