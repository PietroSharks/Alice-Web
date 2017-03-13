class CategoriaServiciosController < ApplicationController
  before_action :set_categoria_servicio, only: [:show, :edit, :update, :destroy]
    require 'will_paginate/array'

  # GET /categoria_servicios
  # GET /categoria_servicios.json
  def index
    @categoria_servicios = CategoriaServicio.all
    @url = Url_WebServices()
    @categorias = HTTParty.get(Url_WebServices() + '/categorias.json')
  end

  # GET /categoria_servicios/1
  # GET /categoria_servicios/1.json
  def show
    #@especialidades = @categoria_servicio.especialidades.paginate(page: params[:page], per_page: 4)
    @categorias = HTTParty.get(Url_WebServices() + '/categorias.json')
    @categorias.each do |categoria|
      if categoria["slug"] = params[:id]
        @tipo_servicios = categoria["tipo_servicios"]
        break
      end
    end
    #@especialidades = Willpaginate::Collection.create(page: params[:page], per_page: 4) do |pager|
     # pager.replace(@tipo_servicios)
    #end

    @per_page = params[:per_page] || 2
    @especialidades= @tipo_servicios.paginate(:per_page => @per_page, :page => params[:page])

  end

  def ver
    @url = Url_WebServices()

    @especialidades = HTTParty.get(@url+'tipo_servicios.json?slug='+params[:slug])
     #@categoria_servicio.especialidades.paginate(page: params[:page], per_page: 4)
  end

  def mas
    @categorias = HTTParty.get(Url_WebServices() + '/categorias.json')
    @categorias.each do |categoria|
      if categoria["slug"] = params[:id]
        @tipo_servicios = categoria["tipo_servicios"]
        break
      end
    end

    @per_page = params[:per_page] || 2
    @especialidades= @tipo_servicios.paginate(:per_page => @per_page, :page => params[:page])
    
  end

  # GET /categoria_servicios/new
  def new
    @categoria_servicio = CategoriaServicio.new
  end

  # GET /categoria_servicios/1/edit
  def edit
  end

  # POST /categoria_servicios
  # POST /categoria_servicios.json
  def create
    @categoria_servicio = CategoriaServicio.new(categoria_servicio_params)

    respond_to do |format|
      if @categoria_servicio.save
        format.html { redirect_to @categoria_servicio, notice: 'Categoria servicio was successfully created.' }
        format.json { render :show, status: :created, location: @categoria_servicio }
      else
        format.html { render :new }
        format.json { render json: @categoria_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categoria_servicios/1
  # PATCH/PUT /categoria_servicios/1.json
  def update
    respond_to do |format|
      if @categoria_servicio.update(categoria_servicio_params)
        format.html { redirect_to @categoria_servicio, notice: 'Categoria servicio was successfully updated.' }
        format.json { render :show, status: :ok, location: @categoria_servicio }
      else
        format.html { render :edit }
        format.json { render json: @categoria_servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categoria_servicios/1
  # DELETE /categoria_servicios/1.json
  def destroy
    @categoria_servicio.destroy
    respond_to do |format|
      format.html { redirect_to categoria_servicios_url, notice: 'Categoria servicio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoria_servicio
      @categoria_servicio = CategoriaServicio.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categoria_servicio_params
      params.require(:categoria_servicio).permit(:codigo, :nombre, :estatus)
    end
end
