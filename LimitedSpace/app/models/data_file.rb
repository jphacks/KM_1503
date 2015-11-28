class DataFile < ActiveRecord::Base
  soft_deletable

  def fileInfo(path)
    arr = path.split("/")
    return { "data" => getHash(data,arr) }
  end
​  def getHash(data, arr)
  if (arr.count == 1){
    return {"files" => (data << arr[0])}
  }
  else {
    name = arr.shift
    if data["folders"].has_key?(name)
      return 
    else
      return { "foldes" => { name => getHash(arr)}}
  }
​   end
end
