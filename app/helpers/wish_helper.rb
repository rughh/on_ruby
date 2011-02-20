# encoding: utf-8

module WishHelper

  def wish_description(wish)
    output = 5.times.map do |n|
      value = n + 1
      html_class = wish.stars >= value ? 'star highlight' : 'star'
      link_to ' ', wish_votes_path(wish, Vote.new, 'vote[count]' => 5), {:method => 'post', :class => html_class, :title => "mit #{value} Sternen bewerten"}
    end.join
    output << "#{wish.stars.to_s} von 5 Sternen (#{wish.votes.count} mal bewertet)"
    output << ' - '
    output << link_to(wish.user.nickname, wish.user.twurl)
    output << ' - '
    output << { 'WISH' => 'wünscht sich diesen Vortrag', 'PROPOSAL' => 'möchte dieses Thema vorstellen' }[wish.activity]
    output.html_safe
  end
end