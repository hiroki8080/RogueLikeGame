// Generated by CoffeeScript 1.10.0
(function() {
  var App, Character, Chip, Combat, Dungeon, Key, Point, dungeon, getTipWithCoordinates, init, options, plyer1,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Key = (function() {
    function Key() {}

    Key.up = 38;

    Key.down = 40;

    Key.left = 37;

    Key.right = 39;

    Key.space = 32;

    return Key;

  })();

  Chip = (function() {
    function Chip() {}

    Chip.road = 1;

    Chip.wall = 2;

    Chip.player = 3;

    Chip.treasureChest = 4;

    Chip.enemy1 = 5;

    Chip.enemy2 = 6;

    Chip.enemy3 = 7;

    Chip.trap = 8;

    Chip.enemies = [Chip.enemy1, Chip.enemy2, Chip.enemy3];

    return Chip;

  })();

  Point = (function() {
    function Point(x, y) {
      this.x = x || 0;
      this.y = y || 0;
    }

    return Point;

  })();

  getTipWithCoordinates = function(x, y) {
    return Chip.road;
  };

  Character = (function() {
    function Character(options) {
      this.bindEvent = bind(this.bindEvent, this);
      this.point = options.point || new Point(0, 0);
      this.name = options.name || "no name";
      this.hp = options.hp || 20;
      this.attack = options.attack || 3;
      this.deffense = options.deffense || 1;
      window.addEventListener('keydown', this.bindEvent, true);
    }

    Character.prototype.bindEvent = function(e) {
      this.move(e.keyCode);
      switch (e.keyCode) {
        case Key.space:
          this.openMenu(1);
      }
      return this.logStatus();
    };

    Character.prototype.move = function(keyCode) {
      switch (keyCode) {
        case Key.up:
          return this.moveUp(1);
        case Key.down:
          return this.moveDown(1);
        case Key.left:
          return this.moveLeft(1);
        case Key.right:
          return this.moveRight(1);
      }
    };

    Character.prototype.moveUp = function(distance) {
      var toY;
      toY = this.point.y - distance;
      if (this.canToMove(this.point.x, toY)) {
        return this.point.y = toY;
      }
    };

    Character.prototype.moveDown = function(distance) {
      var toY;
      toY = this.point.y + distance;
      if (this.canToMove(this.point.x, toY)) {
        return this.point.y = toY;
      }
    };

    Character.prototype.moveLeft = function(distance) {
      var toX;
      toX = this.point.x - distance;
      if (this.canToMove(toX, this.point.x)) {
        return this.point.x = toX;
      }
    };

    Character.prototype.moveRight = function(distance) {
      var toX;
      toX = this.point.x + distance;
      if (this.canToMove(toX, this.point.x)) {
        return this.point.x = toX;
      }
    };

    Character.prototype.moveRandom = function() {
      var directions, rand;
      directions = [Key.up, Key.down, Key.left, Key.right];
      rand = Math.floor(Math.random() * directions.length);
      return this.move(directions[rand]);
    };

    Character.prototype.canToMove = function(point) {
      var tipNo;
      tipNo = getTipWithCoordinates(point.x, point.y);
      switch (tipNo) {
        case Chip.road:
          return true;
        default:
          return false;
      }
    };

    Character.prototype.isEvent = function(point) {
      var tipNo;
      tipNo = getTipWithCoordinates(point.x, point.y);
      switch (tipNo) {
        case Chip.treasureChest:
          searchObject(Chip.treasureChest);
      }
      if (this.enemies.indexOf(tipNo) === -1) {
        return attack();
      }
    };

    Character.prototype.attack = function() {
      return console.log("player attacks");
    };

    Character.prototype.searchObject = function(tipNo) {
      switch (tipNo) {
        case Chip.treasureChest:
          return console.log("open chest");
      }
    };

    Character.prototype.getAroundPoints = function() {
      var centerX, centerY, columnPoints, downY, j, k, leftX, len, len1, rightX, rowPoints, upY, x, xList, y, yList;
      leftX = this.point.x - 1;
      centerX = this.point.x;
      rightX = this.point.x + 1;
      xList = [leftX, centerX, rightX];
      upY = this.point.y - 1;
      centerY = this.point.y;
      downY = this.point.y + 1;
      yList = [upY, centerY, downY];
      columnPoints = [];
      for (j = 0, len = yList.length; j < len; j++) {
        y = yList[j];
        rowPoints = [];
        for (k = 0, len1 = xList.length; k < len1; k++) {
          x = xList[k];
          rowPoints.push(new Point(x, y));
        }
        columnPoints.push(rowPoints);
      }
      return columnPoints;
    };

    Character.prototype.openMenu = function() {
      return console.log("openMenu");
    };

    Character.prototype.logStatus = function() {
      return console.log("name: " + this.name + "\nx: " + this.point.x + ", y: " + this.point.y + "\nhp: " + this.hp);
    };

    return Character;

  })();

  options = {
    name: "トルネコ",
    point: new Point(1, 10)
  };

  plyer1 = new Character(options);

  console.log("\('o')/");

  App = (function() {
    var canvasInit, statusCanvasInit;

    function App() {
      this.loop = bind(this.loop, this);
      this.statusCanvas = document.getElementById('status');
      this.canvas = document.getElementById('main');
      this.ctx = this.canvas.getContext('2d');
      this.statusCtx = this.statusCanvas.getContext('2d');
      this.dungeon = new Dungeon(64);
      options = {
        name: "トルネコ",
        point: new Point(1, 10)
      };
      this.player = new Character(options);
      this.playerImg = new Image();
      this.playerImg.src = 'images/hero.png';
      statusCanvasInit(this.statusCanvas, this.statusCtx);
      canvasInit(this.canvas, this.ctx);
    }

    statusCanvasInit = function(canvas, ctx) {
      canvas.width = 660;
      canvas.height = 30;
      ctx.fillStyle = 'rgb(192, 80, 77)';
      ctx.fillRect(0, 0, 660, 30);
      return ctx.fill();
    };

    canvasInit = function(canvas, ctx) {
      canvas.width = 660;
      canvas.height = 660;
      ctx.fillStyle = 'rgb(192, 80, 77)';
      ctx.fillRect(0, 0, 660, 660);
      return ctx.fill();
    };

    App.prototype.loop = function() {
      var mapData;
      requestAnimationFrame(this.loop);
      this.printStatus();
      console.log("loop");
      mapData = [[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 3, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]];
      return this.printMap(mapData);
    };

    App.prototype.printMap = function(mapData) {
      var data, j, len, results, row, x, y;
      results = [];
      for (x = j = 0, len = mapData.length; j < len; x = ++j) {
        row = mapData[x];
        results.push((function() {
          var k, len1, results1;
          results1 = [];
          for (y = k = 0, len1 = row.length; k < len1; y = ++k) {
            data = row[y];
            switch (data) {
              case 1:
                results1.push(this.printRoad(x, y));
                break;
              case 2:
                results1.push(this.printWall(x, y));
                break;
              case 3:
                results1.push(this.printPlayer(x, y));
                break;
              case 4:
                results1.push(this.printWall(x, y));
                break;
              case 5:
                results1.push(this.printWall(x, y));
                break;
              case 6:
                results1.push(this.printWall(x, y));
                break;
              case 7:
                results1.push(this.printWall(x, y));
                break;
              case 8:
                results1.push(this.printWall(x, y));
                break;
              default:
                results1.push(this.printWall(x, y));
            }
          }
          return results1;
        }).call(this));
      }
      return results;
    };

    App.prototype.printWall = function(x, y) {
      this.wallImg = new Image();
      this.wallImg.onload = (function(_this) {
        return function() {
          return _this.ctx.drawImage(_this.wallImg, x * 60, y * 60);
        };
      })(this);
      return this.wallImg.src = 'images/wall.png';
    };

    App.prototype.printRoad = function(x, y) {
      this.roadImg = new Image();
      this.roadImg.onload = (function(_this) {
        return function() {
          return _this.ctx.drawImage(_this.roadImg, x * 60, y * 60);
        };
      })(this);
      return this.roadImg.src = 'images/floor.png';
    };

    App.prototype.printPlayer = function(x, y) {
      this.playerImg = new Image();
      this.playerImg.onload = (function(_this) {
        return function() {
          return _this.ctx.drawImage(_this.playerImg, x * 60, y * 60);
        };
      })(this);
      return this.playerImg.src = 'images/hero.png';
    };

    App.prototype.printEnemy = function(x, y) {};

    App.prototype.printStatus = function() {
      this.statusCtx.clearRect(0, 0, 660, 60);
      this.statusCtx.strokeText("HP:" + this.player.hp, 0, 10);
      this.statusCtx.strokeText("X:" + this.player.point.x, 100, 10);
      return this.statusCtx.strokeText("Y:" + this.player.point.y, 200, 10);
    };

    return App;

  })();

  init = function() {
    window.rogue = new App();
    console.log("init");
    return window.rogue.loop();
  };

  window.addEventListener('load', init);

  Combat = (function() {
    function Combat() {}

    Combat.prototype.getByEnemies = function(point) {};

    Combat.prototype.attack = function(fromCharacter, toCharacter) {
      var damage;
      damage = fromCharacter.attack - toCharacter.deffense;
      return toCharacter.hp = -damage;
    };

    return Combat;

  })();

  Dungeon = (function() {
    function Dungeon(size) {
      this.size = size;
      this.init();
    }

    Dungeon.prototype.init = function() {
      var j, k, ref, ref1, results, results1, widthArray;
      widthArray = (function() {
        results = [];
        for (var j = 1, ref = this.size; 1 <= ref ? j <= ref : j >= ref; 1 <= ref ? j++ : j--){ results.push(j); }
        return results;
      }).apply(this).map(function(i) {
        return Chip.wall;
      });
      return this.mapData = (function() {
        results1 = [];
        for (var k = 1, ref1 = this.size; 1 <= ref1 ? k <= ref1 : k >= ref1; 1 <= ref1 ? k++ : k--){ results1.push(k); }
        return results1;
      }).apply(this).map(function(i) {
        return widthArray;
      });
    };

    Dungeon.prototype.getChip = function(x, y) {
      return this.dungeonArray[x][y];
    };

    Dungeon.prototype.getMapData = function() {
      return this.mapData;
    };

    return Dungeon;

  })();

  dungeon = new Dungeon(64);

  console.log(dungeon.getMapData());

}).call(this);
