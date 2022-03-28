class ProductsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  before_action :authenticate_admin, except: [:show, :index]
  
  def index
    @products = Product.all
    # render json: @products.as_json
    render template: "products/index"
  end

  def show
    @product = Product.find_by(id: params[:id])
    render template: "products/show"
  end

  def create
    product = Product.new(
      name: params[:name], 
      description: params[:description],
      price: params[:price],
      supplier_id: params[:supplier_id],
      quantity: params[:quantity]
    )
    
    if product.save
      params[:images].each do |image|
        image = Image.new(url: image, product_id: product.id)
        image.save
      end
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
    
  end

  def update
    # find the right product
    product = Product.find_by(id: params[:id])
    # modify that product
    product.name = params[:name] || product.name
    product.description = params[:description] || product.description
    product.price = params[:price] || product.price
    product.images = params[:images] || product.images 
    product.supplier_id = params[:supplier_id] || product.supplier_id
    product.quantity = params[:quantity] || product.quantity

    if product.save
      # params[:images].each do |image|
      #   image = Image.new(url: image, product_id: product.id)
      #   image.save
      # end
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render json: {message: "product removed"}
  end
end
