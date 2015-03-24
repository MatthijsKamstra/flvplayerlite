# FLVPlayerLite #

A simple and lightweight FLV Player.

![http://flvplayerlite.googlecode.com/files/flvplayerlite_00.jpg](http://flvplayerlite.googlecode.com/files/flvplayerlite_00.jpg)

## New ##

A easy way to create a FLVPlayerLite Controler with one click:
http://code.google.com/p/flvplayerlite/wiki/FLVPlayerLiteControler

An command for Flash that will build a controler for you.

## Description ##

FLV video is the native video format for Flash, and because of that probably the most use video format on the internet ([YouTube](http://www.youtube.com/), [Google Video](http://video.google.nl/)).

This FLV Player doesn't have all the features that you have when you use a Flash component, but the basics: play, pause, mute.
In the nearby future it will also have a playback bar, loading progress and a dragable seek button (). It is the basics that I use, and there for this FLV player will be lite.

## Lite ##

I love the lite versions, because you can use in big OOP projects, but also in small (banners) project. My favorite lite class is [tweenlite (AS3)](http://blog.greensock.com/tweenliteas3/) or [AS2](http://blog.greensock.com/tweenliteas2/).
Frequent Tweenlite users will recognize the syntax.

So what is the difference between the Flash component and FLVPlayerLite?
Besides the restrictions I mentioned before (basic features) the SWF will be much "liter"

**Flash component:** 52,0 KB _(53.248 bytes)_ -- VS -- **FLVPlayerLite:** 4,00 KB _(4.096 bytes)_

<sup>I used the FLVPlayback without any extra code or library items, the only thing I changed was the parameter for the source</sup>


## Usage ##

```
import nl.matthijskamstra.media.FLVPlayerLite; // import
var __FLVPlayerLite:FLVPlayerLite = new FLVPlayerLite ( this.flvContainer_mc , 'media/exampleMovie.flv' );
```

visit CodeExamples for more usage examples.

## Todo ##

visit ToDo wiki page...


## Why? ##

I was working on a project with different FLV files and the standard FLV Player component
from the Flash IDE gave me headaches...
The FLV Playback component seem to work fine if it is the only player on stage...

Oke, I know, I know, there is always a developer that wants to create there own component or class, and I'm no difference.

But before I started to programming, I looked for one that was already there.
I found one: http://durej.com/?p=80
This is classes where written in AS2 and I needed AS3.

And this project is the rewrite and improvement of that class.

(and I wanted to use google code, and test the **[Release early, release often](http://www.google.com/search?q=release%20early%20release%20often)** approach that is the 'slogan' of Google code)