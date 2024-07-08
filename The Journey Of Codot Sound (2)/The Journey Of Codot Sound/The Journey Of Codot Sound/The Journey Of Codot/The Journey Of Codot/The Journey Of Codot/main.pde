import ddf.minim.*;

Minim minim;
AudioPlayer[] sceneAudios; // Array to store audio files for each scene

int currentScene = 1; // Active scene starts at 1
int totalScenes = 7; // Total number of scenes
int[] sceneDurations = {39, 36, 22, 48, 64, 30, 3}; // Duration of each scene in seconds
int lastSceneChangeTime; // Time when the last scene change occurred

scene1 sceneOne; // Instance of scene1
Scene2 sceneTwo; // Instance of Scene2
Scene3 sceneThree; // Instance of Scene3
Scene4 sceneFour; // Instance of Scene4
Scene5 sceneFive; // Instance of Scene5
Scene6 sceneSix; // Instance of Scene6
Scene7 sceneSeven; // Instance of Scene7

void setup() {
  size(800, 800);

  // Initialize Minim
  minim = new Minim(this);

  // Load audio files for each scene
  sceneAudios = new AudioPlayer[totalScenes];
  sceneAudios[0] = minim.loadFile("sound1.mp3");
  sceneAudios[1] = minim.loadFile("sound1a.wav");
  sceneAudios[2] = minim.loadFile("sound3.wav");
  sceneAudios[3] = minim.loadFile("sound4.wav");
  sceneAudios[4] = minim.loadFile("sound3.wav");
  sceneAudios[5] = minim.loadFile("sound5.wav");
  sceneAudios[6] = minim.loadFile("sound5.wav");

  // Check if audio files are loaded successfully
  for (int i = 0; i < totalScenes; i++) {
    if (sceneAudios[i] == null) {
      println("Error loading audio file for scene " + (i + 1));
      exit();
    }
  }

  // Record the initial time
  lastSceneChangeTime = millis();

  // Start playing audio for the first scene
  sceneAudios[currentScene - 1].play();

  // Initialize scenes
  sceneOne = new scene1();
  sceneTwo = new Scene2();
  sceneThree = new Scene3();
  sceneFour = new Scene4();
  sceneFive = new Scene5();
  sceneSix = new Scene6();
  sceneSeven = new Scene7();
}

void draw() {
  // Calculate elapsed time
  int elapsedTime = millis() - lastSceneChangeTime;

  println("Current Scene: " + currentScene);
  println("Audio Duration: " + sceneDurations[currentScene - 1]);

  // If elapsed time exceeds the duration of the current scene, switch to the next scene
  if (elapsedTime > sceneDurations[currentScene - 1] * 1000) {
    // Stop and rewind current audio
    sceneAudios[currentScene - 1].pause();
    sceneAudios[currentScene - 1].rewind();

    currentScene++;
    if (currentScene > totalScenes) {
      currentScene = 1; // Return to the first scene after the last scene
    }
    lastSceneChangeTime = millis(); // Reset scene change time

    // Start playing audio for the new scene
    sceneAudios[currentScene - 1].play();
  }

  // Display the active scene
  switch (currentScene) {
    case 1:
      sceneOne.display();
      break;
    case 2:
      sceneTwo.display();
      break;
    case 3:
      sceneThree.display();
      break;
    case 4:
      sceneFour.display();
      break;
    case 5:
      sceneFive.display();
      break;
    case 6:
      sceneSix.display();
      break;
    case 7:
      sceneSeven.display();
      break;
    // Add cases for other scenes as needed
  }
}

void stop() {
  // Stop all audio and clean up Minim when the application stops
  for (int i = 0; i < totalScenes; i++) {
    if (sceneAudios[i] != null) {
      sceneAudios[i].close();
    }
  }
  minim.stop();
  super.stop();
}
