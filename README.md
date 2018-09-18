# flutter_api_stresstest

Runs a few Flutter APIs in combination with native applications.

- Let a native list view (UITableView / RecyclerView) load a few `FlutterView`s and check the performance.
- video_player plugin testing with files from SD card or iTunes file sharing App

# Native List

![Native List View](https://github.com/ened/flutter_api_stresstest/blob/master/docs/native_list_view.png?raw=true "Native List Liew")

This example, while impractical for the real world, tries to outline performance & threading issues when a lot of flutter views are being instantiated.

The UI pattern on display could be used for a mixed Dashboard (existing native views plus a few Flutter Views).

## Getting Started

To start developing on this project, install Flutter, clone this repo and run this command:

```
$ flutter create -i swift -a kotlin .
```
