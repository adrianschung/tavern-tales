module MapsHelper
  def owned?(map)
    current_user.id == map.user_id
  end
end
