## 1. App Information

<b>App Name:-</b> REACNAR  
<b>Tagline:-</b> React before you think.  
<b>App Purpose:-</b> Provides ultra-low-latency, zero-anticipation reflex and reaction training with comprehensive, locally processed biological benchmark analytics.<br>
<b>Target Audience:-</b> Runners, sprinters, reflex trainers, martial artists, gamers, and performance athletes.  
<b>Supported Platforms:-</b> Android, iOS (optimized for native hardware audio/haptic layers)  
<b>Version Number:-</b> v0.1.0  
<b>Release Date:-</b> June 2026  

  

## 2. Core Features Breakdown

### User Authentication

* **What it does:** Nothing. There is no login, registration, or profile creation system.
* **Why it exists:** To honor the zero-data-collection philosophy.
* **User benefit:** Instant access to training without managing passwords or sacrificing personal data privacy.

### Analytics Dashboard (Local Stats)

* **What it does:** Queries the local SQLite database to display historical performance records, average response times, consistency scores, and reaction-time frequency distribution graphs using `fl_chart`. It maps these metrics directly against hardcoded human biological milestones.
* **Why it exists:** To track training efficacy and progress without transmitting metrics to a remote cloud server.
* **User benefit:** Athletes gain immediate, granular visual insights into their cognitive fatigue or progression over days, weeks, or months.

### Data Synchronization

* **What it does:** Omitted by design. The app does not sync data across devices.
* **Why it exists:** To prevent the inclusion of network tracking scripts, API dependencies, or cloud data liabilities.
* **User benefit:** Guaranteed data sovereignty. What happens on the device stays on the device.

### Notifications

* **What it does:** Omitted by design. The app operates entirely in the foreground within an intentional training environment.
* **Why it exists:** To eliminate background battery drainage and unwanted user distraction.
* **User benefit:** Zero interruptions during daily routines or critical training prep.

### Offline Support

* **What it does:** Operates at 100% functionality with airplane mode enabled or cellular radios entirely disabled.
* **Why it exists:** This is the core architectural pillar of the app.
* **User benefit:** Athletes can train in remote areas, underground gyms, concrete stadiums, or tracks with zero cellular coverage.

### Dark Mode & Themes

* **What it does:** Provides instant user interface theme toggles between Light, Dark, Military Green, and High-Contrast.
* **Why it exists:** To ensure readability across highly varied training environments.
* **User benefit:** High-Contrast mode allows crisp readability under blinding outdoor sunlight on a running track, while Dark and Military Green modes prevent eye strain in dimly lit indoor gaming setups or rings.

### False Start Detection

* **What it does:** Instantly halts a countdown and triggers an audible error chime if the input layer registers an event prior to the trigger generation.
* **Why it exists:** To eliminate human anticipation, guess-work, and cheating patterns.
* **User benefit:** Forces the athlete to train purely on raw physical stimulus reflex rather than rhythmic guessing.

  

## 3. Technical Stack

* **Framework:** Flutter (Compiles to native ARM machine binaries for direct hardware execution)
* **Language:** Dart
* **Local Database:** SQLite (`sqflite` for structured historical relational queries) & `Hive` (For lightweight, synchronous key-value configuration storage)
* **Audio Engine:** `flutter_soloud` (Bypasses standard OS software mixers via low-level native C++ wrappers)
* **State Management:** Flutter Riverpod (`StateProvider` / `ConsumerWidget` for reactive theme and UI configuration)
* **Data Visualization:** `fl_chart`
* **Version Control:** Git

  

## 4. Permissions Used

REACNAR requests **zero network permissions**. The only access requested is for local hardware interactions:

  Permission   Layer   Reason for Use  
                
  **Haptic Feedback**   System OS   Triggers the physical vibration motor for tactile stimulus options in the Arena.  
  **Volume Button Intercept**   Hardware Layer   Maps physical volume rocker depressions directly to the reaction input event loop, eliminating screen-tap visual distraction.  

  

## 5. Privacy Policy

* **Data Collected:** Absolutely none. No personal identifiers, IP addresses, location metrics, or usage analytics are harvested.
* **Storage Location:** All session histories, timestamps, and milisecond delta records are kept inside the app’s isolated local client sandbox storage via `SQLite` and `Hive`.
* **Data Sharing:** Data sharing is structurally impossible. The app does not contain networking pipelines to transmit data to third parties.
* **User Rights:** You maintain absolute ownership of your data. To wipe all historical data instantly, clear the app data cache within system settings or uninstall the application.

  

## 6. Terms of Service

* **Acceptable Use:** REACNAR is built strictly for personal athletic, cognitive, and reflex training purposes.
* **User Responsibilities:** The user assumes all responsibility for safety when using the app. Training must be performed in environments free of physical hazards.
* **Account Termination:** Not applicable (no accounts exist).
* **Limitation of Liability:** The developers are not liable for any personal injury, hardware damage (e.g., dropping the device during extreme training maneuvers), or athletic performance variance.

  

## 7. Screenshots & UI Overview

```
┌────────────────────────────────────────────────────────┐
│                        ARENA                           │
│                                                        │
│                                                        │
│                      [ READY ]                         │
│                                                        │
│                                                        │
│  (Tap Anywhere or Press Volume Button on Sound)       │
├───────────────────┬────────────────┬───────────────────┤
│       ARENA       │   ANALYTICS    │     SETTINGS      │
└───────────────────┴────────────────┴───────────────────┘

```

* **Arena Screen (`ReactScreen`):** A minimalist interface designed without any moving visuals, countdown counters, or tickers to prevent visual rhythm bias.
* **Analytics Dashboard (`AnalyticsScreen`):** Displays bar charts and scatter plots tracking response latencies, standard deviations (consistency scoring), and historical performance tiers.
* **Settings Screen (`SettingsScreen`):** Minimal radio selection inputs to alter theme profiles or redefine custom random timing bounds (e.g., $Min: 0.5s$, $Max: 3.0s$).

  

## 8. Installation Instructions (For Developers)

### Prerequisites

* Flutter SDK: `^3.22.0` or higher
* Dart SDK: `^3.4.0` or higher
* CocoaPods (For iOS builds)

### Execution Steps

```bash
# Clone the repository
git clone https://github.com/username/reacnar.git

# Navigate into project root
cd reacnar

# Fetch plugin dependencies
flutter pub get

# Ensure native C++ wrappers are properly linked for flutter_soloud
flutter doctor -v

# Launch the application on a connected hardware device
flutter run --release

```

> **Note:** Because `flutter_soloud` relies heavily on native device audio layers, testing on a physical hardware device is highly recommended over emulator testing to ensure accurate millisecond latency representation.

  

## 9. Known Limitations

* **Device Hardware Latency:** The precision of reaction recording relies fundamentally on the host device hardware digital digitizer polling rate and audio output DAC chip performance.
* **No Cross-Device Syncing:** Because there is no central database or authentication layer, clearing application cache files or changing physical phones will wipe out previous statistics permanently.

  

## 10. Security Information

* **Encryption & Architecture:** The database utilizes the operating system's localized sandbox containment. Other applications installed on the system cannot read REACNAR's relational database files.
* **Data Retention:** Retained indefinitely until manual deletion or complete application uninstallation occurs.

  

## 11. Monetization

* **Model:** 100% Free.
* **No Paywalls:** All modes (Single, Burst, Endurance) are unlocked at first launch.
* **No Advertisements:** Zero ad network tracking frameworks are included, keeping the codebase completely clean and preserving raw system processing cycles for execution timing precision.
<p align="center">
  <a href="https://github.com/darshseraphic/Reacnar/releases/download/v0.1.0/">
    <img 
      src="https://img.shields.io/badge/Release-Check_log-000000?style=for-the-badge&logo=github&logoColor=white" 
      alt="Download Stable Release"
    />
  </a>
</p>
  

## 12. Roadmap (Future Milestones)

* [ ] **Local Data Portability:** Build local JSON/CSV backup exporting and importing configurations directly out of the device storage directory.
* [ ] **Custom Waveform Ingestion:** Allow users to import local `.wav` files into app sandboxing to configure custom alert sounds.
* [ ] **External Peripheral Intercepts:** Implement low-level support for Bluetooth LE devices and USB-C hardware buttons to isolate input lag even further.
