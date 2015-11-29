$(function(){
  try{
    var limited_space = new LimitedSpaceManager();
    limited_space.init();
      
  }catch(e){
    console.log(e);
  }
});
