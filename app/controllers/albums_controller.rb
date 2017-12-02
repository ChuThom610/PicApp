class AlbumsController < ApplicationController
	before_action :set_album, only: [:show, :edit, :update, :destroy]
  
  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @pics = @album.pics.all
    @user = User.find_by_id @album.user_id
  end

  # GET /albums/new
  def new
    @album = Album.new
    @pic = @album.pics.build
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)
    @user = User.find_by_id @album.user_id
    #@albums = @user.albums.all

    respond_to do |format|
      if @album.save
        params[:pics]['picture'].each do |a|
           @pic = @album.pics.create!(:picture => a)
        end
        format.html { redirect_to @album, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :template => "users/show" }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        params[:pics]['picture'].each do |a|
           @pic = @album.pics.create!(:picture => a)
        end
        format.html { redirect_to @album, notice: 'album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private

  	# Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:name, :description, :user_id, pics_attributes: [:id, :album_id, :user_id, :picture])
    end
end

