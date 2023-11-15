#import "./palettes/xcolor.typ": xcolor
#show heading.where(level: 1): set text(24pt)
#show heading.where(level: 2): set text(20pt)
#show heading.where(level: 3): set text(18pt)
#show heading.where(level: 4): set text(16pt)
#set page(numbering: "1")
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

==== Computational Methods

===== Problem Recognition

The first part of the problem is taking user input and translating it into in-game movement. This movement needs to be calculated on the course, and the ball has to interact with any obstacles in the way. Once this is done as single player, multiplayer would need to be implemented. This involves connecting other players to the game, and synchronising the game state between all players, while using minimal bandwidth. Players can also interact with each other via items, which involves player to player interactions.

===== Problem Decomposition

The different components the game involves are:

+ Connecting to the network to play multiplayer
+ Take user input and and serialise it to send to the server
+ Process multiple players' movements on the server
+ Synchronise state to the client, which shows the ball(s) moving

===== Divide and Conquer

These steps can be solved on their own for the most part, as each component can be designed separately, and implemented modularly.

===== Abstraction

Many different abstractions can be done between these components. When movements are sent to the server, the server is not concerned with what buttons the user pressed, but what direction the ball will move in. This abstraction allows the server to process movement without having to worry about the input method.

Similarly, the client should not have to process collisions with obstacles, but just show the ball moving via instructions from the server. This abstraction allows all players to have synchronised states easily, reduces processing on the client, and makes cheating harder.

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

======= 1. How would you like to control your ball and camera?
I think the most intuitive camera setup would be
- The camera is centred onto the ball.
- You can zoom in and out using the scroll wheel,
- You can click and drag with middle mouse/right click to rotate the camera around the ball,
- You can click and drag with left click to shoot the ball at different levels of power.
(Essentially the same as Golf With Your Friends/Putt Party)
It could be interesting to experiment with some control fine-tuning like gear effect (think Wii Sports where you can shoot the ball along different trajectories by introducing effect), though that probably only makes any real amount of sense in sufficiently large courses.
Lastly, it may be nice to have a way to detach the camera from the ball to scout ahead and discover the course.
======= 2. Should there be items/power-ups, and if so, what should they do?
Given the focus of a "multiplayer arcade-style" game, I do believe there should be power-ups. I feel like the main focus for these power-ups should be affecting every player in the game. Essentially, anything that isn't downright frustrating but is still sufficient to put a wrench in the works for the "victims" should be good. An example of this could be a wind effect that can influence every player's next shot(s).
======= 3. How should the co-op part of the game work?
As far as co-op is concerned, I feel like it's important that players get to play on the same hole simultaneously, especially so when taking power-ups into account. You could then make a decision between whether you want there to be distinct turns (i.e. each player gets to do one swing, then waits for all other players to have finished their swing, until the hole is cleared). Introducing turns in this fashion could make power-ups more impactful as you could have them stay active for a number of turns, making players unable to just wait it out.
======= 4. What kind of music would you like in the background?
You could lean into the arcade side of things and make peppy music you would hear in actual arcade games. Something chiptune-like could also work depending on the graphical style of the game. Overall, as long as the music matches the creative direction of the game, I think a lot of different styles could work. An interesting example here is Golf With Your Friends. This game heavily leans into creative map design with an exploration element, and this is reflected well in the music. The bgm for that game could actually fit pretty well into an RPG-style game.
======= 5. How should you be able to join a multiplayer game (invite code, add via in-game friend, etc.)?
I think at a base level, using invite codes is fine, as long as groups aren't disbanded after each game. Entering an invite code once for a session of play with friends is more than acceptable. If the game were to be launched on a platform such as Steam, integrating with the platform's built-in friends system would be a nice addition. For a standalone game, however, I don't think a friends system is really a hard requirement.

====== Alex

======= 1. How would you like to control your ball and camera?
I would like to control the ball with the mouse, and the camera with the keyboard.
======= 2. Should there be items/power-ups, and if so, what should they do?
Yes, not sure.
======= 3. How should the co-op part of the game work?
A few ideas:
1. One person can edit the course, other one shoots the ball.
2. One player moves the camera, one controls the ball
3. One player has a camera locked onto the ball but can't see where it's going to hit, other player only has a top down view but can see where the ball hits
======= 4. What kind of music would you like in the background?
Tetr.io battle music
======= 5. How should you be able to join a multiplayer game (invite code, add via in-game friend, etc.)?
Invite code / link and friends seem reasonable (so you can play with "strangers" and friends)

====== Gwen

======= 1. How would you like to control your ball and camera?
The camera should loosely follow the ball, if 3d the ball should have a ‘forward’ direction that the camera should follow behind
======= 2. Should there be items/power-ups, and if so, what should they do?
Items/power ups should be available but not necessary to complete a level, they should essentially give the player ability modify the game difficultly
======= 3. How should the co-op part of the game work?
There should be sections of the game that require multiple players to be in different places to achieve a goal
======= 4. What kind of music would you like in the background?
There should be a quiet ambient music at all/most times and louder music based on events that happen in-game
======= 5. How should you be able to join a multiplayer game (invite code, add via in-game friend, etc.)?
Players should be able to send invitations from in a game to other players they want to play with, for the receiver to accept or deny

====== Enoki

======= 1. How would you like to control your ball and camera?
Similar to putt party
======= 2. Should there be items/power-ups, and if so, what should they do?
Yes, ideally more focused on affecting others rather than yourself, more extreme stuff is always more fun
======= 3. How should the co-op part of the game work?
Potentially either have them take turns controlling the ball or have one ball that's not controlled by anyone but everyone has to hit it (like in pool) until it gets in the hole
======= 4. What kind of music would you like in the background?
Anything works
======= 5. How should you be able to join a multiplayer game (invite code, add via in-game friend, etc.)?
In game friend is more steps, a code / url is easier, more transient and more accessible

===== Analysis

From these questions, I now have a more specific set of requirements for my game. I will use these requirements to create a set of success criteria below.

Question 1 has shown that putt party provides an ideal control scheme, but a possible keyboard control as suggested by Alex could be more accessible too.

Question 2's results explain how items provide a different experience for every run of the game, and Enoki suggested that power ups that affect others more than yourself are more fun.

Question 3 is still a bit undecided, but Milan suggested that players should be able to play on the same hole simultaneously, and Gwen suggested that there should be sections of the game that require multiple players to be in different places to achieve a goal.

Question 4's results can be combined into one idea. Arcade-like ambient music, with more intense music for events such as when time is running out.

Question 5 demonstrates a simple URL/code is good enough to join a multiplayer game, and Enoki suggested that an in-game friend system is not necessary but a nice to have.

==== Existing Solutions

===== Putt Party
#image("./images/putt-party.png", height: 250pt)

Putt party is a Discord "activity" built in to voice channels. This is an example of what my game will be like, as it is arcade-style and multiplayer. It can be played many times with different results as there are items in the many courses, and it is not frustrating to lose at. It implements multiplayer very well as you just join the same voice channel as your friends. It is simple to understand as the controls are just drag and point with the mouse, and it is not too graphically intensive. It is also not too long, as each hole has a time limit.

One of the downsides though is that you all have to have Discord to be able to play together. The window is quite small as it is a small section of the voice channel overview, so is difficult to see sometimes, especially on smaller screens like laptops.

====== Parts of Putt Party I Can Apply

Multiple of my interviewees have mentioned the controls of putt party, or similar controls. I will take inspiration from this as a way to control the ball.

===== Bomb Party
#image("./images/bomb-party.png", height: 250pt)

Bomb Party is a small party game where you have to type words based on a prompt. It is fast-paced, multiplayer, and has a competitive aspect. It is simple to understand as the controls are just typing, and it is not too graphically intensive. It is also usually not too long as you can configure turn limits and difficulty. The multiplayer aspect is implemented with a 4 letter code that can be entered or used via a link (`domain.tld/CODE`).

====== Parts of Bomb Party I Can Apply

The multiplayer aspect of Bomb Party is something I can apply to my game. It is simple to understand and easy to use, so I will use a similar system in my game. This system was supported by Enoki, Alex and Milan in their responses.

===== Pico Park
#image("./images/pico-park.png", height: 250pt)

Pico Park is a co-operative multiplayer game where you have to work together to complete levels. It also has simple graphics and has short levels, which can get quite difficult as it requires co-ordination of multiple people. It is simple to understand as the controls are just arrow keys and space.

====== Parts of Pico Park I Can Apply

I will consider the ways they make players work together and see how they can fit in a golf-style game. Gwen suggested to look at this game as it has a co-operative aspect.

===== Golf With Your Friends
#image("./images/golf-with-your-friends.png", height: 250pt)

Golf With Your Friends is a 3D multiplayer golf game. It has a bit more complex graphics compared to the other games, but still simple to understand. It has a lot of different courses, and a lot of different game modes. It has a lot of replayability as there are many different ways to play the game. It is also not too long as each hole has a time limit. It has both online and local multiplayer support. There are no items but it has the concept of choosing where to hit your ball, and the power of the shot which makes the controls more complex.

====== Parts of Golf With Your Friends I Can Apply

As this is a 3D game, I can take into consideration how the camera follows the ball on this, which was mentioned by Milan and Gwen in their responses. I can also look at how local multiplayer works too to consider adding.

==== Features of the Proposed Solution

My solution will be a game with a main menu to select whether to host a room, join a room or change settings. When entering a round, there will be a heads-up display with information about the game such as the time left, scoreboard, and the current hole. The controls will be drag and point, the camera will follow the ball but still be possible to rotate with the mouse or keyboard, and the power of the shot will be controlled by how far you drag the mouse. There will be items that affect other players, and there will be a co-operative aspect to the game as a separate game mode. There will be a simple URL/code to join a multiplayer game, and there will be arcade-style ambient music.

==== Limitations of the Proposed Solution

My game would require a Wi-Fi connection. It could use a LAN for local play, but not bluetooth. This is a limitation as school/college Wi-Fi can be unreliable or not accessible at times, and some students may not have access to Wi-Fi at home.

Some visual impairments may be a limitation too. As the game will be 3D, it may be difficult to interpret with a visual impairment. I will try to make the game as accessible as possible with changes such as a high contrast interface, but it may not be possible to make it accessible for all visual impairments.

The game will be controlled with a keyboard and mouse. This is a limitation as some students may not have access to a mouse, or may not be able to use a mouse due to a physical impairment. This would not be something I can solve completely initially, but a low amount of keyboard inputs would mean they can be remapped to a controller or an accessible input device.

The game could also act as a distraction from revision or school work. This is a limitation as it is not the intended purpose of the game. This could be solved by having a setting to lock the game at certain times of the day, but this could be bypassed by changing the system time.

=== Requirements

==== Stakeholder Requirements

// where to split design vs functionality?
===== Design
#table(
  columns: (1fr, 1fr),
  align: top,
  [*Requirement*], [*Explanation*],
  [Main menu], [The game should have a main menu so the player can choose what to do.],
  [Full screen and windowed], [The option of full screen is useful for smaller screens like laptops, but windowed is useful for large screens like desktops.],
  [Simple to understand], [The game should be simple to understand so it is easy to pick up and play.],
  [Simple graphics], [The game should have simple graphics so it is not too graphically intensive.],
  [Simple controls], [The game should have minimal controls so it can be learned straight away.],
  [Following camera], [The camera should follow the ball so the player can see where they are going.],
)

===== Functionality
#table(
  columns: (1fr, 1fr),
  align: top,
  [*Requirement*], [*Explanation*],
  [High Contrast Colour Palette], [The game should have a high contrast colour palette so it is accessible to people with visual impairments, whilst also looking playful too.],
  [Drag and point controls], [The controls should be drag and point so it is simple to understand.],
  [Power of shot controlled by drag], [The power of the shot should be controlled by how far the player drags the mouse.],
  [Items that affect other players], [There should be items that affect other players so the game is more interesting.],
  [Co-operative aspect], [There should be a co-operative aspect to the game so players can work together if they wish.],
  [Simple URL/code to join a multiplayer game], [There should be a simple URL/code to join a multiplayer game so it is easy to join.],
  [Arcade-style ambient music], [There should be arcade-style ambient music so it is not too distracting.],
)

===== Hardware and Software
#table(
  columns: (1fr, 1fr),
  align: top,
  [*Requirement*], [*Explanation*],
  [Keyboard and mouse], [The game should be playable with a keyboard and mouse.],
  // TODO:
  [Minimum ...], [The game should be playable on a minimum of ... (pc specs, todo, no realistic target right now).],
  [Windows >=10, macOS >=13.1, Linux x86_64], [These are the operating system versions that the game should be at minimum playable on.]
)

==== Measurable Success Criteria for the Proposed Solution

// What I will actually do to solve the stakeholder requirements ("buttons with clear text")
#table(
  columns: (1fr, 1fr),
  align: top,
  [*Criteria*], [*How to get evidence*],
  [Clear main menu], [Screenshot of the main menu and user feedback.],
  [Full-screen and windowed options], [Screenshot of the application being full-screen and windowed.],
  [Simple to understand controls], [Screenshot of the controls menu and user feedback of the controls.],
  [In-game camera follows the ball], [Screenshot which shows the ball is visible at all times.],
  [High Contrast Colour Palette], [Screenshot of the game interface and relevant contrast ratios.],
  [Drag and point controls], [Screenshot of the ball being controlled.],
  [Power of shot controlled via dragging the ball], [Screenshot of the ball being controlled.],
  [Items that affect other players], [Screenshot of the items in effect during gameplay.],
  [Multiplayer functionality], [Screenshot of game with multiple players],
  [Co-operative aspect], [Screenshot and explanation of the co-operative aspect.],
  [Simple URL/code to join a multiplayer game], [Screenshot of the URL/code being used.],
  [Arcade-style ambient music], [The code for the music, and where it came from.],
  [Keyboard and mouse controls], [Screenshot of the controls menu.],
  [Includes a settings menu], [Screenshot of the settings menu.],
  [Simple graphics], [Screenshot of the game, and framerate/GPU usage statistics with user feedback.],
  [Scoreboard], [Screenshot of the scoreboard.],
  [Time limit], [Screenshot of the time limit.],
  [Configurable controls], [Screenshot of the controls menu.]
)

== Design

Key points:
- Interface design
- Program structure
- Algorithms - validation
- Features
- Key variables/data structures/classes
- Testing approach