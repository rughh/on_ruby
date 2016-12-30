class Admin::HighlightsController < Admin::ResourcesController
  before_action :set_highlight_defaults, only: :new

  def disable
    @highlight = Highlight.find(params[:id])
    @highlight.disable!
    redirect_to url_for(controller: '/admin/highlights', action: :edit, id: @highlight), notice: 'Disabled!'
  end

  protected

  def set_highlight_defaults
    params[:resource] ||= {}
    params[:resource][:start_at] = Time.now
    params[:resource][:end_at] = 1.week.from_now
  end
end
