module Houston
  module Statuses
    class StatusChecksController < ApplicationController
      def index
        authorize! :read, StatusCheck

        @status_checks = StatusCheck.all
        status_checks_arr = StatusCheck.all.to_a

        init_count = status_checks_arr.select { |sc| sc.status == 'init' }.count
        operational_count = status_checks_arr.select { |sc| sc.status == 'operational' }.count
        warn_count = status_checks_arr.select { |sc| sc.status == 'warn' }.count
        outage_count = status_checks_arr.select { |sc| sc.status == 'outage' }.count

        @init_percent = calculate_percent(init_count, status_checks_arr.count)
        @operational_percent = calculate_percent(operational_count, status_checks_arr.count)
        @warn_percent = calculate_percent(warn_count, status_checks_arr.count)
        @outage_percent = calculate_percent(outage_count, status_checks_arr.count)
      end

      def new
        @status_check = StatusCheck.new
        authorize! :create, @status_check
      end

      def create
        @status_check = StatusCheck.new(status_check_params)
        authorize! :create, @status_check
        @status_check.status = :init

        if @status_check.save
          redirect_to status_checks_path
        else
          render :new
        end
      end

      def edit
        @status_check = StatusCheck.find(params[:id])
        authorize! :update, @status_check
      end

      def update
        @status_check = StatusCheck.find(params[:id])
        authorize! :update, @status_check

        if @status_check.update(status_check_params)
          redirect_to status_checks_path
        else
          render :edit
        end
      end

      private

      def status_check_params
        params.require(:status_check).permit(:name, :url, :checker)
      end

      def calculate_percent(number, all)
        number.to_f / all.to_f * 100
      end
    end
  end
end
