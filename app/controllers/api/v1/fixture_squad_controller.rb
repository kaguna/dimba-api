class Api::V1::FixtureSquadController < ApplicationController
  before_action :authenticate_current_user, except: %i(index show)
  before_action :set_fixture_squad, only: %i(show update destroy)
  after_action :verify_authorized, except: %i(index show)

  def index
    fixture_squad = FixtureSquad.where(fixture_id: params[:fixture_id],
                                      team_id: params[:team_id]
    )

    if fixture_squad.empty?
      render json: { errors: "No squad for this match." },
            status: :bad_request

    else
      render json: fixture_squad, status: :ok
    end
  end

  def show
    p @fixture_squad
    render json: @fixture_squad
  end

  def create
    create_fixture_squad
    render json:
              {
                message: "#{players_paramaters.size} player(s) added to game"
              }, status: :created
  end

  def update
    authorize @fixture_squad
    @fixture_squad.update_attributes(update_params)
    render json: @fixture_squad
  end

  def destroy
    authorize @fixture_squad
    @fixture_squad.destroy
  end

  private

  def create_fixture_squad
    players_paramaters.each do |attributes|
      fixture_squad = FixtureSquad.new(players_params(attributes))
      authorize fixture_squad
      fixture_squad.save!
    end
  end

  def set_fixture_squad
    @fixture_squad = FixtureSquad.find(params[:id])
  end

  def players_params(attributes)
    attributes.permit(:player_id).to_h.merge!(
      fixture_id: params[:fixture_id],
      team_id: params[:team_id]
    )
  end

  def players_paramaters
    params.require(:fixture_squad)
  end

  def update_params
    params.permit(:team_id, :fixture_id, :player_id)
  end
end
