
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
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#challenges-and-score-system">Challenges and score system</a></br>
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#technologies">Technologies</a></br>
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#visual-and-audio">Visual and audio</a></br>
<a href="https://github.com/gperretta/AlgaExperience/blob/main/README.md#process">Process</a></br>
  
<br/><br/>
![Group-1](https://user-images.githubusercontent.com/113616815/216680862-2ce8eef5-4923-4d78-9cee-17a5d8c5b758.png)

  <h2>Gameplay and game mechanics</h2>

As the game begins, the player will see the plant going out of its manhole (or sprout-hole) while the robotic bugs will start surrounding the little harmless plant. 
The player's task is to destroy the incoming bugs by swiping on them in any direction, preventing the enemies from taking away the plant's three lives, represented by its leaves. Each time a bug will get to the plant, the plant will lose a live, retire back in the sprout-hole and them come back up with a leave missing. 
When the plant will have lost all its leaves, the game is going to end as the sprout dies with the planet Earth last chance of survival. 

  <h2>Challenges and score system</h2>

The game is based on a scoring system, where the player can earn 10 points for each robotic bug destroyed. The more bugs get killed, the higher their score is, while the game progressively becomes more challenging with more enemies appearing and approaching the plant to attack in an increasily faster way. Additionally, the enemies will enter the game scene from different points, decided with a certain quantity of randomness, which means their arrival will be not predictable. 

  <h2>Technologies</h2>

The whole game was developed in Xcode, using Swift as a programming language and SpriteKit, an Apple framework to build high-performance and battery-efficient 2D games. 
Thanks to SpriteKit, we were able to apply physics effects to different objects on the scene, to implement a collision detection system between the plant node and the enemy nodes to acknowledge the attack and to add cool animations both the plant and the moving bugs. 
The game also contains an opening screen, a lore screen with an animated text resembling a typography effect and, of course, a game over screen, where the final score of the player will be displayed. 
The highest score will be saved each time using Apple's UserDefaults and then it's going to be showed as a comparison with the last score earned. 

  <h2>Visual and audio</h2>

The whole game is pixel-art-styled with a strong callback to the 80s. 
All the game assets were created from scratch using Aseprite, a pixel-art tool and image editor, by the team's designers. 
On the other hand, the audio was created by playing real instruments or recording voices and sounds and editing the tracks and noises obtained with Apple's GarageBand. 

  <h2>Process</h2>

Sprout is a product of a two-weeks project at the Apple Developer Academy. I've been able to work in a team of four, with another developer and two designers.

<h2> Personal contribution </h2>

My main tasks have been:
- game scenes and nodes rendering,
- core game mechanics implementation with swipe gestures reading,
- score system.

