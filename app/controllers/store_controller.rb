class StoreController < BaseController
  def index
    @online_store_categories = A2::OnlineStoreCategory.children_of(9) #Regions
  end
end
