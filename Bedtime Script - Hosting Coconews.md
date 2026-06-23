# Bedtime Script — How We Host Coconews
### A calm walkthrough of where your app lives, what went wrong, and how we quietly fixed it

---

Tonight we are going to talk about something you just finished. Not the code itself, but the part that comes after the code. The part where your app stops being a project on your computer, and becomes something the whole world can open with a single link.

We are going to talk about hosting. We are going to talk about a problem that showed up out of nowhere. And we are going to talk about the small, clever piece you added to solve it. Take your time with this one. There is no rush tonight.

---

## Stage One — What Hosting Really Means

Before we go anywhere else, let's slow down on one idea. What does it actually mean to host an app.

Think of your Flutter project as a book you have been writing, alone, at your desk. Right now, that book only exists on your desk. If a friend wants to read it, you would have to hand them the actual pages.

Hosting is the moment you take that book and place it on a shelf inside a public library. Once it is on that shelf, anyone, anywhere, can walk in and read it. They do not need your desk. They do not need your laptop. They just need the address of the library, and the name of the shelf.

That address, in your case, became a simple line of text. Something like coconews-app dot web dot app. That is the shelf. That is the library. And the library you chose to use is called Firebase Hosting.

---

## Stage Two — Firebase, the Library

Firebase Hosting is exactly that kind of library. You handed it a finished, built version of your app, and it placed that version on a shelf with a public address. From that point on, anyone who typed that address into a browser would see your news app open up, fully formed, ready to scroll.

This part went smoothly. You built your app for the web, you ran a single command, and Firebase quietly took care of placing it on the shelf. No drama. No surprises.

The drama came later. And it came from a very specific, very sneaky direction.

---

## Stage Three — The First Problem, Hiding in Plain Sight

Here is something important to understand before we get to the problem itself. Your news app does not contain its own news. It does not have stories sitting inside it waiting to be shown. Instead, every time someone opens the app, it reaches out to another service, far away, called GNews, and asks it a simple question. What is happening in the world right now.

Think of GNews as a separate building. A newsroom, sitting somewhere else entirely, with fresh headlines printed every few minutes. Your app sends a runner over to that newsroom and says, give me today's top stories, please.

Now here is the important part. That runner needs a key to even be let inside the newsroom. Not a metal key, but a secret password, proving that the runner is allowed to ask for stories at all. You had that password. It was tucked quietly into your app.

When your app ran on a phone, this worked beautifully. The runner showed up, gave the password, and walked out with the news.

But something different happened the moment your app started living inside a web browser instead of a phone.

---

## Stage Four — Why Browsers Are More Suspicious Than Phones

Let's pause here and build a clearer picture, because this is the heart of tonight's story.

Imagine two different messengers. One messenger works for a phone. The other works for a browser, like Chrome or Edge.

The phone messenger is trusting. If you hand it a request and a password, it walks straight to the newsroom, knocks, hands over the password, and brings back whatever it is given. No questions asked.

The browser messenger is far more cautious. Browsers have a strict, built in rule. Before they let any website talk to a building they do not fully trust, they check one thing first. They ask the building, quietly, behind the scenes, are you expecting requests from this particular website. If the building does not specifically say yes, the browser messenger refuses to even deliver the response back to the website. It simply stops, and reports that something went wrong.

This rule is called CORS, but the name does not matter. What matters is the idea. Browsers act like cautious doormen, and they will only let a conversation happen if the other building has explicitly agreed to talk to that exact website.

GNews, the newsroom, had never agreed to talk to your website specifically. It was perfectly happy to answer your phone messenger, because phones are not bound by this doorman rule. But the moment your browser messenger tried to deliver the news back into your app, the doorman stepped in and blocked it.

That is why you saw an error. Not because your password was wrong. Not because GNews was broken. Simply because the browser refused to let the conversation complete, since GNews never gave it permission in writing.

---

## Stage Five — The Second, Quieter Problem

While we are here, there is a second issue worth understanding, because it is connected, even though it feels separate.

Remember that secret password your app uses to enter the newsroom. When you build an app for the browser, everything inside that app, every word, every secret, gets folded into a bundle of code that is sent to the visitor's browser so it can run there.

This means the password was not just inside your app anymore. It was sitting inside a file that anyone visiting your website could open and read, the same way you might find a sticky note left on a desk in a room anyone could walk into. It was not stolen by anyone clever. It was simply visible, because of how browsers work.

So you were facing two problems at once. The doorman refusing to let your messenger through, and a password that was no longer truly secret once it reached the browser.

---

## Stage Six — The Solution, a Trusted Go-Between

Here is where the story turns calm again, because the fix for both problems turned out to be the same fix.

Instead of having your website messenger run directly to the GNews newsroom, you built a small, trusted go-between. Picture a quiet assistant standing exactly halfway between your website and the newsroom. This assistant is not a browser. It does not follow the cautious doorman rule at all, because it is simply a small program running on a service, in your case, a service called Cloudflare Workers.

Here is how the new arrangement works. Your website no longer asks GNews for anything directly. Instead, it asks your own assistant. The assistant, who is not a browser and is not bound by the doorman rule, walks over to GNews, knocks, hands over the password, and brings the news back. Then the assistant hands that news to your website.

And because this assistant is something you built and control, you taught it to speak the browser's language. You taught it to say, yes, I welcome requests from your website, so the doorman has no reason to object anymore.

The password itself moved too. Instead of living inside your app, where any visitor's browser could see it, it now lives quietly inside the assistant, stored as something called a secret. Visitors to your website never see it. Only the assistant knows it, and the assistant never shows its private notes to anyone passing by.

So now, the full journey of a single news request looks like this. Your website asks your assistant. Your assistant asks GNews, using the password it keeps safely to itself. GNews answers the assistant. The assistant hands that answer back to your website, wrapped in exactly the permission slip the browser was asking for all along.

No doorman objects anymore, because the assistant always carries the right paperwork. And no password is left lying around, because it never leaves the assistant's side.

---

## The Big Picture — Putting It All Together

Let's say the whole thing once more, slowly, from the very top.

Your app lives on a shelf inside a library called Firebase Hosting, reachable by anyone with the address.

Your app does not store its own news. It asks a separate newsroom called GNews, using a secret password.

When your app ran on a phone, this worked immediately, because phones are trusting messengers.

When your app moved into a browser, a cautious doorman appeared, refusing to let the newsroom's answer through, because the newsroom had never agreed to speak with your specific website. At the very same time, the secret password became visible to anyone looking closely at your website's code, simply because of how browsers receive and run code.

To fix both problems together, you built a small, trusted assistant using Cloudflare Workers. This assistant stands between your website and the newsroom, keeps the password safely to itself, and always carries the right paperwork for the doorman.

Now your app, sitting quietly on its shelf, asks the assistant for news. The assistant fetches it, and hands it back, smoothly, every single time.

---

## Closing

That is the whole story of how coconews learned to live safely on the open web. Nothing about your news, your design, or your app itself had to change. Only the path the request travels had to be adjusted, so that the right doors would open, and the right secrets would stay hidden.

The one sentence to remember is this. Browsers will not let your app talk directly to a service that has not agreed to it, and a secret living inside a browser is no longer truly secret, so a small trusted go-between solves both problems at once.

Good night.
