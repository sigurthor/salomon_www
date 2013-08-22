class StoreController < BaseController
  def index
    page 'stores'
    @online_store_categories = A2::OnlineStoreCategory.children_of(9) #Regions
  end
end
