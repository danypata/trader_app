# trader_app

Exinity interview app

## Before running the app

The freezed and json generated code is not commited to github so first run:
`dart run build_runner build --delete-conflicting-outputs && flutter pub get`

to generate everything and have the localizations in place.

For running the project you have to provide the: `--dart-define-from-file=dev.json` arguments.

Normally, the dev.json file would not be commited and it would only be available on
local machine, but to reduce the setup time I decided to add it to github.

