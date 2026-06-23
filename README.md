# coconews

coconews is a Flutter news app that pulls live headlines from the [GNews API](https://gnews.io/) and lets you browse, filter, and save stories. It fetches top headlines across categories (General, World, Nation, Business, Technology, Entertainment, Sports, Science, Health), caches them locally for fast reloads, and lets you bookmark articles to read later — all wrapped in a dark/light themeable UI.

## Tech Stack

**Framework:** Flutter (Dart, SDK ^3.10.3)

**API Integration:** [GNews API](https://gnews.io/) — top headlines endpoint, fetched via `dio`, filtered by category/country/language

**Packages:**

- `get` — state management, routing, dependency injection (GetX)
- `dio` — HTTP networking / API integration
- `json_annotation` / `json_serializable` — JSON model serialization
- `cached_network_image` — image loading & caching
- `url_launcher` — opening articles in an in-app browser
- `intl` — date/number formatting, localization
- `connectivity_plus` — network connectivity checks
- `get_storage` — local caching & bookmark persistence
- `flutter_native_splash` — native splash screen
- `change_app_package_name` — package name management
