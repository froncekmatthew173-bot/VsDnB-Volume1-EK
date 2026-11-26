import objects.HealthIcon;

// script by subpurr [[discord: subpurrowo]]
// please do not use without credit.
// no explicit permission needed to use

var usingWinIcon:Array<Bool> = [false, false]; // nah, i'd win
var icons:Array<HealthIcon> = [];

function refreshIcon(icon:HealthIcon, index:Int) {
    final ratioCheck:FlxSprite = new FlxSprite(0, 0).loadGraphic(icon.graphic);
    final hasWinIcon:Bool = Math.abs(ratioCheck.graphic.width * 0.5 - ratioCheck.graphic.height)
                            > Math.abs(ratioCheck.graphic.width / 3 - ratioCheck.graphic.height);
    ratioCheck.destroy(); // goodbye twitter

    usingWinIcon[index] = hasWinIcon;
    if (hasWinIcon) {
        icon.loadGraphic(icon.graphic, true, Math.floor(icon.graphic.width / 3), Math.floor(icon.graphic.height));

        icon.iconOffsets[0] = (icon.width - 150) / 3;
        icon.iconOffsets[1] = (icon.height - 150) * 0.5;
        icon.updateHitbox();

        icon.animation.add(icon.char, [0, 1, 2], 0, false, icon.isPlayer); // apparently you can just... do this LMAO
        icon.animation.play(icon.char);
    }
}

function onCreatePost() {
    game.iconsAnimations = false;

    icons = [game.iconP1, game.iconP2];
    for (i in 0 ... icons.length) {
        refreshIcon(icons[i], i);
    }
}

function onUpdatePost(e) {
    // check if losing, then check if winning AND has win icon, and then jsut set to default if none
    game.iconP1.animation.curAnim.curFrame = (game.healthBar.percent < 20) ? 1 : (game.healthBar.percent > 80 && usingWinIcon[0]) ? 2 : 0;
    game.iconP2.animation.curAnim.curFrame = (game.healthBar.percent > 80) ? 1 : (game.healthBar.percent < 20 && usingWinIcon[1]) ? 2 : 0;
}

function onEvent(eventName:String, value1:String, value2:String, strumTime:Float) {
    if (eventName == 'Change Character') {
        var charType:Int = 0;
        switch(StringTools.trim(value1.toLowerCase())) {
            case 'gf' | 'girlfriend':
                charType = 2;
            case 'dad' | 'opponent':
                charType = 1;
            default:
                charType = Std.parseInt(value1);
                if(Math.isNaN(charType)) charType = 0;
        }

        if (charType <= 1)
           refreshIcon(icons[charType], charType);
    }
}