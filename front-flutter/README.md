# csm_front

A new Flutter project.

# Architecture

I would like to use kinda of a simple clean architecture.
I will use MVVM as a presentation layer, and I will use a service pattern to abstract the data layer.
I will not use usecases
My folder structure will be like this:

```
lib
├───core
│   ├───constants
│   └───routes
├───data
│   ├───datasources
│   ├───models
│   └───services
├───ui
│   ├───widgets
│   ├───pages
│   │   └───[pagename]
│   │       ├───[pagename]_controller.dart
│   │       └───[pagename]_view.dart
│   └───themes
└───utils
```
