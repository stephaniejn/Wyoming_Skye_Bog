class TagsController < ApplicationController

  def new
    @tags = Tag.new
    @creature = Creature.all

  end

  def index
    @tags = Tag.all
  end

  def destroy
    @tag = Tag.find(params[:id])
    if(@tag.creatures.length == 0)
      @tag.destroy
      redirect_to tags_path
    else
      flash[:danger] = "Cannot delete this tag because there are " + @tag.creatures.length.to_s + " creatures using it"
      redirect_to tags_path
    end
  end

  def create
    @tags = Tag.new(tag_params)
    @tags.save
    flash[:success] = "Your tag has been added."
    redirect_to '/creatures'

  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end


end
