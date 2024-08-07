boolean mouseWasPressed = false;
Fruits draggedFruit = null;

class Window {
  int sx, sy, sw, sh;

  Window() {
    sx = width / 2;
    sy = height / 2;
    sw = 120;
    sh = 30;
  }

  void Start() {
    background(255);
    line(width/2, 0, width/2, height);
    line(0, height/2, width, height/2);

    fill(0);
    text("start", width/2, height/2);
    text("rule", width/2, height/2 + 60);

    if (sx - sw/2 <= mouseX && mouseX <= sx-sw/2 + sw &&
      sy <= mouseY && mouseY <= sy + sh) {
      fill(255, 0, 0);
      if (mousePressed) {
        scene = 1;
      }
    } else {
      fill(0, 0, 255);
    }
    rect(sx - sw/2, sy, sw, sh);

    if (sx - sw/2 <= mouseX && mouseX <= sx-sw/2 + sw &&
      sy + sh*2 <= mouseY && mouseY <= sy+sh*2 + sh) {
      fill(255, 0, 0);
      if (mousePressed) {
        scene = 2;
      }
    } else {
      fill(0, 0, 255);
    }
    rect(sx - sw/2, sy + sh*2, sw, sh);
  }

  void Game() {
    background(0);
    fill(0);
    text("game", width/2, height/2);

    if (frameCount % 60 == 0) {
      int r = int(random(4));
      PImage img = null;
      color fallbackColor;
      if (r == 0) {
        img = loadImage("apple.png");
        fallbackColor = color(255, 0, 0);
      } else if (r == 1) {
        img = loadImage("grape.png");
        fallbackColor = color(128, 0, 128);
      } else if (r == 2) {
        img = loadImage("orange.png");
        fallbackColor = color(255, 165, 0);
      } else {
        img = loadImage("pineapple.png");
        fallbackColor = color(255, 255, 0);
      }
      fruits.add(new Fruits(random(width), 0, 2, 50, 50, img, fallbackColor));
    }

    for (int i = fruits.size() - 1; i >= 0; i--) {
      Fruits fruit = fruits.get(i);
      fruit.fall();
      fruit.display();

      // Check collision with the wall
      if (wall.collision(fruit)) {
        mistakes++;
        fruits.remove(i);
      } else {
        boolean collected = false;
        for (Basket basket : baskets) {
          if (basket.collect(fruit)) {
            if (basket.fallbackColor == fruit.fallbackColor) {
              score++;
            } else {
              mistakes++;
            }
            fruits.remove(i);
            collected = true;
            break;
          }
        }
      }
      if (mistakes >= 3) {
          fill(255, 0, 0);
          textSize(32);
          text("Game Over", width/2 - 80, height/2);
          noLoop();
        }
    }

    for (Basket basket : baskets) {
      basket.display();
    }

    fill(255);
    textSize(16);
    text("Score: " + score, 10, 20);
    text("Mistakes: " + mistakes, 10, 40);
  }

  void Rule() {
    background(255); // 背景を白に設定
    fill(0); // テキストの色を黒に設定
    textAlign(CENTER, CENTER); // テキストを中央に揃える
    text("rule", width/2, height/2); // "rule"テキストを中央に表示

    // マウスが四角形の上にあるかをチェック
    if (width/2 <= mouseX && mouseX <= width/2 + 30 && height/2 <= mouseY && mouseY <= height/2 + 30) {
      fill(255, 0, 0); // マウスが四角形の上にある場合、塗りの色を赤に設定
      if (mouseWasPressed && !mousePressed) { // マウスがクリックされた後にリリースされたかをチェック
        scene = 0; // シーンを0に変更
      }
    } else {
      fill(0, 0, 255); // マウスが四角形の上にない場合、塗りの色を青に設定
    }

    rect(width/2, height/2, 30, 30); // 四角形を描画

    mouseWasPressed = mousePressed; // 現在のマウスの状態を更新
  }

  void End() {
    background(255);
    fill(0);
    text("end", width/2, height/2);
  }
}
