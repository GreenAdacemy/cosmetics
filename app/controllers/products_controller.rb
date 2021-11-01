class ProductsController < ApplicationController
  include Pagy::Backend
  helper Pagy::Frontend

  before_action :set_product, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:index, :show]

  add_breadcrumb I18n.t('breadcrumb.home'), :root_path
  add_breadcrumb I18n.t('breadcrumb.products'), :products_path

  # GET /products or /products.json
  def index
    @pagy, @products = pagy Product.by_order
    respond_to do |f|
      f.html
      f.turbo_stream
    end    
  end

  # GET /products/1 or /products/1.json
  def show
    add_breadcrumb @product.name, product_path(@product)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.by_product(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
