# TestKarma

Notes:

- Architecture: The architecture is MVVM + Coordinators. The coordinators handle the navigation of the app. The parent coordinator is the App Coordinator. The rest, every coordinator handles a navigation flow in the app. Like, there is only one view, right now it's not possible to show this feature.

- Unit test: I have added unit tests to the Network/Service handle part of the app: Network Manager, Local Manager and Local model. Like the implementation was a bit slow, I dediced to do not add more unit tests. There are part of the implementation where they should be added, like: Coordinators, View Models and View Controllers (Snapshot tests).

- Service Error handling: The API doesn't provide response errors. So, I implemented some basic ones. If these errors are common for all the services, they could be handle in the Network layer.

- Persist the following state in memory: I persist the state in memory but, everytime that the user opens the app, I request the data from the backend. The state doesn't persist in the disk. 
