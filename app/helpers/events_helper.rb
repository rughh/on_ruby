module EventsHelper
  def participation_link(event)
    if signed_in?
      if current_user.participates?(event)
        button_to t("show.not_attend"), [event, current_user.participation(event)], method: :delete
      else
        button_to t("show.attend"), [event, Participant.new]
      end
    else
      button_to t("show.attend"), "#", data: {disable: t("show.login_before_attend")}
    end
  end
end
