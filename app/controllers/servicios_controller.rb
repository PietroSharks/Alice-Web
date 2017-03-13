class ServiciosController < ApplicationController
  before_action :set_servicio, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: :especialistas
  respond_to  :js
  
  # GET /servicios
  # GET /servicios.json
  def index
    @servicios = Servicio.all
  end

  # GET /servicios/1
  # GET /servicios/1.json
  def show
    @especialistas = @servicio.especialistas.paginate(page: params[:page], per_page: 4)
     @url = Url_WebServices()
    @noticias = HTTParty.get(Url_WebServices() + '/categoria.json')  
  end

  def ver
     @url = Url_WebServices()
    @tipo_servicio = HTTParty.get(Url_WebServices() + '/tipo_servicios/'+params["id"]'.json')   
  end


  def especialistas
    #@servicio = Servicio.friendly.find(params[:id])
        @servicio = Servicio.where("id = ?", params[:id]).take
           @especialistas = @servicio.especialistas.paginate(page: params[:page], per_page: 4)
                 respond_to do |format|
        #format.html { render partial: 'especialistas', locals: { :servicio => @servicio } }
        format.js
      end
  end

  # GET /servicios/new
  def new
    @servicio = Servicio.new
  end

  # GET /servicios/1/edit
  def edit
  end

  # POST /servicios
  # POST /servicios.json
  def create
    @servicio = Servicio.new(servicio_params)

    respond_to do |format|
      if @servicio.save
        format.html { redirect_to @servicio, notice: 'Servicio was successfully created.' }
        format.json { render :show, status: :created, location: @servicio }
      else
        format.html { render :new }
        format.json { render json: @servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servicios/1
  # PATCH/PUT /servicios/1.json
  def update
    respond_to do |format|
      if @servicio.update(servicio_params)
        format.html { redirect_to @servicio, notice: 'Servicio was successfully updated.' }
        format.json { render :show, status: :ok, location: @servicio }
      else
        format.html { render :edit }
        format.json { render json: @servicio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servicios/1
  # DELETE /servicios/1.json
  def destroy
    @servicio.destroy
    respond_to do |format|
      format.html { redirect_to servicios_url, notice: 'Servicio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servicio
      @servicio = Servicio.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servicio_params
      params.require(:servicio).permit(:codigo, :especialidad_id, :nombre, :estatus)
    end
end
