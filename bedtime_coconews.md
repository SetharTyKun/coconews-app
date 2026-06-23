# Bedtime Script — Building CocoNews
### A calm walkthrough of the Flutter news app you are building — its structure, its layers, and all the pieces working together

---

Tonight we are going to walk through something you have been building with your own hands. Not just one concept. The whole thing. The full picture of CocoNews — the Flutter news app you have been putting together piece by piece.

By the time you fall asleep, you will have the entire map of this app in your head. Every layer. Every room. Every connection. And it will feel simple, because it is simple — once you see the shape of it.

So take a breath. Relax. Let's start from the very beginning.

---

## Stage One — What Is This App, Really?

Imagine you are building a newspaper stand. Not a big one. Just a clean, tidy stand on a street corner where someone can walk up, read the top stories, browse by topic, save articles they like, and come back later to find them again.

That is CocoNews. It is a mobile news app. It fetches real articles from the internet, shows them in a beautiful feed, lets you filter by category, and lets you save articles to a personal bookmark list.

That is the whole idea. Simple. Clean. Useful.

Now, the question is — how do you build something like that in Flutter? You do not just throw everything into one big file. You organize it. You give each responsibility its own home. And that is exactly what you have done.

---

## Stage Two — The Shape of the Project

Think of your project like a building with multiple floors and rooms. Each room has a job. No room tries to do everything.

Your app lives inside a folder called lib. And inside lib, you have organized your code into five areas.

The first area is models. This is where you define the shape of your data — what an article looks like, what fields it has, what a news source contains. Think of it like a form template. Every article in your app follows the same template.

The second area is services. This is where your app talks to the outside world. You have one file here — the API service. It sets up the connection to the news website your app fetches from.

The third area is controllers. This is where the logic lives. When a button is tapped, when data is loaded, when something is saved — a controller handles it. You have five controllers, each with their own job.

The fourth area is screens. These are the visual pages the user actually sees and touches. You have four screens right now.

And the fifth area is bindings and utils. Bindings is where you tell the app which controllers to create when it starts. Utils is where you keep small helper tools that are used across the app.

That is the shape of your building. Models, services, controllers, screens, and the glue that holds them together.

---

## Stage Three — The Heart of the App: GetX

Before we go deeper, we need to talk about the engine running underneath everything.

Imagine a scoreboard at a sports game. When the score changes, the scoreboard updates instantly. Everyone looking at it sees the new number right away. Nobody has to manually refresh it. Nobody has to ask "did the score change?" It just changes, and the board reflects it.

That is what GetX does in your app. GetX is a framework — a set of tools — that handles three things: state management, navigation, and dependency injection.

State management means that when your data changes, the screen updates automatically. You do not have to tell Flutter to redraw the screen. If you wrap a widget in something called Obx, it watches the data and redraws itself whenever that data changes. The scoreboard just updates.

Navigation means moving between pages. With GetX, you do not need to write complicated routing code. You just say "go to this route" and it handles the rest. Your app uses named routes like slash home, slash discover, slash save, and slash profile.

Dependency injection means your controllers are created once and shared everywhere. When the home screen needs the home controller, it does not create a new one. It finds the one that already exists. This keeps everything in sync.

GetX is the engine. Everything else sits on top of it.

---

## Stage Four — The Entry Point: main.dart

Every app has a front door. In Flutter, that front door is main.dart.

When your app launches, the very first thing that happens is the splash screen appears. You are using a package called flutter native splash, which shows a clean branded screen while the app is waking up.

Then, two storage boxes are opened. Think of these like two drawers in a filing cabinet. One drawer is called article — it stores cached news. The other drawer is called bookmark — it stores the articles you have saved. These drawers use a package called GetStorage.

Once the drawers are open, the app renders. It uses GetMaterialApp — which is GetX's version of the standard Flutter app widget. This one handles both light mode and dark mode automatically, following your phone's system setting. It also registers all your named routes and sets the initial bindings.

That is the front door. Simple. Quiet. Just waking up the app and handing control over to everything else.

---

## Stage Five — The Shell: Navigation and Lazy Loading

Now here is something clever you have done.

Imagine a TV with four channels. When you first turn on the TV, only channel one is playing. The other channels are not loaded yet — they are just waiting. When you switch to channel two for the first time, it loads. After that, switching between channels is instant because they are already loaded.

That is exactly how your main shell works.

You have a screen called MainShell. It holds a widget called IndexedStack, which keeps all four screens stacked on top of each other but only shows one at a time. You also have a list called activated, which tracks which screens have been loaded.

When you first open the app, only the home screen is activated. When you tap Discover for the first time, the discover screen activates and loads its data. The next time you tap it, it is already there — no reload needed.

At the bottom of the shell is a BottomNavigationBar with four tabs: Home, Discover, Bookmark, and Profile. Each tab has a filled icon when selected and an outlined icon when not selected.

The MainShellController manages all of this. It also removes the splash screen once everything is ready.

---

## Stage Six — The Article Model

Before your app can show news, it needs to understand what a news article is.

Think of a news article like a form with specific fields. Every article has an ID, a title, a description, the full content, a URL to the original story, an image link, a published date, a language, and a source.

The source itself is its own small form — it has an ID, a name, and a URL.

You have modeled this in Dart using a class called ArticleModel. Each field is typed — the date is a DateTime, the source is its own Source object, and so on.

Now here is the part that required some debugging. When you save an article to storage, you need to convert it into a plain map — a simple key-value structure. The tool that does this conversion is called json serializable, and it generates the conversion code for you automatically.

The issue you ran into was that the nested Source object was being saved as a Dart object instead of being converted into a plain map too. The fix was one small addition: you added explicitToJson colon true to the annotation above the class. That told the generator to also convert nested objects, not just the top level. Then you ran build runner, and the generated file was updated.

That generated file, article model dot g dot dart, is the code that does all the converting. You never write it by hand. The tool writes it for you, and you run it whenever the model changes.

---

## Stage Seven — Fetching News: The API Service and Dio

Your app talks to a service called GNews to get real news articles.

To make that communication happen, you use a package called Dio. Think of Dio like a trained courier. You tell it: here is the address you always deliver to, here is how long to wait at the door before giving up, and here is how long to wait for a reply before giving up. After that, whenever you need to send a request, you just hand it the specific path and it handles the rest.

Your API service file creates one Dio instance with the base URL of the GNews website, a connection timeout of ten seconds, a receive timeout of fifteen seconds, and a send timeout of ten seconds.

Your API key — the secret password that lets you access GNews — is stored securely using something called dart define. It never appears in your code as plain text. It comes in through an environment variable.

This one Dio instance is shared across all your controllers. That is cleaner than each controller creating its own connection.

---

## Stage Eight — Connectivity: Are We Online?

Before fetching any news, your app checks one simple question: is the phone connected to the internet?

The ConnectivityController handles this. When the app starts, it checks the current connection status using a package called connectivity plus. If there is no connection, it stays offline. If there is a connection, it marks itself as online.

Every screen in the app watches this. If the phone is offline, instead of showing a loading spinner forever, the screen shows a friendly message: no internet connection.

This is a small touch, but it is the right touch. Apps that silently spin forever when offline feel broken. Yours tells the user honestly what is happening.

---

## Stage Nine — The Home Screen

The home screen is the first thing the user sees every time they open the app.

At the top, it says Top Stories, and underneath it shows today's date — the full day name and month — like Monday, June fifteenth. There is also a small View All button that takes you to the Discover tab.

Below that is the article list.

Now let's talk about what happens behind the scenes when this list appears.

The HomeController wakes up when the app starts. The very first thing it does is check the storage drawer called article. It looks for two things: a saved list of articles, and a timestamp recording when those articles were saved.

If articles exist and they are less than thirty minutes old, the controller reads them from storage and displays them immediately. No network call needed. Fast and quiet.

If the articles do not exist, or they are older than thirty minutes, the controller calls the GNews API, fetches fresh articles, displays them, and then saves them to storage along with a new timestamp.

This pattern — check the cache, use it if fresh, refresh if stale — is called smart caching. It saves your API quota and makes the app feel fast even on slow connections.

Each article card shows a large image at the top, the source name in bold, the article title, and a time ago label at the bottom — like thirty minutes ago or two hours ago. There is also a small three-dot menu on each card with a Save option.

The user can also pull down on the list to force a refresh, bypassing the cache and fetching the latest news immediately.

---

## Stage Ten — The Discover Screen

The Discover screen is where the user can browse news by topic.

At the top is a horizontal scrollable row of category chips. There are nine categories: General, World, Nation, Business, Technology, Entertainment, Sports, Science, and Health.

When a chip is tapped, the DiscoverController fetches news for that category. And just like the home screen, each category has its own cache. If you already loaded Technology articles and they are still fresh, tapping Technology again loads them instantly from storage instead of making another network request.

The selected category chip is highlighted in a dark color. The others stay light. This gives instant visual feedback about which category you are viewing.

The article cards here are laid out slightly differently from the home screen. Instead of a large image at the top, the image is a small square thumbnail on the right side, with the source name and title on the left. It is a more compact layout — better for browsing through many articles quickly.

The Discover screen is essentially the same engine as the home screen — same caching logic, same error handling — just with category awareness built in.

---

## Stage Eleven — Saving and Bookmarking

Now let's talk about one of the most satisfying features you have built: saving articles.

Imagine you are reading a physical newspaper and you tear out an article to keep. You put it in a folder at home. Later, you can open that folder and read it again.

That is your bookmark feature. And it is powered entirely by local storage — no server, no account required.

The BookmarkController manages a storage box called bookmark. This is a separate box from the article cache. Bookmarks are meant to stay until the user removes them, unlike cached news which expires.

When the user taps Save on an article, the bookmark method runs. It reads the current list of bookmarks from storage. Then it checks: is this article already in the list? It checks by ID, using a method called any. If the article is already there, it stops. No duplicates.

If the article is not in the list, it converts the article to a plain map using toJson, adds it to the list, and writes the whole list back to storage. Read, add, write. That pattern again.

Removing a bookmark works the same way in reverse. Read the list, remove the item where the ID matches, write it back.

---

## Stage Twelve — The Bookmark Screen

The bookmark screen is where saved articles live.

It is clean and minimal. The title says Bookmark. The subtitle says your saved articles, all in one place.

If the list is empty, it shows a centered message that just says Empty.

If there are articles, they appear in a compact card layout — similar to the Discover screen — with the newest article shown at the top. The list is reversed so the most recently saved article is always the first thing you see.

Here is the most satisfying part: to remove an article, you swipe it to the left. A red background with a delete icon appears behind the card. If you swipe far enough — at least eighty percent of the way across — the article slides away and is removed from your bookmarks.

This is powered by a Flutter widget called Dismissible. It wraps each card and handles all the swipe animation, the red background, and the trigger. You told it to only trigger on swipes from right to left, and to require an eighty percent swipe threshold before committing to the delete. This prevents accidental deletions.

When the dismiss fires, the removeBookmark method runs, and the list reloads.

---

## Stage Thirteen — The Glue: Bindings and Reactive State

Let's zoom out for a moment and appreciate how all these pieces connect.

When the app starts, AppBindings runs. Think of it as the morning crew setting everything up before the doors open. It creates the ConnectivityController first — because everything else needs to know if there's internet. Then it registers the other four controllers lazily, meaning they are created only when they are first needed.

This is smarter than creating everything upfront. The bookmark controller, for example, does not need to run until the user opens the bookmark tab for the first time.

Now, how does the screen know when to update?

This is where GetX's reactive system shines. Every piece of data that should trigger a UI update is wrapped in an Rx type. RxList for lists. RxBool for true-false values. RxString for text.

When you wrap a widget in Obx, that widget subscribes to the Rx values it reads inside. When any of those values change, the widget rebuilds automatically. Only that widget. Nothing else.

This is why your bookmark icon updates instantly when you save an article. The icon is inside its own Obx, watching the bookmark controller's article list. The moment an article is added, the list changes, and the icon rebuilds. No delay. No manual setState. Just instant feedback.

---

## Stage Fourteen — The Packages You Are Using

Before we close, let's take a quiet inventory of all the tools in your toolbox.

GetX is your main framework — state, navigation, and dependency injection all in one.

Dio is your HTTP client — the tool that sends requests to GNews and handles errors gracefully.

GetStorage is your local storage — a simple, fast key-value store that persists data across app restarts without needing a database.

CachedNetworkImage is what loads article images efficiently. It downloads the image once and stores it, so the same image does not get downloaded twice.

url launcher opens article URLs inside the app using an in-app browser view.

connectivity plus checks whether the device is online.

flutter native splash gives the app a clean launch screen.

json annotation and json serializable, together with build runner, handle the automatic conversion between Dart objects and plain maps.

intl handles date formatting — turning a DateTime object into something readable like Monday, June fifteenth.

And change app package name is a utility tool that makes it easy to rename the app's package identifier when you are ready to publish.

Each of these packages has one job. Each one is small. Together, they make the app feel complete.

---

## Closing

You have built something real. A news app that fetches live articles, caches them intelligently, lets you explore by category, and saves the stories you want to keep. It handles offline gracefully. It updates the UI instantly. It is organized cleanly with each layer having its own responsibility.

You did not do this all at once. You did it one piece at a time — one controller, one screen, one bug fix at a time. And now when you look at the project, you can see how all the rooms connect.

The one sentence to remember is this. CocoNews is a layered Flutter app — models define the data, Dio fetches it, GetStorage keeps it, GetX reacts to it, and four clean screens present it to the user.

Good night.
