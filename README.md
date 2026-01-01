# 🌙 DreamCatcher

Ein modernes, privates und performantes Traumtagebuch, entwickelt mit **Flutter** und **Isar DB**.
Diese App ermöglicht es Nutzern, ihre Träume schnell zu erfassen, zu bewerten und zu analysieren. Der Fokus liegt auf Privatsphäre (Offline-First), Performance und einem angenehmen Dark-Mode-Design.

## ✨ Features (MVP)

* **Traum-Erfassung:** Titel, Inhalt, Datum, Klarheit (1-5 Sterne) und Tags.
* **Persistenz:** Lokale Speicherung mittels **Isar DB**.
* **CRUD-Operationen:** Vollständiges Erstellen, Lesen, Bearbeiten und Löschen von Einträgen.
* **Smart UI:** Swipe-to-Delete mit Undo-Funktion und reaktive Listen-Updates via Streams.
* **Design:** Optimierter Dark Mode für die Nutzung in der Nacht.

## 🛠 Technologie-Stack

* **Framework:** Flutter
* **Datenbank:** [Isar Database](https://isar.dev/)
* **Code Generation:** Build Runner für typsichere Datenbankabfragen.

## 🚀 Installation & Setup

Um das Projekt lokal auszuführen, folge diesen Schritten:

1.  **Abhängigkeiten installieren:**
    Stelle sicher, dass alle Pakete aus der `pubspec.yaml` geladen sind:
    ```bash
    flutter pub get
    ```

2.  **Datenbank-Modelle generieren:**
    Da Isar Code-Generierung nutzt, um die `dream.g.dart` Dateien zu erstellen, musst du den Build-Runner einmalig (oder bei Änderungen am Model) ausführen:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
    *Tipp: Nutze `watch`, damit der Generator im Hintergrund aktiv bleibt:*
    ```bash
    flutter pub run build_runner watch
    ```

3.  **App starten:**
    Stelle sicher, dass ein Emulator oder ein physisches Gerät angeschlossen ist:
    ```bash
    flutter run
    ```

## 🔮 Roadmap

* [ ] **Volltextsuche:** Schnelles Finden von Trauminhalten.
* [ ] **Aktualisierung des Designs:** Optische Anpassung der Anwendung.
* [ ] **Kategorisierung:** Filtern nach Traum-Typen (z.B. Luzid, Albtraum).
* [ ] **Statistiken:** Visualisierung der Traumfrequenz und Klarheit.

---
*Entwickelt als Flutter Showcase Projekt.*