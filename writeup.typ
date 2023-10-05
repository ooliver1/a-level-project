#import "./palettes/xcolor.typ": xcolor
#show heading.where(level: 1): set text(24pt)
#show heading.where(level: 2): set text(20pt)
#show heading.where(level: 3): set text(18pt)
#show heading.where(level: 4): set text(16pt)
#set text(14pt)

#align(center)[
Oliver Wilkes

Nottingham College

#linebreak()
#text(18pt)[
  Computer Science

  Programming Project
]

= \<title>

#linebreak()
#text(16pt, fill: xcolor.royal-purple)[
2023/24
]
]
#pagebreak()

// Strong 2nd level.
#show outline.entry.where(level: 2): it => {
  strong(it)
}
// Hide main title.
// Hide after 4th level, at least for now since that has the specific "existing solutions", which looks weird and clutters.
#let sel = range(2, 5).fold(heading.where(level: 2), (s, d) => s.or(heading.where(level: d)))

#outline(target: sel, indent: 1em, title: text(16pt)[Contents])
#pagebreak()

// TODO: sub headings for analysis, such as "research", "requirements", "Questionnaire" where the current headings lie.
== Analysis

=== Problem Identification

In exam time, students can get stressed from revising for exams. Many students use video games as a way to escape from revision from time to time, but many games require too much of a time investment to be able to play for short periods of time. Multiplayer games can help during exam time as it can be a time to socialise during breaks while revising. Many recent games also require powerful computers to run the graphics requirements they meet, so I propose a game which has simpler graphics, shorter round times, and is multiplayer.

==== Clients
My users are a group of 15-19 year old students which sometimes play video games. Many of them prefer smaller games where you do not have to worry if you have time to finish the game/round. Many of them also have low powered laptops, so a game that is easier on the graphics is more enjoyable due to less lag.

=== Questionnaire

=== Research

==== Existing Solutions

// TODO: Evaluate how you can pair up in multiplayer modes (invite code, link, search)

===== ogcopen.com
#image("./images/ogcopen.png", height: 250pt)

`ogcopen.com` is an online 3D golf game. It has multiplayer with random people and groups.

This game has high-detail graphics to look similar to real golf, as well as complex controls for the ball such as intensity, accuracy and placement.

Unfortunately it does not seem to have settings for UI theme and does not seem to respect browser text size in some places. This makes it difficult to read for visually impaired people.

This game is a bit too complex for the style of game I am looking for. The controls are too hard to understand, and there are too many elements like equipment and training. I am going more for a crazy golf style game where anyone can get started with a shallow learning curve.

===== Backyard Mini Golf
#image("./images/backyard-mini-golf.png", height: 250pt)

`Backyard Mini Golf` is a 2D mini golf game. It is single-player only with levels.

Despite it not having multiplayer, the interface is similar to what I am looking for. Simple and easy to understand, no initial skill required. The text is large but not intrusive, and there are no complicated elements added.

One disadvantage is that you cannot rotate the camera around the ball, so you are stuck with a static orthogonal camera where you can only pan. The green/yellow colour scheme looks all "yellow" with protanopia and deuteranopia colour blindness.

===== playscrabble.com
#image("./images/playscrabble.png", height: 250pt)

`playscrabble.com` is an online implementation of the Scrabble word board game. It has multiplayer and single-player against the computer.

Some good things about this include the fact that you can add a time limit to games. The interface is easy to understand for the most part, with the game on one side and information about the game itself on the other. There is also a dark interface which is a good accessibility feature for the visually impaired.

One downside with online scrabble is the fact that it requires a lot of skill to get good at the game. The time limit also limits the time on your turn quite drastically, so you are forced to rush your turn.

===== chess.com
#image("./images/chess.png", height: 250pt)

`chess.com` is an online implementation of the Chess board game. It also has multiplayer and single-player against the computer.

This game also has the ability to add a time limit to games. The game is the main centre of the interface, taking up most of the screen. This also has a dark interface for accessibility. You can play against a friend or via matchmaking online, which is useful if nobody else is available to play.

One downside is the fact that chess requires a lot of initial knowledge to be able to play well, and a high skill cap which is not as good for playing against friends.

==== Features of the Proposed Solution

// TODO:
// Main menu, scoreboard, time remaining, what controls (drag mouse, how to pan (mouse, keyboard option))

==== Limitations of the Proposed Solution

My game would require a Wi-Fi connection. It could use a LAN for local play, but not bluetooth. This is a limitation as school/college Wi-Fi can be unreliable or not accessible at times, and some students may not have access to Wi-Fi at home.

Some visual impairments may be a limitation too. As the game will be 3D, it may be difficult to interpret with a visual impairment. I will try to make the game as accessible as possible with changes such as high contrast, but it may not be possible to make it accessible for all visual impairments.

The game will be controlled with a keyboard and mouse. This is a limitation as some students may not have access to a mouse, or may not be able to use a mouse due to a physical impairment. This would not be something I can solve completely initially, but a low amount of keyboard inputs would mean they can be remapped to a controller or an accessible input device.

// TODO:
// They may play to distract from college/revision?

=== Requirements

==== Stakeholder Requirements

// TODO: Requirements by stakeholders ("simple to understand")
===== Design
#table(
  columns: (1fr, 1fr),
  align: horizon,
  [*Requirement*], [*Explanation*]
)

===== Functionality
#table(
  columns: (1fr, 1fr),
  align: horizon,
  [*Requirement*], [*Explanation*]
)

===== Hardware and Software
// TODO: Look at pacman example, quite a few generic shiz.
==== Functionality
#table(
  columns: (1fr, 1fr),
  align: horizon,
  [*Requirement*], [*Explanation*]
)

==== Measurable Success Criteria for Proposed Solution

// What I will actually do to solve the stakeholder requirements ("buttons with clear text")
#table(
  columns: (1fr, 1fr),
  align: horizon,
  [*Criteria*], [*How to get evidence*]
)
