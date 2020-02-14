# Ahgora API

Unofficial Dart API for Ahgora.

## About

This is a Dart (Flutter compatible) project.

## Usage

To use this library, add `ahgora_api` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example
``` dart
import 'package:ahgora_api/ahgora_api.dart';

Ahgora ahgora;

void main() {
  ahgora = Ahgora();
  ahgora.login('COMPANY_ID', 9999, 'USER_PASSWORD')
        .then(_loginCallback);
}

void _loginCallback() {
  if (result) {
    print('Login succeeded!');
    ahgora
      .getMonthlyReport(DateTime.now(), fiscalMonth: false)
      .then(_monthlyReportCallback);
  } else {
    print('Login failed!');
  }
}

void _monthlyReportCallback(MonthlyReport report) {
  print('Employee name: ${report.employee.name}');
  print('First day from this month: ${report.days.first.reference}');
}
```

