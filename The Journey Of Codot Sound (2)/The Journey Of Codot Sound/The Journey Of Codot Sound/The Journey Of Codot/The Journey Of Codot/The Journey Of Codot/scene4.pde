class Scene5 {

  int scene = 5;
  // Global variables for pocong position, movement, and status
  float pocongX = width / 4; // Initial X position of pocong, in the middle of the screen
  float pocongY = height / 5; // Initial Y position of pocong, above the ground
  float pocongSpeed = 0.15; // Horizontal movement speed of pocong
  float jumpAmplitude = 5; // Jump amplitude
  float jumpSpeed = 0.1; // Jump frequency
  float pocongAlpha = 255; // Alpha for fading effect, starting at 255 (opaque)

  // Position of clouds and teenagers
  float[] cloudX = {200, 600, 400}; // Initial X positions for clouds
  float[] cloudY = {200, 150, 100};
  float cloudSpeed = 0.5; // Speed of clouds
  float[] x = {700}; // Initial X position for teenagers

  // Unique attributes for each teenager
  color[] bodyColors = {color(255, 204, 0)};
  float[] bodyHeights = {50};
  float[] headSizes = {20};
  color[] hairColors = {color(0)};

  int numClouds = 3;

  Scene5() {
    // No initialization needed for setup, move it to the constructor
  }

  void display() {
    drawSky();
    drawGround(); // Draw the ground including the pocong
    drawSun(); // Draw the sun
    drawClouds(); // Draw the clouds
    drawTrees(); // Draw the trees
    drawTeenagers();
    drawPocong(pocongX, pocongY, 0.8, pocongAlpha);
  }

  void drawSky() {
    background(25, 25, 112); // Dark blue color for the almost night sky
  }

  void drawGround() {
    fill(100, 50, 0); // Brown color for forest ground
    noStroke();
    rect(0, height / 2, width, height / 2); // Bottom half of the screen

    // Logic for pocong movement
    if (pocongX > 0) { // Move left until reaching the left edge of the screen
      pocongX -= pocongSpeed; // Move left
      pocongY = height / 2 + 100 + sin(frameCount * jumpSpeed) * jumpAmplitude; // Jumping effect for pocong
    } else {
      // If pocong reaches the left edge (0), we can add additional logic if needed.
      // For example, we can gradually fade out the pocong or stop it in place.
      pocongAlpha -= 5; // Decrease alpha for fading out effect
      if (pocongAlpha < 0) pocongAlpha = 0; // Ensure alpha does not go below 0
    }

    // Draw pocong on the ground
    if (pocongAlpha > 0) {
      drawPocong(pocongX, pocongY, 0.8, pocongAlpha);
    }
  }

  void drawSun() {
    fill(255, 165, 0); // Orange color for the setting sun
    noStroke();
    ellipse(700, 100, 100, 100); // Draw sun at the same position as before
  }

  void drawClouds() {
    // Call drawCloud function for each cloud
    for (int i = 0; i < numClouds; i++) {
      drawCloud(cloudX[i], cloudY[i], 1.5);

      // Update cloud positions
      cloudX[i] += cloudSpeed;

      // Reset cloud position if it moves off screen
      if (cloudX[i] > width + 50) {
        cloudX[i] = -50;
      }
    }
  }

  void drawCloud(float x, float y, float scale) {
    pushMatrix();
    translate(x, y);
    scale(scale);
    fill(150);
    noStroke();
    ellipse(0, 0, 50, 50);
    ellipse(20, 0, 50, 50);
    ellipse(40, 0, 50, 50);
    ellipse(20, -20, 50, 50);
    popMatrix();
  }

  void drawTrees() {
    float startXTrees = 50; // Starting from the left edge of the screen for trees
    float startYTrees = height / 2 + 200; // Lower on the ground
    float treeSpacing = 70; // Reduced tree spacing for denser forest
    float treeHeight = 100; // Tree height

    for (int i = 0; i < 3; i++) { // 3 rows of trees horizontally
      for (int j = 0; j < 5; j++) { // Draw 5 trees on the left side of the screen only
        float offsetXTrees = j * treeSpacing; // Horizontal distance between trees
        float offsetYTrees = i * 80; // Vertical distance between tree rows tighter
        drawTree(startXTrees + offsetXTrees, startYTrees + offsetYTrees, treeHeight);
      }
    }
  }

  void drawTree(float x, float y, float height) {
    pushMatrix();
    translate(x, y);

    // Tree trunk
    fill(139, 69, 19); // Dark brown
    rect(-5, 0, 10, -height);

    // Tree leaves
    fill(34, 139, 34); // Leaf green
    ellipse(0, -height, 80, 80);
    ellipse(-20, -height - 20, 60, 60);
    ellipse(20, -height - 20, 60, 60);

    popMatrix();
  }

  void drawTeenager(float x, float y, color bodyColor, float bodyHeight, float headSize, color hairColor) {
    // Draw body
    fill(bodyColor);
    rect(x - 10, y, 20, bodyHeight); // body

    // Draw head
    fill(255, 220, 177);
    ellipse(x, y - 20, headSize, headSize); // head

    // Draw facial details
    fill(0);
    ellipse(x - 4, y - 22, 3, 3); // eye

    // Draw hair
    fill(hairColor);
    arc(x, y - 27, 25, 15, PI, TWO_PI);

    // Draw arms (reverse direction for left and right arms)
    fill(bodyColor);
    pushMatrix();
    translate(x - 15, y + 10);
    rect(0, 0, 10, 30); // left arm
    popMatrix();

    pushMatrix();
    translate(x + 5, y + 10);
    rect(0, 0, 10, 30); // right arm
    popMatrix();

    // Draw legs (reverse direction for left and right legs)
    fill(0);
    pushMatrix();
    translate(x - 5, y + bodyHeight);
    rect(0, 0, 10, 30); // left leg
    popMatrix();

    pushMatrix();
    translate(x + 5, y + bodyHeight);
    rect(0, 0, 10, 30); // right leg
    popMatrix();
  }

  void drawTeenagers() {
    for (int i = 0; i < x.length; i++) {
      // Set the position of the teenager
      float posX = width * 3 / 4; // Place the teenager at 3/4 the width of the screen
      float posY = height * 3 / 4; // Place the teenager at 3/4 the height of the screen
      drawTeenager(posX, posY, bodyColors[i], bodyHeights[i], headSizes[i], hairColors[i]);
    }
  }

  void drawPocong(float x, float y, float scale, float alpha) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    // Set alpha for fading effect
    tint(255, alpha); // Use alpha value for transparency effect

    // Body with polkadot pattern
    fill(255, 182, 193);
    noStroke();
    rect(-15, -30, 30, 60, 10);

    // Polkadot pattern
    fill(255, 0, 0);
    ellipse(-5, -15, 4, 4); // Dot 1
    ellipse(5, -10, 4, 4); // Dot 2
    ellipse(0, 0, 4, 4); // Dot 3
    ellipse(7, 5, 4, 4); // Dot 4
    ellipse(1, 9, 4, 4); // Dot 5

    // Head
    fill(255, 182, 193);
    ellipse(0, -45, 30, 30);

    // Eyes
    fill(0);
    ellipse(-5, -50, 5, 5);
    ellipse(5, -50, 5, 5);

    // Mouth
    ellipse(0, -40, 10, 5);

    // Wrapping
    stroke(255, 182, 193);
    strokeWeight(2);

    // Triangle above head
    fill(255, 182, 193);
    triangle(-15, -75, 15, -75, 0, -60); // Sharp angle below

    // Triangle below feet
    triangle(-10, 45, 0, 25, 10, 45); // Adjusting position of triangle below feet

    popMatrix();
  }
}
