class Admin::HighlightsController < Admin::BaseAdminController
  def disable
    highlight = Highlight.find(params[:id])
    highlight.disable!
    redirect_to url_for(controller: "/admin/highlights", action: :edit, id: highlight.id), notice: "Disabled!"
  end
end
