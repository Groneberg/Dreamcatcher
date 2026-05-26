# 🌙 DreamCatcher

[English](#english) | [Deutsch](#deutsch)

---

## English

A modern, private and performant dream journal, developed with **Flutter** and **ObjectBox**.  
This app allows users to quickly capture, rate and analyze their dreams. The focus is on privacy (offline-first), performance and a pleasant dark-mode design.

## 🧘 Design Philosophy: "The Silent Companion"

The development follows strict principles to optimally support the user in the moment of awakening and reflection:

* **Low Sensory Input:** The "Midnight Theme" uses muted colors to respect morning light sensitivity. No bright animations, no visual noise.
* **Anti-Gamification:** No "streaks", performance pressure or reward systems. Pauses in the journal are part of the process and not a failure.
* **Neutrality instead of Interpretation:** The app offers no pre-made dream interpretations. It serves as a neutral mirror that shows patterns but leaves the sovereignty of interpretation entirely to the user.
* **Speed before Complexity:** Every second counts before a dream fades. The interface is optimized for the fastest possible capture.

## ✨ Features (MVP)

* **Dream Capture:** Title, content, date, clarity (1-5 stars) and tags.
* **Persistence:** Local storage using **ObjectBox**.
* **CRUD Operations:** Complete creating, reading, editing and deleting of entries.
* **Smart UI:** Swipe-to-delete with undo function and reactive list updates via streams.
* **Design:** Optimized Dark Mode ("Midnight Theme") for use at night.

## 🎨 Design & Colors

The application uses a harmonious color palette to create a calming, nocturnal atmosphere:
* **Navy Blue** (`#0A1128`): The base of the night sky (background).
* **Deep Purple** (`#1B1464`): Depth and structure (cards & buttons).
* **Lavender** (`#E0B0FF`): Soft contrast for texts and primary icons.
* **Burnished Gold** (`#D4AF37`): Highlights for important actions and ratings.
* **Sterling Silver** (`#C0C0C0`): Subtle accents and secondary information.

## 🛠 Technology Stack

* **Framework:** Flutter
* **Database:** [ObjectBox](https://objectbox.io/)
* **Code Generation:** Build Runner for type-safe database queries.

## 🚀 Installation & Setup

1.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

2.  **Generate database models:**
    ObjectBox requires generated code to map your objects to the database:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **Start the app:**
    ```bash
    flutter run
    ```

## 🔮 Roadmap

* [x] **Quick Entry:** Fast entry of dreams immediately after opening the application.
* [ ] **Full Text Search:** Quickly find dream content (current focus).
* [ ] **Smart Filter:** Filter by clarity, mood or specific periods.
* [ ] **Categorization:** Filter by dream types (e.g., lucid, nightmare).
* [ ] **Designs in Figma:** Finalization of UI components and widgets.
* [ ] **Updating the Design:** Continuous visual adaptation of the application.
* [ ] **Statistics:** Visualization of dream frequency and clarity.

---
*Developed as a Flutter Showcase Project.*

---

# 🌙 DreamCatcher

## Deutsch

Ein modernes, privates und performantes Traumtagebuch, entwickelt mit **Flutter** und **ObjectBox**.
Diese App ermöglicht es Nutzern, ihre Träume schnell zu erfassen, zu bewerten und zu analysieren. Der Fokus liegt auf Privatsphäre (Offline-First), Performance und einem angenehmen Dark-Mode-Design.

## 🧘 Design-Philosophie: "Der stille Begleiter"

Die Entwicklung folgt strikten Prinzipien, um den Nutzer im Moment des Erwachens und der Reflexion optimal zu unterstützen:

* **Reizarmut:** Das "Midnight Theme" nutzt gedämpfte Farben, um die morgendliche Lichtempfindlichkeit zu respektieren. Keine grellen Animationen, kein visueller Lärm.
* **Anti-Gamification:** Verzicht auf "Streaks", Leistungsdruck oder Belohnungssysteme. Pausen im Tagebuch sind Teil des Prozesses und kein Versagen.
* **Neutralität statt Interpretation:** Die App bietet keine vorgefertigten Traumdeutungen. Sie dient als neutraler Spiegel, der Muster aufzeigt, die Deutungshoheit aber vollständig beim Nutzer belässt.
* **Geschwindigkeit vor Komplexität:** Jede Sekunde zählt, bevor ein Traum verblasst. Das Interface ist auf schnellstmögliche Erfassung optimiert.

## ✨ Features (MVP)

* **Traum-Erfassung:** Titel, Inhalt, Datum, Klarheit (1-5 Sterne) und Tags.
* **Persistenz:** Lokale Speicherung mittels **ObjectBox**.
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
* **Datenbank:** [ObjectBox](https://objectbox.io/)
* **Code Generation:** Build Runner für typsichere Datenbankabfragen.

## 🚀 Installation & Setup

1.  **Abhängigkeiten installieren:**
    ```bash
    flutter pub get
    ```

2.  **Datenbank-Modelle generieren:**
    ObjectBox benötigt generierten Code für die Datenbank-Modelle. Führe dazu den Build-Runner aus:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

3.  **App starten:**
    ```bash
    flutter run
    ```

## 🔮 Roadmap

* [x] **Schnelleintragung:** Schnelles Eintragen von Träumen direkt nach dem Öffnen der Anwendung.
* [ ] **Volltextsuche:** Schnelles Finden von Trauminhalten (Aktueller Fokus).
* [ ] **Smart Filter:** Filtern nach Klarheit, Stimmung oder spezifischen Zeiträumen.
* [ ] **Kategorisierung:** Filtern nach Traum-Typen (z.B. Luzid, Albtraum).
* [ ] **Designs in Figma:** Finalisierung der UI-Komponenten und Widgets.
* [ ] **Aktualisierung des Designs:** Fortlaufende optische Anpassung der Anwendung.
* [ ] **Statistiken:** Visualisierung der Traumfrequenz und Klarheit.

---
*Entwickelt als Flutter Showcase Projekt.*