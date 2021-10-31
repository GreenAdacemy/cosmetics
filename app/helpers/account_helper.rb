module AccountHelper
  def is_guest?
    !user_signed_in?
  end

  def is_user?
    user_signed_in?
  end

  def missing_avatar?
    !current_user.avatar.attached?
  end
end