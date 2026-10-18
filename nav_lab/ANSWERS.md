# Lab 5 – Navigation & Routing: answers

## How to run a task

Every task is a separate file with its own `main()` in `lib/categoryN/task_M.dart`. Run one with:

```
flutter run -t lib/category3/task_4.dart
```

## Questions asked inside the tasks

**1.2 – System back button.** On C it goes back to B, on B it goes back to A, and on A it closes the app because there's nothing left in the stack.

**4.5 – Back arrow on /rate.** `pushNamed<int>` gives back `null`. Home checks for `null` and keeps the old text ("not rated", or the previous rating).

**6.1 – Why is there no back arrow after `go`?** `context.go('/details')` swaps the whole stack for the stack that matches `/details`. `/details` is a top-level route, so it's the only page left and there's nothing to pop. `context.push` puts Details on top of Home, so you get the back arrow and `pop()` works.

**6.3 – `extra` after a browser reload.** `extra` lives only in memory and isn't part of the URL, so after a reload it's `null` (the code shows a fallback screen). A path parameter like `/product/2` is in the URL itself. It survives reloads, deep links and shared links, so it's safer.

## Self-check questions

1. **push vs pushReplacement.** `push` adds a new screen on top and keeps the current one below it, so the user can go back. `pushReplacement` removes the current screen and puts the new one in its place, so the user can't go back to it. A typical use is Login → Home.

2. **Why keep route names in constants?** If names are plain strings scattered around the code, a typo like `'/setings'` only shows up when the app runs. With constants (`AppRoutes.settings`) the compiler catches the mistake, autocomplete helps, and renaming a route means changing one line.

3. **Returning a value.** The second screen calls `Navigator.pop(context, value)`. The first screen waits for it with `final result = await Navigator.push<T>(...)`. If the user presses the system back button or the AppBar arrow, `result` is `null`, so always handle `null`. Also check `if (!mounted) return;` after the `await`.

4. **context.go vs context.push.** `go` moves to a location and rebuilds the stack to match that URL, replacing what was there. `push` adds the page on top of the current stack, like `Navigator.push`, so `pop` goes back to the previous page.

5. **Path parameter vs extra.** Use a path parameter when the data can be written as a short string (an id, a slug) and the page should work from a URL: web reloads, deep links, bookmarks, sharing. `extra` is only for passing a ready-made in-memory object for convenience, and the page has to cope with it being lost.
