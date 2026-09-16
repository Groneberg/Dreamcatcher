# 🌙 DreamCatcher

[![Flutter Version](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Database: ObjectBox](https://img.shields.io/badge/Database-ObjectBox-%23005A9C.svg?style=for-the-badge)](https://objectbox.io/)
[![Platform: Mobile](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-lightgrey?style=for-the-badge)](#)
[![License: Proprietary](https://img.shields.io/badge/License-Proprietary-red.svg?style=for-the-badge)](#-license--lizenz)

### Language Selection / Sprachauswahl
🌐 **[English Version](#english)** | 🌐 **[Deutsche Version](#deutsche-version)**

---

## English

A modern, private, and performant dream journal built with **Flutter** and **ObjectBox**. DreamCatcher acts as a *"Silent Companion"*, designed to protect your sleep hygiene and mental peace in the vulnerable moment of waking. The entire ecosystem is built upon an uncompromising offline-first architecture to guarantee absolute data sovereignty, minimal sensory intrusion, and zero-pressure reflection.

### 📌 Table of Contents
1. [🧘 Design Philosophy: "The Silent Companion"](#-design-philosophy-the-silent-companion)
2. [✨ Features (MVP)](#-features-mvp)
3. [🎨 UI Design & Color Palette](#-ui-design--color-palette)
4. [🛠️ Tech Stack & Architecture](#%EF%B8%8F-tech-stack--architecture)
5. [🚀 Installation & Setup](#-installation--setup)
6. [🔧 Troubleshooting](#-troubleshooting)
7. [🔮 Roadmap](#-roadmap)
8. [📜 License](#-license--lizenz)

---

### 🧘 Design Philosophy: "The Silent Companion"

The development adheres to four uncompromising pillars that define the essence of *The Silent Companion*:

* **🔒 Privacy-First – Absolute Data Sovereignty:** Every dream remains strictly on your device. ObjectBox ensures all data persists locally in transactional storage without any cloud synchronization, external tracking, or unauthorized background transmission. Your inner world belongs solely to you.
* **🌙 Hypnopompic-Optimized – Low Sensory Input:** Specifically calibrated for dawn consciousness and sleep inertia. The deep "Midnight Theme" eliminates visual clutter, prevents eye strain in darkened rooms, and avoids morning cortisol spikes. Design for the vulnerable moment right after waking.
* **⛔ Anti-Gamification – Natural Rhythms, No Pressure:** Zero artificial streaks, no reward metrics, and no push notifications demanding consistency. Gaps in journaling are not failures—they are an authentic part of the natural human cycle. The app simply waits, without judgment, for the next dream.
* **🪞 Neutral Mirror – Reflection Over Interpretation:** No intrusive generative AI images that distort authentic dream imagery through cognitive interference, and no esoteric symbol dictionaries. The app strictly separates effortless morning capture from later evening reflection, keeping interpretation authority entirely with you.

---

### ✨ Features (MVP)

* **⚡ Cold-Start Capture Mode (Speed-to-Entry):** Immediate dream drafting right upon app initialization to capture fleeting dream memories before they fade.
* **🔮 Glassmorphism UI System:** Translucent frosted glass components (`FrostedGlassBox`), dynamic backdrop blur filters, and illuminated focal interactions (`DreamFAB` with gold glow).
* **🔍 Unified Adaptive Search Architecture:** A single, transformable search interface that fluidly handles both full-text symbol search and reactive tag cloud filtering in real time.
* **💾 Local-First Persistence & Reactivity:** High-performance, transactional on-device storage using **ObjectBox** with reactive streams for immediate UI updates.
* **✍️ Full CRUD Operations & Safe States:** Create, view, edit, and delete dream entries effortlessly, complete with swipe-to-delete gestures and instant undo functionality.
* **🌌 Midnight Theme & Night-Optimized Layout:** Tailored Dark Mode interface designed for low-light morning ergonomics.

---

### 🎨 UI Design & Color Palette

To support the calming, nocturnal atmosphere, the interface strictly adheres to the following cohesive color mapping:

| Visual Accent | Color Name | Hex Code | Purpose & Application |
| :--- | :--- | :--- | :--- |
| 🌌 **Base Background** | Navy Blue | `#0A1128` | The base of the night sky, minimizing eye strain. |
| 🔮 **Surface / Cards** | Deep Purple | `#1B1464` | Adds structural depth for interactive elements and frosted surfaces. |
| 🪻 **Primary Typography**| Lavender | `#E0B0FF` | Soft, elegant contrast for readable texts and primary icons. |
| 👑 **Highlights** | Burnished Gold | `#D4AF37` | Reserved for focal points, interactive ratings, and primary actions (`DreamFAB`). |
| 🥈 **Secondary Info** | Sterling Silver| `#C0C0C0` | Subtle accents, borders, and less prominent meta-information. |

---

### 🛠️ Tech Stack & Architecture

* **Framework:** Flutter (Cross-Platform Mobile UI Ecosystem)
* **Local Database:** [ObjectBox](https://objectbox.io/) (High-performance, transactional NoSQL on-device database with reactive streams)
* **Code Generation:** Dart `build_runner` for generating type-safe compiled database mappings
* **Architecture Pattern:** Modular Feature-First structure (`lib/src/features/`, `data/`, and `common_widgets/`)

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
dart run build_runner build --delete-conflicting-outputs
```

#### 3. Launch the Application
```bash
flutter run
```

---

### 🔧 Troubleshooting

If the code generation stage fails due to altered entity schemas, force a clean build cache:
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

ObjectBox requires native compilation support. Ensure your deployment targets match these baselines:
* **Android:** `minSdkVersion 21` (or higher) in `android/app/build.gradle`.
* **iOS:** Run `pod install` within the `ios/` directory before building.

---

### 🔮 Roadmap

#### Phase 1: Foundation & Core Capture (MVP – Completed)
* [x] **Quick Entry & Capture Mode:** Instant capture of dream notes directly upon app launch.
* [x] **Local Persistence & Reactivity:** Transactional on-device storage using ObjectBox and reactive streams.
* [x] **Adaptive Search & Tag Cloud:** Combined full-text and reactive tag-filtering in real time.
* [x] **Glassmorphism UI:** Translucent midnight design system featuring frosted glass cards and gold accents.

#### Phase 2: Hypnopompic Capture & Screen-Free Workflows (Current Focus)
* [ ] **Device Migration & Backup Restore (1-Click):** Seamless backup and restore of dream data when switching to a new smartphone or from an older device.
* [ ] **Structured Data Export (PDF/CSV):** Local report generation formatted for dream therapy, psychotherapy, and sleep clinics.

#### Phase 3: Trust, Security & Data Sovereignty
* [ ] **Biometric Lock:** Optional private journal protection using PIN, Face ID, or fingerprint authentication.
* [ ] **Presentation Mode:** Clean, enlarged view for reading individual dreams aloud without revealing private metadata.
* [ ] **On-Device Voice-to-Text:** Offline voice dictation for recording dreams immediately upon waking without typing.
* [ ] **Context Factors (Previous Day Tags):** Optional tracking of waking-life influences (e.g., stress level, workouts).


#### Phase 4: Gentle Insight & Reflection (Post-MVP)
* [ ] **Hindsight Layer:** Adding reflective annotations to past dreams from a present-day perspective.
* [ ] **Emotional Aura (Weathering):** Data-driven ambient color gradients instead of disruptive generative AI artwork.

---

*Developed as a Flutter Showcase Project.*

---

---

## Deutsche Version

Ein modernes, privates und hochperformantes Traumtagebuch, entwickelt mit **Flutter** und **ObjectBox**. DreamCatcher fungiert als „stiller Begleiter“, der darauf ausgelegt ist, die Schlafhygiene und die mentale Ruhe des Nutzers im vulnerablen Moment des Erwachens zu schützen. Die gesamte Architektur setzt auf kompromisslose Datensouveränität (100 % On-Device), maximale Reizarmut und druckfreie Reflexion.

### 📌 Inhaltsverzeichnis
1. [🧘 Design-Philosophie: „Der stille Begleiter“](#-design-philosophie-der-stille-begleiter)
2. [✨ Features (MVP)](#-features-mvp-1)
3. [🎨 UI-Design & Farbpalette](#-ui-design--farbpalette-1)
4. [🛠️ Technologie-Stack & Architektur](#%EF%B8%8F-technologie-stack--architektur)
5. [🚀 Installation & Setup](#-installation--setup-1)
6. [🔧 Fehlerbehebung (Troubleshooting)](#-fehlerbehebung-troubleshooting)
7. [🔮 Roadmap](#-roadmap-1)
8. [📜 Lizenz](#-license--lizenz)

---

### 🧘 Design-Philosophie: „Der stille Begleiter“

Die Entwicklung folgt vier unerschütterlichen Säulen, die das Wesen des *Stillen Begleiters* definieren:

* **🔒 Privacy-First – Absolute Datensouveränität:** Jeder Traum bleibt ausschließlich auf deinem Gerät. ObjectBox garantiert lokale Persistierung in transaktionalem Speicher ohne Cloud-Synchronisierung, Tracking oder unbefugte Datenübertragung. Deine innere Welt gehört nur dir.
* **🌙 Hypnopomp-Optimiert – Reizarmut (Low Sensory Input):** Entwickelt für den Zustand der Schlaftrunkenheit direkt nach dem Aufwachen. Das tiefdunkle „Midnight Theme“ eliminiert visuelles Rauschen, schont lichtempfindliche Augen im Dunkeln und vermeidet morgendlichen Cortisol-Stress.
* **⛔ Anti-Gamification – Natürliche Rhythmen, kein Druck:** Null künstliche Streaks, keine Belohnungsmetriken und keine fordernden Push-Benachrichtigungen. Lücken im Tagebuch sind kein Versagen – sie sind Teil des natürlichen menschlichen Rhythmus. Die App wartet ohne Wertung auf den nächsten Traum.
* **🪞 Neutraler Spiegel – Reflexion statt Deutungshoheit:** Keine verfälschenden generativen KI-Bilder, die das eigene fragile Traumgedächtnis überschreiben, und keine esoterischen Symbollexika. Die App trennt das morgendliche, intuitive Sammeln (Auffangmodus) strikt von der späteren Reflexion.

---

### ✨ Features (MVP)

* **⚡ Kaltstart-Auffangmodus (Speed-to-Entry):** Blitzschnelle Erfassung flüchtiger Traumfragmente direkt beim App-Start, bevor die Traumerinnerung verblasst.
* **🔮 Glassmorphism UI-System:** Atmosphärische Frosted-Glass-Karten (`FrostedGlassBox`), flüssige Backdrop-Filter, immersiver Nachthimmel und akzentuierte Interaktionselemente (`DreamFAB` mit goldenem Glow).
* **🔍 Kombinierte adaptive Such-Architektur:** Ein einziges transformierbares Eingabefeld, das Freitext-Symbolsuche und reaktive Tag-Wolken-Filterung in Echtzeit vereint.
* **💾 Lokale Persistenz & Reaktivität:** Transaktionssichere, blitzschnelle Datenspeicherung via **ObjectBox** mit reaktiven Datenströmen (Streams) für sofortige UI-Aktualisierungen.
* **✍️ Vollständige CRUD-Operationen & Undo:** Problemloses Erstellen, Lesen, Bearbeiten und Löschen von Einträgen inklusive Swipe-to-Delete und Undo-Funktion.
* **🌌 Nacht-optimiertes Interface:** Speziell angepasster Dark Mode („Midnight Theme“) für die blendfreie Nutzung im Dunkeln.

---

### 🎨 UI-Design & Farbpalette

Um eine beruhigende, nächtliche Atmosphäre zu gewährleisten, nutzt das Interface eine präzise abgestimmte Farbverteilung:

| Visueller Akzent | Farbname | Hex-Code | Funktion & Anwendung |
| :--- | :--- | :--- | :--- |
| 🌌 **Hintergrund** | Navy Blue | `#0A1128` | Basis des Nachthimmels. Schont die Augen am frühen Morgen. |
| 🔮 **Karten & Flächen** | Deep Purple | `#1B1464` | Schafft Tiefe und visuelle Struktur für Frosted-Glass-Elemente. |
| 🪻 **Primärtext** | Lavender | `#E0B0FF` | Sanfter, kontrastreicher Ton für Texte und primäre Icons. |
| 👑 **Highlights** | Burnished Gold | `#D4AF37` | Akzente für Core-Interaktionen, Bewertungen und den `DreamFAB`. |
| 🥈 **Sekundäre Info** | Sterling Silver | `#C0C0C0` | Dezente Einfärbung für Ränder, Trennlinien und Meta-Informationen. |

---

### 🛠️ Technologie-Stack & Architektur

* **Framework:** Flutter (Plattformübergreifende native App-Entwicklung)
* **Lokale Datenbank:** [ObjectBox](https://objectbox.io/) (Transaktionale NoSQL On-Device-Datenbank mit reaktiven Streams)
* **Code Generation:** Dart `build_runner` für kompilierte, typsichere Entity-Bindeglieder
* **Architektur:** Modulare Feature-First-Struktur (`lib/src/features/`, `data/` und `common_widgets/`)

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
dart run build_runner build --delete-conflicting-outputs
```

#### 3. Anwendung starten
```bash
flutter run
```

---

### 🔧 Fehlerbehebung (Troubleshooting)

Solltest du Änderungen an den Entities vorgenommen haben und der Build fehlschlagen, hilft ein Clean des Build-Caches:
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Da ObjectBox native C-Bibliotheken nutzt, überprüfe bitte folgende Parameter:
* **Android:** Die `minSdkVersion` in `android/app/build.gradle` muss mindestens auf `21` stehen.
* **iOS:** Führe vor dem Build im Terminal ein `cd ios && pod install` durch.

---

### 🔮 Roadmap

#### Phase 1: Fundament & Kern-Erfassung (MVP – Abgeschlossen)
* [x] **Quick Entry & Auffangmodus:** Sofortiges Erfassen von Trauminhalten direkt beim App-Start.
* [x] **Lokale Persistenz & Reaktivität:** Transaktionssichere On-Device-Speicherung via ObjectBox und reaktive Streams.
* [x] **Adaptive Volltextsuche & Tag-Cloud:** Kombinierte Freitext- und Tag-Filterung in Echtzeit.
* [x] **Glassmorphism-UI:** Transluzentes Midnight-Design mit Frosted-Glass-Karten und Gold-Akzenten.

#### Phase 2: Hypnopompe Erfassung & Screen-Free Workflows (Aktueller Fokus)
* [ ] **Geräteumzug & Backup-Restore (1-Klick):** Nahtlose Sicherung und Wiederherstellung der Traumdaten beim Wechsel auf ein neues Smartphone oder von einem Altgerät.
* [ ] **Strukturierter Datenexport (PDF/CSV):** Lokale Berichterstellung für Traumtherapie, Psychotherapie und Schlaflabore.

#### Phase 3: Vertrauen, Sicherheit & Daten-Souveränität
* [ ] **Biometrischer Zugriffsschutz:** Optionale Absicherung des Journals via PIN, Face ID oder Fingerabdruck.
* [ ] **On-Device Voice-to-Text:** Lokale, offlinefähige Spracherkennung für verschlafenes Einsprechen ohne Display-Tippen.
* [ ] **Kontext-Faktoren (Vortags-Tags):** Leichtes Erfassen von Einflussfaktoren (z. B. Stresslevel, Sport, Genussmittel).
* [ ] **Präsentations-Modus:** Großformatiges, sicheres Vorlesen/Zeigen einzelner Träume ohne Freigabe privater Metadaten.

#### Phase 4: Sanfte Erkenntnis & Reflexion (Post-MVP)
* [ ] **Hindsight-Layer (Spätere Reflexion):** Nachträgliches Kommentieren alter Träume aus heutiger Sicht („Was wurde daraus?“).
* [ ] **Emotionales Wetterleuchten / Aura:** Datenbasierte Farbverläufe und Stimmungs-Auren statt verfälschender KI-Bilder.

---

*Entwickelt als Flutter Showcase-Projekt.*

---

## 📜 License / Lizenz

### English

**Copyright © 2026. All rights reserved.** This software, its source code, design assets, and the underlying conceptual framework ("The Silent Companion") are proprietary and protected by copyright.

**Restrictions on Use:**
- **No Redistribution:** You may not redistribute, sublicense, host public mirrors, or sell this software in any form.
- **No Re-uploading:** Publishing or re-uploading this application (including personal forks) to public app stores (Apple App Store, Google Play Store, etc.) or public repositories is strictly prohibited without explicit written permission from the copyright holder.
- **No Unauthorized Deployment:** Deploying or hosting derivative versions is not permitted without prior written consent.

For licensing inquiries or permission requests, contact the copyright holder directly.

---

### Deutsch

**Copyright © 2026. Alle Rechte vorbehalten.** Diese Software, ihr Quellcode, ihre Design-Assets und das zugrunde liegende konzeptionelle Framework ("Der stille Begleiter") sind proprietär und urheberrechtlich geschützt.

**Nutzungsbeschränkungen:**
- **Keine Weiterverbreitung:** Es ist nicht gestattet, diese Software in irgendeiner Form weiterzuverbreiten, zu unterlizenzieren, öffentliche Mirrors zu hosten oder zu verkaufen.
- **Kein Re-Uploading:** Das Veröffentlichen oder erneute Hochladen dieser Anwendung (einschließlich eigener Forks) in öffentliche App-Stores (Apple App Store, Google Play Store, etc.) oder öffentliche Repositories ist ohne ausdrückliche schriftliche Genehmigung des Urhebers strengstens untersagt.
- **Keine unbefugte Bereitstellung:** Das Bereitstellen oder Hosting von abgeleiteten Versionen ist ohne vorherige schriftliche Genehmigung nicht gestattet.

Für Lizenzanfragen oder Genehmigungsanträge wende dich bitte direkt an den Urheberrechtsinhaber.

