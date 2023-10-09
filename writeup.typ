#import "./palettes/xcolor.typ": xcolor
#show heading.where(level: 1): set text(24pt)
#show heading.where(level: 2): set text(20pt)
#show heading.where(level: 3): set text(18pt)
#show heading.where(level: 4): set text(16pt)
#set text(14pt)

#page[
#set align(center)
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

#page[
// Strong 2nd level.
#show outline.entry.where(level: 2): it => {
  strong(it)
}
// Hide main title.
// Hide after 4th level, at least for now since that has the specific "existing solutions", which looks weird and clutters.
#let sel = range(2, 5).fold(heading.where(level: 2), (s, d) => s.or(heading.where(level: d)))

#outline(target: sel, indent: 1em, title: text(16pt)[Contents])
]

== Analysis

=== Problem Identification

In exam time, students can get stressed from revising for exams. Many students use video games as a way to escape from revision from time to time, but many games require too much of a time investment to be able to play for short periods of time. Multiplayer games can help during exam time as it can be a time to socialise during breaks while revising. Many recent games also require powerful computers to run the graphics requirements they meet, so I propose a game which has simpler graphics, shorter round times, and is multiplayer.

==== Clients
My users are a group of 16-19 year old students which sometimes play video games. Many of them prefer smaller games where you do not have to worry if you have time to finish the game/round. Many of them also have low powered laptops, so a game that is easier on the graphics is more enjoyable due to less lag.

=== Interview

==== First Interview

===== Interview Questions

The clients I have chosen to interview have played arcade-style games before. The aim of my first interview is to gather a general idea of mechanics and play styles that my clients enjoy. I will ask them questions about similar games they have played, and what they liked and disliked about them.

1. Have you played a multiplayer arcade-style game before?
2. If so, how many different games in this genre have you played?
3. What were your favourite parts of these games?
4. What were your least favourite parts of these games?
5. What would you like to see in a game like this?

===== Responses

// TODO: Set name headings to be a different colour to differentiate names and questions.
====== Milan

======= 1. Have you played a multiplayer arcade-style game before?
Yes, I have.
======= 2. If so, how many different games in this genre have you played?
Probably something around 20. The new Discord activities, Golf With Your Friends, Ultimate Chicken Horse, etc.
======= 3. What were your favourite parts of these games?
I particularly enjoy how these games facilitate a competitive environment while not being particularly frustrating to lose. Compared to real competitive games, it's easy to jump into a game like this with a group of friends and just have a good time trying to win, even if you end up doing poorly.
======= 4. What were your least favourite parts of these games?
Generally, there's a very simple premise behind this type of game. After a couple hours of play it can feel like I've seen everything the game has to offer, which leads to me growing tired of such a game particularly quickly.
======= 5. What would you like to see in a game like this?
5. This mostly relates to my answer to (4.), where I think some extra thought into replayability can go a long way. Something like impactful power-ups can drastically change the flow of a game, which can go a long way towards keeping it interesting.
======= Extra Comments
Another pretty cool example of this is Ultimate Chicken Horse, where the whole premise of the game is to have the players "create" the levels on the fly in a match. Each player gets to pick one of a few random items at the beginning of each round which they then place. Levels generally start off impossible to clear so players need to cooperate to make it winnable, and from there they start placing stuff to make it hard to clear. The goal of the game is to clear the stage while making others unable to clear it.

====== Alex

======= 1. Have you played a multiplayer arcade-style game before?
Yes
======= 2. If so, how many different games in this genre have you played?
At least 10
======= 3. What were your favourite parts of these games?
Playing against/with friends --> competition / teamwork
======= 4. What were your least favourite parts of these games?
When someone is a lot better than the rest of the group (skill gap)
======= 5. What would you like to see in a game like this?
Skill levelling (chess.com has this when playing with friends, making it harder for one of the players)

====== Gwen

======= 1. Have you played a multiplayer arcade-style game before?
Yes
======= 2. If so, how many different games in this genre have you played?
About 5
======= 3. What were your favourite parts of these games?
I like it when the rules are pretty simple but the game can be played in different ways based on the player
======= 4. What were your least favourite parts of these games?
I don't like it when seemingly benign aspects of a game (i.e. character selection or locations on a map) give a player an unfair advantage over their competitors
======= 5. What would you like to see in a game like this?
More collaboration between teammates
======= Extra Comments
I like Pico Park where several players (2+) have to learn and use the physics system of the game to their advantage, reach certain checkpoints, and use teamwork in order to complete a level. I want more of that in arcade-style games.

====== Enoki

======= 1. Have you played a multiplayer arcade-style game before?
Yes
======= 2. If so, how many different games in this genre have you played?
10-15
======= 3. What were your favourite parts of these games?
The multiplayer aspect of it with different player interacting with each other in meaningful ways
======= 4. What were your least favourite parts of these games?
The meta progression that some games have that give players unfair advantages over others
======= 5. What would you like to see in a game like this?
Players being able to hijack other players' controls

===== Analysis

From those questions, I have gathered a general idea of what my clients would like to see in a game like this. They would like to see a game that is simple to understand, but has a lot of replayability. They would also like to see a game that has a competitive aspect, but is not frustrating to lose. They would also like to see a game that has a multiplayer aspect, but is not unfair to players that are new to the game. Every game should act almost ephemeral in a way, where the previous game does not affect the next game. This keeps it to the arcade style as standard arcade games do not have progression between games.

A co-operative aspect is something that Milan, Alex and Gwen mentioned in their responses. This could be something implemented as an extra game-mode in the game, but it would not be the main focus of the game. It would be something that could be played if the players wanted to, but it would not be forced upon them.

==== Second Interview

In this second interview, I asked my clients more specific questions about the mechanics of the game. I asked about the controls, the camera, the items and the co-op aspect of the game. This allows me to curate success criteria for my game, and a set of requirements that I can use to make my game.

===== Interview Questions

+ How would you like to control your ball and camera?
+ Should there be items/power-ups, and if so, what should they do?
+ How should the co-op part of the game work?
+ What kind of music would you like in the background?
+ How should you be able to join a multiplayer game (invite code, add via in-game friend, etc.)?

===== Responses

====== Milan
====== Alex

/*
1. Camera that follows the ball, click on ball to shoot ball, everywhere else to move the cam (putt party)
2. Yes, not sure
3. A few ideas: 1. One person can edit the course, other one shoots the ball. 2. One player moves the cam one the ball 3. One player has a camera locked onto the ball but cant see where its going to hit other player only has a top down view but can see where the ball hits
4. tetr.io battle music
5. invite code / link and friends seem reasonable (so you can play with "strangers" and friends)
*/

====== Gwen

/*
1. the camera should loosely follow the ball, if 3d the ball should have a ‘forward’ direction that the camera should follow behind
2. items/power ups should be available but not necessary to complete a level, they should essentially give the player ability modify the game difficultly
3. there should be sections of the game that require multiple players to be in different places to achieve a goal
4. there should be a quiet ambient music at all/most times and louder music based on events that happen in-game
5. players should be able to send invitations from in a game to other players they want to play with, for the receiver to accept or deny
*/

====== Enoki

=== Research

==== Existing Solutions

// TODO: Evaluate how you can pair up in multiplayer modes (invite code, link, search)

redoing examples
// putt party
// bomb party
// pico park
// scrabble.io

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

waiting on interview responses for full requirements list
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
// TODO: Look at pacman example, quite a few generic stuff.
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
