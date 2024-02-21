class DetailsController < ApplicationController
  before_action :set_person
  before_action :set_detail, only: [:edit, :update, :destroy]

  def index
    @details = @person.details

    respond_to do |format|
      format.json { render json: @details }
      format.html
    end
  end

  def show
    @detail = @person.details.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @detail }
    end
  end

  def new
    @detail = @person.details.new
  end

  # POST /people/:person_id/details
  def create
    @detail = @person.details.new(detail_params)

    respond_to do |format|
      if @detail.save
        format.html { redirect_to person_path(@person), data: { turbo_frame: "details" } }
        format.json { render json: @person.details, status: :created, location: person_url(@person) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /people/:person_id/details/:id/edit
  def edit; end

  # PATCH/PUT /people/:person_id/details/:id
  def update
    if @detail.update(detail_params)
      redirect_to person_path(@person), data: { turbo_frame: "details" }
    else
      render :edit
    end
  end

  # DELETE /people/:person_id/details/:id
  def destroy
    @detail.destroy
    redirect_to people_path(@person), data: { turbo_frame: "details" }
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

