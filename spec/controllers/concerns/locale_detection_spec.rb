# frozen_string_literal: true

require 'spec_helper'

describe LocaleDetection do
  controller(ApplicationController) do
    def index
      head :ok
    end
  end

  before do
    routes.draw { get 'index' => 'anonymous#index' }
  end

  it 'concern is included' do
    expect(controller.class.ancestors.include?(described_class)).to be(true)
  end

  it 'uses the default locale if no locale is requested and browser doesnt provide locales' do
    get :index
    expect(I18n.locale).to eq(I18n.default_locale)
  end

  it 'uses the defaut locale if the browser provided ones arent available' do
    request.headers.merge! 'Accept-Language': 'fr-CH, fr;q=0.9, *;q=0.5'
    get :index
    expect(I18n.locale).to eq(I18n.default_locale)
  end

  it 'uses the default locale if the requested locale is not available' do
    get :index, params: { locale: 'yy' }
    expect(I18n.locale).to eq(I18n.default_locale)
  end

  it 'uses first matching locale from browser provided list' do
    request.headers.merge! 'Accept-Language': 'pl-PL, pl;q=0.9, en;q=0.8, *;q=0.5'
    get :index
    expect(I18n.locale).to eq(:pl)
  end

  it 'switches the locale via params' do
    get :index, params: { locale: 'de' }
    expect(I18n.locale).to eq(:de)
    expect(cookies[:locale]).to eq('de')
  end

  it 'uses the locale from a cookie' do
    cookies[:locale] = 'pl'
    get :index
    expect(I18n.locale).to eq(:pl)
  end
end
