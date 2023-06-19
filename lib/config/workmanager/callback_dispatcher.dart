import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey = 'com.maxalva.miscelaneos.fetchBackgroundTask';
const fetchPeriodicBackgroundTaskKey =
    'com.maxalva.miscelaneos.fetchPeriodicBackgroundTask';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case fetchBackgroundTaskKey:
        print('fetchBackgroundTaskKey');
        break;
      case fetchPeriodicBackgroundTaskKey:
        print('fetchPeriodicBackgroundTaskKey');
        break;
      case Workmanager.iOSBackgroundTask:
        print('iOSBackgroundTask');
    }

    return Future.value(true);
  });
}
