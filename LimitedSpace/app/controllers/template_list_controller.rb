class TemplateListController < ApplicationController
  def TemplateList
    result = {
      1,
      2,
      3,
      4
    }
    render json: result
  end
end
