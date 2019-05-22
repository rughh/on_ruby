module TopicsHelper
  def like_link(topic)
    if signed_in?
      if topic.user == current_user
        button_to t('topic.edit'), edit_topic_path(topic), method: :get
      elsif like = topic.already_liked?(current_user)
        button_to t('topic.unlike'), topic_like_path(like.topic, like), method: :delete
      else
        button_to t('topic.like'), topic_likes_path(topic), method: :post
      end
    else
      button_to t('topic.like'), login_path, method: :get, params: {referrer: request.url}
    end
  end

  def proposal_type_selection
    Hash[Topic::PROPOSAL_TYPES.map { |type| [I18n.t("topic.proposal_types.#{type}"), type] }]
  end
end
