module KaminariHelper
  def paged(*items)
    Kaminari.paginate_array(Array(items)).page(0).per(25)
  end
end
