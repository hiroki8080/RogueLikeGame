class Combat
  # 周囲の敵を取得
  getByEnemies: (point) ->
    # 周囲の座標を取得
    # 各座標が敵かをチェック
    # 敵のCharacterクラスを配列で返す
  attack: (fromCharacter, toCharacter) ->
    damage = fromCharacter.attack - toCharacter.deffense
    toCharacter.hp =- damage
