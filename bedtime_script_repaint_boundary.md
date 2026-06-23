# Bedtime Script — Why your dark mode toggle felt laggy, and the calm fix called RepaintBoundary
### A walk through rooms, painters, and giving each screen its own glass box

---

Tonight we are going to talk about something small that you noticed, but that hides something much bigger underneath. You flipped a switch. Just one switch, on one screen. And the app felt a little slow, just for a moment. Tonight, we find out why. And then, we find the fix. Take your time. There is nothing to rush here.

---

## The Why — before we get to how

Before we talk about what is happening inside your app, let's talk about why this even matters. A smooth app feels alive. It feels like it is listening to you, responding the moment you touch it. A laggy app, even for half a second, breaks that feeling. It is a tiny crack in the glass. And the strange thing is, the crack you noticed on your settings screen was never really about the switch at all. It was about three other rooms in your house that you could not even see.

Let's go there now. Slowly.

---

## The House — setting the scene

Imagine your app is a house. Not a small one. A house with four rooms. One room is called Home. Another is called Discover. Another is Bookmark. And the last one, the one you were standing in, is called Setting.

Now, in most houses, when you are not in a room, the door is closed and the lights are off. Nobody is keeping that room ready and waiting. But your house is a little different. Your house keeps all four rooms fully built, fully furnished, and fully lit, all of the time, even the ones you are not standing in. The furniture stays in place. The lights stay on. The walls stay painted. All four rooms exist, together, at once, even though you can only stand in one of them.

This is not a flaw. It is a choice you made, because it means when you walk into another room, everything is already exactly how you left it. No waiting. No rebuilding furniture from scratch. That part is good.

But it comes with a cost. And that cost is what we are about to uncover.

---

## The Light Switch — what really happened

Now, somewhere in this house, there is a master light switch. Not just for one room. For the whole house. When you flip it, every wall in every room is told the same thing, at the same time. Change your color. Right now.

This is what dark mode really is. It is not a setting that lives quietly inside the Setting room. It is a broadcast that reaches every wall in every room of the house, whether that room's door is open or closed, whether you are standing in it or not.

So when you tapped that switch, here is what actually happened. The walls in your Setting room heard the broadcast and changed color, yes. But so did the walls in Home. So did the walls in Discover. So did the walls in Bookmark. All four rooms, repainting their walls, at the exact same moment, even though your eyes could only see one of them.

That is the real reason it felt laggy. You were not waiting for one room to repaint. You were waiting for four.

---

## The Architect and the Painter — two different jobs

Now here is the important part, so let's slow down even further.

There are two different jobs happening inside your house whenever something changes. The first job belongs to the architect. The architect's job is to redraw the blueprint. To decide, on paper, where every wall, every table, every chair should go, based on the new instructions. This part is usually fast. Paper and pencil. Quick decisions.

The second job belongs to the painter. The painter's job is to actually pick up a brush, dip it in color, and physically cover every wall, every surface, with new paint. This part takes real time and real effort. This is the slow part. This is the part you actually feel.

When the light switch was flipped, the architect rushed to all four rooms and redrew the blueprints. That part, by itself, is not what made things feel slow. What made things feel slow is that the painter also rushed to all four rooms, and tried to repaint every single wall in every single room, all at once, all in the same breath.

Remember this difference. The architect plans. The painter paints. The painter is the expensive one.

---

## RepaintBoundary — the glass box around each room

So now, finally, we arrive at the fix. And it is a gentle one. It does not ask you to tear down any walls or remove any rooms. It simply asks you to give each room its own glass box.

Picture it like this. Around each of your four rooms, you now place a tall, clear glass wall, sealing that room off from the others. The room is still there. The furniture is still there. The architect can still walk in and redraw the blueprint whenever the broadcast goes out. Nothing about that changes.

But now, when the painter arrives, something different happens. The painter only needs to step inside the glass box of the room that actually needs new paint on its visible surface. The paint that already dried on the other rooms, sealed safely behind their own glass, does not need to be touched again. It is simply reused, exactly as it was, frame after frame.

This glass box is what we call a RepaintBoundary. It does not stop the architect from doing the planning work. But it stops the painter from redoing work that was already finished and is sitting there, perfectly fine, behind its own seal.

When you wrap each of your four rooms in this glass box, the master light switch can still reach every wall, and every wall can still update its plan. But the heavy, physical work of actually painting gets contained, room by room, instead of spilling across the whole house at once. And that containment is what gives you back the smoothness you were missing.

---

## Bringing it back

So if your screens still feel a little slow even after adding the glass boxes, remember there is a second, deeper option. You can choose not to keep all four rooms built and furnished at once. You can choose to only build a room the first time someone actually walks through its door. That way, the broadcast from the light switch only ever has to reach the rooms that truly exist yet. But that is a bigger renovation, for another night. Tonight, the glass box is enough.

---

## Closing

You noticed something small, a flicker of slowness in one switch, and underneath it was a whole house quietly repainting itself, room by room, wall by wall, all at once. Now you know why, and now you know the fix. Each room gets its own glass box, so the painter only ever touches what truly needs new color.

The one sentence to remember is this. A RepaintBoundary gives each part of your screen its own sealed glass box, so when something changes, only the part that truly needs repainting gets repainted, and everything else simply stays as it was.

Good night.
