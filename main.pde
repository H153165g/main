ArrayList<Basket> baskets;
ArrayList<Fruits> fruits;
Wall wall;
Window window;
PImage appleImg, grapeImg, orangeImg, pineappleImg;
int score;
int mistakes;
int scene;

void setup() {
  size(800, 600);

  fruits = new ArrayList<Fruits>();
  baskets = new ArrayList<Basket>();
  wall = new Wall(0, height, width, 1);
  window = new Window();

  appleImg = loadImage("apple.png");
  grapeImg = loadImage("grape.png");
  orangeImg = loadImage("orange.png");
  pineappleImg = loadImage("pineapple.png");

  color appleColor = color(255, 0, 0);
  color grapeColor = color(128, 0, 128);
  color orangeColor = color(255, 165, 0);
  color pineappleColor = color(255, 255, 0);

  baskets.add(new Basket(width/2 - 350, height - 100, 100, 100, "apple", appleImg, appleColor));
  baskets.add(new Basket(width/2 - 150, height - 100, 100, 100, "grape", grapeImg, grapeColor));
  baskets.add(new Basket(width/2 + 50, height - 100, 100, 100, "orange", orangeImg, orangeColor));
  baskets.add(new Basket(width/2 + 250, height - 100, 100, 100, "pineapple", pineappleImg, pineappleColor));

  score = 0;
  mistakes = 0;
  scene = 0;
  //Fruits draggedFruit = null;
}

void draw() {
  if (scene == 0) {
    window.Start();
  } else if (scene == 1) {
    window.Game();
  } else if (scene == 2) {
    window.Rule();
  } else {
    window.End();
  }
}

void mousePressed() {
  for (Basket basket : baskets) {
    basket.fallbackColor = randomFruitColor(basket.fn);
    //basket.img = null; // 画像をクリアして色のみを表示
  }
  for (Fruits fruit : fruits) {
    // マウスの位置がフルーツの範囲内にある場合にドラッグを開始する
    if (fruit.x <= mouseX && mouseX <= fruit.x + fruit.fw &&
      fruit.y <= mouseY && mouseY <= fruit.y + fruit.fh) {
      fruit.startDragging();
      if (fruit.dragging) {
        draggedFruit = fruit; // ドラッグ中のフルーツを設定
        break;
      }
    }
  }
}

void mouseDragged() {
  if (draggedFruit != null) {
    draggedFruit.drag(); // ドラッグ中のフルーツをドラッグ
  }
}

void mouseReleased() {
  if (draggedFruit != null) {
    draggedFruit.stopDragging(); // ドラッグを終了
    draggedFruit = null; // ドラッグ中のフルーツをリセット
  }
}


color randomFruitColor(String fruitName) {
  if (fruitName.equals("apple")) return color(255, 0, 0);
  if (fruitName.equals("grape")) return color(128, 0, 128);
  if (fruitName.equals("orange")) return color(255, 165, 0);
  if (fruitName.equals("pineapple")) return color(255, 255, 0);
  return color(255); // デフォルトの色（白）
}
