class scene1 {
  int scene = 1;
  float[] x = {350, 400, 450}; // initial x positions for the teenagers
  float[] y = {height * 0.75 - 100, height * 0.75 - 100, height * 0.75 - 100}; // initial y positions for the teenagers
  float[] cloudX = {100, 300, 500}; // initial x positions for the clouds
  float cloudSpeed = 0.5; // speed of the clouds

  // Unique attributes for each teenager
  color[] bodyColors = {color(255, 204, 0), color(0, 204, 255), color(204, 0, 255)};
  float[] bodyHeights = {50, 60, 55};
  float[] headSizes = {20, 22, 18};
  color[] hairColors = {color(0), color(255, 0, 0), color(255, 255, 0)};

  // Display function for rendering Scene1
  void display() {
    background(135, 206, 250); // sky blue

    drawSun();
    drawClouds();
    drawBackground();
    drawRoad();
    drawTeenagers();
  }

  // Draw sun
  void drawSun() {
    fill(255, 223, 0);
    ellipse(700, 100, 100, 100);
  }

  // Draw clouds
  void drawClouds() {
    for (int i = 0; i < cloudX.length; i++) {
      drawCloud(cloudX[i], 100 + i * 50);
      cloudX[i] += cloudSpeed;
      if (cloudX[i] > width) {
        cloudX[i] = -60; // Reset cloud position to left if it moves off screen
      }
    }
  }

  void drawCloud(float x, float y) {
    fill(255);
    ellipse(x, y, 50, 50);
    ellipse(x + 30, y, 50, 50);
    ellipse(x + 60, y, 50, 50);
    ellipse(x + 30, y - 20, 50, 50);
  }

  // Draw background with trees and houses
  void drawBackground() {
    fill(210, 180, 140); // light brown color
    rect(0, height * 0.75 - 170, width, 170); // ground

    for (int i = 0; i < width; i += 200) {
      drawHouse(i + 50, height * 0.75 - 170);
      drawTree(i + 150, height * 0.75 - 170);
    }
  }

  void drawHouse(float x, float y) {
    fill(176, 224, 230); // light blue color for the house
    rect(x, y, 100, 100); // house body

    fill(139, 69, 19); // brown color for the door
    rect(x + 40, y + 50, 20, 50); // door

    fill(255); // white color for the windows
    rect(x + 10, y + 20, 20, 20); // left window
    rect(x + 70, y + 20, 20, 20); // right window

    fill(128, 0, 0); // dark red color for the roof
    triangle(x - 10, y, x + 110, y, x + 50, y - 40); // roof
  }

  void drawTree(float x, float y) {
    fill(139, 69, 19);
    rect(x - 10, y, 20, 100); // trunk
    for (int i = 0; i < 10; i++) {
      float yPos = y + i * 10;
      stroke(160, 82, 45);
      line(x - 10, yPos, x + 10, yPos); // trunk details
    }
    noStroke();

    fill(34, 139, 34);
    for (int i = 0; i < 5; i++) {
      ellipse(x, y - 20 - i * 20, 100 - i * 10, 50);
    }
  }

  // Draw road
  void drawRoad() {
    fill(169, 169, 169);
    rect(0, height * 0.75, width, height * 0.25);

    for (int i = 0; i < width; i += 40) {
      fill(255);
      rect(i, height * 0.875, 20, 5); // dashed lines
    }
  }

  // Draw teenagers in a discussion
  void drawTeenagers() {
    for (int i = 0; i < x.length; i++) {
      drawTeenager(x[i], y[i], bodyColors[i], bodyHeights[i], headSizes[i], hairColors[i], i);
    }
  }

  void drawTeenager(float x, float y, color bodyColor, float bodyHeight, float headSize, color hairColor, int index) {
    fill(bodyColor);
    rect(x - 10, y, 20, bodyHeight); // body

    fill(255, 220, 177); // light skin color
    ellipse(x, y - 20, headSize, headSize); // head

    fill(0); // black for eye
    ellipse(x - 4, y - 22, 3, 3); // eye

    fill(255, 220, 177);
    triangle(x, y - 20, x + 5, y - 20, x, y - 17);

    fill(0);
    arc(x + 2, y - 17, 10, 5, 0, PI / 2); // side smile

    fill(hairColor);
    arc(x, y - 27, 25, 15, PI, TWO_PI);

    fill(bodyColor);
    pushMatrix();
    translate(x - 15, y + 10);
    rotate(radians(-15 + index * 15));
    rect(0, 0, 10, 30); // left arm
    popMatrix();

    pushMatrix();
    translate(x + 5, y + 10);
    rotate(radians(15 - index * 15));
    rect(0, 0, 10, 30); // right arm
    popMatrix();

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
}
