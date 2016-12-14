class WelcomeController < ApplicationController
    before_action :authenticate_admin!, only: [:dashboard, :sold]
    def index
    end
    def dashboard
        @product = Product.unpublished_products
    end
    def sold
        @product = Product.already_sold
    end
end
