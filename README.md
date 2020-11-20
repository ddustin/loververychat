Lovevery Chat App
Design Document

The Lovevery Chat App is a simple application for helping trusted people communicate with each other. It has roughly three pieces of functionality

* View all chat messages
* View a specific user’s chat message
* Submit a new chat message

The app is setup using two pages. The first page downloads and displays all chat messages. The second page is used for submitting chat messages. Server API calls are handled through a singleton called Messages — this singleton is responsible for maintaining compatibility with the API.

In order to view a specific user’s chat message, we have a special flag on the first page. This flag, if present, specifies which user messages should be shown. In this case — the first page renders the same but adjust’s it’s server request to only download that user’s particular messages. This trade-off allows for simple, less duplicate code.

Testing

Testing is handled by automated user interface testing. This is code that automates the opening of the app, tapping buttons, and entering content. This style of testing most closely simulates the actual user experience, while also rigorously using the underlying methods and APIs required for the app’s functioning. This style comes with a number of benefits:

* Thoroughness
  * By implementing UI based testing we test the user experience, underlying modules/SDKs, and the server itself.
* Closeness to user
  * Too often we implement tests that demonstrate an underlying item works whilst forgetting about the user. This is often revealed by login screen errors — some of the most overlooked errors by testers… because they are already logged in! By simulating an actual user experience from head to toe, we can be assured no users are left with an unpleasant experience.

There is, however, a downside to this style of testing. It will definitely catch any faults in the app. It will not, however, be very specific about the fault.

Failures are not specific

This downside means more wasted developer time. This is why it is best to supplement UI testing with additional traditional testing. These traditional tests are best placed around particularly complex logic. Every time a module can be “black boxed” — it usually should get some simple tests made around it.  Striking the correct balance of enough tests and too many tests is always a challenge. I believe adding UI tests allows you to feel safer with less traditional tests as all you are risking is developer time — *not* customer experience.
