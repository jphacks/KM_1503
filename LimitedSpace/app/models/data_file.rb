class DataFile < ActiveRecord::Base
  soft_deletable
  scope :search_with_space_id, ->(spaceId){where(space_id: spaceId )}

  def getInfo
    ret = Hash.new

    ret[:id] = self.id
    arr = self.path.split("/")
    ret[:name] = arr[arr.length-1]
    ret[:type] = self.type
    ret[:size] = self.size
    ret[:updated_at] = self.updated_at.to_i

    return ret
  end
end
