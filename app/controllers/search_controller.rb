class SearchController < ApplicationController
  def search
    @users = params[:q].nil? ? [] : User.search(
      query: {
        query_string: {
          query: "*#{params[:q]}*"
        }
      }
    ).results
  end
end
