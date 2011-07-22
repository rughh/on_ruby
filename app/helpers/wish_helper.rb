# encoding: UTF-8

module WishHelper
  def stars(wish)
    5.times.map do |n|
      value = n + 1
      img = wish.stars >= value ? 'star.png' : 'star-empty.png'
      if signed_in?
        if wish.done?
          image_tag img, alt: 'Thema ist schon abgefrühstückt!'
        else
          title = "mit #{value} Sternen bewerten"
          link_to wish_votes_path(wish, Vote.new, 'vote[count]' => n + 1), {method: 'post', title: title} do
            image_tag img, alt: title
          end
        end
      else
        title = 'Bitte anmelden!'
        link_to '#', :confirm => title do
          image_tag img, alt: title
        end
      end
    end.join.html_safe
  end

  def meta(wish)
    "von #{link_to_twitter(wish.user)} - #{wish.votes.count} mal mit #{wish.stars} von 5 Sternen bewertet".html_safe
  end
end
