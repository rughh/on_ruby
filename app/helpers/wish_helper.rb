# encoding: utf-8

module WishHelper
  
  def activity_type_label_method
    lambda { |key| { Wish::ACTIVITY_WISH => 'Ich wünsche mir', Wish::ACTIVITY_PROPOSAL => 'Mein Thema ist'}[key] }
  end
  
  def wish_description(wish)
    output = 5.times.map do |n|
      value = n + 1
      html_class = wish.stars >= value ? 'star highlight' : 'star'
      if signed_in?
        link_to ' ', wish_votes_path(wish, Vote.new, 'vote[count]' => n + 1), {:method => 'post', :class => html_class, :title => "mit #{value} Sternen bewerten"}
      else
        link_to ' ', '#', :confirm => 'Bitte anmelden!', :class => html_class
      end
    end.join
    output << "#{wish.stars.to_s} von 5 Sternen (#{wish.votes.count} mal bewertet)"
    output << ' - '
    output << link_to_twitter(wish.user)
    output << ' - '
    output << { 'WISH' => 'wünscht sich diesen Vortrag', 'PROPOSAL' => 'möchte dieses Thema vorstellen' }[wish.activity]
    output.html_safe
  end
end