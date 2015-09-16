class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.for_user(current_user).all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search.results
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
    @search = Search.find params[:id]
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.perform_search search_params, current_user
    respond_to do |format|
      if !@search.errors.any?
        format.html { redirect_to search_path @search, notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { ra json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      @search.transaction do
          @search.update(search_params)
          format.html { redirect_to search_path @search, notice: 'Search was successfully updated.' }
          format.json { render :show, status: :ok, location: @search }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params[:search].permit(:query, :type)
    end
end
