class String
  def shorten(length=80)
    text = self.dup
    if text.length > length
      text[0..length] + "..."
    else
      text
    end.html_safe
  end
end