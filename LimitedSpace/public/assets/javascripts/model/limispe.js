// ===========================
// リミスペクラス
// ===========================
function LimitedSpace( $area ) {
    this.id;
    this.position = {x:0,y:0};
    this.span;
    this.name;
    this.radius;
    this.creadted_at;
    this.image = "";
    this.obj = $("<div>");
}

// -----------------------------------
//  静的変数
// -----------------------------------

//  リミスペID
LimitedSpace.prototype.ID = "space"

// リミスペの大きさ
LimitedSpace.prototype.SIDE = 85;

// 最大の長さ [ms]
LimitedSpace.prototype.SPAN_MAX = 180; 

// 最大の範囲 [m]
LimitedSpace.prototype.RADIUS_MAX = 1000;

// jqueryを使っているため別で。 
$(function(){
    LimitedSpace.prototype.AREA = $("#space");
});

// -----------------------------------
//  メソッド
// -----------------------------------

LimitedSpace.prototype.init = function( limispeID, span, radius,created_at, name, x,y ) {
    
    // 
    this.id = this.ID +  limispeID;
    this.span = span;
    this.radius = radius;
    this.created_at = created_at;
    this.name;
    this.setPosition( x ,y );
    
    
    this.obj.attr("id",this.id);
    
    // CSS
    this.setCSS();
    
    // アニメーションクラスの付与
    this.obj.addClass('animated bounceIn');
    
    this.AREA.append(this.obj);
}


// ---
// CSSの付与
// ---
LimitedSpace.prototype.setCSS = function() {
    this.obj.css({
        "width": this.SIDE+"px"
        ,"height": this.SIDE+"px"
        ,"left": this.position.x+"px"
        ,"top": this.position.y+"px"
        ,"position": "absolute"
        ,"border-radius" : " 400px"
        ," border" : "5px solid #fff"
        ,"box-shadow" : "0px 0px 10px #ccc, inset 0px 0px 10px rgba(0, 0, 0, 0.8)"
        ,"background" : "url( " + "7205325.jpeg" +") center center"
        ,"background-size" : "cover"
        ,"-webkit-animation-duration": "1s"
        ,"-webkit-animation-delay" : ".5s"
        ,"-webkit-animation-iteration-count": "1"
    });
}

// ******************************
// ポジションに関するメソッド 
// ******************************
LimitedSpace.prototype.setX = function(x){
    this.position.x = x;
    this.obj.css("left",x+"px");
}

// --------------------------
// Y方向の設定
// --------------------------
LimitedSpace.prototype.setY = function(y){
    this.position.y = y;
    this.obj.css("top",y+"px");
}

// --------------------------
// 位置の設定
// --------------------------
LimitedSpace.prototype.setPosition = function(x,y){
    this.setX(x);
    this.setY(y);
}

