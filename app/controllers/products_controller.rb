class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :like, :dislike, :publish, :comprar, :comprado]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authenticate_seller!, only: [:new, :create,:edit, :update]
  before_action :authenticate_admin!, only: [:destroy]
  before_action :current_user_in_url , only: [:comprar, :comprado]
  # GET /products
  # GET /products.json
  def index
    @products = Product.published_products.order_desc_products
  end

  # GET /products/1
  # GET /products/1.json
  def show
     @comment = Comment.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end
  def like
      @product.increment_params
      redirect_to @product
  end

  def dislike
      @product.decrement_params
      redirect_to @product
  end
  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def publish
      @product.publish!
      redirect_to products_url, :notice => "El producto fue publicado exitosamente"
  end
  def comprar
  end
  def comprado
      @seller = @product.user
      if @user.account_of_saving > @product.price_product
          c = @user.account_of_saving - @product.price_product
          @user.update_your_count(c)
          @product.sell!
          v = @seller.account_of_saving + @product.price_product
          @seller.update_your_count(v)
          redirect_to products_url , notice:"Ha comprado el producto #{@product.name_product} esperamos que te guste tu compra :)"
      end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end
    def current_user_in_url
        @user = current_user
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name_product, :description_product,:price_product, :image,:video)
    end
end
