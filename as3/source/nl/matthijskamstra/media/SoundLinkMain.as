/**
* SoundLinkMain (AS3), version 1.0
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
* @class  	: 	SoundLinkMain
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	1.0 - class creation (AS3)
* @since 	:	2-9-2008 14:02 
*
* Changelog:
*
* 		v 1.0 [2-9-2008 14:02] - Initial release
*
* 
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	
	
	import nl.matthijskamstra.media.SoundLink; // import
	import nl.matthijskamstra.media.SoundLinkMixer; // import
	
	public class SoundLinkMain extends MovieClip {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundLinkMain;
		public static var CLASS_NAME : String = "SoundLinkMain";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundLinkMain";
		// vars
		public static var targetObj:DisplayObjectContainer;	
		private var _soundLinkMixer:SoundLinkMixer;
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.SoundLinkMain; // import
		*			var __SoundLinkMain:SoundLinkMain = new SoundLinkMain ( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function SoundLinkMain( $targetObj:DisplayObjectContainer = null ) {
			trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			targetObj = ($targetObj == null) ? this : $targetObj;
			initSoundLinkMain ( targetObj ) ;
		}
		
		public function initSoundLinkMain ($targetObj:DisplayObjectContainer = null) {
			trace( "SoundLinkMain.initSoundLinkMain > $targetObj : " + $targetObj );
			
			// _soundLiteMixer = new SoundLiteMixer (["mp3/kick.mp3", "mp3/kick_snare.mp3", "mp3/kick_snare_hihat.mp3", "mp3/kick_snare_hihat_bass.mp3", "mp3/kick_snare_hihat_bass_nasty.mp3", "mp3/kick_snare_hihat_bass_nasty_dingetje.mp3"],5);		
			
			
			_soundLinkMixer = new SoundLinkMixer ( [new track1(), new track2(), new track3(), new track4(), new track5(), new track6()] ,5 );
			
			// var _SoundLink:SoundLink = new SoundLink ( new track6());
			
			
			Button.onRelease (MovieClip($targetObj).btn1_mc, soundMixerHandler, 0 );
			Button.onRelease (MovieClip($targetObj).btn2_mc, soundMixerHandler, 1 );
			Button.onRelease (MovieClip($targetObj).btn3_mc, soundMixerHandler, 2 );
			Button.onRelease (MovieClip($targetObj).btn4_mc, soundMixerHandler, 3 );
			Button.onRelease (MovieClip($targetObj).btn5_mc, soundMixerHandler, 4 );
			Button.onRelease (MovieClip($targetObj).btn6_mc, soundMixerHandler, 5 );
		}
		
	
		//////////////////////////////////////// Listener/Handler ////////////////////////////////////////
		
		private function soundMixerHandler($id:uint):void {
			trace( "SoundLinkMain.soundMixerHandler > $id : " + $id );
			_soundLinkMixer.activateTrack ($id);
		}		
	} // end class
	
} // end package
