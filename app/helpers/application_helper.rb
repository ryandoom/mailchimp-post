module ApplicationHelper

  def docs_for?(value)
    return !params.has_key?(:docs) if value == 'both'
    !params.has_key?(:docs) || params[:docs] == value
  end

end
