<!-- Copilot / AI agent instructions for quickshell-config (updated 2025-10-13) -->

This repo is a focused Quickshell configuration using QML. The project structure is intentionally small and runtime-driven. The long-term goal is to build a Waybar-style status bar (workspaces, tray, clock, controls) using QML components and Quickshell APIs.

Project layout (current)
- `shell.qml` — root entrypoint (keeps global instantiation minimal).
- `assets/` — static assets (icons, images).
- `modules/` — reusable UI components (per-component `.qml` files).
- `services/` — singletons and shared providers (clock, system state, helpers).
- `scripts/` — helper scripts invoked by quickshell or components (e.g., for controlling volume/media).

Key patterns and actionable rules
- Use `Scope { }` for top-level isolation in components (seen in `shell.qml` and `Bar.qml`).
- Use `Variants { model: Quickshell.screens }` to create one `PanelWindow` per screen — keep per-screen layout inside that Variant.
- Prefer small, single-responsibility components in `modules/` (e.g. `modules/ClockWidget.qml`). Keep presentation logic there and state in `services/`.
- Shared/global logic should live in `services/` as `pragma Singleton` QML files (the existing `Time.qml` is the pattern to follow).

How to instantiate modules and services (practical options)
- Simple approach: keep component QML files in the same directory as the importer and instantiate by name: `ClockWidget { }`.
- If components are in `modules/` and not found by name, either:
  - Add a `qmldir` to register `modules/` as a QML module (recommended for many components), or
  - Load lazily with `Loader { source: "modules/ClockWidget.qml" }` for one-off or dynamic usage.
- Singletons: keep `pragma Singleton` in the service QML (e.g. `services/Time.qml`). To use a singleton globally either register the `services/` directory via `qmldir` or import/load the file explicitly where needed (e.g. `Text { text: Time.time }` once the singleton is discoverable).

Developer workflow and runtime
- No build step: edit QML files and reload Quickshell to see changes.
- Keep changes small and test in a running Quickshell session. The runtime provides `Quickshell.*` APIs and Wayland integration — do not try to polyfill those in code.

Examples and quick edits
- Add a right-side status dot inside your panel `RowLayout`:
  Rectangle { width: 8; height: 8; color: "red"; radius: 4 }
- Small service example (already present): `Time.qml` uses `pragma Singleton` and `SystemClock` to expose `time`.

Inspiration & docs
- User inspirations: `https://github.com/caelestia-dots/shell` and `https://github.com/end-4/dots-hyprland` (see `.config/quickshell/` patterns there).
- QML/Qt references:
  - QtQuick: https://doc.qt.io/qt-6/qtquick-index.html
  - QtQML: https://doc.qt.io/qt-6/qtqml-index.html

Files to inspect when changing behavior
- `modules/` — UI components (add or adjust layout/style here).
- `services/` — singletons and providers (clock, system state).
- `scripts/` — external scripts called by components.
- `shell.qml` — global entrypoint; add `GlobalStates.qml` here in future as needed.

What to avoid
- Don’t attempt to add or import external JS/Qt modules that the Quickshell runtime already provides. Prefer using `Loader`/`qmldir` patterns for local modules.

If something is unclear
- Tell me which area to expand: component registration (`qmldir`), singleton loading, example modules (workspaces/tray), or a short developer quickstart (reload steps and testing tips). I can add concrete code snippets per your preference.
