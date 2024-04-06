import 'package:device_preview/device_preview.dart';
import 'package:recommendo/app/app.dart';
import 'package:recommendo/bootstrap.dart';

void main() {
  bootstrap(() => DevicePreview(builder: (_) => const App()));
}
