Different methods to use FLVPlayerLite.

# Code examples #
Load a .FLV on a timeline

```
import nl.matthijskamstra.media.FLVPlayerLite; // import
var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this, 'flv/foobar.flv' );
```

or

```
FLVPlayerLite.create ( this, 'flv/foobar.flv' );
```


Load a .FLV in a movieclip and loops the movie
```
import nl.matthijskamstra.media.FLVPlayerLite; // import
FLVPlayerLite.create ( flvContainer_mc, 'flv/foobar.flv' , {autoLoop:true} );
```


Do you want more controle over your .FLV: in this case your movie doesn't start at once(autoPlay:false) and at the end of the .FLV (onComplete) a function will be called (example: "`flvOnComplete`").

```
import nl.matthijskamstra.media.FLVPlayerLite; // import
FLVPlayerLite.create ( player1Container_mc, 'flv/foobar.flv', { autoPlay:false , onComplete:flvOnComplete } );
private function flvOnComplete():void { // trace( ":: flvOnComplete ::"); }
```

You can also get the feedback on cuepoints in your .FLV:  at the end of the .FLV (onComplete) a function will be called (example: "`flvOnComplete`") and every cuepoint in the .FLV will call to a function (example: "`flvOnCuePoint`").
This function will receive the name and time of the cuepoint

```
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
```