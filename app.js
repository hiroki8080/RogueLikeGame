// Generated by CoffeeScript 1.10.0
(function() {
  var App, Character, Chip, Combat, Dungeon, Key, MapGenerator, Point, Room, RoomUtils, SquareRoad, getTipWithCoordinates, init,
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

    Chip.outside = -1;

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

  MapGenerator = (function() {
    function MapGenerator(size1) {
      var k, ref, results;
      this.size = size1;
      this.mapData = (function() {
        results = [];
        for (var k = 1, ref = this.size; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--){ results.push(k); }
        return results;
      }).apply(this).map((function(_this) {
        return function(i) {
          var k, ref, results;
          return (function() {
            results = [];
            for (var k = 1, ref = _this.size; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--){ results.push(k); }
            return results;
          }).apply(this).map(function(i) {
            return Chip.wall;
          });
        };
      })(this));
      this.squareRoadList = [];
    }

    MapGenerator.prototype.generateSquareRoad = function(roadIndex) {
      var MAX_ROAD_SIZE, MIN_ROAD_SIZE, OUTER_WALL_SIZE, k, l, len, randomPoint, ref, ref1, results, roadSize, room, squareRoad, x, y;
      OUTER_WALL_SIZE = 1;
      MIN_ROAD_SIZE = 11;
      MAX_ROAD_SIZE = 25;
      for (x = k = 1, ref = roadIndex; 1 <= ref ? k <= ref : k >= ref; x = 1 <= ref ? ++k : --k) {
        roadSize = Math.floor(Math.random() * (MAX_ROAD_SIZE - MIN_ROAD_SIZE + 1)) + MIN_ROAD_SIZE;
        this.squareRoadList.push(new SquareRoad(roadSize, new Point()));
      }
      ref1 = this.squareRoadList;
      results = [];
      for (l = 0, len = ref1.length; l < len; l++) {
        squareRoad = ref1[l];
        randomPoint = new Point();
        randomPoint.x = Math.floor(Math.random() * (this.size - squareRoad.maxWidth - 1 - OUTER_WALL_SIZE));
        randomPoint.y = Math.floor(Math.random() * (this.size - squareRoad.maxHeight - 1 - OUTER_WALL_SIZE));
        results.push((function() {
          var m, ref2, results1;
          results1 = [];
          for (x = m = 0, ref2 = squareRoad.maxWidth; 0 <= ref2 ? m < ref2 : m > ref2; x = 0 <= ref2 ? ++m : --m) {
            results1.push((function() {
              var len1, n, o, ref3, ref4, results2;
              results2 = [];
              for (y = n = 0, ref3 = squareRoad.maxHeight; 0 <= ref3 ? n < ref3 : n > ref3; y = 0 <= ref3 ? ++n : --n) {
                if (squareRoad.getSquareRoadData()[x][y] !== Chip.wall) {
                  squareRoad.point.x = x + OUTER_WALL_SIZE + randomPoint.x;
                  squareRoad.point.y = y + OUTER_WALL_SIZE + randomPoint.y;
                  ref4 = squareRoad.roomList;
                  for (o = 0, len1 = ref4.length; o < len1; o++) {
                    room = ref4[o];
                    room.point.x = squareRoad.point.x;
                    room.point.y = squareRoad.point.y;
                  }
                  results2.push(this.mapData[squareRoad.point.x][squareRoad.point.y] = squareRoad.getSquareRoadData()[x][y]);
                } else {
                  results2.push(void 0);
                }
              }
              return results2;
            }).call(this));
          }
          return results1;
        }).call(this));
      }
      return results;
    };

    MapGenerator.prototype.setTreasureBox = function() {
      var allRoomList, firstRoom, roomX, roomY;
      allRoomList = this.squareRoadList.map(function(squareRoad) {
        return squareRoad.roomList;
      }).reduce(function(a, b) {
        return a.concat(b);
      });
      console.log(allRoomList);
      RoomUtils.shuffle(allRoomList);
      firstRoom = allRoomList[0];
      console.log(firstRoom);
      roomX = Math.floor(Math.random() * firstRoom.size);
      roomY = Math.floor(Math.random() * firstRoom.size);
      console.log(firstRoom.point);
      firstRoom.setChip(Chip.treasureChest, new Point(roomX, roomY));
      return this.mapData[firstRoom.point.x - roomX][firstRoom.point.y - roomY] = Chip.treasureChest;
    };

    MapGenerator.prototype.getMapData = function() {
      return this.mapData.map(function(array) {
        return [].concat(array);
      });
    };

    return MapGenerator;

  })();

  SquareRoad = (function() {
    function SquareRoad(roadSize1, point1) {
      var k, ref, results;
      this.roadSize = roadSize1;
      this.point = point1;
      this.roomList = [];
      this.generateRoom();
      this.maxWidth = this.getMaxWidth();
      this.maxHeight = this.getMaxHeight();
      this.squareRoadData = (function() {
        results = [];
        for (var k = 1, ref = this.maxWidth; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--){ results.push(k); }
        return results;
      }).apply(this).map((function(_this) {
        return function(i) {
          var k, ref, results;
          return (function() {
            results = [];
            for (var k = 1, ref = _this.maxHeight; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--){ results.push(k); }
            return results;
          }).apply(this).map(function(i) {
            return Chip.wall;
          });
        };
      })(this));
      this.renderSquareRoad();
    }

    SquareRoad.prototype.getMaxHeight = function() {
      var error, error1, maxLowerRoomMiddleSize, maxUpperRoomMiddleSize;
      try {
        maxUpperRoomMiddleSize = Math.floor(Math.max(this.roomList[0].size, this.roomList[2].size) / 2);
        maxLowerRoomMiddleSize = Math.floor(Math.max(this.roomList[1].size, this.roomList[3].size) / 2);
        return maxUpperRoomMiddleSize + maxLowerRoomMiddleSize + this.roadSize;
      } catch (error1) {
        error = error1;
        print(error);
        return print("does not exist, four rooms");
      }
    };

    SquareRoad.prototype.getMaxWidth = function() {
      var error, error1, maxLeftRoomMiddleSize, maxRightRoomMiddleSize;
      try {
        maxLeftRoomMiddleSize = Math.floor(Math.max(this.roomList[0].size, this.roomList[1].size) / 2);
        maxRightRoomMiddleSize = Math.floor(Math.max(this.roomList[2].size, this.roomList[3].size) / 2);
        return maxLeftRoomMiddleSize + maxRightRoomMiddleSize + this.roadSize;
      } catch (error1) {
        error = error1;
        print(error);
        return print("does not exist, four rooms");
      }
    };

    SquareRoad.prototype.generateRoom = function() {
      var MAX_ROOM_MULTIPLE_SIZE, MIN_ROOM_MULTIPLE_SIZE, k, position, size;
      MAX_ROOM_MULTIPLE_SIZE = 4;
      MIN_ROOM_MULTIPLE_SIZE = 1;
      for (position = k = 0; k <= 3; position = ++k) {
        size = (Math.floor(Math.random() * (MAX_ROOM_MULTIPLE_SIZE - MIN_ROOM_MULTIPLE_SIZE + 1)) + MIN_ROOM_MULTIPLE_SIZE) * 2 + 1;
        this.roomList.push(new Room(size, position, new Point()));
      }
      this.roomList[1].point.y = this.getMaxHeight() - this.roomList[1].size;
      this.roomList[2].point.x = this.getMaxWidth() - this.roomList[2].size;
      this.roomList[3].point.x = this.getMaxWidth() - this.roomList[3].size;
      return this.roomList[3].point.y = this.getMaxHeight() - this.roomList[3].size;
    };

    SquareRoad.prototype.renderSquareRoad = function() {
      var k, l, leftRoadPosition, len, lowerRoadPosition, m, minLowerRoom, minLowerRoomMiddleSize, minRightRoom, minRightRoomMiddleSize, n, ref, ref1, ref2, ref3, results, rightRoadPosition, room, upperRoadPosition, x, y;
      console.log("maxWidth:" + this.maxWidth);
      console.log("maxHeight:" + this.maxHeight);
      ref = this.roomList;
      for (k = 0, len = ref.length; k < len; k++) {
        room = ref[k];
        for (x = l = 0, ref1 = room.size; 0 <= ref1 ? l < ref1 : l > ref1; x = 0 <= ref1 ? ++l : --l) {
          for (y = m = 0, ref2 = room.size; 0 <= ref2 ? m < ref2 : m > ref2; y = 0 <= ref2 ? ++m : --m) {
            this.squareRoadData[room.point.x + x][room.point.y + y] = room.getRoomData()[x][y];
          }
        }
      }
      upperRoadPosition = Math.floor(Math.min(this.roomList[0].size, this.roomList[2].size) / 2);
      minLowerRoom = RoomUtils.min(this.roomList[1], this.roomList[3]);
      minLowerRoomMiddleSize = Math.floor(minLowerRoom.size / 2);
      lowerRoadPosition = minLowerRoomMiddleSize + minLowerRoom.point.y;
      leftRoadPosition = Math.floor(Math.min(this.roomList[0].size, this.roomList[1].size) / 2);
      minRightRoom = RoomUtils.min(this.roomList[2], this.roomList[3]);
      minRightRoomMiddleSize = Math.floor(minRightRoom.size / 2);
      rightRoadPosition = minRightRoomMiddleSize + minRightRoom.point.x;
      this.squareRoadData[leftRoadPosition] = this.squareRoadData[leftRoadPosition].map(function(i) {
        return Chip.road;
      });
      this.squareRoadData[rightRoadPosition] = this.squareRoadData[rightRoadPosition].map(function(i) {
        return Chip.road;
      });
      results = [];
      for (x = n = 0, ref3 = this.maxWidth; 0 <= ref3 ? n < ref3 : n > ref3; x = 0 <= ref3 ? ++n : --n) {
        this.squareRoadData[x][upperRoadPosition] = Chip.road;
        results.push(this.squareRoadData[x][lowerRoadPosition] = Chip.road);
      }
      return results;
    };

    SquareRoad.prototype.getSquareRoadData = function() {
      return this.squareRoadData.map(function(array) {
        return [].concat(array);
      });
    };

    return SquareRoad;

  })();

  Room = (function() {
    function Room(size1, position1, point1) {
      var k, ref, results;
      this.size = size1;
      this.position = position1;
      this.point = point1;
      this.roomData = (function() {
        results = [];
        for (var k = 1, ref = this.size; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--){ results.push(k); }
        return results;
      }).apply(this).map((function(_this) {
        return function(i) {
          var k, ref, results;
          return (function() {
            results = [];
            for (var k = 1, ref = _this.size; 1 <= ref ? k <= ref : k >= ref; 1 <= ref ? k++ : k--){ results.push(k); }
            return results;
          }).apply(this).map(function(i) {
            return Chip.road;
          });
        };
      })(this));
    }

    Room.prototype.getRoomData = function() {
      return this.roomData.map(function(array) {
        return [].concat(array);
      });
    };

    Room.prototype.setChip = function(chip, point) {
      var error, error1;
      try {
        return this.roomData[point.x][point.y] = chip;
      } catch (error1) {
        error = error1;
        return print("does not set chip to the room at the point");
      }
    };

    return Room;

  })();

  RoomUtils = (function() {
    function RoomUtils() {}

    RoomUtils.max = function(room1, room2) {
      if (room1.size > room2.size) {
        return room1;
      } else {
        return room2;
      }
    };

    RoomUtils.min = function(room1, room2) {
      if (room1.size > room2.size) {
        return room2;
      } else {
        return room1;
      }
    };

    RoomUtils.shuffle = function(roomList) {
      var i, j, tmpi, tmpj;
      i = roomList.length;
      if (i === 0) {
        return false;
      }
      while (--i) {
        j = Math.floor(Math.random() * (i + 1));
        tmpi = roomList[i];
        tmpj = roomList[j];
        roomList[i] = tmpj;
        roomList[j] = tmpi;
      }
    };

    return RoomUtils;

  })();

  Point = (function() {
    function Point(x, y) {
      this.x = x || 0;
      this.y = y || 0;
    }

    Point.prototype.getRelativePoint = function(x, y) {
      return new Point(this.x + x, this.y + y);
    };

    return Point;

  })();

  Dungeon = (function() {
    function Dungeon(size1) {
      this.size = size1;
      this.init();
    }

    Dungeon.prototype.init = function() {
      var array, k, len, mapGenerator, ref, results;
      mapGenerator = new MapGenerator(this.size);
      mapGenerator.generateSquareRoad(4);
      mapGenerator.setTreasureBox();
      this.mapData = mapGenerator.getMapData();
      ref = this.mapData;
      results = [];
      for (k = 0, len = ref.length; k < len; k++) {
        array = ref[k];
        results.push(console.log(array));
      }
      return results;
    };

    Dungeon.prototype.getChip = function(x, y) {
      return this.mapData[x][y];
    };

    Dungeon.prototype.getMapData = function() {
      return this.mapData;
    };

    Dungeon.prototype.getAroundPoints = function(point, scale) {
      var arraySize, half, points, x, xBase, xx, y, yBase, yy;
      if (scale == null) {
        scale = 1;
      }
      half = scale;
      xBase = point.x - half;
      yBase = point.y - half;
      arraySize = 2 * scale + 1;
      return points = (function() {
        var k, ref, results;
        results = [];
        for (y = k = 0, ref = arraySize; 0 <= ref ? k < ref : k > ref; y = 0 <= ref ? ++k : --k) {
          results.push((function() {
            var l, ref1, results1;
            results1 = [];
            for (x = l = 0, ref1 = arraySize; 0 <= ref1 ? l < ref1 : l > ref1; x = 0 <= ref1 ? ++l : --l) {
              xx = xBase + x;
              yy = yBase + y;
              if ((yy >= 0 && xx >= 0) && (yy < 64 && xx < 64)) {
                results1.push(this.getChip(xBase + x, yBase + y));
              } else {
                results1.push(Chip.outside);
              }
            }
            return results1;
          }).call(this));
        }
        return results;
      }).call(this);
    };

    Dungeon.prototype.searchRoad = function() {
      var k, l, ref, ref1, x, y;
      for (y = k = 0, ref = this.size; 0 <= ref ? k < ref : k > ref; y = 0 <= ref ? ++k : --k) {
        for (x = l = 0, ref1 = this.size; 0 <= ref1 ? l < ref1 : l > ref1; x = 0 <= ref1 ? ++l : --l) {
          if (this.mapData[x][y] === Chip.road) {
            return new Point(x, y);
          }
        }
      }
      return console.log("NOT FOUND");
    };

    return Dungeon;

  })();

  getTipWithCoordinates = function(x, y) {
    return Chip.road;
  };

  Character = (function() {
    function Character(options) {
      this.moveRandom = bind(this.moveRandom, this);
      this.bindEvent = bind(this.bindEvent, this);
      this.point = options.point || new Point(0, 0);
      this.name = options.name || "no name";
      this.hp = options.hp || 20;
      this.attack = options.attack || 3;
      this.deffense = options.deffense || 1;
      this.type = options.type || Chip.enemy1;
      this.dungeon = options.dungeon;
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
      var toPoint;
      toPoint = this.point.getRelativePoint(0, -distance);
      if (this.canToMove(toPoint)) {
        this.point = toPoint;
      }
      return this.isEvent(toPoint);
    };

    Character.prototype.moveDown = function(distance) {
      var toPoint;
      toPoint = this.point.getRelativePoint(0, +distance);
      if (this.canToMove(toPoint)) {
        this.point = toPoint;
      }
      return this.isEvent(toPoint);
    };

    Character.prototype.moveLeft = function(distance) {
      var toPoint;
      toPoint = this.point.getRelativePoint(-distance, 0);
      if (this.canToMove(toPoint)) {
        this.point = toPoint;
      }
      return this.isEvent(toPoint);
    };

    Character.prototype.moveRight = function(distance) {
      var toPoint;
      toPoint = this.point.getRelativePoint(+distance, 0);
      if (this.canToMove(toPoint)) {
        this.point = toPoint;
      }
      return this.isEvent(toPoint);
    };

    Character.prototype.moveRandom = function() {
      var directions, rand;
      directions = [Key.up, Key.down, Key.left, Key.right];
      rand = Math.floor(Math.random() * directions.length);
      return this.move(directions[rand]);
    };

    Character.prototype.canToMove = function(point) {
      var tipNo;
      tipNo = this.dungeon.getChip(point.x, point.y);
      switch (tipNo) {
        case Chip.road:
          return true;
        default:
          return false;
      }
    };

    Character.prototype.isPlayer = function() {
      if (this.type === Chip.player) {
        return true;
      } else {
        return false;
      }
    };

    Character.prototype.isEnemy = function() {
      if (Chip.enemies.indexOf(this.type) !== -1) {
        return true;
      } else {
        return false;
      }
    };

    Character.prototype.isEvent = function(point) {
      var tipNo;
      tipNo = this.dungeon.getChip(point.x, point.y);
      console.log(tipNo);
      switch (tipNo) {
        case Chip.treasureChest:
          this.searchObject(Chip.treasureChest);
      }
      if (Chip.enemies.indexOf(tipNo) === -1) {
        return console.log("player attacks");
      }
    };

    Character.prototype.searchObject = function(tipNo) {
      switch (tipNo) {
        case Chip.treasureChest:
          return alert("ワンピースを手に入れた");
      }
    };

    Character.prototype.getAroundPoints = function() {
      var centerX, centerY, columnPoints, downY, k, l, leftX, len, len1, rightX, rowPoints, upY, x, xList, y, yList;
      leftX = this.point.x - 1;
      centerX = this.point.x;
      rightX = this.point.x + 1;
      xList = [leftX, centerX, rightX];
      upY = this.point.y - 1;
      centerY = this.point.y;
      downY = this.point.y + 1;
      yList = [upY, centerY, downY];
      columnPoints = [];
      for (k = 0, len = yList.length; k < len; k++) {
        y = yList[k];
        rowPoints = [];
        for (l = 0, len1 = xList.length; l < len1; l++) {
          x = xList[l];
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

  console.log("\('o')/");

  App = (function() {
    var canvasInit, statusCanvasInit;

    function App() {
      this.loop = bind(this.loop, this);
      var options, startPosition;
      this.statusCanvas = document.getElementById('status');
      this.canvas = document.getElementById('main');
      this.ctx = this.canvas.getContext('2d');
      this.statusCtx = this.statusCanvas.getContext('2d');
      this.dungeon = new Dungeon(64);
      startPosition = this.dungeon.searchRoad();
      options = {
        name: "トルネコ",
        point: startPosition,
        dungeon: this.dungeon
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
      mapData = this.dungeon.getAroundPoints(this.player.point, 5);
      return this.printMap(mapData);
    };

    App.prototype.printMap = function(mapData) {
      var data, k, l, len, len1, row, x, y;
      for (x = k = 0, len = mapData.length; k < len; x = ++k) {
        row = mapData[x];
        for (y = l = 0, len1 = row.length; l < len1; y = ++l) {
          data = row[y];
          switch (data) {
            case 1:
              this.printRoad(y, x);
              break;
            case 2:
              this.printWall(y, x);
              break;
            case 3:
              this.printPlayer(y, x);
              break;
            case 4:
              this.printTreasureBox(y, x);
              break;
            case 5:
              this.printWall(y, x);
              break;
            case 6:
              this.printWall(y, x);
              break;
            case 7:
              this.printWall(y, x);
              break;
            case 8:
              this.printWall(y, x);
              break;
            default:
              this.printWall(y, x);
          }
        }
      }
      return this.printPlayer(5, 5);
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

    App.prototype.printTreasureBox = function(x, y) {
      this.treasureBoxImg = new Image();
      this.treasureBoxImg.onload = (function(_this) {
        return function() {
          return _this.ctx.drawImage(_this.treasureBoxImg, x * 60, y * 60);
        };
      })(this);
      return this.treasureBoxImg.src = 'images/treasurebox.png';
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

}).call(this);
