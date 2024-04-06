import 'package:device_preview/device_preview.dart';
import 'package:minimal_advertisment/app/app.dart';
import 'package:minimal_advertisment/bootstrap.dart';

void main() {
  bootstrap(() => DevicePreview(builder: (_) => const App()));
}
