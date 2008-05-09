/**

FLVPlayerLite (AS3), version 0.1

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>

@class  	: 	FLVPlayerLite
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	0.1 - class creation (AS3)
@since 		:	7-4-2008 17:07 


DESCRIPTION:
	FLV video is the native video format for Flash, and because of that probably the 
	most use video format on the internet (YouTube, Google Video).

	This FLV Player doesn't have all the features that you have when you use a Flash component, 
	but the basics: play, pause, mute. In the nearby future it will also have a playback bar, 
	loading progress and a dragable seek button (). 
	It is the basics that I use, and there for this FLV player will be lite. 
	
	I love the lite versions, because you can use in big OOP projects, but also in small (banners) project. 
	My favorite lite class is tweenlite (AS3) or AS2. Frequent Tweenlite users will recognize the syntax.

	So what is the difference between the Flash component and FLVPlayerLite? 
	Besides the restrictions I mentioned before (basic features) the SWF will be much "liter"
	
	Flash component: 51,6 KB (52.840 bytes) -- VS -- FLVPlayerLite: 3,11 KB (3.185 bytes)

	an empty .SWF is: 36 bytes (36 bytes)
	a clean FLVPlayerLite is: 3,11 KB (3.185 bytes)
	a clean Flash component is : 51,6 KB (52.840 bytes) (but has more functionality)
	

ARGUMENTS:
	1) $targetObj: 	Target MovieClip (or any other object) where the FLVPlayerLite will be created
	2) $url: 		path to FLV file
	3) $obj: 		An object containing param that you want to use with the creation of the FLVPlayerLite, playing or ending of the FLV
						CREATION: 
							x					: set the FLVPlayerLite's x position 	(not functional yet)
							y					: set the FLVPlayerLite's y position 	(not functional yet)
							depth				: set the FLVPlayerLite's depth 		(not functional yet)
							name				: set the FLVPlayerLite's name (default 'FLVPlayerLite')
						PLAYING:
							autoPlay			: start automatic play 	(default true)
							autoLoop			: loops the movie 		(default false)
						SPECIAL PROPERTIES:
							onCuePoint			: If you'd like to call a function when a cuepoint is entered, use this. 
							onCuePointParams	: An array of parameters to pass the onCuePoint function (optional)
							onComplete			: If you'd like to call a function when the tween has finished, use this. 
							onCompleteParams	: An array of parameters to pass the onComplete function (optional)
							
EXAMPLES: 
	Load a .FLV on a timeline
		
		import nl.matthijskamstra.media.FLVPlayerLite; // import
		var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this, 'flv/foobar.flv' );
		
		or 
		
		FLVPlayerLite.create ( this, 'flv/foobar.flv' );
		
	Load a .FLV in a movieclip and loops the movie
		
		import nl.matthijskamstra.media.FLVPlayerLite; // import
		FLVPlayerLite.create ( flvContainer_mc, 'flv/foobar.flv' , {autoLoop:true} );
		
		
	Do you want more controle over your .FLV: in this case your movie doesn't start at once(autoPlay:false) 
	and at the end of the .FLV (onComplete) a function will be called (example: "flvOnComplete").
		
		import nl.matthijskamstra.media.FLVPlayerLite; // import
		FLVPlayerLite.create ( player1Container_mc, 'flv/foobar.flv', { autoPlay:false , onComplete:flvOnComplete } );
		private function flvOnComplete():void { // trace( ":: flvOnComplete ::"); }
		
	You can also get the feedback on cuepoints in your .FLV:  
	at the end of the .FLV (onComplete) a function will be called (example: "flvOnComplete")
	and every cuepoint in the .FLV will call to a function (example: "flvOnCuePoint"). 
	This function will receive the name and time of the cuepoint		
		
		var __FLVPlayerLite1 = new FLVPlayerLite ( Container_mc, 'flv/foobar.flv', { onComplete:flvOnComplete , onCuePoint:flvOnCuePoint} );
		private function flvOnComplete():void { // trace( ":: flvOnComplete ::"); }
		private function flvOnCuePoint( $name:String, $time:Number, ...arg ):void {
			// trace( ":: flvOnCuePoint ::" );
			// trace( "$name : " + $name + ' - '+ typeof ($name));
			// trace( "$time : " + $time + ' - '+ typeof ($time));
			switch ($name) {
				case 'foobar':
					trace('<< foobar >>');
					break;
				default:
					trace(">> " + $name);
			}
		}
		

NOTES:
	- this project is opensource: http://code.google.com/p/flvplayerlite/
	- some features descibed here will not be working currently so visit the project homepage for detailed information
	- visit my site: http://MatthijsKamstra.nl/blog
	- all your base are belong to us
	- will add 3KB to your .SWF


CHANGELOG:
	v0.1 [7-4-2008] - Initial release
		
*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*; 
	import flash.media.SoundTransform;
    import flash.media.Video;
	import flash.net.NetConnection;
    import flash.net.NetStream;

    public class FLVPlayerLite extends Sprite {
		
		public static var version:Number = 0.1;
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.FLVPlayerLite;
		public static var CLASS_NAME : String = "FLVPlayerLite";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.FLVPlayerLite";
		// vars
		public static var targetObj:DisplayObjectContainer;	
		
		//compulsory vars passed via constructor
		//private var url				:String;			//flv file that is to be played
		private var fileURL				:String; 			//flv file that is to be played
		  
		//optional switches 
		public var isLooping			:Boolean = false;	// enables video looping
		public var isAutostart			:Boolean = true;	// the video will start playing
		public var isSoundOnStart		:Boolean = true;	// determines whether audio is muted at the begining
		//public var isSoundOnStart		:Boolean = false;	// determines whether audio is muted at the begining
		
		//configurable public buffering values	
		public var minBufferNumber		:Number = 2;		//default number of seconds of playback available before playing can start
		public var maxBufferNumber		:Number = 15;		//increased number of seconds for buffering after minBufferNumber is insufficient for continuous playback
	
		//loader properties
		public var isPlaying			:Boolean = false;	//determines whether playback is in progress
		public var nDuration			:Number = 0;		//duration of the flv. Only available after and if metadata has been received
		public var isSoundOn			:Boolean = true;	//mute on / off status of the player
		
		public var ncVideo				:NetConnection;
		public var nsVideo				:NetStream;
		public var videoObj_vid			:Video;	
		static var trackingEngine		:Object;
		static var loadCheckingEngine	:Object;
		// extra object values 
		private var xPos				:Number = 0;
		private var yPos				:Number = 0;
		private var FLVPlayerName		:String = 'FLVPlayerLite';
		public var FLVpercentLoaded		:Number = 0;		//percentage loaded of FLV
		
		private var onComplete			:Function; 			//The function that should be triggered when this tween has completed
		private var onCompleteParams	:Array; 			//An array containing the parameters that should be passed to the this.onComplete when this tween has finished.
		private var onCuePoint			:Function; 			//The function that should be triggered when a cuepoint is entered
		private var onCuePointParams	:Array; 			//An array containing the parameters that should be passed to the this.onCuePoint when this tween has finished.
		
	
		//static var pausedOnce			:Boolean = false;

		/**
		* Constructor: create a lite FLV player
		* 
		* @usage   	import nl.matthijskamstra.media.FLVPlayerLite; // import
		*			var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this , 'flv/Final_Mov_Sequence.flv' );
		* 			(read comments in 'nl.matthijskamstra.media.FLVPlayerLite')
		* 
		* @param	$targetObj		a reference to a movie clip or object
		* @param	$url			path to FLV file (example: '../flv/foobar.flv')
		* @param	$obj			object with extra param (read mor about this in the comments on the top)
		*/
		public function FLVPlayerLite( $targetObj:DisplayObjectContainer, $url:String, $obj:Object = null) {
			//trace ( '+ ' + LINKAGE_ID + ' class instantiated');
			targetObj = ($targetObj == null) ? this : $targetObj;
			
			//trace( "\t|\t - targetObj : " + targetObj.name );
			//trace( "\t|\t - $url : " + $url );
			//trace( "\t|\t - $obj : " + $obj );
			
			if ($obj != null) {
				if ($obj.autoPlay != null) { isAutostart = $obj.autoPlay; }
				if ($obj.autoLoop != null) { isLooping = $obj.autoLoop;}
				if ($obj.FLVPlayerName != null) { this.FLVPlayerName = $obj.name; }
				this.xPos = $obj.x;
				this.yPos = $obj.y;
				this.onComplete = $obj.onComplete;
				this.onCompleteParams = $obj.onCompleteParams || [];
				this.onCuePoint = $obj.onCuePoint;
				this.onCuePointParams = $obj.onCuePointParams || [];
			}
			
			this.fileURL = $url;
			
			this.videoObj_vid = new Video ();
			videoObj_vid.name = this.FLVPlayerName;
			initFLVPlayerLite () ;
		}
		
		// init
        private function initFLVPlayerLite( ):void {
            ncVideo = new NetConnection();
            ncVideo.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusListener);
            ncVideo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorListener);
            ncVideo.connect(null);
			
			// start checking loading and playhead
			startLoadCheckingEngine (); // [mck] don't know for sure
			startPlayheadTrackingEngine (); // [mck] don't know for sure
        }
		
		/////////////////////////////////////// start :: FLVPlayerLite Controlers ///////////////////////////////////////
		
		// mute the sound
		public function mute():void	{
			//trace( "\t|\t mute sound");
			var __SoundTransform:SoundTransform = new SoundTransform();
			if (isSoundOn){
				//trace ('no sound')
				__SoundTransform.volume = 0;
				nsVideo.soundTransform = __SoundTransform;
				isSoundOn = false;
			} else {
				//trace ('yes sound')
				__SoundTransform.volume = 1;
				nsVideo.soundTransform = __SoundTransform;
				isSoundOn = true;
			}
			//// updateButtonStatus();
		}
		
		public function playPauseToggle():void {
			//trace( "\t| :: playPauseToggle : " + playPauseToggle );
			if (isPlaying){
				pauseMedia();
			} else {
				playMedia();
			}
		}
		
		public function stopMedia ():void {
			//trace( "\t| :: isPlaying : " + isPlaying );
			if (isPlaying) {
				pauseMedia();
			}
		}
		
		public function pauseMedia():void {
			//trace( "\t| :: pauseMedia : " + pauseMedia );
			nsVideo.togglePause();
			isPlaying = false;
			// updateButtonStatus();
		}
		
		public function playMedia():void {
			//trace( "\t| :: playMedia : " + playMedia );
			nsVideo.togglePause();
			isPlaying = true;
			// updateButtonStatus();
		}
		
		public function rewToStart():void {
			//trace( "\t| :: rewToStart : " + rewToStart );
			nsVideo.seek(0);
			pauseMedia();
			playMedia();
		}
		
		public function rewToStartAndStop():void {
			//trace( "\t| :: rewToStart : " + rewToStart );
			nsVideo.seek(0);
			stopMedia()
		}	
		
		public function scrub(perc:Number):void	{
			//trace( "\t| :: scrub : " + scrub );
			var seekTime:Number = nDuration/100 * perc;
			nsVideo.seek(seekTime);		
		}
		
		public function seek($sec:Number):void	{
			//trace( "\t| :: scrub : " + scrub );
			nsVideo.seek($sec);		
		}

		/////////////////////////////////////// end :: FLVPlayerLite Controlers ///////////////////////////////////////
   
		/*
		public function loadVideo():void {
			videoObj_vid.attachVideo(nsVideo);
			startPlayheadTrackingEngine();
			startLoadCheckingEngine();
			
			if (!isAutostart){
				pauseMedia();
			} else {
				playMedia();
			}
		}*/
	
		private function connectStream():void {
			
			var customClient:Object = new Object();
			customClient.onCuePoint = onCuePointListener;
			customClient.onMetaData = onMetaDataListener;
			customClient.onPlayStatus = onPlayStatusListener;
			
            nsVideo = new NetStream(ncVideo);
            nsVideo.addEventListener(IOErrorEvent.IO_ERROR , onIOErrorListener);
            nsVideo.addEventListener(NetStatusEvent.NET_STATUS, onNetStatusListener);
            nsVideo.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			nsVideo.client = customClient;
           
			videoObj_vid.attachNetStream(nsVideo);
            nsVideo.play(fileURL);
            nsVideo.bufferTime = minBufferNumber;
			targetObj.addChild(videoObj_vid);
			
			if (!isAutostart) {
				//trace( "isAutostart : " + isAutostart );
				pauseMedia();
			} 
        }
		
		////////////////////////////////// start: FLV loading ///////////////////////////////////
		private function onFLVLoadProgress () : void {
			var totalBytes:Number  	= nsVideo.bytesTotal;
			var loadedBytes:Number  = nsVideo.bytesLoaded;
			if (totalBytes > 4)	{
				FLVpercentLoaded = Math.floor(loadedBytes / totalBytes * 100);
				//trace( "FLVpercentLoaded : " + FLVpercentLoaded );
				onLoadProgress(FLVpercentLoaded);
				if (FLVpercentLoaded >= 100) {
					stopLoadCheckingEngine();
				}
			}
		}
		public function onLoadProgress($percent:Number):void {
			//trace( "\t|\t " + CLASS_NAME + " :: onLoadProgress -- $percent : " + $percent );
		}
		protected function startLoadCheckingEngine():void {
			targetObj.addEventListener(Event.ENTER_FRAME, onEnterFrameLoadingListener);
		}
		protected function stopLoadCheckingEngine():void {
			targetObj.removeEventListener(Event.ENTER_FRAME, onEnterFrameLoadingListener);
		}	
		private function onEnterFrameLoadingListener(e:Event):void {
			onFLVLoadProgress ();
		}
		////////////////////////////////// end: FLV loading ///////////////////////////////////
		
		////////////////////////////////// start: FLV playhead ///////////////////////////////////
		private function onPlayheadProgress () : void {
			var nPercent:Number = 100 * nsVideo.time / nDuration;
			onPlayProgress(Math.floor(nPercent), nsVideo.time, nDuration);
		}
		public function onPlayProgress($percent:Number, $currentTime:Number, $totalTime:Number):void {
			//trace( "\t|\t " + CLASS_NAME + " :: onPlayProgress -- $percent : " + $percent + " | $currentTime : " + $currentTime + " | $totalTime : " + $totalTime );
		}
		protected function startPlayheadTrackingEngine():void {
			targetObj.addEventListener(Event.ENTER_FRAME, onEnterFramePlayProgressListener);		
		}
		protected function stopPlayheadTrackingEngine():void{
			targetObj.removeEventListener(Event.ENTER_FRAME, onEnterFramePlayProgressListener);
		}
		private function onEnterFramePlayProgressListener(e:Event):void {
			onPlayheadProgress ();
		}
		////////////////////////////////// end: FLV playhead ///////////////////////////////////
		
		/**
		 * kill every thing!!!
		 */
		public function destroy():void {
			//trace( "\t| :: destroy : " + destroy );
			stopPlayheadTrackingEngine();
			stopLoadCheckingEngine();
			nsVideo.close();
			ncVideo.close();
			videoObj_vid.clear();
		}
		
		/////////////////////////////////////// Static ///////////////////////////////////////
		
		/**
		* create a lite FLV player
		* 
		* @usage   	import nl.matthijskamstra.media.FLVPlayerLite; // import
		*			var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this , 'flv/Final_Mov_Sequence.flv' );
		* 			(read comments in 'nl.matthijskamstra.media.FLVPlayerLite')
		* 
		* @param	$targetObj		a reference to a movie clip or object
		* @param	$url			path to FLV file (example: '../flv/foobar.flv')
		* @param	$obj			object with extra param (read mor about this in the comments on the top)
		*/
		public static function create ( $targetObj:DisplayObjectContainer , $url:String, $obj:Object=null):FLVPlayerLite {
			return new FLVPlayerLite ($targetObj, $url, $obj);
		}
		
		/////////////////////////////////////// Listeners ///////////////////////////////////////
		
		private function onNetStatusListener(event:NetStatusEvent):void {
            
			var netStatusCode = event.info.code;
			var netStatusLevel = event.info.level;
			////trace ("\t|\t onNetStatusListener || event.info.code: '"+netStatusCode+"'\te.info.level : "+netStatusLevel);
			
			// STOND ER ALL
			switch (netStatusCode) {
				case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
					// ERROR MANAGEMENT
                    trace("Unable to locate video: '" + fileURL + "'");
                    break;
				case "NetStream.Play.Stop":
					// when playhed reached the end rewind to beginning
					//trace("\t| Stop [" + nsVideo.time.toFixed(3) + " seconds]");
					// //trace ('end?')
					if (this.onComplete != null) {
						this.onComplete.apply(null, this.onCompleteParams);
					}
					if (isLooping){
						rewToStart();
					} else {
						isPlaying = false;
						//// updateButtonStatus();
						//onMediaStop();
					}  
					break;
				case "NetStream.Play.Start":
					// Playback has started.
					//trace("\t| Start [" + nsVideo.time.toFixed(3) + " seconds]");

					if (!isSoundOnStart || !isSoundOn){
						mute();
					}
					if (isAutostart){
						isPlaying = true;
						//// updateButtonStatus();
						//onMediaStart();
					} 
					break;
				case "NetStream.Buffer.Full":
					// DYNAMIC BUFFERING
					// The buffer is full and the stream will begin playing.
					nsVideo.bufferTime = maxBufferNumber;
					break;
				case "NetStream.Buffer.Empty":
					//DYNAMIC BUFFERING
					/* 
					Data is not being received quickly enough to fill the buffer. 
					Data flow will be interrupted until the buffer refills, at which time a 
					NetStream.Buffer.Full message will be sent and the stream will begin playing again.
					*/
					nsVideo.bufferTime = minBufferNumber;
					break;			
				default:
					// //trace ('\t|\t\t|\t netStatusCode: ' + netStatusCode)
					//trace ("\t|\t onNetStatusListener || event.info.code: '"+netStatusCode+"'\te.info.level : "+netStatusLevel);
			}
		}
		
		private function onIOErrorListener(e:IOErrorEvent):void {
			trace( "\t|\t onIOErrorListener : " + onIOErrorListener + "\te : " + e );
			
		}
		
        private function onSecurityErrorListener(event:SecurityErrorEvent):void {
            trace("\t|\t onSecurityErrorListener: " + event);
        }
        
        private function asyncErrorHandler(event:AsyncErrorEvent):void {
            // ignore AsyncErrorEvent events.
        }

		/**
		 * received metadata
		 */
		public function onMetaDataListener(info:Object):void {
			//trace("\t|\t onMetaDataListener :: duration = " + info.duration + "\t width = " + info.width + "\t height = " + info.height + "\t framerate = " + info.framerate + "\t --> fileURL : " + fileURL);
			// for( var i:String in info ) //trace( "key : " + i + ", value : " + info[ i ] );
			
			nDuration = info.duration;	
			
			var vidWidth:Number 	= info.width;
			var vidHeight:Number 	= info.height;
			
			videoObj_vid.width		= vidWidth;
			videoObj_vid.height 	= vidHeight;
			
			//trace( "vidWidth : " + vidWidth + "\t - vidHeight : " + vidHeight );
			
		}
		
		public function onCuePointListener(info:Object):void {
			//trace("\t|\t onCuePointListener :: cuepoint: time = " + info.time + "\t  name = " + info.name + "\t  type = " + info.type);
			if (this.onCuePoint != null) {
				this.onCuePointParams = [];
				this.onCuePointParams.push(info.name);
				this.onCuePointParams.push(info.time);
				this.onCuePoint.apply(null, this.onCuePointParams);
			}
		}

		public function onPlayStatusListener(info:Object):void {
			//trace("t|\t onPlayStatusListener :: info" + info);
		    //trace("NetStream.onPlayStatus called");
			for (var prop in info) {
				//trace("\t"+prop+":\t"+info[prop]);
			}
			//trace("");
		}		
		
    } // end class
} // end package