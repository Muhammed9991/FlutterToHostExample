import 'package:pigeons_demo/app/app.bottomsheets.dart';
import 'package:pigeons_demo/app/app.dialogs.dart';
import 'package:pigeons_demo/app/app.locator.dart';
import 'package:pigeons_demo/src/messages.g.dart';
import 'package:pigeons_demo/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _exampleHostApi = ExampleHostApi();

  String get counterLabel => 'Counter is: $_counter';

  int _counter = 0;

  void incrementCounter() {
    _counter++;
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
      description: 'Give stacked $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    MessageData messageData = MessageData(
      code: Code.one,
      data: {'name': 'From flutter', 'description': 'becuase its cool!'},
    );
    _exampleHostApi.sendMessage(messageData);
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }
}
