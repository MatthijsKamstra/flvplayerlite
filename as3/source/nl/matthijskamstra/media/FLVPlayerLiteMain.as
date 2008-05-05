/**
* FLVPlayerLiteMain (AS3), version 1.0
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
* @class  	: 	FLVPlayerLiteMain
* @author 	:  	Matthijs C. Kamstra [mck]
* @version 	:	r1.0 - class creation (AS3)
* @since 	:	7-4-2008 17:10 
* 
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*; 
	
	public class FLVPlayerLiteMain extends MovieClip {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.FLVPlayerLiteMain;
		public static var CLASS_NAME : String = "FLVPlayerLiteMain";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.FLVPlayerLiteMain";
		// vars
		public static var targetObj:DisplayObjectContainer;	
		private var use_FLVLoaderLite:FLVLoaderLite;
		private var use_FLVLoaderLite2:FLVLoaderLite;
		private var use_FLVLoaderLite3:FLVLoaderLite;
		
		/**
		* Constructor
		* 
		* @usage   	import nl.matthijskamstra.media.FLVPlayerLiteMain; // import
		*			var use_FLVPlayerLiteMain__ : nl.matthijskamstra.media.FLVPlayerLiteMain = new nl.matthijskamstra.media.FLVPlayerLiteMain ( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function FLVPlayerLiteMain( $targetObj:DisplayObjectContainer = null ) {
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');

			if ( $targetObj == null ) { 
				targetObj = this;
			} else {
				targetObj = $targetObj;
			}
			setupControlers ()
			initFLVPlayerLiteMain ( targetObj ) ;
		}
		
		/**
		 * 
		 */
		private function setupControlers():void {
			trace( "setupControlers : " + setupControlers );
			var controler1 = (targetObj as MovieClip).controle_1;
			var controler2 = (targetObj as MovieClip).controle_2;
			var controler3 = (targetObj as MovieClip).controle_2;

			// playBtn_mc button
			var __playBtn_mc = controler1.playBtn_mc;
			__playBtn_mc.buttonMode = true;
			 __playBtn_mc.btn_txt.mouseEnabled = false;
			__playBtn_mc.addEventListener (MouseEvent.CLICK, playBtn_mcListener);
			
			// stopBtn_mc button
			var __stopBtn_mc = controler1.stopBtn_mc;
			__stopBtn_mc.buttonMode = true;
			 __stopBtn_mc.btn_txt.mouseEnabled = false;
			__stopBtn_mc.addEventListener (MouseEvent.CLICK, stopBtn_mcListener);
			
			// pauseBtn_mc button
			var __pauseBtn_mc = controler1.pauseBtn_mc;
			__pauseBtn_mc.buttonMode = true;
			 __pauseBtn_mc.btn_txt.mouseEnabled = false;
			__pauseBtn_mc.addEventListener (MouseEvent.CLICK, pauseBtn_mcListener);
			
			
			
			
			trace( "controler3 : " + controler3 );
			
		}
		
		/**
		* initFLVPlayerLiteMain used to jumpstart everything
		* 
		* @usage   	import nl.matthijskamstra.media.FLVPlayerLiteMain; // import
		*			var use_FLVPlayerLiteMain:FLVPlayerLiteMain = new FLVPlayerLiteMain ();
		*			use_FLVPlayerLiteMain.initFLVPlayerLiteMain( this );
		* @param	$targetObj		a reference to a movie clip or object
		*/
		public function initFLVPlayerLiteMain( $targetObj:DisplayObjectContainer ) {
			//trace( "\t|\t $targetObj : " + $targetObj );
			//var use_FLVLoaderLite:FLVLoaderLite = new FLVLoaderLite ( $targetObj, '../deploy/flv/Final_Mov_Sequence.flv' );
			//use_FLVLoaderLite = new FLVLoaderLite ( ($targetObj as MovieClip).flvContainer_mc, '../deploy/flv/beenbreuk-V2.flv' , {autoPlay:false,onComplete:test , onCompleteParams:['beenbreuk' , true]} );
			//use_FLVLoaderLite2 = new FLVLoaderLite ( ($targetObj as MovieClip).flvContainer2_mc, '../deploy/flv/Final_Mov_Sequence.flv' , {autoPlay:true, onComplete:test , onCompleteParams:['final' , true]}  );
			use_FLVLoaderLite3 = new FLVLoaderLite ( ($targetObj as MovieClip).flvContainer3_mc, '../deploy/flv/alex_rndrn_shade_def.flv' , {autoPlay:true, onComplete:flvTwoOnComplete, onCuePoint:flvOnCuePoint } );

		}
		
		private function flvTwoOnComplete():void {
			trace( "flvTwoOnComplete : " + flvTwoOnComplete );
			
		}
		
		
		

		private function flvOnCuePoint( $name:String, $time:Number, ...arg ):void {
			trace( "$time : " + $time );
			//trace( "|| flvOnCuePoint ||" );
			// >> loop
			// >> down
			
			/**
			<< loop >>
			$time : 9.606
			<< down >>
			$time : 19.044
			*/
			
			// use_FLVLoaderLite3.seek (19.044);
			
			switch ($name) {
				case 'loop':
					trace('<< loop >>');
					//use_FLVLoaderLite3.rewToStart ()
					break;
				case 'down':
					trace('<< down >>');
					use_FLVLoaderLite3.seek (9.606);
					break;
				default:
					trace(">> " + $name);
			}
		}
		
		
		
		// function onComplete
		function test2 () {
			trace( "test2 : " + test2 );
		}
		function test($debug:String = '', $isTrue:Boolean = true) {
			trace( "test : " + test2 );
			
			trace( "$debug : " + $debug );
			trace( "$debug : " + typeof ($debug) );		
			
			trace( "$isTrue : " + $isTrue );
			trace( "$isTrue : " +typeof ( $isTrue) );

			
		}
		

		
		
		///////////////////////////////// Listener ///////////////////////////////// 
		
		
		private function pauseBtn_mcListener (e:MouseEvent){
			//trace( "pauseBtn_mcListener (e : " + e );
			use_FLVLoaderLite.pauseMedia();
			
		}
		
		private function stopBtn_mcListener (e:MouseEvent){
			trace( "stopBtn_mcListener (e : " + e );
			use_FLVLoaderLite.stopMedia();
		}
		
		private function playBtn_mcListener (e:MouseEvent){
			//trace( "playBtn_mcListener (e : " + e );
			use_FLVLoaderLite.playMedia ();
			
		}		
	} // end class
	
} // end package
