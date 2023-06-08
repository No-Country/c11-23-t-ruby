class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def loans
    # @loans = Loan.all.ordered
    @pagy, @loans = pagy(Loan.all.ordered, items: 10)
  end
end
