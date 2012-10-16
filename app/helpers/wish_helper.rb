# encoding: UTF-8

module WishHelper
  def stars(wish)
    5.times.map do |n|
      value = n + 1
      img = wish.stars >= value ? 'star.png' : 'star-empty.png'
      if signed_in? && !wish.done? && !wish.already_voted?(current_user)
        title = t("wish.vote", stars: value)
        link_to wish_votes_path(wish, Vote.new, 'vote[count]' => n + 1), {method: 'post', title: title} do
          image_tag img, alt: title
        end
      else
        image_tag img
      end
    end.join.html_safe
  end

  def meta(wish)
    raw t("wish.meta", link: link_to(wish.user.nickname, wish.user), count: wish.votes.count, stars: wish.stars)
  end
end
