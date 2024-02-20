class DetailsController < ApplicationController
  before_action :set_person
  before_action :set_detail, only: [:show, :edit, :update, :destroy]

  def index
    @person = @person
    @details = @person.details
  end

  def show
  end

  def new
    @detail = @person.details.build
  end

  def edit
  end

  def create
    @detail = @person.details.build(detail_params)
    respond_to do |format|
      if @detail.save
        format.html { redirect_to person_details_path(@person), notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @detail.update(detail_params)
      redirect_to person_detail_path(@detail.person, @detail), notice: 'Detail was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @detail.destroy
    redirect_to person_details_url(@person), notice: 'Detail was successfully destroyed.'
  end

  private
  def set_person
    @person = Person.find(params[:person_id])
  end

  def set_detail
    @detail = @person.details.find(params[:id])
  end

  def detail_params
    params.require(:detail).permit(:title, :age, :phone, :email)
  end
end
