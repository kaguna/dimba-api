module Api
  module V1  
    class FavouritesController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show]
      before_action :set_favourite, only: %i[show update destroy]

      def index
        render json: Favourite.all
      end

      def show
        render json: @favourite
      end

      def create
        favourite = Favourite.new(favourite_params)
        favourite.user_id = current_user&.id

        if favourite.save
          render json: favourite, status: :created
        else
          render json: favourite.errors, status: :unprocessable_entity
        end
      end

      def update
        @favourite.update_attributes(favourite_params)
        render json: @favourite
      end

      def destroy
        @favourite.destroy
      end

      private

      def set_favourite
        @favourite = Favourite.find(params[:id])
      end

      def favourite_params
        params.permit(
          :category,
          :category_id,
          :user_id # not needed, remove later
        )
      end
    end
  end
end
