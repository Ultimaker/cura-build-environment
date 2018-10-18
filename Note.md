Build on Mac OS X for 10.9
==========================

**References:**
 - https://www.felix-schwarz.org/blog/2016/03/how-to-use-the-os-x-109-sdk-with-xcode-73

If you install Xcode 7.3, it only ships with OS X 10.11 SDK, and this unfortunately causes problems when you want to
compile code targeting an earlier OS X version, such as 10.9. To fix this, I did what's described in the reference
page linked above. The steps are:
 - Quit Xcode 7.3
 - Get Xcode 6.4 which contains SDKs for OS X 10.9 and 10.10. It's probably going to be an
   [Xcode_6.4.dmg](https://developer.apple.com/devcenter/download.action?path=/Developer_Tools/Xcode_6.4/Xcode_6.4.dmg)
 - Mount the DMG using `hdiutil` probably to /Volumes/Xcode
 - The SDKs are located in `Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/`
     - `MacOSX10.9.sdk`
     - `MacOSX10.10.sdk`
 - Copy the required SDKs to `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/`
 - Open file `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Info.plist`
   and remove the following lines:
   ```
   <key>MinimumSDKVersion</key>
   <string>10.11</string>
   ```
