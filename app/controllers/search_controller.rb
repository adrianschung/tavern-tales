class SearchController < ApplicationController
  def search
    @users = params[:q].nil? ? [] : User.search(
      query: {
        query_string: {
          default_operator: "AND",
          analyzer: "trigrams",
          query: "#{params[:q]}"
        }
      }
    ).results
  end
end
