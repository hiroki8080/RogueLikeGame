// Generated by CoffeeScript 1.10.0
(function() {
  var App, Character, Dungeon, dungeon, getTipWithCoordinates, global, init;

  global = window;

  global.Key = (function() {
    function Key() {}

    Key.up = 38;

    Key.down = 40;

    Key.left = 38;

    Key.rigth = 39;

    Key.space = 32;

    return Key;

  })();

  global.Chip = (function() {
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

  getTipWithCoordinates = function(x, y) {
    return Chip.road;
  };

  Character = (function() {
    function Character(options) {
      this.x = options.x;
      this.y = options.y;
      this.hp = options.hp;
      this.attack = options.attack;
      this.deffense = options.deffense;
      window.document.keydown(bindEvents);
    }

    Character.prototype.bindEvents = function(e) {
      switch (e.keyCode) {
        case Key.up:
          return moveUp();
        case Key.down:
          return moveDown();
        case Key.left:
          return moveLeft();
        case Key.right:
          return moveRight();
        case Key.space:
          return openMenu();
      }
    };

    Character.prototype.moveUp = function(distance) {
      var toY;
      toY = this.y - distance;
      if (canToMove(this.x, toY)) {
        return this.y = toY;
      }
    };

    Character.prototype.moveDown = function(distance) {
      var toY;
      toY = this.y + distance;
      if (canToMove(this.x, toY)) {
        return this.y = toY;
      }
    };

    Character.prototype.moveLeft = function(distance) {
      var toX;
      toX = this.x - distance;
      if (canToMove(toX, this.y)) {
        return this.x = toX;
      }
    };

    Character.prototype.moveRight = function(distance) {
      var toX;
      toX = this.x + distance;
      if (canToMove(toX, this.y)) {
        return this.x = toX;
      }
    };

    Character.prototype.canToMove = function(x, y) {
      var tipNo;
      tipNo = getTipWithCoordinates(x, y);
      switch (tipNo) {
        case Chip.road:
          return true;
        default:
          return false;
      }
    };

    Character.prototype.isEvent = function(x, y) {
      var tipNo;
      tipNo = getTipWithCoordinates(x, y);
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

    Character.prototype.openMenu = function() {
      return console.log("openMenu");
    };

    return Character;

  })();

  console.log("\('o')/");

  App = (function() {
    var canvasInit;

    function App() {
      this.canvas = document.getElementById('main');
      this.ctx = this.canvas.getContext('2d');
      canvasInit(this.canvas, this.ctx);
    }

    canvasInit = function(canvas, ctx) {
      canvas.width = 500;
      canvas.height = 500;
      ctx.fillStyle = 'rgb(192, 80, 77)';
      ctx.fillRect(0, 0, 500, 500);
      return ctx.fill();
    };

    return App;

  })();

  init = function() {
    window.rogue = new App();
    return console.log("init");
  };

  window.addEventListener('load', init);

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
      return this.mapData.concat();
    };

    return Dungeon;

  })();

  dungeon = new Dungeon(64);

  dungeon.getMapData()[1][1] = 1000;

  console.log(dungeon.getMapData());

}).call(this);
