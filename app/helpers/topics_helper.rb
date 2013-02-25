module TopicsHelper
  def like_link(topic)
    if signed_in?
      if like = topic.already_liked?(current_user)
        button_to t('topic.unlike'), topic_like_path(like.topic, like), method: :delete
      else
        button_to t('topic.like'), topic_likes_path(topic), method: :post
      end
    else
      button_to t('topic.like'), '', data: { disable: t('show.login_before_attend') }
    end
  end
end
