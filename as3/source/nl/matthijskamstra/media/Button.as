/**
Button (AS3), version 1.1

A fast way to create buttons

<pre>
 ____                   _      ____ 
|  __| _ __ ___    ___ | | __ |__  |
| |   | '_ ` _ \  / __|| |/ /    | |
| |   | | | | | || (__ |   <     | |
| |__ |_| |_| |_| \___||_|\_\  __| |
|____|                        |____|

</pre>

@class  	: 	Button
@author 	:  	Matthijs C. Kamstra [mck]
@version 	:	1.1 - class creation (AS3)
@since 		:	23-4-2008 10:51 

EXAMPLES: 
	Button.onRelease (FLVPlayerControler.playBtn_mc , buttonActivateButton, 'play');
	Button.onRollover (FLVPlayerControler.playBtn_mc , buttonActivateButton, 'rolloverPlay');
	
	private function buttonActivateButton($id:String):void {
		//trace( "++ buttonActivateButton : " + buttonActivateButton );
		//trace( "$id : " + $id );
		switch ($id) {
			case 'play': 
				trace('play');
				break;
			case 'rolloverPlay': 
				trace('rolloverPlay');
				break;
			default:
				trace( "case '" + $id + "': \n\ttrace('"+$id+"');\n\tbreak;");
		}
	}

NOTES:
	- visit my website: http://www.MatthijsKamstra.nl/blog
	- all your base are belong to us
	
CHANGELOG:
		v1.1 [28-8-2008 15:51] - changed document name from FLVPlayerLite to Button and more documentation
		v1.0 [23-4-2008 10:51] - Initial release

*/
package nl.matthijskamstra.media {
	
	import flash.display.*;
	import flash.events.*;

	public class Button {
		
		// Constants:
		public static var CLASS_REF = nl.matthijskamstra.media.Button;
		public static var CLASS_NAME : String = "Button";
		public static var LINKAGE_ID : String = "nl.matthijskamstra.media.Button";
		// vars
		private var func:Function;
		private var vars:Array = [];
		
		/**
		 * Constructor
		 * @usage		import nl.matthijskamstra.media.Button; //import
		 * 				var _button:Button = new Button (this.foobarBtn, onClickHandler, 'test', 'CLICK')
		 * @param	$target			the movieClip that is used for button
		 * @param	$func			function that is triggered on $mouseEvent
		 * @param	$vars			vars that will be send to function
		 * @param	$mouseEvent		different mouse states ('CLICK','ROLL_OVER','ROLL_OUT') 
		 */
		public function Button( $target:Object , $func:Function, $vars:* = null, $mouseEvent:String = '' ) {
			// trace ( '+ ' + LINKAGE_ID + ' class instantiated');	
			if ($target == null) { return; }
			
			this.func = $func;
			if (typeof ($vars) == 'object') {
				this.vars = $vars || [];
			} else {
				this.vars.push ($vars)
			}
			
			var _btn_mc = $target;
			_btn_mc.buttonMode = true;	
			if ($mouseEvent == '') {
				_btn_mc.addEventListener (MouseEvent.CLICK, ButtonListener);
			} else {
				_btn_mc.addEventListener (MouseEvent[$mouseEvent], ButtonListener);
			}
			
		}
		
		/////////////////////////////////////// Static ///////////////////////////////////////
		
		/**
		 * same as constructor but now a static 
		 * 
		 * @usage		import nl.matthijskamstra.media.Button; //import
		 * 				var btn:Button = Button.create (this.foobarBtn, onClickHandler, 'test', 'CLICK')
		 * @param	$target			the movieClip that is used for button
		 * @param	$func			function that is triggered on $mouseEvent
		 * @param	$vars			vars that will be send to function
		 * @param	$mouseEvent		different mouse states ('CLICK','ROLL_OVER','ROLL_OUT') 
		 */
		static public function create ($target:Object , $func:Function, $vars:* = null, $mouseEvent:String = '' ):Button {
			return new Button($target, $func, $vars , $mouseEvent);
		}
		/**
		 * create a easy onRelease button (static)
		 * 
		 * @usage		import nl.matthijskamstra.media.Button; //import
		 * 				var btn:Button = Button.onRelease (this.foobarBtn, onClickHandler, 'play');
		 * @param	$target			the movieClip that is used for button
		 * @param	$func			function that is triggered on $mouseEvent
		 * @param	$vars			vars that will be send to function
		 */
		static public function onRelease ($target:Object, $func:Function, $vars:* = null ):Button {
			return new Button($target, $func, $vars , 'CLICK');
		}
		static public function onRollover ($target:Object, $func:Function, $vars:* = null ):Button {
			return new Button($target, $func, $vars , 'ROLL_OVER');
		}
		static public function onRollout ($target:Object, $func:Function, $vars:* = null ):Button {
			return new Button($target, $func, $vars , 'ROLL_OUT');
		}
		
		/////////////////////////////////////// Listener ///////////////////////////////////////
		
		private function ButtonListener(e:MouseEvent):void {
			this.func.apply(null, vars);
		}

		
	} // end class
	
} // end package
