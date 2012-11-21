class MiscController < ApplicationController
  helper_method :urls
  respond_to :xml
  layout :false

  def sitemap; end

  private

  def urls
    Whitelabel.labels.map do |label|
      Whitelabel.with_label(label) do
        subdomain = label.label_id
        %w(Wish User Event Location).map do |clazz|
          clazz.constantize.all.map { |it| send :"#{clazz.downcase}_url", it, subdomain: subdomain }
        end + [root_url(subdomain: subdomain)]
      end
    end.flatten
  end
end
