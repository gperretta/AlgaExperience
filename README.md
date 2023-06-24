
<h1>
  <p align="center">
    SPROUT
  </p>
</h1>
</br>

> Fight. Grow. Heal the world with the power of nature. 

</br></br>
"Sprout" is a pixel-art-style mobile game revolving around a little plant, a sprout, being the last living creature on a dying Earth. 

As the sprout is the last and only hope of the planet, the player's mission is to protect it from the robotic bugs that threaten its existence.
</br></br>

<h3>Table of contents</h3>
 
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#gameplay-and-game-mechanics">Gameplay and game mechanics</a></br>
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#score-and-game-complexity">Score and game complexity</a></br>
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#technologies-and-softwares">Technologies and softwares</a></br>
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#visual-and-audio">Visual and audio</a></br>
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#process-and-contributions">Process and contributions</a></br>
  
<br/><br/>
![Group-1](https://user-images.githubusercontent.com/113616815/216680862-2ce8eef5-4923-4d78-9cee-17a5d8c5b758.png)

  <h2>Gameplay and game mechanics</h2>

As the game begins, the player will see the plant going out of its manhole (or sprout-hole) while the robotic bugs will start surrounding the little harmless plant. 
The player's task is to destroy the incoming bugs by swiping on them in any direction, preventing the enemies from taking away the plant's three lives - represented by its leaves. Each time a bug will get to the plant, the plant will lose a live, retiring back in the sprout-hole and them coming back up. 
When the plant will have lost all its leaves, the game is going to end as the sprout dies for good. 

  <h2>Score and game complexity</h2>

The game is based on a scoring system, where the player can earn 10 points for each robotic bug destroyed. The more bugs get killed, the higher the score is, while the game progressively becomes more challenging with more enemies appearing and approaching the plant to attack in an increasily faster way. Additionally, the enemies will enter the game scene from different positions, decided with a certain quantity of randomness, which means their arrival will not be predictable. 

  <h2>Technologies and softwares</h2>

The whole game was developed in Xcode, using Swift as a programming language and SpriteKit, an Apple framework to build high-performance and battery-efficient 2D games. 
Thanks to SpriteKit, we were able to apply physics effects to different objects on the scene, to implement a collision detection system between the plant node and the enemy nodes to acknowledge the attack and to add cool animations both the plant and the moving bugs. 

  <h2>Visual and audio</h2>

The whole game is pixel-art-styled with a strong callback to the 80s. 
All the game assets were created from scratch using Aseprite, a pixel-art tool and image editor, by our two designers. 
On the other hand, the audio was created by one of the designers as well, using Apple's GarageBand. 

  <h2>Process and contributions</h2>

Sprout was entirely created by a team of four, two developers and two designers/game artists, during a two-weeks game-jam as a project for the Apple Developer Academy, hence the choice of developing a game for iPhone only.
As one of the developers, my main tasks and responsabilities have been:
- game scenes and nodes rendering, such as the spawning of the enemies in random starting positions;
- core game mechanics implementation with swipe gestures reading, such as the enemies movement patterns, their speed and their death as well and the increasing game complexity;
- scoring system, adding to the players' score 10 points for each bugs they killed.

