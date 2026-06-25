# 🌙 DreamCatcher

[![Flutter Version](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Database: ObjectBox](https://img.shields.io/badge/Database-ObjectBox-%23005A9C.svg?style=for-the-badge)](https://objectbox.io/)
[![Platform: Mobile](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

### Language Selection / Sprachauswahl
🌐 **[English Version](#english)** | 🌐 **[Deutsche Version](#deutsch)**

---

## English

A modern, private, and performant dream journal developed with **Flutter** and **ObjectBox**. This app allows users to quickly capture, rate, and analyze their dreams. The entire ecosystem is designed with an offline-first architecture to guarantee absolute data sovereignty and privacy.

### 📌 Table of Contents
1. [🧘 Design Philosophy](#-design-philosophy-the-silent-companion)
2. [✨ Features (MVP)](#-features-mvp)
3. [🎨 UI Design & Color Palette](#-ui-design--color-palette)
4. [🛠️ Tech Stack](#%EF%B8%8F-tech-stack)
5. [🚀 Installation & Setup](#-installation--setup)
6. [🔧 Troubleshooting](#-troubleshooting)
7. [🔮 Roadmap](#-roadmap)

---

### 🧘 Design Philosophy: "The Silent Companion"

The development follows strict psychological and practical principles to optimally support users in the fragile moment of awakening:

* **Low Sensory Input:** The "Midnight Theme" uses carefully muted colors to respect morning light sensitivity without visual noise.
* **Anti-Gamification:** No artificial "streaks", performance pressure, or gamified rewards. Pauses in journaling are a natural part of the reflection process.
* **Neutrality instead of Interpretation:** No automated, pre-made interpretations. The app acts as a neutral mirror to show patterns while leaving absolute sovereignty of interpretation to the user.
* **Speed before Complexity:** Every single second counts before a dream memory fades. The user interface is heavily optimized for immediate, friction-free capture.

---

### ✨ Features (MVP)

* **Seamless Dream Capture:** Save titles, contents, dates, emotional tags, and clarity level (1–5 stars).
* **Local-First Persistence:** Secure, lightning-fast on-device storage using **ObjectBox**.
* **Full CRUD Operations:** Effortlessly create, read, update, and delete journal entries.
* **Unified Adaptive Search Architecture:** A single, transformable search field that fluidly handles both full-text symbol searches (Magnifier) and reactive tag cloud filtering (Tag Icon) in real-time.
* **Reactive & Smart UI:** Smooth swipe-to-delete behavior accompanied by an instant undo function and reactive list updates via reactive streams.
* **Night-Optimized Layout:** Tailored Dark Mode interface ("Midnight Theme") designed for low-light environments.

---

### 🎨 UI Design & Color Palette

To support the calming, nocturnal atmosphere, the interface strictly adheres to the following cohesive color mapping:

| Visual Accent | Color Name | Hex Code | Purpose & Application |
| :--- | :--- | :--- | :--- |
| 🌌 **Base Background** | Navy Blue | `#0A1128` | The base of the night sky, minimizing eye strain. |
| 🔮 **Surface / Cards** | Deep Purple | `#1B1464` | Adds structural depth for interactive elements and buttons. |
| 🪻 **Primary Typography**| Lavender | `#E0B0FF` | Soft, elegant contrast for readable texts and primary icons. |
| 👑 **Highlights** | Burnished Gold | `#D4AF37` | Reserved for crucial focal points, interactive ratings, and actions. |
| 🥈 **Secondary Info** | Sterling Silver| `#C0C0C0` | Subtle accents and less prominent meta-information. |

---

### 🛠️ Tech Stack

* **Framework:** Flutter (Cross-Platform Mobile UI Ecosystem)
* **Local Database:** [ObjectBox](https://objectbox.io/) (High-performance, transactional NoSQL on-device database)
* **Code Generation:** Dart `build_runner` for generating type-safe compiled database mappings

---

### 🚀 Installation & Setup

Ensure you have the Flutter SDK installed on your system before proceeding.

#### 1. Fetch Dependencies
```bash
flutter pub get

```

#### 2. Trigger Code Generation

ObjectBox requires pre-generated database code to map your entities. Run the builder with the conflict-cleanup flag:

```bash
flutter pub run build_runner build --delete-conflicting-outputs

```

#### 3. Launch the Application

```bash
flutter run

```

---

### 🔧 Troubleshooting

If the code generation stage fails due to altered entity schemas, force a clean build cache by executing:

```bash
flutter pub run build_runner clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

```

ObjectBox requires native compilation support. Ensure your deployment targets match these baselines:

* **Android:** `minSdkVersion 21` (or higher) in your `android/app/build.gradle`.
* **iOS:** Run `pod install` within the `ios/` directory before building.

---

### 🔮 Roadmap

* [x] **Quick Entry:** Immediate dream drafting right upon app initialization.
* [x] **Full-Text Search & Tag Cloud:** Reactive full-text symbol search paired with an atmospheric, on-demand tag filtering overlay using combined ObjectBox streams.
* [ ] **Smart Filtering:** Multi-layered sorting based on chronological timelines (astronomical cycles), general moods, or lucidity scales (Current Focus).
* [ ] **Categorization Matrix:** Dedicated segmentation for distinct dream states (e.g., Lucid Dreams, Nightmares).
* [ ] **Figma Design System:** Finalizing explicit architectural UI component guidelines.
* [ ] **Design Refinement:** Continuous visual styling updates to maintain low-sensory excellence.
* [ ] **Advanced Analytics:** Interactive, local-first metrics tracing frequency curves and clarity indexes over time.

---

*Developed as a Flutter Showcase Project.*

---

---

## Deutsche Version

Ein modernes, privates und performantes Traumtagebuch, entwickelt mit **Flutter** und **ObjectBox**. Diese App ermöglicht es Nutzern, ihre Träume schnell zu erfassen, zu bewerten und zu analysieren. Der Fokus liegt konsequent auf absoluter Datensouveränität (Offline-First) und einem reizarmen Dark-Mode-Design.

### 📌 Inhaltsverzeichnis

1. [🧘 Design-Philosophie](https://www.google.com/search?q=%23-design-philosophie-der-stille-begleiter)
2. [✨ Features (MVP)](https://www.google.com/search?q=%23-features-mvp-1)
3. [🎨 UI-Design & Farbpalette](https://www.google.com/search?q=%23-ui-design--farbpalette)
4. [🛠️ Technologie-Stack](https://www.google.com/search?q=%23%25EF%25B8%258F-technologie-stack)
5. [🚀 Installation & Setup](https://www.google.com/search?q=%23-installation--setup-1)
6. [🔧 Fehlerbehebung (Troubleshooting)](https://www.google.com/search?q=%23-fehlerbehebung-troubleshooting)
7. [🔮 Roadmap](https://www.google.com/search?q=%23-roadmap-1)

---

### 🧘 Design-Philosophie: "Der stille Begleiter"

Die Entwicklung folgt strikten Prinzipien, um den Nutzer im sensiblen Moment des Erwachens und der Reflexion optimal zu unterstützen:

* **Reizarmut:** Das "Midnight Theme" nutzt gedämpfte Farben, um die morgendliche Lichtempfindlichkeit zu respektieren. Keine grellen Animationen, kein visueller Lärm.
* **Anti-Gamification:** Verzicht auf künstliche "Streaks", Leistungsdruck oder Belohnungssysteme. Pausen im Tagebuch sind Teil des Prozesses und kein Versagen.
* **Neutralität statt Interpretation:** Die App bietet keine vorgefertigten Traumdeutungen. Sie dient als neutraler Spiegel, der Muster aufzeigt, die Deutungshoheit aber vollständig beim Nutzer belässt.
* **Geschwindigkeit vor Komplexität:** Jede Sekunde zählt, bevor ein Traum verblasst. Das Interface ist auf schnellstmögliche Erfassung optimiert.

---

### ✨ Features (MVP)

* **Intuitive Traum-Erfassung:** Sichern von Titel, Inhalt, Datum, Tags und der Klarheit (1–5 Sterne).
* **Lokale Persistenz:** Blitzschnelle, Offline-First Speicherung mittels **ObjectBox** direkt auf dem Gerät.
* **Vollständige CRUD-Operationen:** Problemloses Erstellen, Lesen, Bearbeiten und Löschen von Einträgen.
* **Kombinierte adaptive Such-Architektur:** Ein einziges, sich dynamisch anpassendes Eingabefeld, das sowohl die Freitext-Symbolsuche (Lupe) als auch eine reaktive Tag-Wolken-Filterung (Tag-Icon) in Echtzeit verarbeitet.
* **Smartes UI-Handling:** Reaktives Swipe-to-Delete mit direkter Undo-Funktion und automatischen Listen-Updates via Streams.
* **Nacht-optimiertes Interface:** Speziell angepasster Dark Mode ("Midnight Theme") für die blendfreie Nutzung im Dunkeln.

---

### 🎨 UI-Design & Farbpalette

Um eine beruhigende, nächtliche Atmosphäre zu gewährleisten, nutzt das Interface eine präzise abgestimmte Farbverteilung:

| Visueller Akzent | Farbname | Hex-Code | Funktion & Anwendung |
| --- | --- | --- | --- |
| 🌌 **Hintergrund** | Navy Blue | `#0A1128` | Basis des Nachthimmels. Schont die Augen am frühen Morgen. |
| 🔮 **Karten & Buttons** | Deep Purple | `#1B1464` | Schafft Tiefe und visuelle Struktur für interaktive Elemente. |
| 🪻 **Primärtext** | Lavender | `#E0B0FF` | Sanfter, kontrastreicher Ton für Texte und primäre Icons. |
| 👑 **Highlights** | Burnished Gold | `#D4AF37` | Akzente für wichtige Aktionen, Core-Interaktionen und Bewertungen. |
| 🥈 **Sekundäre Info** | Sterling Silver | `#C0C0C0` | Dezente Einfärbung für Meta-Informationen und Ränder. |

---

### 🛠️ Technologie-Stack

* **Framework:** Flutter (Plattformübergreifende native App-Entwicklung)
* **Datenbank:** [ObjectBox](https://objectbox.io/) (Superschnelle, transaktionale NoSQL-On-Device-Datenbank)
* **Code Generation:** Dart `build_runner` für kompilierte, typsichere Datenbankabfragen

---

### 🚀 Installation & Setup

Stelle sicher, dass das Flutter SDK auf deinem System einsatzbereit ist.

#### 1. Abhängigkeiten installieren

```bash
flutter pub get

```

#### 2. Datenbank-Modelle generieren

ObjectBox benötigt generierten Code für die Validierung der Entities. Führe den Build-Runner mit automatischer Konfliktbereinigung aus:

```bash
flutter pub run build_runner build --delete-conflicting-outputs

```

#### 3. Anwendung starten

```bash
flutter run

```

---

### 🔧 Fehlerbehebung (Troubleshooting)

Solltest du Änderungen an den Entities vorgenommen haben und der Build fehlschlagen, hilft ein radikaler Clean des Build-Caches:

```bash
flutter pub run build_runner clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

```

Da ObjectBox native C-Bibliotheken nutzt, überprüfe bitte folgende Parameter:

* **Android:** Die `minSdkVersion` in `android/app/build.gradle` muss mindestens auf `21` stehen.
* **iOS:** Führe vor dem Build im Terminal ein `cd ios && pod install` durch.
