﻿ /* 
 * [mck] FLVPlayerLite controler, version 1.0
 *
 * create a flvControler_mc, for easy use of the FLVPlayerLite with custom controler
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
 * @author :  		Matthijs C. Kamstra [mck]
 * @version: 			1.0
 * @since :			18-3-2008 14:06
 * @langversion: 		ActionScript 2.0 / 3.0
 * 
 * Changelog: 
 * 		v 1.0 [2008-03-18] - Initial release
 */
 
var versionString = '1.0'; 
 
/*
* 
*/
function createLoaderMC (AStype){

	// clear library // I'm a lazy bastard
	/* 
	if (fl.getDocumentDOM().library.itemExists('02 [mck] FLVPlayerLite/flvControler_mc')){
		fl.getDocumentDOM().selectNone();
		fl.getDocumentDOM().library.selectItem('01 [mck] Basic');
		fl.getDocumentDOM().library.selectItem('02 [mck] FLVPlayerLite/flvControler_mc', false);
		fl.getDocumentDOM().library.deleteItem();
	}
	*/

	// check if there is a folder with basic elements
	if (!fl.getDocumentDOM().library.itemExists('01 [mck] Basic/50x50px_mc')){
		// alert ('not set yet');
		setupLibrary ();
	}

	// set default colors in tools
	// makes flash crash.... to bad, it would be nice to have controle over the color
	/*	
	var fill = fl.getDocumentDOM().getCustomFill(); 
	fill.color = '#cccccc'; 
	fill.style = "solid";
	fl.getDocumentDOM().setCustomFill(fill);
 	var stroke = fl.getDocumentDOM().getCustomStroke(); 
	stroke.thickness = 0.05;
	stroke.color = '#666666'; 
	stroke.style = "hair";
	fl.getDocumentDOM().setCustomStroke(stroke);
	*/
	
	fl.getDocumentDOM().library.selectItem('01 [mck] Basic/50x50px_mc');
	fl.getDocumentDOM().library.addItemToDocument({x:145, y:45});
	fl.getDocumentDOM().setInstanceTint('#cccccc', 100);
	fl.getDocumentDOM().setInstanceAlpha(50);
	fl.getDocumentDOM().scaleSelection(7, 0.4);

	fl.getDocumentDOM().convertToSymbol('movie clip', 'flvControler_mc', 'top left');
	/*
	// no linkage, yet
	var lib = fl.getDocumentDOM().library;
	if (lib.getItemProperty('linkageImportForRS') == true) {
		lib.setItemProperty('linkageImportForRS', false);
	}
	lib.setItemProperty('linkageExportForAS', true);
	lib.setItemProperty('linkageExportForRS', false);
	lib.setItemProperty('linkageExportInFirstFrame', true);
	lib.setItemProperty('linkageClassName', 'nl.noise.MyLoader');
	*/
	fl.getDocumentDOM().clipCut();
	fl.getDocumentDOM().getTimeline().addNewLayer('flvControler_mc', "normal", true);
	fl.getDocumentDOM().clipPaste(true);
	fl.getDocumentDOM().selection[0].name = 'flvControler_mc';

	// edit 'flvControler_mc'
	fl.getDocumentDOM().enterEditMode("inPlace");
	
	fl.getDocumentDOM().selection[0].name = 'bg2_mc';
	fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
	fl.getDocumentDOM().getTimeline().setLayerProperty('name', 'bg2_mc');
	fl.getDocumentDOM().getTimeline().setLayerProperty('locked', true);
	
	// create layers for FLVPlayerLite controler
	var tl = fl.getDocumentDOM().getTimeline();
	// basic
	tl.addNewLayer('> playback controler', 'folder' , true); 	// 0
		tl.addNewLayer('playBtn_mc', 'normal' , false); 
		tl.addNewLayer('pauseBtn_mc', 'normal' , false); 
	tl.addNewLayer('> sound controler', 'folder' , false); 		// 3
		tl.addNewLayer('soundBtn_mc', 'normal' , false); 
		tl.addNewLayer('soundOffBtn_mc', 'normal' , false); 
	tl.addNewLayer('> loader - progress', 'folder' , false); 	// 6
		tl.addNewLayer('progress txt', 'normal' , false); 
		tl.addNewLayer('loaderBar_mc', 'normal' , false); 
		tl.addNewLayer('loaderProgress_mc', 'normal' , false); 
		tl.addNewLayer('loaderSize_mc', 'normal' , false); 
	tl.addNewLayer('> bg', 'folder' , false); 					// 11
		tl.addNewLayer('bg_mc', 'normal' , false); 
		tl.addNewLayer('size_mc', 'normal' , false); 

	// fill the folders with the layers
	// folder ' playback controler' vullen met andere layers
	var parLayer = tl.layers[0];
	tl.layers[1].parentLayer = parLayer;
	tl.layers[2].parentLayer = parLayer;
	// folder '> sound controler' vullen met andere layers
	var parLayer = tl.layers[3];
	tl.layers[4].parentLayer = parLayer;
	tl.layers[5].parentLayer = parLayer;
	// folder '> loader - progress' vullen met andere layers
	var parLayer = tl.layers[6];
	tl.layers[7].parentLayer = parLayer;
	tl.layers[8].parentLayer = parLayer;
	tl.layers[9].parentLayer = parLayer;
	tl.layers[10].parentLayer = parLayer;
	// folder '> bg' vullen met andere layers
	var parLayer = tl.layers[11];
	tl.layers[12].parentLayer = parLayer;
	tl.layers[13].parentLayer = parLayer;

	
	
	// fill layers with content
	var tl = fl.getDocumentDOM().getTimeline();
	
	/*
	+ folder'> bg'
	 	|	layer 'bg_mc'
		|	layer 'size_mc'
	*/
	// select layer 'size_mc'
	tl.setSelectedLayers(tl.findLayerIndex("size_mc")[0], true);
	//tl.addNewLayer('size_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('01 [mck] Basic/50x50px_mc');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().moveSelectionBy({x:25, y:25});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(7, 0, 0, 0.4); // 50x50 pixels must be 350x20 :: 350/50=7 & 20/50=0.4
		fl.getDocumentDOM().setInstanceTint('#999999', 100);
		fl.getDocumentDOM().setInstanceAlpha(0);
		fl.getDocumentDOM().selection[0].name = 'size_mc';	
	
	// select layer 'bg_mc'
	tl.setSelectedLayers(tl.findLayerIndex("bg_mc")[0], true);
		// create a default bg shape/color for player	
		fl.getDocumentDOM().setStroke("#666666", 0.05, 'hairline');// #666666 color for stroke (dark gray) 
		fl.getDocumentDOM().setFillColor("#cccccc");// #cccccc for fill color (light gray)
		fl.getDocumentDOM().addNewRectangle({left:100, top:100, right:150, bottom:150},0);
		fl.getDocumentDOM().setSelectionRect({left:90, top:90, right:170, bottom:170}, true, true);
		fl.getDocumentDOM().setStrokeSize(0.05);
		fl.getDocumentDOM().setStrokeStyle('hairline');
		fl.getDocumentDOM().setStrokeColor('#333333');	
		fl.getDocumentDOM().setSelectionRect({left:90, top:90, right:170, bottom:170}, true, true);
		fl.getDocumentDOM().setFillColor('#cccccc');
		fl.getDocumentDOM().setSelectionRect({left:90, top:90, right:170, bottom:170}, true, true);
		fl.getDocumentDOM().convertToSymbol('movie clip', 'controlerShape', 'top left');
		fl.getDocumentDOM().selection[0].name = 'bg_mc';
		fl.getDocumentDOM().moveSelectionBy({x:-130, y:-65});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(7, 0, 0, 0.4); // 50x50 pixels moet worden 350x20 :: 350/50=7 & 20/50=0.4
		
	/*
	+ folder '> loader - progress'
		|	layer 'progress txt' : with two text fields (...)
		|	layer 'loaderBar_mc'
		|	layer 'loaderProgress_mc'
		|	layer 'loaderSize_mc'
	*/
	// loaderSize_mc
	tl.setSelectedLayers(tl.findLayerIndex("loaderSize_mc")[0], true);
	//tl.addNewLayer('loaderSize_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('01 [mck] Basic/50x50px_mc');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(4.6, 0, 0, 0.1);
		fl.getDocumentDOM().moveSelectionBy({x:50, y:32});
		fl.getDocumentDOM().setInstanceTint('#999999', 100);
		fl.getDocumentDOM().selection[0].name = 'loaderSize_mc';
		
	// loaderProgress_mc
	tl.setSelectedLayers( tl.findLayerIndex("loaderProgress_mc")[0], true);
	// tl.addNewLayer('loaderProgress_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('01 [mck] Basic/50x50px_mc');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(3.6, 0, 0, 0.1);		
		fl.getDocumentDOM().moveSelectionBy({x:50, y:32});
		fl.getDocumentDOM().setInstanceTint('#666666', 100);
		fl.getDocumentDOM().selection[0].name = 'loaderProgress_mc';
			
	// loaderBar_mc	
	tl.setSelectedLayers( tl.findLayerIndex("loaderBar_mc")[0], true);
	// tl.addNewLayer('loaderBar_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('01 [mck] Basic/50x50px_mc');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(2.6, 0, 0, 0.1);		
		fl.getDocumentDOM().moveSelectionBy({x:50, y:32});
		fl.getDocumentDOM().setInstanceTint('#333333', 100);
		fl.getDocumentDOM().selection[0].name = 'loaderBar_mc';
		
	/*
	+ folder 'controlerShape'
		|	layer 'playBtn_mc' 
		|	layer 'pauseBtn_mc'
	*/
	// playBtn_mc		@play
	tl.setSelectedLayers(tl.findLayerIndex("playBtn_mc")[0], true);
	//tl.addNewLayer('playBtn_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('controlerShape');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(.4, 0, 0, .4);	//20/50=2.5
		fl.getDocumentDOM().selection[0].name = 'btn';	
		fl.getDocumentDOM().convertToSymbol('movie clip', 'playBtn_mc', 'top left');	
		fl.getDocumentDOM().selection[0].name = 'playBtn_mc';
		fl.getDocumentDOM().moveSelectionBy({x:25, y:25});	
		fl.getDocumentDOM().enterEditMode('inPlace');
		fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
		fl.getDocumentDOM().getTimeline().setLayerProperty('name', 'btn');
		fl.getDocumentDOM().getTimeline().addNewLayer('play', 'normal' , true);
		// draw a play icon
			fl.getDocumentDOM().addNewLine({x:18, y:16}, {x:18, y:24});
			fl.getDocumentDOM().addNewLine({x:18, y:24}, {x:23, y:20});
			fl.getDocumentDOM().addNewLine({x:23, y:20}, {x:18, y:16});
			fl.getDocumentDOM().setFillColor('#cccccc');
			fl.getDocumentDOM().setSelectionRect({left:-2.4, top:3.4, right:45.0, bottom:34.2}, true, true);
			fl.getDocumentDOM().setStrokeColor('#333333');
			fl.getDocumentDOM().moveSelectionBy({x:-40, y:25});
		// end draw a play icon
		fl.getDocumentDOM().exitEditMode();

	// pauseBtn_mc 		@pause
	tl.setSelectedLayers(tl.findLayerIndex("pauseBtn_mc")[0], true);
	//tl.addNewLayer('playBtn_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('controlerShape');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(.4, 0, 0, .4);	//20/50=2.5
		fl.getDocumentDOM().selection[0].name = 'btn';	
		fl.getDocumentDOM().convertToSymbol('movie clip', 'pauseBtn_mc', 'top left');		
		fl.getDocumentDOM().selection[0].name = 'pauseBtn_mc';	
		fl.getDocumentDOM().moveSelectionBy({x:25, y:25});
		fl.getDocumentDOM().enterEditMode('inPlace');
		fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
		fl.getDocumentDOM().getTimeline().setLayerProperty('name', 'btn');
		fl.getDocumentDOM().getTimeline().addNewLayer('pause', 'normal' , true);
		// draw a pause icon
			fl.getDocumentDOM().addNewRectangle({left:16, top:16, right:19, bottom:24}, 0);
			fl.getDocumentDOM().addNewRectangle({left:21, top:16, right:24, bottom:24}, 0);
			fl.getDocumentDOM().setSelectionRect({left:7.7, top:13.3, right:28.9, bottom:26.6}, true, true);
			fl.getDocumentDOM().setStrokeColor('#33333300');
			fl.getDocumentDOM().setFillColor('#333333');
			fl.getDocumentDOM().setSelectionRect({left:-9.8, top:-1.3, right:49.4, bottom:28.9}, true, true);
			fl.getDocumentDOM().moveSelectionBy({x:-40, y:25});
		// end draw pause icon
		fl.getDocumentDOM().exitEditMode();		
		
	/*
	+ folder '> sound controler'
		|	layer 'soundBtn_mc' 
		|	layer 'pauseBtn_mc'
	*/
	// soundBtn_mc		@sound on
	tl.setSelectedLayers(tl.findLayerIndex("soundBtn_mc")[0], true);
	//tl.addNewLayer('soundBtn_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('controlerShape');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(.4, 0, 0, .4);	//20/50=2.5
		fl.getDocumentDOM().selection[0].name = 'btn';	
		fl.getDocumentDOM().convertToSymbol('movie clip', 'soundBtn_mc', 'top left');	
		fl.getDocumentDOM().selection[0].name = 'soundBtn_mc';
		fl.getDocumentDOM().moveSelectionBy({x:355, y:25});
		fl.getDocumentDOM().enterEditMode('inPlace');
		fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
		fl.getDocumentDOM().getTimeline().setLayerProperty('name', 'btn');
		fl.getDocumentDOM().getTimeline().addNewLayer('sound on', 'normal' , true);
		// draw sound on icon
			fl.getDocumentDOM().addNewRectangle({left:345, top:15, right:350, bottom:20}, 0);
			fl.getDocumentDOM().addNewRectangle({left:347, top:14, right:350, bottom:21}, 0);
			fl.getDocumentDOM().addNewRectangle({left:348, top:13, right:350, bottom:22}, 0);
			fl.getDocumentDOM().addNewRectangle({left:349, top:12, right:350, bottom:23}, 0);
			// first sound wave 
			fl.getDocumentDOM().addNewRectangle({left:351, top:16, right:352, bottom:17}, 0);
			fl.getDocumentDOM().addNewRectangle({left:352, top:17, right:353, bottom:19}, 0);
			fl.getDocumentDOM().addNewRectangle({left:351, top:19, right:352, bottom:20}, 0);
			// second sound wave
			fl.getDocumentDOM().addNewRectangle({left:352, top:14, right:353, bottom:15}, 0);
			fl.getDocumentDOM().addNewRectangle({left:353, top:15, right:354, bottom:16}, 0);
			fl.getDocumentDOM().addNewRectangle({left:354, top:16, right:355, bottom:20}, 0);
			fl.getDocumentDOM().addNewRectangle({left:353, top:20, right:354, bottom:21}, 0);
			fl.getDocumentDOM().addNewRectangle({left:352, top:21, right:353, bottom:22}, 0);
			// third sound wave
			fl.getDocumentDOM().addNewRectangle({left:354, top:13, right:355, bottom:14}, 0);
			fl.getDocumentDOM().addNewRectangle({left:355, top:14, right:356, bottom:15}, 0);
			fl.getDocumentDOM().addNewRectangle({left:356, top:15, right:357, bottom:21}, 0);
			fl.getDocumentDOM().addNewRectangle({left:355, top:21, right:356, bottom:22}, 0);
			fl.getDocumentDOM().addNewRectangle({left:354, top:22, right:355, bottom:23}, 0);
		// end draw sound on icon
		fl.getDocumentDOM().setSelectionRect({left:341.2, top:10.2, right:363.1, bottom:26.4}, true, true);
		fl.getDocumentDOM().setStrokeColor('#33333300');
		fl.getDocumentDOM().setFillColor('#333333');
		fl.getDocumentDOM().selectNone();
		fl.getDocumentDOM().setSelectionRect({left:330, top:5.6, right:387.6, bottom:38.8}, true, true);
		fl.getDocumentDOM().moveSelectionBy({x:-40, y:27});
		fl.getDocumentDOM().exitEditMode();

	// soundOffBtn_mc			@sound off
	tl.setSelectedLayers(tl.findLayerIndex("soundOffBtn_mc")[0], true);
	//tl.addNewLayer('soundOffBtn_mc', 'normal' , true);
		fl.getDocumentDOM().library.selectItem('controlerShape');
		fl.getDocumentDOM().library.addItemToDocument({x:0, y:0});
		fl.getDocumentDOM().setTransformationPoint({x:0, y:0});
		fl.getDocumentDOM().transformSelection(.4, 0, 0, .4);	//20/50=2.5
		fl.getDocumentDOM().selection[0].name = 'btn';	
		fl.getDocumentDOM().convertToSymbol('movie clip', 'soundOffBtn_mc', 'top left');		
		fl.getDocumentDOM().selection[0].name = 'soundOffBtn_mc';	
		fl.getDocumentDOM().moveSelectionBy({x:355, y:25});
		fl.getDocumentDOM().enterEditMode('inPlace');
		fl.getDocumentDOM().getTimeline().setSelectedFrames([]);
		fl.getDocumentDOM().getTimeline().setLayerProperty('name', 'btn');
		fl.getDocumentDOM().getTimeline().addNewLayer('sound off', 'normal' , true);
		// draw sound off icon
			fl.getDocumentDOM().addNewRectangle({left:345, top:15, right:350, bottom:20}, 0);
			fl.getDocumentDOM().addNewRectangle({left:347, top:14, right:350, bottom:21}, 0);
			fl.getDocumentDOM().addNewRectangle({left:348, top:13, right:350, bottom:22}, 0);
			fl.getDocumentDOM().addNewRectangle({left:349, top:12, right:350, bottom:23}, 0);
		// end draw sound off icon
		fl.getDocumentDOM().setSelectionRect({left:341.2, top:10.2, right:363.1, bottom:26.4}, true, true);
		fl.getDocumentDOM().setStrokeColor('#33333300');
		fl.getDocumentDOM().setFillColor('#333333');
		fl.getDocumentDOM().selectNone();
		fl.getDocumentDOM().setSelectionRect({left:330, top:5.6, right:387.6, bottom:38.8}, true, true);
		fl.getDocumentDOM().moveSelectionBy({x:-40, y:27});
		fl.getDocumentDOM().exitEditMode();		
		
	// progress txt
	tl.setSelectedLayers( tl.findLayerIndex("progress txt")[0], true);
	// tl.addNewLayer('loader_txt', 'normal' , true);
		fl.getDocumentDOM().addNewText({left:280, top:2, right:290, bottom:10} );	
		fl.getDocumentDOM().setElementTextAttr('face', '_sans');
		fl.getDocumentDOM().setElementTextAttr('size', 10);	
		fl.getDocumentDOM().setElementTextAttr('letterSpacing', 0.1);
		fl.getDocumentDOM().setElementTextAttr('alignment', 'right');
		fl.getDocumentDOM().setElementProperty('textType', 'dynamic');
		fl.getDocumentDOM().setElementProperty('autoExpand', true);
		fl.getDocumentDOM().setTextString('00:00');
		fl.getDocumentDOM().setTextSelection(0,65535);
		fl.getDocumentDOM().setFillColor('#ffffff');
		fl.getDocumentDOM().selection[0].name = 'currentTime_txt';
		
	// loaderPercentage_txt
	tl.setSelectedLayers( tl.findLayerIndex("progress txt")[0], true);
	// tl.addNewLayer('loaderPercentage_txt', 'normal' , true);
		fl.getDocumentDOM().addNewText({left:290, top:2, right:300, bottom:10} );	
		fl.getDocumentDOM().setElementTextAttr('face', '_sans');
		fl.getDocumentDOM().setElementTextAttr('size', 10);
		fl.getDocumentDOM().setElementTextAttr('letterSpacing', 0.1);
		fl.getDocumentDOM().setElementTextAttr('alignment', 'left');
		fl.getDocumentDOM().setElementProperty('textType', 'dynamic');
		fl.getDocumentDOM().setElementProperty('autoExpand', true);
		fl.getDocumentDOM().setTextString('00:00');
		fl.getDocumentDOM().setTextSelection(0,65535);
		fl.getDocumentDOM().setFillColor('#000000');
		fl.getDocumentDOM().selection[0].name = 'totalTime_txt';

	// stop editing in container
	fl.getDocumentDOM().exitEditMode();
	
	// move container to correct position
	fl.getDocumentDOM().selectNone();
	fl.getDocumentDOM().setSelectionRect({left:-104, top:-1, right:484.9, bottom:106}, true, true);
	fl.getDocumentDOM().moveSelectionBy({x:40, y:-25});

	// clean up the library
	// move 'flvControler_mc' to folder
	fl.getDocumentDOM().library.selectItem('flvControler_mc');
	fl.getDocumentDOM().library.moveToFolder('02 [mck] FLVPlayerLite' , 'flvControler_mc' , true);
	// move 'controlerShape' to folder
	fl.getDocumentDOM().library.selectItem('controlerShape');
	fl.getDocumentDOM().library.moveToFolder('02 [mck] FLVPlayerLite/01 flvControler' , 'controlerShape' , true);
	// move 'pauseBtn_mc' to folder
	fl.getDocumentDOM().library.selectItem('pauseBtn_mc');
	fl.getDocumentDOM().library.moveToFolder('02 [mck] FLVPlayerLite/01 flvControler' , 'pauseBtn_mc' , true);	
	// move 'playBtn_mc' to folder
	fl.getDocumentDOM().library.selectItem('playBtn_mc');
	fl.getDocumentDOM().library.moveToFolder('02 [mck] FLVPlayerLite/01 flvControler' , 'playBtn_mc' , true);	
	// move 'soundBtn_mc' to folder
	fl.getDocumentDOM().library.selectItem('soundBtn_mc');
	fl.getDocumentDOM().library.moveToFolder('02 [mck] FLVPlayerLite/01 flvControler' , 'soundBtn_mc' , true);	
	// move 'soundOffBtn_mc' to folder
	fl.getDocumentDOM().library.selectItem('soundOffBtn_mc');
	fl.getDocumentDOM().library.moveToFolder('02 [mck] FLVPlayerLite/01 flvControler' , 'soundOffBtn_mc' , true);	
	// open folder structuur
	fl.getDocumentDOM().library.selectItem('02 [mck] FLVPlayerLite');
	fl.getDocumentDOM().library.expandFolder(true);
	fl.getDocumentDOM().library.selectItem('02 [mck] FLVPlayerLite/01 flvControler');
	fl.getDocumentDOM().library.expandFolder(true);
	
	// feedback
	fl.trace (':: NOISE setup flvControler_mc - v' + versionString);
}



/**
* create layers in the Library
*/
function setupLibrary ($id){
	if ($id == null){
		$id = '[mck]';
	}
	fl.getDocumentDOM().library.newFolder("01 " + $id + " Basic"); 
	fl.getDocumentDOM().library.newFolder("02 " + $id + " FLVPlayerLite"); 
	fl.getDocumentDOM().library.newFolder("01 flvControler"); 

	// create basic matrials
	// 50x50px_mc / border_mc
	fl.getDocumentDOM().addNewRectangle({left:10, top:10, right:60, bottom:60},0, false, true);
	fl.getDocumentDOM().mouseDblClk({x:25, y:25}, false, false, true);
	fl.getDocumentDOM().setFillColor('#ff0000');
	fl.getDocumentDOM().selectNone();
	// 50x50px_mc
	fl.getDocumentDOM().setSelectionRect({left:0, top:0, right:70, bottom:70}, true, true);
	fl.getDocumentDOM().convertToSymbol('movie clip', '50x50px_mc', 'top left');
	// move into folder
	fl.getDocumentDOM().library.moveToFolder("01 " + $id + " Basic" , '50x50px_mc' , true);
	// expand folder basic
	fl.getDocumentDOM().library.selectItem("01 " + $id + " Basic");
	fl.getDocumentDOM().library.expandFolder(true);

	// clean timeline
	fl.getDocumentDOM().mouseClick({x:38, y:48}, false, true);
	fl.getDocumentDOM().deleteSelection();
	// move into folder
	fl.getDocumentDOM().library.moveToFolder("02 " + $id + " FLVPlayerLite" , '01 flvControler' , true);
	//
	fl.trace (':: setup Library FLVPlayerLite - v' + versionString);
}

createLoaderMC ('as3');



// end jsfl