class RoomsController < ApplicationController
  before_action :require_athentication, only: [:new, :edit, :create, :update, :destroy]

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: 'Quatro criado com sucesso!'
    else
      render action: :new
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to @room, notice: 'Quarto atualizado com sucesso!'
    else
      render action: :edit
    end
  end

  private
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end
end
