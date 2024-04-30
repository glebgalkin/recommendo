# Recommendo

A mobile client for recomendo project. Suppoused to run on iOS and Android.

---

## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the app in any flavors there are 3 variables that has to be provided by --dart-define.

FIREBASE_OPTIONS -- firebase configuration as json string

MAPS_API_KEY -- google maps api key

BACKEND_BASE_URL -- base url to backend server


```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart --dart-define FIREBASE_OPTIONS=YOUR_FIREBASE_CONFIG --dart-define MAPS_API_KEY=YOUR_MAPS_API_KEY --dart-define BACKEND_BASE_URL=YOUR_BACKEND_URL

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart --dart-define FIREBASE_OPTIONS=YOUR_FIREBASE_CONFIG --dart-define MAPS_API_KEY=YOUR_MAPS_API_KEY --dart-define BACKEND_BASE_URL=YOUR_BACKEND_URL

# Production
$ flutter run --flavor production --target lib/main_production.dart --dart-define FIREBASE_OPTIONS=YOUR_FIREBASE_CONFIG --dart-define MAPS_API_KEY=YOUR_MAPS_API_KEY --dart-define BACKEND_BASE_URL=YOUR_BACKEND_URL
```

FIREBASE_OPTIONS

MAPS_API_KEY

BACKEND_BASE_URL

_\*Recommendo works on iOS, Android._

--
