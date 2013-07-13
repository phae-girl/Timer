Timer
=====

Just a simple little timer app to remind me to check the stove while I'm coding. 
Requires OS X 10.8 (Mountain Lion)


![Timer Screenshot](http://veganswithtypewriters.net/img/TimerApp.png)

If you're interested in downloading a prebuilt binary to play with, you can find one [here][2]. <s>Please be aware that it isn't code signed, but if you're here on GitHub, that shouldn't be an issue for you.</s> If you have any questions or comments, please feel free to contact me here, or drop me an email at <phae@veganswithtypewriters.com>

##Release Notes

###V0.7.6
2013-07-13
- No new features, but a lot of refactoring under the hood. Code having to do with user notification interaction has been broken out into its own class, as well as code having to do with time remaining on a timer. There have been some other minor changes as well, such as changing a method to use `[array enumerateObjectsUsingBlock:...]` thanks to [this article][hipster] by NSHipster. I also added a class to set the keys for interacting with `NSUserDefaults` as global variables, a technique directly ripped off from Aaron Hillegass' book [Cocoa Programming for Mac OS X][hillegass]. Finally there was another general tidy-up of the code base. I think this is actually starting to look like something. 

[hipster]: http://nshipster.com/enumerators/ (NSFastEnumeration / NSEnumerator / -enumerateObjectsUsingBlock: : NSHipster)
[hillegass]: http://www.amazon.ca/Cocoa-Programming-Mac-4th-Edition/dp/0321774086 (Cocoa Programming for Mac OS X (4th Edition): Amazon.ca: Aaron Hillegass, Adam Preble: Books)

###V0.7.5
2013-07-01
- Code signed app. Yay!

###V0.7.4
2013-06-24
- Added the ability to set custom timer durations for each button in the preferences sheet.

###V0.7.3
2013-06-22
- Moved controls to select sound and repeat timer to preferences sheet.
- Changed timer countdown logic to something more reasonable.
- Changed timer class to accept arbitrary hours, minutes and seconds. 

###V0.7.1
2013-06-17

####Features Added
- Added option to speak alert.
- Added a plist file to tweak options while developing. Thanks to Brent Simmons for that idea. 


###V0.7
June 16, 2013

####Features Added
- Added a preference panel and hooked up the ability to trun notifications on and off as well as set custom notification messages.

####Bug Fixes
- Fixed a bug that would prevent the timer from stopping if the repeats checkbox was unchecked after the timer as started.

###V0.6
2013-06-15
Thanks to a little luck, I found a decent looking icon at, of all places, Wikipedia. It was made for Wikimedia Commons by [TeeKay][1] and licensed under a Creative Commons Attribution-ShareAlike 2.5 Generic License.

###V0.5
2013-06-15

Did a little bit of code tidy-up and added some UI improvements. Control buttons (Pause, Resume, Cancel) now toggle on and off in response to timer state. For example, the Resume button is disabled when the timer is running. Also added a checkbox to allow timers to repeat.

[1]: http://en.wikipedia.org/wiki/User:Tkgd2007 (User:Tkgd2007 - Wikipedia, the free encyclopedia)
[2]: http://veganswithtypewriters.net/apps/Timer.app.zip (Vegans With Typewriters)