package ui.menu.freeplay.category;

import flixel.system.FlxAssets.FlxGraphicAsset;
import ui.menu.freeplay.category.Category.CategorySong;

class StridenCrisisCategory extends Category
{
    public function new()
    {
        super('striden crisis');
    }

    public function getName():String
    {
        return 'Striden Crisis';
    }

    public function getSongs():Array<CategorySong>
    {
        return [
            {id: 'sweetcorn', color: [0xFF00C300]},
            {id: 'field', color: [0xFF647300]},
            {id: 'cob', color: [0xFF004B64]},
            {id: 'malice', color: [0xFF690000]},
            {id: 'opposition', color: [0xFFFFFFFF]},
            {id: 'thearchy', color: [0xFFFFFFFF]},
            {id: 'ether', color: [0xFFFF4B00]},
            {id: 'azure', color: [0xFF78C8FF]},
            {id: 'automation', color: [0xFF3C50FF]},
            {id: 'golden', color: [0xFFFFFF00]},
            {id: 'enthusiastic', color: [0xFF7E28FF]},
            {id: 'flip-phone', color: [0xFF2E78FD]},
            {id: 'ploinker', color: [0xFFF0FD0D]},
            {id: 'theophany', color: [0xFFEBD50D]},
            {id: 'the-b', color: [0xFFFFFFFF]},
            {id: 'hjoim', color: [0xFF000000]},
            {id: 'phillip', color: [0xFFFFFFFF]},
            {id: 'malice-old', color: [0xFF00C300]},
            {id: 'opposition-old', color: [0xFFFFFFFF]},
            {id: 'thearchy-old', color: [0xFFFFFFFF]},
            {id: 'ether-new', color: [0xFFFF4B00]},
            {id: 'the-b-v2', color: [0xFFFFFFFF]},
            {id: 'tungarchy', color: [0xFFFFFFFF]},
        ];
    }

    public function getIcon():FlxGraphicAsset
    {
        return Paths.image('freeplay/categories/stridentcrisis');
    }
}
