class UfsController < ApplicationController
  before_action :set_uf, only: [:show, :update, :destroy]

  # GET /ufs
  def index
    @ufs = Uf.pluck(:value, :date).map {|data| {value: data.first, date: data.second}}  #selecciona los campos que quieres que se muestre, ni instancia el resultado

    render json: @ufs
  end

  # GET /ufs/1
  def show
    user_code = request.headers["X-CLIENTE"]
    user = Client.find_by(code: user_code)
    return render json: "User not valid" unless user.present? 
    return render json: "Your date is not valid" unless @uf.present? 
    UserRequest.create(date: Time.now, user_id: user.id)
    render json: {value: @uf.value, date: @uf.date}  #Eliges que valores quieres que se enseñen
  end

  # POST /ufs
  def create
    @uf = Uf.new(uf_params)

    if @uf.save
      render json: @uf, status: :created, location: @uf
    else
      render json: @uf.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ufs/1
  def update
    if @uf.update(uf_params)
      render json: @uf
    else
      render json: @uf.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ufs/1
  def destroy
    @uf.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uf
      @uf = Uf.find_by(date: params[:date])  #.find= solo id, .find_by es mas especifico, entregas los datos que quieres saber
    end

    # Only allow a trusted parameter "white list" through.
    def uf_params
      params.require(:uf).permit(:value, :date)
    end    
end
