class ScenesController < ApplicationController
  def index
    if params[:episode_id]
      @episode = Episode.find(params[:episode_id])
    else
      @scenes = Scene.all
    end
  end

  def new
    if params[:plotline_id]
      @plotline = Plotline.find(params[:plotline_id])
    elsif params[:episode_id]
      @episode = Episode.find(params[:episode_id])
    end
    @scene = Scene.new
  end

  def create
    @scene = Scene.new(scene_params)
    if @scene.save
      flash[:notice] = "Scene created!"
      redirect_to scene_path(@scene)
    else
      @episode = @scene.episode
      render :new
    end
  end

  def show
    @scene = Scene.find(params[:id])
  end

  def edit
    @scene = Scene.find(params[:id])
  end

  def update
    @scene = Scene.find(params[:id])
    if @scene.update(scene_params)
      flash[:notice] = "Scene updated!"
      redirect_to scene_path(@scene)
    else
      render :edit
    end
  end

  def destroy
    @scene = Scene.find(params[:id])
    @scene.destroy
    flash[:notice] = "Scene has been taken by the Demogorgon."
    redirect_to scenes_path
  end

private
  def scene_params
    params.require(:scene).permit(:description, :episode_id, :plotline_id)
  end
end
