#!/usr/bin/env bash
set -euo pipefail

# Install a stable Flutter SDK locally if not already present
FLUTTER_DIR="$PWD/.flutter"
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Downloading Flutter SDK..."
  # Using Flutter 3.38.5 stable release (includes Dart SDK 3.10.4, compatible with SDK ^3.9.2)
  wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.38.5-stable.tar.xz -O flutter.tar.xz
  mkdir -p "$FLUTTER_DIR"
  tar -xf flutter.tar.xz -C "$FLUTTER_DIR" --strip-components=1
  rm flutter.tar.xz
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter --version
flutter precache
flutter pub get

# Run the web build with the TMDB API token
flutter build web --dart-define=TMDB_API_TOKEN="$TMDB_API_TOKEN"
