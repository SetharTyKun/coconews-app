# Bedtime Script — Keeping Tabs Alive: How Apps Handle Their Bottom Navigation
### A calm walkthrough of two different ways apps build their tabs, and three real apps that show you the difference

---

Tonight we are going to talk about something small that you have touched a thousand times without ever thinking about it. The little bar at the bottom of almost every app you use. Home. Search. Profile. A few icons, side by side, waiting for your thumb.

You already know what it does. Tap one icon, and a new screen appears. Tap another, and it changes again. Simple, on the surface. But underneath that simple tap, the app has to make a quiet decision, every single time. And tonight, we are going to sit with that decision until it feels completely clear. Then you can let it go, and drift off.

---

## The Why — Two Doors Into the Same Problem

Imagine you are scrolling through a long list of photos. You scroll down, and down, past dozens of them, until you find the one you wanted to look at again later. Then you get distracted. You tap over to your profile tab, just to check something. A few seconds later, you tap back to that photo list.

Here is the quiet question the app has to answer in that moment. Are you dropped back exactly where you left off, still looking at that same photo, scroll position and all? Or does the list reset, scrolled all the way back to the top, as if you had never been there?

That single difference, whether your place is remembered or forgotten, comes from a decision made far away from you, deep inside the way the app was built. And there are two main ways to make that decision.

---

## The Analogy — A Theater With Several Stages

Let's step away from screens for a moment and picture a theater. Not an ordinary one. This theater has several stages, side by side, under one roof. Each stage has its own play running on it. Actors in place. Props arranged. Lights set just so.

Now imagine you, the audience, sitting in a chair that can spin around. When you want to watch a different play, someone simply turns your chair to face a different stage. The play you were just watching does not stop. It keeps going quietly behind you, actors still mid-scene, exactly where they were. You can spin back at any moment and find it waiting for you, untouched.

That is one way to run a theater. Every stage is built. Every play is running. Nothing is torn down. You just choose where to look.

Now picture a different theater. This one has only one stage. When you ask for a different play, the crew rushes in, tears down the entire set you were just watching, and builds a brand new one from scratch. New props. New lighting. The actors from before are gone, and when you ask for that first play again, it has to be built all over again, from the very beginning.

Both theaters can put on the same plays. But they cost very different things, and they leave you with very different experiences.

---

## Back to the App — Building Only the Tab You Tap

Now let's bring this back to your app. In the first kind of theater, the one-stage version, the app only ever builds the screen for the tab you are currently looking at. The moment you tap a different tab, the screen you were just viewing is taken down completely. Its place in memory is cleared. And when you come back to it later, it is built fresh, from the very top.

This feels light and efficient at first. The app is not holding onto anything it does not need right now. But it comes with a cost. Your scroll position is gone. If you had typed something into a search box, it is gone too. Any small animation that was playing simply stops existing. Every return to that tab feels like walking into an empty room that has to be furnished all over again before you can sit down.

---

## The Other Way — A Stage That Never Goes Dark

Now let's bring back the many-stage theater. In an app, this approach is often built using something called an IndexedStack. Do not worry about the name. What matters is what it does. It builds every single tab's screen, all of them, right from the start, and it keeps every one of them alive in the background, even the ones you are not currently looking at. When you tap between tabs, nothing is being torn down and nothing is being rebuilt. The app is simply turning your chair to face a different, already-running stage.

This is why, in some apps, switching tabs feels instant and your place is always exactly where you left it. The scroll position is still there. The half-typed search is still there. Nothing had to start over, because nothing ever stopped.

---

## The Trade-off — What You Gain, What You Pay For

Of course, nothing comes for free. Keeping every stage running, all of the time, means the theater needs more staff, more lighting, more resources running in the background, even for stages nobody is watching right now. In an app, this shows up as a little more memory being used, since every tab's screen is sitting there, alive, even the ones currently out of view.

Building only one stage at a time uses fewer resources moment to moment, but it asks the audience, and the user, to wait a little, and to lose their place, every time they wander off and come back.

Neither choice is simply right or wrong. It depends on what the app cares about more. A feeling of instant, seamless movement between tabs, or a lighter footprint while it runs.

---

## Three Real Apps, Three Choices

Let's look at how this plays out in apps you likely already have on your phone. Watch closely the next time you use them, and you will start to notice these patterns for yourself.

### Instagram — The Feed That Remembers Where You Left It

Open Instagram, and scroll partway down your feed. Then tap over to your profile, look around, and tap back to the home tab. Notice how you land exactly where you were, mid-scroll, as if no time had passed at all. That smooth return is the feeling of a stage that never went dark. Your place in that feed was being held the entire time you were looking elsewhere.

### Spotify — The Search That Waits For You

Open Spotify, and type something into the search tab. A song, an artist, anything at all. Then jump over to your library, browse for a moment, and come back to search. More often than not, your search and its results are still sitting there, waiting, as though you never left. That waiting search box is a small, quiet sign that the screen was kept alive in the background rather than wiped clean.

### WhatsApp — Three Tabs, Three Lives Lived at Once

Open WhatsApp, and look at the tabs along the top or bottom, depending on your version. Chats, updates, calls. Scroll through your chat list, then switch over to check your updates, then come back. Your chat list is usually still scrolled to where you left it. Three small worlds, each one quietly continuing to exist, even while your attention is somewhere else.

---

## Closing

So there you have it. Two different ways of building the same simple bar of icons at the bottom of a screen. One tears down and rebuilds each time, light but forgetful. The other builds everything once and simply hides what you are not looking at, heavier but endlessly patient, always remembering exactly where you left things.

The one sentence to remember is this. Keeping every tab alive in the background, the way a theater keeps every stage lit, is what lets an app remember your place, while rebuilding only the tab you tap is lighter, but asks you to start over every single time you return.

Good night.
