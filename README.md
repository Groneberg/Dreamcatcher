# 🌙 DreamCatcher

Ein modernes, privates und performantes Traumtagebuch, entwickelt mit **Flutter** und **Isar DB**.
Diese App ermöglicht es Nutzern, ihre Träume schnell zu erfassen, zu bewerten und zu analysieren. Der Fokus liegt auf Privatsphäre (Offline-First), Performance und einem angenehmen Dark-Mode-Design.

## 🧘 Design-Philosophie: "Der stille Begleiter"

Die Entwicklung folgt strikten Prinzipien, um den Nutzer im Moment des Erwachens und der Reflexion optimal zu unterstützen:

* **Reizarmut:** Das "Midnight Theme" nutzt gedämpfte Farben, um die morgendliche Lichtempfindlichkeit zu respektieren. Keine grellen Animationen, kein visueller Lärm.
* **Anti-Gamification:** Verzicht auf "Streaks", Leistungsdruck oder Belohnungssysteme. Pausen im Tagebuch sind Teil des Prozesses und kein Versagen.
* **Neutralität statt Interpretation:** Die App bietet keine vorgefertigten Traumdeutungen. Sie dient als neutraler Spiegel, der Muster aufzeigt, die Deutungshoheit aber vollständig beim Nutzer belässt.
* **Geschwindigkeit vor Komplexität:** Jede Sekunde zählt, bevor ein Traum verblasst. Das Interface ist auf schnellstmögliche Erfassung optimiert.

## ✨ Features (MVP)

* **Traum-Erfassung:** Titel, Inhalt, Datum, Klarheit (1-5 Sterne) und Tags.
* **Persistenz:** Lokale Speicherung mittels **Isar DB**.
* **CRUD-Operationen:** Vollständiges Erstellen, Lesen, Bearbeiten und Löschen von Einträgen.
* **Smart UI:** Swipe-to-Delete mit Undo-Funktion und reaktive Listen-Updates via Streams.
* **Design:** Optimierter Dark Mode ("Midnight Theme") für die Nutzung in der Nacht.

## 🎨 Design & Farben

Die Anwendung nutzt eine harmonische Farbpalette, um eine beruhigende, nächtliche Atmosphäre zu schaffen:
* **Navy Blue** (`#0A1128`): Die Basis des Nachthimmels (Hintergrund).
* **Deep Purple** (`#1B1464`): Tiefe und Struktur (Karten & Buttons).
* **Lavender** (`#E0B0FF`): Sanfter Kontrast für Texte und primäre Icons.
* **Burnished Gold** (`#D4AF37`): Highlights für wichtige Aktionen und Bewertungen.
* **Sterling Silver** (`#C0C0C0`): Dezentere Akzente und sekundäre Informationen.

## 🛠 Technologie-Stack

* **Framework:** Flutter
* **Datenbank:** [Isar Database](https://isar.dev/)
* **Code Generation:** Build Runner für typsichere Datenbankabfragen.

## 🚀 Installation & Setup

1.  **Abhängigkeiten installieren:**
    ```bash
    flutter pub get
    ```

2.  **Datenbank-Modelle generieren:**
    Da Isar Code-Generierung nutzt, muss der Build-Runner ausgeführt werden:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **App starten:**
    ```bash
    flutter run
    ```

## 🔮 Roadmap

* [ ] **Volltextsuche:** Schnelles Finden von Trauminhalten (Aktueller Fokus).
* [ ] **Schnelleintragung:** Schnelles Eintragen von Träumen direckt nach dem Öffnen der Anwendung
* [ ] **Smart Filter:** Filtern nach Klarheit, Stimmung oder spezifischen Zeiträumen.
* [ ] **Kategorisierung:** Filtern nach Traum-Typen (z.B. Luzid, Albtraum).
* [ ] **Designs in Figma:** Finalisierung der UI-Komponenten und Widgets.
* [ ] **Aktualisierung des Designs:** Fortlaufende optische Anpassung der Anwendung.
* [ ] **Designs in Figma:** Ausarbeitung von Komponenten und Widgets für ein konsistentes UI/UX.
* [ ] **Statistiken:** Visualisierung der Traumfrequenz und Klarheit.

---
*Entwickelt als Flutter Showcase Projekt.*