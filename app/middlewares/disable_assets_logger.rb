# https://github.com/rails/rails/issues/2639#issuecomment-6591735
class DisableAssetsLogger
  def initialize(app)
    @app = app
    Rails.application.assets.logger = Logger.new('/dev/null')
  end

  def call(env)
    previous_level = Rails.logger.level
    Rails.logger.level = Logger::ERROR if env['PATH_INFO'].index("/assets/") == 0
    @app.call(env)
  ensure
    Rails.logger.level = previous_level
  end
end
