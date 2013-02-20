class MiscController < ApplicationController
  helper_method :urls
  respond_to :xml
  layout :false

  def sitemap; end

  private

  def urls
    label = Whitelabel.label_for(params[:label])
    Whitelabel.with_label(label) do
      subdomain = label.label_id
      %w(Topic User Event Location).map do |clazz|
        clazz.constantize.all.map { |it| send :"#{clazz.downcase}_url", it, subdomain: subdomain }
      end + [root_url(subdomain: subdomain)]
    end.flatten
  end
end
