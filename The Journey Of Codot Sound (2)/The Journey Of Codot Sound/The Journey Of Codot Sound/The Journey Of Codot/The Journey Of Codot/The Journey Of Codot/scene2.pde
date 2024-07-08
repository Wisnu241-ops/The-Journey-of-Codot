class Scene3 {
  int scene = 3;
  float t = 0; // time for animation
  float[] x = {150, 350, 550}; // initial x positions for the teenagers
  float[] cloudX = {300, 900}; // initial x positions for the clouds
  float cloudSpeed = 0.5; // speed of the clouds

  // Unique attributes for each teenager
  color[] bodyColors = {color(255, 204, 0), color(0, 204, 255), color(204, 0, 255)};
  float[] bodyHeights = {50, 60, 55};
  float[] headSizes = {20, 22, 18};
  color[] hairColors = {color(0), color(255, 0, 0), color(255, 255, 0)};

  void display() {
    background(255);

    // Draw sunset background
    drawSunset();

    // Draw sea
    drawSea();

    // Draw beach
    drawBeach();

    // Draw moving clouds
    for (int i = 0; i < cloudX.length; i++) {
      drawCloud(cloudX[i], 100); // All clouds at y = 100
      cloudX[i] += cloudSpeed;
      if (cloudX[i] > width) {
        cloudX[i] = -60; // Reset cloud position to left if it moves off screen
      }
    }

    // Draw three tents
    drawTent(200, 450);
    drawTent(400, 450);
    drawTent(600, 450);

    // Draw additional elements for beach scene
    drawBeachUmbrella(100, 500);
    drawBeachChair(150, 550);

    // Draw teenagers building
    for (int i = 0; i < x.length; i++) {
      drawTeenagerBuilding(x[i], 400, bodyColors[i], bodyHeights[i], headSizes[i], hairColors[i], i);
    }

    // Update time for animation
    t += 0.01;
  }

  void drawSunset() {
    noStroke();
    for (int i = 0; i < height; i++) {
      float inter = map(i, 0, height, 0, 1);
      color c = lerpColor(color(255, 100, 0), color(0, 0, 128), inter);
      stroke(c);
      line(0, i, width, i);
    }

    // Draw sun
    fill(255, 223, 0);
    ellipse(700, 500, 100, 100); // Sun setting
  }

  void drawSea() {
    fill(0, 119, 190);
    rect(0, height / 2 - 50, width, 100); // Sea behind the beach
  }

  void drawBeach() {
    fill(194, 178, 128);
    rect(0, height / 2, width, height / 2);
  }

  void drawTent(float x, float y) {
    fill(255, 0, 0);
    triangle(x, y, x + 100, y, x + 50, y - 100); // Front tent
    fill(200, 0, 0);
    triangle(x + 50, y - 100, x + 150, y, x + 100, y); // Side tent
    fill(150, 0, 0);
    rect(x + 40, y - 50, 20, 50); // Tent door
  }

  void drawTeenagerBuilding(float x, float y, color bodyColor, float bodyHeight, float headSize, color hairColor, int index) {
    float armSwing = sin(t * 2 + index * 0.1) * 20;

    // Draw body
    fill(bodyColor);
    rect(x - 10, y, 20, bodyHeight); // body

    // Draw head from side view
    fill(255, 220, 177); // light skin color
    ellipse(x, y - 20, headSize, headSize); // head
    
    // Draw facial details for side view
    fill(0); // black for eye
    ellipse(x - 4, y - 22, 3, 3); // eye
    
    // Draw nose
    fill(255, 220, 177);
    triangle(x, y - 20, x + 5, y - 20, x, y - 17);
    
    // Draw mouth
    fill(0);
    arc(x + 2, y - 17, 10, 5, 0, PI / 2); // side smile
    
    // Draw hair
    fill(hairColor);
    arc(x, y - 27, 25, 15, PI, TWO_PI);
    
    // Draw arms with animation indicating they are building the tent
    fill(bodyColor);
    pushMatrix();
    translate(x - 15, y + 10);
    rotate(radians(armSwing));
    rect(0, 0, 10, 30); // left arm
    popMatrix();

    pushMatrix();
    translate(x + 5, y + 10);
    rotate(radians(-armSwing));
    rect(0, 0, 10, 30); // right arm
    popMatrix();
    
    // Draw legs
    fill(0);
    rect(x - 5, y + bodyHeight, 10, 30); // left leg
    rect(x + 5, y + bodyHeight, 10, 30); // right leg
  }

  void drawCloud(float x, float y) {
    noStroke();
    fill(255);
    
    float[] cloudSizes = {50, 60, 70, 40}; // Different sizes for cloud parts
    for (int i = 0; i < cloudSizes.length; i++) {
      float offsetX = i * 30;
      float offsetY = (i % 2 == 0) ? 0 : -20; // Alternate the height slightly for variety
      ellipse(x + offsetX, y + offsetY, cloudSizes[i], cloudSizes[i]);
    }
  }

  void drawBeachUmbrella(float x, float y) {
    fill(255, 0, 0);
    arc(x, y, 100, 100, PI, TWO_PI); // Umbrella top
    fill(150, 75, 0);
    rect(x - 5, y, 10, 100); // Umbrella pole
  }

  void drawBeachChair(float x, float y) {
    fill(139, 69, 19);
    rect(x, y, 10, 50); // Chair leg 1
    rect(x + 40, y, 10, 50); // Chair leg 2
    fill(255, 204, 153);
    rect(x, y - 20, 50, 20); // Chair seat
    rect(x, y - 40, 50, 20); // Chair back
  }
}
