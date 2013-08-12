class Admin::HighlightsController < Admin::ResourcesController
  def disable
    @highlight = Highlight.find(params[:id])
    @highlight.disable!
    redirect_to url_for(controller: "/admin/highlights", action: :edit, id: @highlight), notice: "Disabled!"
  end
end
