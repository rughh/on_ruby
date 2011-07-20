# encoding: utf-8

module WishHelper

  def activity_type_label_method
    lambda { |key| { Wish::ACTIVITY_WISH => 'Ich wünsche mir', Wish::ACTIVITY_PROPOSAL => 'Mein Thema ist'}[key] }
  end

  def stars(wish)
    5.times.map do |n|
      value = n + 1
      img = wish.stars >= value ? 'star.png' : 'star-empty.png'
      if signed_in?
        link_to wish_votes_path(wish, Vote.new, 'vote[count]' => n + 1), {:method => 'post', :title => "mit #{value} Sternen bewerten"} do
          image_tag img
        end
      else
        link_to '#', :confirm => 'Bitte anmelden!' do
          image_tag img
        end
      end
    end.join.html_safe
  end

  def meta(wish)
    "von #{link_to_twitter(wish.user)} - #{wish.votes.count} mal bewertet".html_safe
  end

end
