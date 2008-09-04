/**
* SoundLiteMain (AS3), version 1.0
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
* @class  	: 	SoundLiteMain
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	1.0 - class creation (AS3)
* @since 	:	28-8-2008 11:44 
*
* Changelog:
*
* 		v 1.0 [28-8-2008 11:44] - Initial release
*
* 
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;	

	public class SoundLiteMain extends MovieClip {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.SoundLiteMain;
		public static var CLASS_NAME : String = "SoundLiteMain";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.SoundLiteMain";
		// vars
		public static var targetObj:DisplayObjectContainer;	
		private var bgSoundLiteController:SoundLiteController;
		private var _soundLiteMixer:SoundLiteMixer;
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.SoundLiteMain; // import
		*			var __SoundLiteMain:SoundLiteMain = new SoundLiteMain ( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function SoundLiteMain( $targetObj:DisplayObjectContainer = null ) {
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			targetObj = ($targetObj == null) ? this : $targetObj;
			initSoundLiteMain ( targetObj ) ;
		}
		
		//////////////////////////////////////// static ////////////////////////////////////////		

		/**
		* initSoundLiteMain used to jumpstart everything
		* 
		* @usage   	import nl.matthijskamstra.media.SoundLiteMain; // import
		*			var __SoundLiteMain:SoundLiteMain = new SoundLiteMain ();
		*			__SoundLiteMain.initSoundLiteMain( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function initSoundLiteMain( $targetObj:DisplayObjectContainer ) {
			//trace( "SoundLiteMain.initSoundLiteMain > $targetObj : " + $targetObj );
			// var soundBG:SoundLite = SoundLite.create ("mp3/donuts_music_loop.mp3", { isAutoPlay:true, onProgress:onProgressHandler, onComplete:onCompleteHandler, onTag:onTagHandler } ); 
			
			Button.onRelease (MovieClip($targetObj).soundBtn_mc , soundOnHandler );
			Button.onRelease (MovieClip($targetObj).soundOffBtn_mc , soundOffHandler);

			
			var controllerMC = $targetObj.getChildByName ('bgSound_mc');
			bgSoundLiteController = new SoundLiteController (controllerMC, "mp3/donuts_music_loop.mp3" , { loopTimes:2, autoPlay:false, onTag:onTagHandler } );
			
			var controller1MC = $targetObj.getChildByName ('sound1_mc');
			var controller2MC = $targetObj.getChildByName ('sound2_mc');
			var controller3MC = $targetObj.getChildByName ('sound3_mc');
			
			var _sc1:SoundLiteController = new SoundLiteController (controller1MC, "mp3/donuts_loop_langzaam.mp3" , {  autoPlay:false} );
			var _sc2:SoundLiteController = new SoundLiteController (controller2MC, "mp3/donuts_loop_medium.mp3" , {  autoPlay:false } );
			var _sc3:SoundLiteController = new SoundLiteController (controller3MC, "mp3/donuts_loop_snel.mp3" , {  autoPlay:false  } );
			/**/
			
			
			//_soundLiteMixer = new SoundLiteMixer (["mp3/donuts_loop_langzaam.mp3", "mp3/donuts_loop_medium.mp3", "mp3/donuts_loop_snel.mp3"]);
			_soundLiteMixer = new SoundLiteMixer (["mp3/kick.mp3", "mp3/kick_snare.mp3", "mp3/kick_snare_hihat.mp3", "mp3/kick_snare_hihat_bass.mp3", "mp3/kick_snare_hihat_bass_nasty.mp3", "mp3/kick_snare_hihat_bass_nasty_dingetje.mp3"],5);		

			
			
			Button.onRelease (MovieClip($targetObj).btn1_mc, soundMixerHandler, 0 );
			Button.onRelease (MovieClip($targetObj).btn2_mc, soundMixerHandler, 1 );
			Button.onRelease (MovieClip($targetObj).btn3_mc, soundMixerHandler, 2 );
			Button.onRelease (MovieClip($targetObj).btn4_mc, soundMixerHandler, 3 );
			Button.onRelease (MovieClip($targetObj).btn5_mc, soundMixerHandler, 4 );
			Button.onRelease (MovieClip($targetObj).btn6_mc, soundMixerHandler, 5 );
			
			
		}
		
		private function soundMixerHandler($id:uint):void {
			trace( "SoundLiteMain.soundMixerHandler > $id : " + $id );
			_soundLiteMixer.activateTrack ($id);
		}
		
		//////////////////////////////////////// Listener/Handler ////////////////////////////////////////		
		
		private function soundOffHandler():void {
			//trace( "SoundLiteMain.soundOffHandler" );
			bgSoundLiteController.buttonActivateButton('pause');
		}
		
		private function soundOnHandler():void {
			//trace( "SoundLiteMain.soundOnHandler" );
			bgSoundLiteController.buttonActivateButton('play');
		}
		
		
		
		private function onTagHandler($id3):void {
			trace( "SoundLiteMain.onTagHandler > $id3 : " + $id3 );
			trace ("Artist: " + $id3.artist );
			trace ("Song name: " + $id3.songName );
			trace ("Album: " + $id3.album ); 
		}		
		
		private function onCompleteHandler():void {
			trace( "SoundLiteMain.onCompleteHandler" );
			
		}
		
		private function onProgressHandler(i):void {
			trace( "SoundLiteMain.onProgressFunc > i : " + i );
			
		}
		
		
		
		
	} // end class
	
} // end package
