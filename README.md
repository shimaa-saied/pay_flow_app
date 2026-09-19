# PayFlow — Feature Study Guide

A personal finance Flutter app built with Clean Architecture. This document maps every app feature to the concepts you must study to implement it.

---


## Tech Stack at a Glance

| Layer | Technology |
|-------|-----------|
| UI | Flutter Widgets, Material Design |
| State Management | BLoC / Cubit (`flutter_bloc`) |
| Architecture | Clean Architecture (Domain / Data / Presentation) |
| Immutable State | `freezed` + `build_runner` |
| Routing | `go_router` |
| Backend | Firebase Auth + Cloud Firestore |
| HTTP Client | Dio + Retrofit |
| Dependency Injection | GetIt |

---

## Feature Map

---

### 1. Authentication (Login / Logout)

**What it does:**
Email/password login via Firebase. Persists session across restarts. Redirects unauthenticated users to login.

**Key files:**
- `lib/features/auth/presentation/screens/login_screen.dart`
- `lib/features/auth/presentation/widgets/login_form_widget.dart`
- `lib/features/auth/presentation/cubit/auth_cubit.dart`
- `lib/features/auth/presentation/cubit/auth_state.dart`

**What to study:**

| Topic | Why You Need It |
|-------|----------------|
| Firebase Authentication | Sign in with email/password, handle FirebaseAuthException codes |
| BLoC / Cubit | Manage loading, authenticated, unauthenticated states |
| `freezed` unions | Define sealed state types (`AuthState`) |
| `ChangeNotifier` / `UserSession` | Keep a global in-memory session object that the router listens to |
| `go_router` redirects | Guard routes — unauthenticated → `/login`, authenticated → `/` |
| Form validation in Flutter | Validate email/password before submitting |
| `BlocConsumer` | Listen for state changes (show SnackBar) + rebuild UI |

---

### 2. Home Screen 

**What it does:**
Displays the bank card with current balance, live USD→EUR exchange rate, and the 5 most recent transactions.

**Key files:**
- `lib/features/home/presentation/screens/home_screen.dart`
- `lib/features/home/presentation/cubit/account_cubit/account_cubit.dart`
- `lib/features/home/presentation/cubit/exchange_rate_cubit/exchange_rate_cubit.dart`
- `lib/core/widgets/bank_card_widget.dart`

**What to study:**

| Topic | Why You Need It |
|-------|----------------|
| BLoC / Cubit | `AccountCubit` holds balance, currency, and transaction list |
| `BlocBuilder` | Rebuild card and list when state changes |
| Firestore real-time streams | `snapshots()` stream keeps balance up-to-date automatically |
| Stream subscriptions in Cubit | Listen to a Firestore stream inside `loadAccount()` |
| Clean Architecture — Use Cases | `GetTransactionsUseCase` isolates business logic from UI |
| Dio + Retrofit | Call the Frankfurter API for the exchange rate |
| `ExchangeRateCubit` | Separate Cubit for exchange rate to keep concerns isolated |
| `ListView.builder` | Render the transaction list efficiently |

---

### 3. Transaction History Screen

**What it does:**
Full list of all transactions in reverse-chronological order.

**Key files:**
- `lib/features/home/presentation/screens/history_screen.dart`
- `lib/features/home/presentation/widgets/transaction_tile_widget.dart`

**What to study:**

| Topic | Why You Need It |
|-------|----------------|
| `BlocBuilder` | Read transaction list from `AccountCubit` |
| Firestore ordering | Query ordered by date descending |
| `ListView.builder` | Render variable-length lists |
| Date formatting | `DateFormatter` utility to display readable dates |
| `go_router` navigation | Navigate to `/history` from the home screen |

---

### 4. Send Money (Withdraw)

**What it does:**
Input an amount, subtract it from the balance, save a `withdraw` transaction to Firestore.

**Key files:**
- `lib/features/send/presentation/screens/send_screen.dart`
- `lib/features/send/presentation/widgets/send_header_widget.dart`

**What to study:**

| Topic | Why You Need It |
|-------|----------------|
| `TextEditingController` | Capture and clear the amount input |
| Input validation | Parse amount, check > 0 and ≤ balance |
| `AccountCubit.withdraw()` | Business logic that validates balance and calls `AddTransactionUseCase` |
| Clean Architecture — Use Cases | `AddTransactionUseCase` adds a transaction without UI knowing about Firestore |
| `BlocListener` | Show error SnackBar when withdrawal fails |
| Firestore writes | `add()` on a subcollection to persist the transaction |

---

### 5. Receive Money (Deposit)

**What it does:**
Input an amount, add it to the balance, save a `deposit` transaction to Firestore.

**Key files:**
- `lib/features/receive/presentation/screens/receive_screen.dart`
- `lib/features/receive/presentation/widgets/receive_header_widget.dart`

**What to study:**

| Topic | Why You Need It |
|-------|----------------|
| `TextEditingController` | Capture and clear the amount input |
| Input validation | Parse amount, check > 0 |
| `AccountCubit.deposit()` | Business logic that calls `AddTransactionUseCase` |
| Clean Architecture — Use Cases | Same `AddTransactionUseCase` reused by both Send and Receive |
| `BlocListener` | Show error SnackBar on failure |
| Firestore writes | Persist deposit transaction to user subcollection |

---

### 6. Profile Screen

**What it does:**
Shows user email, account status, device model and OS version. Has a sign-out button.

**Key files:**
- `lib/features/profile/presentation/screens/profile_screen.dart`
- `lib/features/profile/presentation/widgets/` (5 widget files)
- `lib/core/services/device_info_service.dart`

**What to study:**

| Topic | Why You Need It |
|-------|----------------|
| `device_info_plus` package | Retrieve phone model and OS version at runtime |
| `FutureBuilder` | Display async device info in the UI |
| `BlocBuilder` | Read email from `AuthCubit` |
| `AuthCubit.logout()` | Sign out of Firebase and clear `UserSession` |
| Widget decomposition | Break a screen into small, single-responsibility widgets |
| `GetIt` service locator | Retrieve `DeviceInfoService` singleton anywhere |

---

### 7. Main Layout (Bottom Navigation)

**What it does:**
Shell that holds all 4 tabs (Home, Send, Receive, Profile). Preserves tab state. Loads exchange rate on startup.

**Key files:**
- `lib/features/main_layout/presentation/screens/main_layout.dart`

**What to study:**

| Topic | Why You Need It |
|-------|----------------|
| `IndexedStack` | Keep all 4 screens alive simultaneously (no state loss on tab switch) |
| `BottomNavigationBar` | Build the tab bar and track selected index |
| `StatefulWidget` | Track `_currentIndex` locally |
| `initState` | Trigger `ExchangeRateCubit.fetchRate()` when layout first mounts |
| `BlocListener` | Show global error SnackBars from `AccountCubit` |
| `MultiBlocProvider` | Provide both `AccountCubit` and `ExchangeRateCubit` to the widget tree |

---

## Cross-Cutting Concerns

### Clean Architecture
Every feature with data follows three strict layers:

```
Presentation  →  Domain  →  Data
(Cubit/Screen)   (UseCase / Entity / Repository interface)   (Repository impl / DataSource / Model)
```

**What to study:**
- **Entities**: Plain Dart classes with no framework dependency
- **Repository pattern**: Abstract interface in domain, concrete class in data
- **Use Cases**: One class, one public method, one responsibility
- **Dependency inversion**: Cubits depend on abstract interfaces, not concrete classes

---

### Dependency Injection (GetIt)
All dependencies are registered in `lib/core/dependency_injection/injection.dart` and resolved without `BuildContext`.

**What to study:**
- `GetIt.instance.registerSingleton` vs `registerFactory`
- Service locator pattern
- When to use singletons (repositories, services) vs factories (Cubits)

---

### Routing (go_router)
Routes are declared in `lib/core/router/app_router.dart`. Auth guards use `redirect` callbacks.

**What to study:**
- Defining named routes with `GoRoute`
- `redirect` callback for auth guards
- `context.go()` vs `context.push()`
- Listening to `UserSession` (ChangeNotifier) to trigger router refresh

---

### Immutable State (freezed)
All Cubit state classes use `freezed` unions.

**What to study:**
- `@freezed` annotation and `freezed_annotation` package
- `build_runner` code generation (`dart run build_runner build`)
- Union types and `.when()` / `.maybeWhen()` pattern matching
- Why immutable state prevents subtle bugs in reactive UIs

---

### Error Handling
Errors propagate from data → domain → presentation as typed `Failure` objects.

**What to study:**
- Abstract `Failure` class + `ServerFailure` / `NetworkFailure` subclasses
- Catching exceptions in repository implementations and wrapping them
- Mapping `Failure` to user-readable strings inside Cubits
- Firebase error codes (e.g., `user-not-found`, `wrong-password`)

---

### Real-Time Data (Firestore Streams)
The balance and transaction list update automatically without polling.

**What to study:**
- Firestore `.snapshots()` and what a `QuerySnapshot` is
- `StreamSubscription` in a Cubit — subscribe in `loadAccount()`, cancel in `close()`
- Mapping Firestore `DocumentSnapshot` to domain entities

---

### Networking (Dio + Retrofit)
The exchange rate is fetched from the Frankfurter REST API.

**What to study:**
- Dio instance configuration (base URL, timeouts, interceptors)
- `PrettyDioLogger` for debug logging
- Retrofit `@GET` annotations and auto-generated API clients (`api_services.g.dart`)
- Parsing JSON responses into model classes

---

## Study Priority Order

If you are starting from scratch, learn in this sequence:

1. **Flutter basics** — Widgets, StatefulWidget, BuildContext, layout
2. **Dart fundamentals** — async/await, Streams, abstract classes
3. **BLoC / Cubit** — State management, `BlocBuilder`, `BlocListener`, `BlocProvider`
4. **Firebase Auth** — Email/password sign-in, error handling
5. **Cloud Firestore** — CRUD operations, real-time streams, subcollections
6. **Clean Architecture** — Layers, repository pattern, use cases, dependency inversion
7. **freezed** — Code generation, immutable state, union types
8. **GetIt** — Service locator, singletons vs factories
9. **go_router** — Declarative routing, guards, navigation
10. **Dio + Retrofit** — HTTP requests, interceptors, generated clients