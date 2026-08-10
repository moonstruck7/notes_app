# 📝 Notes App

A simple, offline-first note-taking app built with Flutter. Create, edit,
and delete notes that persist locally on your device using
`SharedPreferences` — no backend, no internet connection required.

---

## Features

- ➕ **Add notes** with a title and content
- ✏️ **Edit notes** — same form as Add, pre-filled with existing data
- 🗑️ **Delete notes** via swipe-to-dismiss or a delete icon, with a
  confirmation dialog
- 📋 **View all notes** in a scrollable list, sorted by most recently
  updated
- 💾 **Persistent local storage** — notes survive app restarts
- ✅ **Form validation** — title and content can't be saved empty
- 🔄 **Pull-to-refresh** on the notes list
- 📭 **Empty state** UI when no notes exist yet

---

## Tech Stack

| Component        | Details                              |
|-------------------|---------------------------------------|
| Framework          | Flutter                              |
| Language           | Dart                                  |
| Local storage      | `shared_preferences` package          |
| Data format        | JSON (encoded/decoded via `dart:convert`) |
| State management   | `StatefulWidget` + `setState`         |

---

## Project Structure

```
lib/
├── main.dart                       # App entry point
├── models/
│   └── note.dart                   # Note data class (toJson/fromJson)
├── services/
│   └── notes_storage.dart          # SharedPreferences CRUD operations
└── screens/
    ├── notes_home_page.dart        # Displays all notes, handles delete
    └── add_edit_note_page.dart     # Shared form for adding and editing
```

---

## How It Works

Notes are stored as a single JSON-encoded string under one
`SharedPreferences` key (`notes_list`). Since `SharedPreferences` has no
built-in support for updating a single item in a list, every write
operation follows the same pattern:

1. Read the full list of notes from storage
2. Modify it in memory (add / replace / remove one note)
3. Re-encode the whole list and write it back

Each note has a unique `id` (generated from a timestamp) that's used to
find and update or delete the correct note in that list.

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- An emulator or physical device to run the app

### Installation

1. Clone or download this project
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

### Dependencies

Add this to `pubspec.yaml` if not already present:

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
```

---

## Usage

- Tap **Add Note** (floating action button) to create a new note
- Tap any note in the list to open and edit it
- Swipe a note left, or tap its delete icon, to remove it (with
  confirmation)
- Pull down on the list to refresh

---

## Possible Improvements

- Search/filter notes by title or content
- Sort toggle (created date vs. last updated)
- Categories or tags for notes
- Migrate to `sqflite` for better performance at large note counts
- Rich text or checklist-style notes
- Dark mode support

---

## License

This project was built for learning purposes as part of a Flutter
development internship.
