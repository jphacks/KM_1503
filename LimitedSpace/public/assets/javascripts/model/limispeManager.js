// ===========================
// リミスペ管理クラス
// ===========================
function LimitedSpaceManager() {
    // リミスペの配列
    this.LimitedSpaces = [];
    // リミスペを配置できる範囲
    this.points = [];
}

//  位置
function point(x, y) {
    this.x = x;
    this.y = y;
}

// ===========================
// 
// ===========================

LimitedSpaceManager.prototype.GRID = 85;


LimitedSpaceManager.prototype.init = function () {
    var body = $("#space");
    var bg_height = body.height();
    var bg_width = body.width();

    var grid = LimitedSpaceManager.prototype.GRID;

    for (var rows = grid; rows < bg_height - grid; rows += grid * 2) {
        for (var cols = grid; cols < bg_width - grid; cols += grid * 2) {
            var point_tmp = new point(cols -grid/2+ 10,rows - grid/2);
            this.points.push(point_tmp);
        }
    }
    
     console.log( this.points );
    try {

        for (var i = 0; i< this.points.length; i++) {
            var limited_space = new LimitedSpace();
            
            limited_space.init(i, 100, 100, 100, 100, this.points[i].x, this.points[i].y );
            this.LimitedSpaces.push( limited_space );
            
        }
    } catch (e) {
        console.log(e);
    }

}