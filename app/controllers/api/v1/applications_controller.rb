class Api::V1::ApplicationsController < ApplicationController
  before_action :authenticate_token!, only: [:create, :update]

  def create

  end

  def update

  end

end
