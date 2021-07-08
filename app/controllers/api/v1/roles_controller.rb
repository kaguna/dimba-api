module Api
  module V1  
    class RolesController < ApplicationController
      before_action :authenticate_current_user!, except: %i[index show]
      before_action :set_role, only: %i[show update destroy]
      after_action :verify_authorized, except: %i[index show]

      def index
        render json: Role.all
      end

      def show
        render json: @role
      end

      def create
        role = Role.new(role_params)
        authorize role

        if role.save
          render json: role, status: :created
        else
          render json: role.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize @role
        @role.update_attributes(role_params)
        render json: @role
      end

      def destroy
        authorize @role
        @role.destroy
      end

      private

      def set_role
        @event = Role.find(params[:id])
      end

      def role_params
        params.permit(
          :name,
          :description
        )
      end
    end
  end
end
