## Batsie

An example project using the private BatteryCenter framework, available on iOS and watchOS. BatteryCenter is responsible for the Battery Today Widget on iOS.

On Reddit there were a lot of requests for a watchOS complication that shows the battery percentages of all connected devices, similar to the Battery Today Widget on iOS.
The problem with existing apps, is that the iPhone battery percentage must be obtained from the iOS device (using UIDevice API). Due to the app not being open all the time, the required communication is not dependable.
I was interested in whether this framework would be able to get the battery percentage of the iPhone, directly from the Watch. This project demonstrates that only the local Watch information is available.
