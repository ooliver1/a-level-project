#show heading.where(level: 1): set text(24pt)
#show heading.where(level: 2): set text(20pt)
#show heading.where(level: 3): set text(18pt)
#show heading.where(level: 4): set text(16pt)
#set text(14pt)

= Title Pending

Styling, page breaks and content is a work in progress.

// Strong 2nd level.
#show outline.entry.where(level: 2): it => {
  strong(it)
}
// Hide main title.
#let sel = range(2, 100).fold(heading.where(level: 2), (s, d) => s.or(heading.where(level: d)))

#outline(target: sel, indent: 1em, title: text(16pt)[Contents])

== Analysis

=== Problem Identification
In exam time, students can get stressed from revising for exams. Many students use video games as a way to escape from revision from time to time, but many games require too much of a time investment to be able to play for short periods of time. Multiplayer games can help during exam time as it can be a time to socialise during breaks while revising. Many recent games also require powerful computers to run the graphics requirements they meet, so I propose a game which has simpler graphics, shorter round times, and is multiplayer.

=== Clients
My users are a group of 15-19 year old students which sometimes play video games. Many of them prefer smaller games where you do not have to worry if you have time to finish the game/round. Many of them also have low powered laptops, so a game that is easier on the graphics is more enjoyable due to less lag.

=== Existing Solutions

==== playscrabble.com

#image("./images/playscrabble.png", height: 250pt)

`playscrabble.com` is an online implementation of the Scrabble word board game. It has multiplayer and single-player against the computer.

Some good things about this include the fact that you can add a time limit to games. The interface is easy to understand for the most part, with the game on one side and information about the game itself on the other. There is also a dark interface which is a good accessibility feature for the visually impaired.

One downside with online scrabble is the fact that it requires a lot of skill to get good at the game. The time limit also limits the time on your turn quite drastically, so you are forced to rush your turn.

==== chess.com

#image("./images/chess.png", height: 250pt)

`chess.com` is an online implementation of the Chess board game. It also has multiplayer and single-player against the computer.

This game also has the ability to add a time limit to games. The game is the main centre of the interface, taking up most of the screen. This also has a dark interface for accessibility. You can play against a friend or via matchmaking online, which is useful if nobody else is available to play.

One downside is the fact that chess requires a lot of initial knowledge to be able to play, and a high skill cap which is not as good for playing against friends.

=== Features of the Proposed Solution

=== Limitations of the Proposed Solution

// Accessibility, network requirement, ...

=== Solution Requirements Specification

// List of basic requirements like "camera view is ..."

=== Measurable Success Criteria for Proposed Solution
