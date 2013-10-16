module OnlineHelper
  def online?
    if @_online.nil?
      @_online = ping
    end
    @_online
  end

  private

  def ping
    timeout(5) do
      s = TCPSocket.new("www.google.com", 80)
      s.close
    end
    return true
  rescue
    return false
  end
end
