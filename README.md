# Task_26 – Flutter Shopping App

This project is a Flutter app with **Login**, **Profile**, and **category-based product listing**. It demonstrates handling of **NestedScrollView with pinned headers and sticky tabbar**

---

## My Approach to Solve the Scrolling Problem

- I used **`NestedScrollView`** to combine a scrollable content area with **pinned headers**.
- The **Search Bar** and **TabBar** are implemented as `SliverPersistentHeader` with `pinned: true`, so they stay visible while scrolling.
- For the **product lists under each tab**, I used `CustomScrollView` with `SliverList` to ensure smooth scrolling.
- `SliverOverlapAbsorber` and `SliverOverlapInjector` were used to handle the **overlap of pinned headers and scrollable lists**, which solves the common scrolling issues in nested slivers.
- Each tab has its **own API** and **lazy loading**, so data is fetched only when the user opens a tab for the first time. This prevents unnecessary network calls and improves performance.
- **Reactive state management** with GetX (`RxList` and `Obx`) automatically updates the UI when data changes.

---

## Trade-offs

_- Each `CustomScrollView` per tab adds a very small/minor memory overhead.
- I did not implement pagination for product lists due to time constraints, so fetching large lists may affect performance on slower devices. can be implemented in future.
- Error handling is basic: currently only shows messages; advanced retry logic or offline caching is not implemented.

---

## Limitations

- No pagination or infinite scrolling implemented.
- No persistent search/filter for products across tabs.
- Profile screen only displays basic user info; advanced settings are not included.
- The app assumes backend APIs are always available and does not handle offline mode.
