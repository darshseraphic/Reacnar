# REACNAR // REFLEX FIELD

An ultra-low latency, cybernetic-inspired reaction time measurement, neuro-motor training, and biometron telemetric analysis framework.

## Executive Summary & Core Philosophy

<p align="center">
  <img src="https://github.com/user-attachments/assets/3fe0193b-ebe4-4150-9d45-2fedbde244da" alt="react - Light" width="31%" />
  <img src="https://github.com/user-attachments/assets/c3736101-479d-49b7-a385-b042a6425769" alt="stat - Light" width="31%" />
  <img src="https://github.com/user-attachments/assets/ba762cda-9d39-4ce6-9b2d-979e66eb26cf" alt="setting - Light" width="31%" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/261df632-6ca7-487f-9a0a-8a463d8fe529" alt="react - Dark" width="31%" />
  <img src="https://github.com/user-attachments/assets/db6b7169-efb2-4add-b4ad-41e819cd32ad" alt="stat - Dark" width="31%" />
  <img src="https://github.com/user-attachments/assets/31983ca6-eb63-4820-b2ad-66fb4bc4398f" alt="Setting - Dark" width="31%" />
</p>

**REACNAR // REFLEX FIELD** is a professional-grade neuro-motor benchmarking and reaction conditioning engine built to analyze human reflex dynamics with sub-millisecond precision. Developed around a brutalist, distraction-free aesthetic, Reacnar strips away the bloat, animations, gamified pop-ups, and intrusive network overhead typical of modern visual tools. What remains is a pure, high-precision laboratory environment optimized for raw biological input and instantaneous visual-haptic telemetry feedback.

In high-stakes environments—ranging from elite esports competition and high-speed motorsport to combat sports and tactical operations—a fraction of a millisecond dictates the line between success and failure. Reacnar provides an unadulterated field for testing, tracking, and conditioning neuromuscular latency. By removing input lag, background computation tasks, and visual noise, Reacnar acts as an uncompromising mirror to your biological processing speed.

### The Core Triad

* **Extreme Input Fidelity:** Designed to interface directly with device hardware event loops to capture touch interactions at the precise hardware interrupt frame.
* **Radical Privacy Architecture:** Operates entirely air-gapped on-device. Zero telemetry servers, zero user accounts, zero analytics tracking, and zero cloud persistence.
* **Monochrome Brutalist Interface:** High-contrast, typography-driven UI designed to eliminate visual clutter and focus human attention solely on target acquisition and immediate execution.



## Technical Architecture & Core Subsystems

```
+-------------------------------------------------------------------+
|                     REACNAR ENGINE ARCHITECTURE                   |
+-------------------------------------------------------------------+
|                                                                   |
|   +-----------------------------------------------------------+   |
|   |                    USER INTERFACE LAYER                   |   |
|   |   [ ARENA VIEW ]    [ ANALYTICS VIEW ]   [ SETTINGS VIEW ]|   |
|   +-----------------------------------------------------------+   |
|                                 |                                 |
|                                 v                                 |
|   +-----------------------------------------------------------+   |
|   |                    EXECUTION MODES                        |   |
|   |      [ NORMAL ]       [ BURST ]       [ CLICK ]           |   |
|   +-----------------------------------------------------------+   |
|                                 |                                 |
|                                 v                                 |
|   +-----------------------------------------------------------+   |
|   |                 HARDWARE & TUNING LAYER                   |   |
|   |   - Precision Clock (Sub-ms Stopwatch)                       |   |
|   |   - Unpredictable Delay Matrix Engine (0.1s - 10.0s)          |   |
|   |   - Anti-Cheat Penalty System & False Start Intercept         |   |
|   |   - Tactile Haptic Confirmation Engine                        |   |
|   +-----------------------------------------------------------+   |
|                                 |                                 |
|                                 v                                 |
|   +-----------------------------------------------------------+   |
|   |                 LOCAL TELEMETRY PERSISTENCE               |   |
|   |   - Isolated On-Device Database Storage                       |   |
|   |   - Biological Performance Categorization Matrix              |   |
|   |   - Absolute Hardware Purge Safeguard                         |   |
|   +-----------------------------------------------------------+   |
|                                                                   |
+-------------------------------------------------------------------+

```

## Detailed Operational Training Modes

Reacnar divides reflex testing into three distinct operational modes, each designed to isolate and strain different pathways of the human central nervous system and motor cortex.

```
+-------------------------------------------------------------------+
|                    TRAINING MODES & DYNAMICS                      |
+-------------------------------------------------------------------+
|  [ NORMAL MODE ]   --> Single-stimulus simple reaction latency    |
|  [ BURST MODE ]    --> Rapid-fire cluster sequence consistency    |
|  [ CLICK MODE ]    --> High-frequency motor stamina & tap rate    |
+-------------------------------------------------------------------+

```

### 1. Normal Mode (Single-Stimulus Visual Latency)

* **Primary Objective:** Measure absolute simple reaction time from visual visual-stimulus trigger to kinetic tap registration.
* **Neuromuscular Pathway:** Visual cortex recognition to motor cortex signal activation down the spinal cord to finger flexor contraction.
* **Execution Flow:**
1. The user taps the field to initialize the signal state.
2. The arena enters an unpredictable standby state (`AWAITING UNPREDICTABLE MATRIX COLD PULSE...`).
3. The system engine calculates a randomized delay variable strictly bounded by user-configured parameters (e.g., between 1.0s and 10.0s).
4. Upon interval expiration, the central target matrix instantly transitions state (`TRIGGER ACQUIRED: DETONATE ACTIONS IMMEDIATELY`), triggering a light haptic impact.
5. The high-precision clock measures the exact elapsed time in milliseconds until user contact is registered.
6. The system logs the response delta and renders the exact latency score.



### 2. Burst Mode (Sustained Cluster Sequence Trainer)

* **Primary Objective:** Measure motor response consistency and recovery speed under rapid, variable-interval multi-stimulus sequences.
* **Neuromuscular Pathway:** Sustained visual attention, rapid motor reset, and cognitive adaptation to micro-interval perturbations.
* **Execution Flow:**
1. Initiating the field generates a cluster sequence containing between 3 and 5 random fire ticks.
2. The user reacts to the primary stimulus trigger.
3. Immediately upon impact, the clock logs the delta for Tick 1, resets internally, and places the system into a micro-interval standby state (randomized between 150ms and 450ms).
4. Subsequent visual pulses fire in rapid succession without returning the user to a rest state.
5. The user must detonate every tick in the active sequence.
6. Upon sequence completion, the system computes the cluster mean delta in milliseconds, capturing both peak speed and fatigue recovery.



### 3. Click Mode (High-Frequency Motor Stamina & Velocity)

* **Primary Objective:** Measure continuous neuro-motor firing rate, motor endurance, and maximum physical tap velocity over a sustained time domain.
* **Neuromuscular Pathway:** Fast-twitch muscle fiber activation, rate coding of motor units, and central motor fatigue resistance over a 60-second window.
* **Execution Flow:**
1. Tapping the central field initiates an active 60-second countdown trial.
2. The display transforms into a touch-responsive field (`MASH DISPLAY BOUNDS!`).
3. The user executes maximum frequency physical taps anywhere across the interface bounds.
4. Real-time telemetry tallies total valid tap volume alongside a live countdown clock.
5. At $T = 0$, the session completes, computing total tap accumulation and extrapolating average frequency metrics (Taps Per Minute / Hz equivalency).


## Anti-Cheat Architecture & False Start Dynamics

To maintain absolute scientific integrity across telemetry records, Reacnar incorporates an aggressive **Anti-Cheat Penalty System**.

```
+-------------------------------------------------------------------+
|                   ANTI-CHEAT PENALTY WORKFLOW                     |
+-------------------------------------------------------------------+
|  [ USER TAP ]                                                     |
|       |                                                           |
|       v                                                           |
|  [ ARENA STATE CHECK ]                                            |
|       |                                                           |
|       +---> State == Waiting (Pre-Trigger)                        |
|       |          |                                                |
|       |          v                                                |
|       |     [ ABORT COUNTDOWN TIMER ]                             |
|       |          |                                                |
|       |          v                                                |
|       |     [ LOG FALSE START RECORD (isFalseStart: True) ]       |
|       |          |                                                |
|       |          v                                                |
|       |     [ TRIGGER HEAVY HAPTIC PENALTY ]                      |
|       |          |                                                |
|       |          v                                                |
|       |     [ LOCK ARENA IN RED PENALTY GLOW ]                    |
|       |                                                           |
|       +---> State == Triggered (Post-Trigger)                     |
|                  |                                                |
|                  v                                                |
|             [ LOG VALID REACTION MS ]                             |
+-------------------------------------------------------------------+

```

### Anticipation vs. Reaction

In human reflex testing, users frequently attempt to "predict" or time the visual signal rather than react to it. This produces artificial speed scores that do not reflect true biological reaction latency. Reacnar neutralizes anticipation through two core mechanics:

1. **Unpredictable Matrix Delay Engine:** Randomizes standby intervals across floating-point precision bounds. Because the human brain cannot accurately predict a microsecond-randomized time window, guessing leads to false starts.
2. **False Start Penalty Routine:** If a user initiates contact during the waiting phase before visual pulse ignition:
* The active countdown timer is instantly destroyed.
* A heavy haptic feedback impulse is injected to penalize muscle memory.
* The arena locks into a vibrant **Red Penalty State** (`FALSE START PENALTY ROUTINE INJECTED`).
* An immutable infraction entry is written to local database records (`ANTI-CHEAT INFRACTIONS TRAPPED`).
* The user must execute a manual reset tap to clear the penalty state, preventing automated button-mashing strategies.


## Biological Performance Profiling & Telemetry Analytics

Reacnar transforms raw millisecond logs into structured biological insights. By analyzing session averages and distribution curves, the application automatically assigns users a **Biological Performance Profile Tier**.

```
+-------------------------------------------------------------------+
|                 BIOLOGICAL TIER CLASSIFICATION                    |
+-------------------------------------------------------------------+
|  LATENCY RANGE (MS)      BIOLOGICAL TIER CLASSIFICATION           |
|  ------------------      ---------------------------------------  |
|  < 140 ms                ELITE REFLEX SPECIFICATION               |
|  140 ms - 199 ms         PRO ATHLETIC CONDITION                   |
|  200 ms - 259 ms         TRAINED MILITARY COMBATANT               |
|  >= 260 ms               STANDARD BIOLOGICAL BASELINE             |
+-------------------------------------------------------------------+
|  MOTOR TAPPING (TAPS/MIN) TAPPING TIER CLASSIFICATION             |
|  ----------------------- ---------------------------------------  |
|  >= 400 Taps/min         CYBERNETIC SPEED SPECIFICATION           |
|  300 - 399 Taps/min      HYPER-TAP ATHLETIC CONDITION             |
|  180 - 299 Taps/min      TRAINED MOTOR RESPONSE SYSTEM            |
|  < 180 Taps/min          STANDARD BIOLOGICAL TAPPING RATE         |
+-------------------------------------------------------------------+

```

### Telemetry Dashboard Metrics

The Analytics terminal provides a complete breakdown of user performance metrics:

```
+-------------------------------------------------------------------+
|                    TELEMETRY DASHBOARD DISPLAY                    |
+-------------------------------------------------------------------+
|  TELEMETRY DASHBOARD                                              |
|  +-------------------------------------------------------------+  |
|  | BIOLOGICAL PERFORMANCE PROFILE                              |  |
|  | STANDARD BIOLOGICAL BASELINE                                 |  |
|  +-------------------------------------------------------------+  |
|                                                                   |
|   |█|    | |    | |    |█|    | |    | |    | |                   |
|   MON    TUE    WED    THU    FRI    SAT    SUN                   |
|   341     -      -     381     -      -      -                    |
|                                                                   |
|  SYSTEM TOTAL ENGAGEMENTS                                     5   |
|  ALL-TIME VELOCITY MINIMA (PR)                          317 MS   |
|  ALL-TIME VELOCITY MAXIMA                                 0 MS   |
|  COMPUTED SESSION MEAN DELTA                            349 MS   |
|  ANTI-CHEAT INFRACTIONS TRAPPED                               0   |
|                                                                   |
|  [ PURGE ALL SYSTEM METRICS ]                                     |
|                                                                   |
|  +-------------------------------------------------------------+  |
|  |  [NORMAL]          |      BURST        |       CLICK        |  |
|  +-------------------------------------------------------------+  |
+-------------------------------------------------------------------+

```

#### Metrics Breakdown

* **Biological Performance Profile:** Evaluates historical trial averages against human physiological baselines to determine current neuromuscular classification.
* **Weekly Temporal Matrix Bar Chart:** A seven-day comparative bar graph displaying daily performance averages (Monday through Sunday), allowing users to track neuromuscular fatigue, recovery cycles, and daily progress.
* **System Total Engagements:** Total count of logged trials executed within the selected operational mode.
* **All-Time Velocity Minima (PR):** The single fastest valid reaction latency (Personal Record) achieved across all historical sessions.
* **All-Time Velocity Maxima:** The slowest recorded reaction delta, representing maximum biological processing lag or lapse in attention.
* **Computed Session Mean Delta:** The mathematically rigorous mean average of all valid non-penalty reaction trials logged in system storage.
* **Anti-Cheat Infractions Trapped:** An absolute count of false starts caught by the penalty engine.


## Visual Aesthetics & Design System (UI)

Reacnar's visual architecture is rooted in **Monochrome Cybernetic Brutalism**. By eschewing modern trends like soft drop shadows, pastel gradients, and decorative animations, the interface preserves system resources and maintains user focus.

```
+-------------------------------------------------------------------+
|                      DISPLAY THEME MATRIX                         |
+-------------------------------------------------------------------+
|                                                                   |
|   DARK TERMINAL MODE                      LIGHT FIELD MODE        |
|   +--------------------------+            +-------------------+   |
|   | Background: #000000      |            | Background:#FFFFFF|   |
|   | Primary:    #FFFFFF      |            | Primary:   #000000|   |
|   | Borders:    #1F1F1F      |            | Borders:   #E5E5E5|   |
|   | Alert/Red:  #EF4444      |            | Alert/Red: #EF4444|   |
|   +--------------------------+            +-------------------+   |
|                                                                   |
+-------------------------------------------------------------------+

```

### Visual Principles

#### Monochrome Color Palettes

* **Dark Terminal Mode:** Absolute deep black surface (`#000000`) paired with crisp white primary elements (`#FFFFFF`) and dark slate wireframe boundaries (`#1F1F1F`). Designed for low-light environments to reduce eye strain and maximize display contrast.
* **Light Field Mode:** Stark white background (`#FFFFFF`) with jet-black active indicators (`#000000`) and subtle gray structural divisions (`#E5E5E5`). Designed for high ambient light conditions.

#### Technical Typography

Uses a monospaced font family (**Roboto Mono**) rendered in uppercase with tight tracking. Every character occupies an identical horizontal footprint, eliminating layout shifts when numerical millisecond metrics rapidly update.

#### Wireframe Geometry & Stark Tactility

All UI components—buttons, containers, mode toggles, and modal links—are bound by sharp, 0.8pt to 1.2pt solid borders with zero corner rounding. Switches and sliders use square thumbs and box toggles, reinforcing a hardware terminal aesthetic.

#### Zero Non-Essential Motion

Transitions are instantaneous or linear. There are no easing curves, bouncing spring physics, or decorative visual effects that could consume GPU cycles or cause visual lag.


## Hardware Tuning & Customization Interface

The **Hardware Tuning Interface** allows users to configure operational parameters, physical feedback loops, and display modes.

```
+-------------------------------------------------------------------+
|                    HARDWARE TUNING INTERFACE                      |
+-------------------------------------------------------------------+
|                                                                   |
|  TACTILE HAPTIC CONFIRMATION                              [█]     |
|                                                                   |
|  ANTI-CHEAT PENALTY GLOW                                  [█]     |
|                                                                   |
|  MIN EXPERIMENTAL DELAY                                  1.0s     |
|  ■----------------------------------------------------            |
|                                                                   |
|  MAX EXPERIMENTAL DELAY                                 10.0s     |
|  ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■           |
|                                                                   |
|  DISPLAY THEME MATRIX                                             |
|  +-------------------------------------------------------------+  |
|  | DARK TERMINAL MODE                                 [ACTIVE] |  |
|  +-------------------------------------------------------------+  |
|  | LIGHT FIELD MODE                                            |  |
|  +-------------------------------------------------------------+  |
|                                                                   |
|  SYSTEM OPERATION GUIDE                                   //      |
|  PRIVACY POLICY PROTOCOL                                  //      |
|  OFFICIAL WEB PLATFORM                                     //      |
|  SUBMIT CENTRAL FEEDBACK                                  //      |
|                                                                   |
+-------------------------------------------------------------------+

```

### Adjustable Hardware Parameters

* **Tactile Haptic Confirmation:** Toggles linear physical motor vibration feedback upon stimulus firing and input registration. This reinforces visual stimuli with physical feedback.
* **Anti-Cheat Penalty Glow:** Toggles the false start penalty trap. When enabled, premature taps lock the arena into a red penalty state that requires a manual reset tap.
* **Min Experimental Delay Slider:** Sets the lower bound for the randomized delay generator (configurable from 0.1s to 10.0s in 0.1s increments).
* **Max Experimental Delay Slider:** Sets the upper bound for the randomized delay generator (configurable from 0.1s to 10.0s). Setting equal min and max values creates fixed-interval rhythm training.
* **Display Theme Matrix:** Toggles between Dark Terminal Mode and Light Field Mode, re-rendering the layout instantly without requiring an app restart.
* **System Operations Linkage:** Provides inline access to the integrated operation manual, local privacy protocol, official platform URL, and direct user feedback channels.

## User Experience (UX) Engineering & Ergonomics

```
+-------------------------------------------------------------------+
|                     UX ERGONOMICS & FLOW                          |
+-------------------------------------------------------------------+
|                                                                   |
|   +-----------------------------------------------------------+   |
|   |                   FULL-FIELD TAP TARGET                   |   |
|   |                                                           |   |
|   |                         ( 160px )                         |   |
|   |                        CIRCULAR MATRIX                    |   |
|   |                            CENTER                         |   |
|   |                                                           |   |
|   |          ANYWHERE Contact Detonates Signal Field          |   |
|   +-----------------------------------------------------------+   |
|                                 |                                 |
|                                 v                                 |
|   +-----------------------------------------------------------+   |
|   |                   THREE-TAB BOTTOM NAVIGATION             |   |
|   |    [ ARENA ]          [ ANALYTICS ]        [ SETTINGS ]   |   |
|   +-----------------------------------------------------------+   |
|                                                                   |
+-------------------------------------------------------------------+

```

Reacnar's UX architecture addresses the physical ergonomics of mobile touchscreens during high-stress reaction testing:

### 1. Full-Field Input Target

While the arena displays a central 160px focal ring, the entire display area acts as an active touch target during testing. Users do not need to hit a tiny button under extreme time pressure—tapping anywhere on the display immediately fires the response register.

### 2. High-Frequency Tactile Feedback

Haptic impacts are timed to physical touch registration rather than UI frame renders. This creates an immediate physical connection between user touch and system response.

### 3. Thumb-Zone Optimization

Primary sub-mode toggles (`NORMAL`, `BURST`, `CLICK`) and top-level navigation tabs (`ARENA`, `ANALYTICS`, `SETTINGS`) are anchored at the bottom of the screen. This allows for easy one-handed operation without stretching across the display.

### 4. Zero Cognitive Friction

When a trial finishes, there are no modal popups, summary overlays, or confirmation prompts to dismiss. The screen instantly displays the recorded score and returns to standby mode, allowing users to run consecutive trials seamlessly.


## Security, Privacy, and Data Isolation Protocol

Reacnar adheres to a strict zero-trust privacy and data security model.

```
+-------------------------------------------------------------------+
|                  LOCAL DATA ISOLATION BOUNDARY                    |
+-------------------------------------------------------------------+
|                                                                   |
|   REACNAR ENVIRONMENT (ON-DEVICE)                                 |
|   +-----------------------------------------------------------+   |
|   |  - Reaction Logs                                          |   |
|   |  - Telemetry Metrics                                      |   |
|   |  - User Settings                                          |   |
|   |  - Hive Local Storage Database                            |   |
|   +-----------------------------------------------------------+   |
|                                                                   |
|  ------------------ AIR-GAP BOUNDARY ---------------------------  |
|                                                                   |
|   EXTERNAL NETWORKS (NO CONNECTION)                               |
|   [ No Analytics SDKs ] [ No Cloud Servers ] [ No Ad Tracking ]   |
|                                                                   |
+-------------------------------------------------------------------+

```

### Security Guarantees

* **100% On-Device Air-Gapped Execution:** Reacnar does not require, request, or utilize an active network connection for core testing. Telemetry data never leaves the local device storage environment.
* **Zero Third-Party SDK Integration:** Reacnar contains no analytics SDKs, crash-reporting frameworks, advertising software, or remote tracking scripts. Your motor performance data is strictly your own.
* **No Authentication or Identification:** The app operates without user accounts, emails, profile sign-ins, or persistent hardware identifiers.
* **Local Embedded Database Isolation:** Telemetry data and configuration states are persisted locally using Hive, an ultra-fast, lightweight key-value database engine that runs fully isolated within the app's sandboxed storage directory.
* **Instant Hardware Metrics Purge:** Selecting `PURGE ALL SYSTEM METRICS` in the Analytics tab triggers an immediate sweep that deletes all stored session logs, reset performance profiles, and zeroes out historical metrics.


## Competitive Advantage & Comparative Matrix

```
+-----------------------------------------------------------------------------------------------+
|                                    COMPREHENSIVE COMPARISON                                   |
+-----------------------------------------------------------------------------------------------+
| EVALUATION CRITERIA       WEB REACTION TESTS       GAMIFIED MOBILE APPS      REACNAR PLATFORM     |
+-----------------------------------------------------------------------------------------------+
| Input Precision           Browser-bound (High)     OS Layered (Variable)     Low-level Native     |
| Visual Noise              High (Ads/Banners)       High (Animations/Glow)    Zero (Brutalist UI)  |
| Telemetry Depth           Basic Mean Score         Gated behind Paywalls     Complete Dashboard   |
| Offline Functionality     Requires Connection      Partial (Ad-supported)    100% Air-Gapped      |
| Anti-Cheat Detection      Basic / None             Minimal                   Hardware Penalty Lock|
| Sequence Training         Rarely Supported         Gated / Microtransactions Native Burst Engine  |
| Data Privacy              Tracked / Cookie Logged  Sold / Ad-profiled        Zero Data Collection |
| Theme System              Basic / Fixed            Cosmetic Micro-Tx         Zero-Lag Monochrome  |
| Custom Signal Delays      Fixed Window             Fixed Window              0.1s-10.0s Precision |
+-----------------------------------------------------------------------------------------------+

```


## Target Applications & Real-World Use Cases

```
+-------------------------------------------------------------------+
|                     TARGET FIELD APPLICATIONS                     |
+-------------------------------------------------------------------+
|  [ ESPORTS ]        --> Reflex conditioning for FPS/RTS players   |
|  [ ATHLETICS ]      --> Sprint start & combat reaction timing     |
|  [ NEUROLOGY ]      --> Motor rehabilitation & fatigue tracking   |
|  [ HIGH-RISK ]      --> Readiness verification for pilots/drivers |
+-------------------------------------------------------------------+

```

### 1. Esports & Competitive Gaming Optimization

* **First-Person Shooters (FPS):** Trains flick-reaction speed and visual target acquisition latencies for competitive players in fast-paced games.
* **Real-Time Strategy (RTS) & MOBA:** Trains high-frequency physical motor tap endurance (APM conditioning) through Click Mode trials.

### 2. Athletic & Combat Sports Conditioning

* **Track & Field Athletes:** Trains reaction speed off the blocks using custom min/max delay settings to mirror starting-gun intervals.
* **Martial Artists & Boxers:** Conditions counter-reaction timing and visual stimulus responsiveness.

### 3. Neurological Tracking & Motor Rehabilitation

* **Fatigue Monitoring:** Offers a quick way to quantify central nervous system (CNS) fatigue before high-intensity physical training or demanding tasks.
* **Rehabilitation Assessment:** Tracks motor recovery progress in post-injury physical therapy by measuring latency improvements over time.

### 4. High-Risk Professional Readiness Verification

* **Aviation & Motorsport:** Provides a pre-session diagnostic tool for pilots, race drivers, and heavy machinery operators to verify neurological alertness and reaction speed before operating equipment.


## Complete Operational User Manual

### System Setup & Initial Calibration

1. **Launch Environment:** Open Reacnar to enter the primary **Reflex Field** screen.
2. **Select Display Profile:** Navigate to `SETTINGS`, then under `DISPLAY THEME MATRIX`, select either `DARK TERMINAL MODE` or `LIGHT FIELD MODE` based on your ambient lighting conditions.
3. **Configure Haptic Feedback:** Toggle `TACTILE HAPTIC CONFIRMATION` to match your physical feedback preferences.
4. **Calibrate Unpredictability Window:** Adjust `MIN EXPERIMENTAL DELAY` and `MAX EXPERIMENTAL DELAY` to set your desired standby delay range (e.g., 2.0s to 5.0s for standard testing, or 1.0s to 1.0s for rhythm training).

### Executing a Testing Protocol

1. **Select Operational Mode:** Tap the mode selector at the bottom of the Arena view (`NORMAL`, `BURST`, or `CLICK`).
2. **Initiate Trial:** Tap anywhere on the main screen area.
3. **React to Visual Stimulus:**
* **In Normal Mode:** Wait for the dark matrix to flash white (`TRIGGER ACQUIRED`), then tap as fast as possible.
* **In Burst Mode:** Maintain focus through the rapid visual pulses, tapping immediately as each pulse fires until the sequence completes.
* **In Click Mode:** Tap as rapidly as possible across the entire screen area until the 60-second timer expires.


4. **Review Live Telemetry:** Your response time in milliseconds (or tap count in Click Mode) displays instantly on screen.

### Analyzing Session Data

1. **Access Telemetry:** Tap the `ANALYTICS` tab in the bottom navigation bar.
2. **Filter by Mode:** Toggle between `NORMAL`, `BURST`, and `CLICK` at the bottom of the dashboard to view mode-specific telemetry.
3. **Assess Biological Tier:** Review your assigned **Biological Performance Profile** classification based on your recorded performance.
4. **Review Weekly Analytics:** Check the daily bar chart to identify performance trends, neurological fatigue patterns, or recovery cycles throughout the week.
5. **Purge Local Data:** To clear all stored logs and reset your metrics, scroll to the bottom of the Analytics view and tap `PURGE ALL SYSTEM METRICS`.


## Frequently Asked Questions (FAQ)

### Latency & Hardware Accuracy

#### How accurate are Reacnar's reaction measurements?

Reacnar uses native system timers that measure elapsed time at sub-millisecond precision. By disabling heavy background processes and visual transitions, touch input latency is minimized to reflect true biological response speed as closely as handheld touch hardware allows.

#### Does touchscreen hardware introduce input lag?

Yes. All capacitive touchscreens introduce a small hardware-level input latency (typically 10ms to 30ms depending on display polling rates and device hardware). Reacnar minimizes app-side overhead, ensuring that any remaining delay stems entirely from screen hardware rather than software execution.

### Anti-Cheat & Penalties

#### Why did my screen turn red during a test?

The red screen indicates an **Anti-Cheat False Start Penalty**. You tapped the display while the system was in its standby waiting phase before the visual pulse ignited. Tap once more to clear the penalty screen and reset the arena.

#### Can I turn off the Anti-Cheat Penalty System?

Yes. Open `SETTINGS` and switch off `ANTI-CHEAT PENALTY GLOW`. Premature taps will no longer lock the screen in a red penalty state, though false starts will still be flagged to protect data accuracy.

### Data Management & Customization

#### How does Reacnar categorize my performance tier?

Reacnar calculates your overall average reaction time in milliseconds across valid non-penalty trials and compares it against human physiological baselines:

* **< 140ms:** Elite Reflex Specification
* **140ms - 199ms:** Pro Athletic Condition
* **200ms - 259ms:** Trained Military Combatant
* **>= 260ms:** Standard Biological Baseline

#### Is my performance data uploaded to any server?

No. Reacnar operates entirely on-device and air-gapped. Your metrics are stored locally in isolated device database files and are never transmitted over a network.

#### How do I delete all my stored analytics data?

Go to the `ANALYTICS` tab, scroll down past your metrics list, and tap `PURGE ALL SYSTEM METRICS`. This permanently deletes all stored reaction logs across all modes.

## Future Development & Architectural Roadmap

```
+-------------------------------------------------------------------+
|                        DEVELOPMENT ROADMAP                        |
+-------------------------------------------------------------------+
|                                                                   |
|   PHASE I: HARDWARE & MOTOR EXPANSION                             |
|   - Multi-Zone Spatial Visual Stimulus Field                      |
|   - Dynamic Audio-Visual Latency Comparison Engine                |
|   - Customizable Micro-Interval Burst Patterns                    |
|                                                                   |
|   PHASE II: TELEMETRY & ANALYTICS ADVANCEMENTS                    |
|   - Gaussian Bell-Curve Reaction Distribution Rendering           |
|   - Extended Rolling Historical Session Trends                    |
|   - Export Local Session Telemetry to CSV/JSON                    |
|                                                                   |
|   PHASE III: ACCESSIBILITY & DISPLAY EXTENSIONS                   |
|   - Ultra-High Refresh Rate (120Hz/144Hz) Display Tuning          |
|   - Extended Color-Blind Accessible Contrast Themes               |
|   - System Haptic Intensity Level Tuning                          |
|                                                                   |
+-------------------------------------------------------------------+

```

## License & Developer Disclosure

**REACNAR // REFLEX FIELD** is released as proprietary high-performance neuro-motor benchmarking software.

All trademarks, visual terminal layouts, design systems, and telemetry profiling specifications associated with **REACNAR** remain the exclusive property of its original software engineers.

* **Official Web Platform:** [https://reacnar.lovable.app](https://www.google.com/search?q=https://reacnar.lovable.app)
* **Central Feedback Channel:** [https://reacnar.lovable.app/contact](https://www.google.com/search?q=https://reacnar.lovable.app/contact)
* **System Specification Build:** Version 1.0.0 (Release June 2026)

`SYSTEM STATUS: OPERATIONAL // TERMINAL READY FOR DISPATCH`