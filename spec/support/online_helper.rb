# frozen_string_literal: true

module OnlineHelper
  def online?
    @_online = ping if @_online.nil?
    @_online
  end

  private

  def ping
    Timeout.timeout(5) do
      s = TCPSocket.new('www.google.com', 80)
      s.close
    end
    true
  rescue
    false
  end
end
